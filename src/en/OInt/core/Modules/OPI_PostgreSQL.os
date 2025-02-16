﻿// OneScript: ./OInt/core/Modules/OPI_PostgreSQL.os
// Lib: PostgreSQL
// CLI: postgres

// MIT License

// Copyright (c) 2023 Anton Tsitavets

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// https://github.com/Bayselonarrend/OpenIntegrations

// BSLLS:Typo-off
// BSLLS:LatinAndCyrillicSymbolInWord-off
// BSLLS:IncorrectLineBreak-off
// BSLLS:NumberOfOptionalParams-off
// BSLLS:UsingServiceTag-off
// BSLLS:LineLength-off

//@skip-check module-structure-top-region
//@skip-check module-structure-method-in-regions
//@skip-check wrong-string-literal-content
//@skip-check method-too-many-params
//@skip-check constructor-function-return-section
//@skip-check doc-comment-collection-item-type

// Uncomment if OneScript is executed
#Use "../../tools"

#Region Public

#Region CommonMethods

// Create Connection !NOCLI
// Creates a connection to the specified base
//
// Parameters:
// ConnectionString - String - Connection string. See GenerateConnectionString - sting
//
// Returns:
// Arbitrary - Connector object or structure with error information
Function CreateConnection(Val ConnectionString = "") Export

    If IsConnector(ConnectionString) Then
        Return ConnectionString;
    EndIf;

    OPI_TypeConversion.GetLine(ConnectionString);
    OPI_Tools.RestoreEscapeSequences(ConnectionString);

    Connector = AttachAddInOnServer("OPI_PostgreSQL");

    Connector.ConnectionString = ConnectionString;

    Result = Connector.Connect();
    Result = OPI_Tools.JsonToStructure(Result, False);

    Return ?(Result["result"], Connector, Result);

EndFunction

// Close connection !NOCLI
// Explicitly closes the passed connection
//
// Parameters:
// Connection - Arbitrary - AddIn object with open connection - dbc
//
// Returns:
// Structure Of KeyAndValue - Result of connection termination
Function CloseConnection(Val Connection) Export

    If IsConnector(Connection) Then

        Result = Connection.Close();
        Result = OPI_Tools.JsonToStructure(Result, False);

    Else

        Result = New Structure("result,error", False, "It's not a connection");

    EndIf;

    Return Result;

EndFunction

// Is connector !NOCLI
// Checks that the value is an object of a PostgreSQL AddIn
//
// Parameters:
// Value - Arbitrary - Value to check - value
//
// Returns:
// Boolean - Is connector
Function IsConnector(Val Value) Export

    Return String(TypeOf(Value)) = "AddIn.OPI_PostgreSQL.Main";

EndFunction

// Execute SQL query
// Executes an arbitrary SQL query
//
// Note
// Query parameters are specified as an array of structures of the following type: `{'Type': 'Value'}`.^^
// The list of available types is described on the initial page of the PostgreSQL library documentation
// Without specifying the `ForcifyResult` flag, result data is returned only for queries beginning with `SELECT` keyword^^
// For other queries, `result:true` or `false` with error text is returned
//
// Parameters:
// QueryText - String - Database query text - sql
// Parameters - Array Of Arbitrary - Array of positional parameters of the request - params
// ForceResult - Boolean - Includes an attempt to retrieve the result, even for nonSELECT queries - force
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue - Result of query execution
Function ExecuteSQLQuery(Val QueryText
    , Val Parameters = ""
    , Val ForceResult = False
    , Val Connection = "") Export

    OPI_TypeConversion.GetLine(QueryText, True);
    OPI_TypeConversion.GetBoolean(ForceResult);

    Parameters_ = ProcessParameters(Parameters);

    If IsConnector(Connection) Then
        CloseConnection = False;
        Connector       = Connection;
    Else
        CloseConnection = True;
        Connector       = CreateConnection(Connection);
    EndIf;

    If Not IsConnector(Connector) Then
        Return Connector;
    EndIf;

    Result = Connector.Execute(QueryText, Parameters_, ForceResult);

    If CloseConnection Then
        CloseConnection(Connector);
    EndIf;

    Result = OPI_Tools.JsonToStructure(Result);

    Return Result;

EndFunction

// Generate connection string
// Forms a connection string from the passed data
//
// Parameters:
// Address - String - IP address or domain name of the server - addr
// Base - String - Name of the database to connect - db
// Login - String - Postgres user login - login
// Password - String - Postgres user password - pass
// Port - String - Connection port - port
//
// Returns:
// String - PostgreSQL database connection string
Function GenerateConnectionString(Val Address, Val Base, Val Login, Val Password = "", Val Port = "5432") Export

    OPI_TypeConversion.GetLine(Address);
    OPI_TypeConversion.GetLine(Login);
    OPI_TypeConversion.GetLine(Base);
    OPI_TypeConversion.GetLine(Port);
    OPI_TypeConversion.GetLine(Password);

    Port     = ?(ValueIsFilled(Port), ":" + Port, Port);
    Password = ?(ValueIsFilled(Password), ":" + Password, Password);

    StringTemplate   = "postgresql://%1%2@%3%4/%5";
    ConnectionString = StrTemplate(StringTemplate, Login, Password, Address, Port, Base);

    Return ConnectionString;

EndFunction

#EndRegion

#Region ORM

// Create database
// Creates a database with the specified name
//
// Parameters:
// Base - String - Database name - base
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue - Result of query execution
Function CreateDatabase(Val Base, Val Connection = "") Export

    Result = OPI_SQLQueries.CreateDatabase(OPI_PostgreSQL, Base, Connection);
    Return Result;

EndFunction

// Drop database
// Deletes the database
//
// Parameters:
// Base - String - Database name - base
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue - Result of query execution
Function DeleteDatabase(Val Base, Val Connection = "") Export

    Result = OPI_SQLQueries.DeleteDatabase(OPI_PostgreSQL, Base, Connection);
    Return Result;

EndFunction

// Disable all database connections
// Terminates all connections to the database except the current one
//
// Parameters:
// Base - String - Database name - base
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue - Result of query execution
Function DisableAllDatabaseConnections(Val Base, Val Connection = "") Export

    OPI_TypeConversion.GetLine(Base);

    TextSQL        = "SELECT pg_terminate_backend(pid)
    |FROM pg_stat_activity
    |WHERE datname = '%1' AND pid <> pg_backend_pid();";

    TextSQL = StrTemplate(TextSQL, Base);

    Result = ExecuteSQLQuery(TextSQL, , , Connection);

    Return Result;

EndFunction

// Get table information
// Gets information about the table
//
// Parameters:
// Table - String - Table name - table
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue - Result of query execution
Function GetTableInformation(Val Table, Val Connection = "") Export

    OPI_TypeConversion.GetLine(Table);

    TextSQL           = "SELECT column_name, data_type, character_maximum_length
    |FROM information_schema.columns
    |WHERE table_name = '%1';";

    TextSQL = StrTemplate(TextSQL, Table);

    Result = ExecuteSQLQuery(TextSQL, , , Connection);

    Return Result;

EndFunction

// Create table
// Creates an empty table in the database
//
// Note
// The list of available types is described on the initial page of the PostgreSQL library documentation
//
// Parameters:
// Table - String - Table name - table
// ColoumnsStruct - Structure Of KeyAndValue - Column structure: Key > Name, Value > Data type - cols
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue - Result of query execution
Function CreateTable(Val Table, Val ColoumnsStruct, Val Connection = "") Export

    Result = OPI_SQLQueries.CreateTable(OPI_PostgreSQL, Table, ColoumnsStruct, Connection);
    Return Result;

EndFunction

// Clear table
// Clears the database table
//
// Parameters:
// Table - String - Table name - table
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue, String - Result of query execution
Function ClearTable(Val Table, Val Connection = "") Export

    Result = OPI_SQLQueries.DeleteRecords(OPI_PostgreSQL, Table, , Connection);
    Return Result;

EndFunction

// Delete table
// Deletes a table from the database
//
// Parameters:
// Table - String - Table name - table
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue, String - Result of query execution
Function DeleteTable(Val Table, Val Connection = "") Export

    Result = OPI_SQLQueries.DeleteTable(OPI_PostgreSQL, Table, Connection);
    Return Result;

EndFunction

// Add rows
// Adds new rows to the table
//
// Note
// Record data is specified as an array of structures of the following type:^
// `{'Field name 1': {'Type': 'Value'}, 'Field name 2': {'Type': 'Value'},...}`
// The list of available types is described on the initial page of the PostgreSQL library documentation
//
// Parameters:
// Table - String - Table name - table
// DataArray - Array of Structure - An array of string data structures: Key > field, Value > field value - rows
// Transaction - Boolean - True > adding records to transactions with rollback on error - trn
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue, String - Result of query execution
Function AddRecords(Val Table, Val DataArray, Val Transaction = True, Val Connection = "") Export

    Result = OPI_SQLQueries.AddRecords(OPI_PostgreSQL, Table, DataArray, Transaction, Connection);
    Return Result;

EndFunction

// Get records
// Gets records from the selected table
//
// Parameters:
// Table - String - Table name - table
// Fields - Array Of String - Fields for selection - fields
// Filters - Array of Structure - Filters array. See GetRecordsFilterStrucutre - filter
// Sort - Structure Of KeyAndValue - Sorting: Key > field name, Value > direction (ASC, DESC) - order
// Count - Number - Limiting the number of received strings - limit
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue, String - Result of query execution
Function GetRecords(Val Table
    , Val Fields = "*"
    , Val Filters = ""
    , Val Sort = ""
    , Val Count = ""
    , Val Connection = "") Export

    Result = OPI_SQLQueries.GetRecords(OPI_PostgreSQL, Table, Fields, Filters, Sort, Count, Connection);
    Return Result;

EndFunction

// Update records
// Updates the value of records by selected criteria
//
// Note
// Record data is specified as an array of structures of the following type:^
// `{'Field name 1': {'Type': 'Value'}, 'Field name 2': {'Type': 'Value'},...}`
// The list of available types is described on the initial page of the PostgreSQL library documentation
//
// Parameters:
// Table - String - Table name - table
// ValueStructure - Structure Of KeyAndValue - Values structure: Key > field, Value > field value - values
// Filters - Array of Structure - Filters array. See GetRecordsFilterStrucutre - filter
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue, String - Result of query execution
Function UpdateRecords(Val Table, Val ValueStructure, Val Filters = "", Val Connection = "") Export

    Result = OPI_SQLQueries.UpdateRecords(OPI_PostgreSQL, Table, ValueStructure, Filters, Connection);
    Return Result;

EndFunction

// Delete records
// Deletes records from the table
//
// Parameters:
// Table - String - Table name - table
// Filters - Array of Structure - Filters array. See GetRecordsFilterStrucutre - filter
// Connection - String, Arbitrary - Connection or connection string - dbc
//
// Returns:
// Structure Of KeyAndValue, String - Result of query execution
Function DeleteRecords(Val Table, Val Filters = "", Val Connection = "") Export

    Result = OPI_SQLQueries.DeleteRecords(OPI_PostgreSQL, Table, Filters, Connection);
    Return Result;

EndFunction

// Get records filter strucutre
// Gets the template structure for filtering records in ORM queries
//
// Note
// The use of the `raw` feature is necessary for compound constructions like `BEETWEEN`.^^
// For example: with `raw:false` the filter `type:BETWEEN` `value:10 AND 20` will be interpolated as `BETWEEN ?1 `^^
// where `?1 = "10 AND 20,"' which would cause an error.
// In such a case, you must use `raw:true` to set the condition directly in the query text
//
// Parameters:
// Clear - Boolean - True > structure with empty valuse, False > field descriptions at values - empty
//
// Returns:
// Structure Of KeyAndValue - Record filter element
Function GetRecordsFilterStrucutre(Val Clear = False) Export

    Return OPI_SQLQueries.GetRecordsFilterStrucutre(Clear);

EndFunction

#EndRegion

#EndRegion

#Region Internal

Function ConnectorName() Export
    Return "OPI_PostgreSQL";
EndFunction

Function GetFeatures() Export

    Features = New Map;
    Features.Insert("ParameterNumeration", True);
    Features.Insert("ParameterMarker"    , "$");

    Return Features;

EndFunction

#EndRegion

#Region Private

Function AttachAddInOnServer(Val AddInName, Val Class = "Main")

    If OPI_Tools.IsOneScript() Then
        TemplateName = OPI_Tools.AddInsFolderOS() + AddInName + ".zip";
    Else
        TemplateName = "CommonTemplate." + AddInName;
    EndIf;

    AttachAddIn(TemplateName, AddInName, AddInType.Native);

    AddIn = New ("AddIn." + AddInName + "." + Class);
    Return AddIn;

EndFunction

Function ProcessParameters(Val Parameters)

    If Not ValueIsFilled(Parameters) Then
        Return "[]";
    EndIf;

    OPI_TypeConversion.GetArray(Parameters);

    For N = 0 To Parameters.UBound() Do

        CurrentParameter = Parameters[N];

        CurrentParameter = ProcessParameter(CurrentParameter);

        Parameters[N] = CurrentParameter;

    EndDo;

    Parameters_ = OPI_Tools.JSONString(Parameters, , False);

    If StrStartsWith(Parameters_, "NOT JSON") Then
        Raise "JSON parameter array validation error!";
    EndIf;

    Return Parameters_;

EndFunction

Function ProcessParameter(CurrentParameter)

    CurrentType = TypeOf(CurrentParameter);

    If CurrentType = Type("BinaryData") Then

        CurrentParameter = New Structure("BYTEA", Base64String(CurrentParameter));

    ElsIf CurrentType = Type("UUID") Then

        CurrentParameter = String(CurrentParameter);

    ElsIf CurrentType = Type("Date") Then

        CurrentParameter = OPI_Tools.DateRFC3339(CurrentParameter);

    ElsIf OPI_Tools.CollectionFieldExist(CurrentParameter, "BYTEA") Then

        CurrentParameter = ProcessBlobStructure(CurrentParameter);

    ElsIf CurrentType  = Type("Structure")
        Or CurrentType = Type("Map") Then

        CurrentParameter_ = OPI_Tools.CopyCollection(CurrentParameter);

        For Each ParamElement In CurrentParameter_ Do

            CurrentKey   = Upper(ParamElement.Key);
            CurrentValue = ParamElement.Value;

            If CurrentKey     = "JSONB"
                Or CurrentKey = "JSON"
                Or CurrentKey = "HSTORE" Then
                Continue;
            EndIf;

            CurrentParameter[ParamElement.Key] = ProcessParameter(CurrentValue);

        EndDo;

    Else

        If Not OPI_Tools.IsPrimitiveType(CurrentParameter) Then
            OPI_TypeConversion.GetLine(CurrentParameter);
        EndIf;

    EndIf;

    Return CurrentParameter;

EndFunction

Function ProcessBlobStructure(Val Value)

    DataValue = Value["BYTEA"];

    If TypeOf(DataValue) = Type("BinaryData") Then
        Value            = New Structure("BYTEA", Base64String(DataValue));
    Else

        DataFile = New File(String(DataValue));

        If DataFile.Exist() Then

            CurrentData = New BinaryData(String(DataValue));
            Value       = New Structure("BYTEA", Base64String(CurrentData));

        EndIf;

    EndIf;

    Return Value;

EndFunction

Function GetTypesMap()

    DescriptionBool    = New TypeDescription("Boolean");
    DescriptionOldchar = New TypeDescription("Number", , , New NumberQualifiers(1, 0, AllowedSign.Nonnegative));
    DescriptionI       = New TypeDescription("Number", , , New NumberQualifiers(, 0, AllowedSign.Any));
    DescriptionU       = New TypeDescription("Number", , , New NumberQualifiers(, 0, AllowedSign.Nonnegative));
    DescriptionF       = New TypeDescription("Number", , , New NumberQualifiers(, , AllowedSign.Any));
    DescriptionString  = New TypeDescription("String");

    TypesMap = New Map();
    TypesMap.Insert("BOOL"                    , DescriptionBool);
    TypesMap.Insert("""CHAR"""                , DescriptionOldchar);
    TypesMap.Insert("OLDCHAR"                 , DescriptionOldchar);
    TypesMap.Insert("SMALLINT"                , DescriptionI);
    TypesMap.Insert("SMALLSERIAL"             , DescriptionI);
    TypesMap.Insert("INT"                     , DescriptionI);
    TypesMap.Insert("SERIAL"                  , DescriptionI);
    TypesMap.Insert("BIGINT"                  , DescriptionI);
    TypesMap.Insert("BIGSERIAL"               , DescriptionI);
    TypesMap.Insert("TIMESTAMP"               , DescriptionI);
    TypesMap.Insert("TIMESTAMP WITH TIME ZONE", DescriptionI);
    TypesMap.Insert("TIMESTAMP_WITH_TIME_ZONE", DescriptionI);
    TypesMap.Insert("OID"                     , DescriptionU);
    TypesMap.Insert("REAL"                    , DescriptionF);
    TypesMap.Insert("DOUBLE PRECISION"        , DescriptionF);
    TypesMap.Insert("DOUBLE_PRECISION"        , DescriptionF);
    TypesMap.Insert("VARCHAR"                 , DescriptionString);
    TypesMap.Insert("TEXT"                    , DescriptionString);
    TypesMap.Insert("CHAR"                    , DescriptionString);
    TypesMap.Insert("CITEXT"                  , DescriptionString);
    TypesMap.Insert("NAME"                    , DescriptionString);
    TypesMap.Insert("LTREE"                   , DescriptionString);
    TypesMap.Insert("LQUERY"                  , DescriptionString);
    TypesMap.Insert("LTXTQUERY"               , DescriptionString);
    TypesMap.Insert("INET"                    , DescriptionString);
    TypesMap.Insert("UUID"                    , DescriptionString);

    Return TypesMap;

EndFunction

#EndRegion
