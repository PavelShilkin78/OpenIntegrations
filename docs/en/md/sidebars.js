﻿export default {
 docs: [
 
 {
 type: 'category',
 label: 'Welcome!',
 link: {type: 'doc', id:'Instructions/Start'},
 className: 'Start',
 items:[{type: 'autogenerated', dirName: 'Start'}]
 },

 {
 type: 'category',
 label: 'Messengers',
 className: 'Messenger',
 items: [
 { type: 'category', link: {type: 'doc', id:'Instructions/Telegram'}, label: 'Telegram', className: 'Telegram', items:[{type: 'autogenerated', dirName: 'Telegram'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/Viber'}, label: 'Viber', className: 'Viber', items:[{type: 'autogenerated', dirName: 'Viber'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/Slack'}, label: 'Slack', className: 'Slack', items:[{type: 'autogenerated', dirName: 'Slack'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/VKTeams'}, label: 'VK Teams', className: 'VKTeams', items:[{type: 'autogenerated', dirName: 'VKTeams'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/GreenAPI'}, label: 'Green API (WhatsApp)', className: 'GreenAPI', items:[{type: 'autogenerated', dirName: 'GreenAPI'}]},
 ],
 },
 {
 type: 'category',
 label: 'Social networks',
 className: 'Social',
 items:[
 { type: 'category', link: {type: 'doc', id:'Instructions/VK'}, label: 'VK', className: 'VK', items:[{type: 'autogenerated', dirName: 'VK'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/Twitter'}, label: 'Twitter', className: 'Twitter', items:[{type: 'autogenerated', dirName: 'Twitter'}]},
 ],
 },
 {
 type: 'category',
 label: 'Databases and spreadsheets',
 className: 'Database',
 items:[
 { type: 'category', link: {type: 'doc', id:'Instructions/Airtable'}, label: 'Airtable', className: 'Airtable', items:[{type: 'autogenerated', dirName: 'Airtable'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/GoogleSheets'}, label: 'Google Sheets', className: 'GoogleSheets', items:[{type: 'autogenerated', dirName: 'Google_Sheets'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/PostgreSQL'}, label: 'PostgreSQL', className: 'PostgreSQL', items:[{type: 'autogenerated', dirName: 'PostgreSQL'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/SQLite'}, label: 'SQLite', className: 'SQLite', items:[{type: 'autogenerated', dirName: 'SQLite'}]},
 ],
 },
 {
 type: 'category',
 label: 'File-hosting services and storages',
 className: 'Folder',
 items:[
 { type: 'category', link: {type: 'doc', id:'Instructions/GoogleDrive'}, label: 'Google Drive', className: 'GoogleDrive', items:[{type: 'autogenerated', dirName: 'Google_Drive'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/YandexDisk'}, label: 'Yandex Disk', className: 'YandexDisk', items:[{type: 'autogenerated', dirName: 'Yandex_Disk'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/Dropbox'}, label: 'Dropbox', className: 'Dropbox', items:[{type: 'autogenerated', dirName: 'Dropbox'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/S3'}, label: 'AWS S3 (MinIO)', className: 'S3', items:[{type: 'autogenerated', dirName: 'S3'}]},
 ],
 },
 {
 type: 'category',
 label: 'Complete solutions (CMS, CRM)',
 className: 'CRM',
 items:[
 { type: 'category', link: {type: 'doc', id:'Instructions/Bitrix24'}, label: 'Bitrix24', className: 'Bitrix24', items:[{type: 'autogenerated', dirName: 'Bitrix24'}]},
 ],
 },
 {
    type: 'category',
    label: 'E-commerce and delivery',
    className: 'Commerce',
    items:[
      { type: 'category', link: {type: 'doc', id:'Instructions/Ozon'}, label: 'Ozon', className: 'Ozon', items:[{type: 'autogenerated', dirName: 'Ozon'}]},
      { type: 'category', link: {type: 'doc', id:'Instructions/CDEK'}, label: 'CDEK', className: 'CDEK', items:[{type: 'autogenerated', dirName: 'CDEK'}]},
    ],
  },
 {
 type: 'category',
 label: 'Planning and projects managment ',
 className: 'Calendar',
 items:[
 { type: 'category', link: {type: 'doc', id:'Instructions/GoogleCalendar'}, label: 'Google Calendar', className: 'GoogleCalendar', items:[{type: 'autogenerated', dirName: 'Google_Calendar'}]},
 { type: 'category', link: {type: 'doc', id:'Instructions/Notion'}, label: 'Notion', className: 'Notion', items:[{type: 'autogenerated', dirName: 'Notion'}]},
 ],
 },
 {
  type: 'category',
  label: 'Other',
  className: 'Other',
  items:[
    { type: 'category', link: {type: 'doc', id:'Instructions/Neocities'}, label: 'Neocities', className: 'Neocities', items:[{type: 'autogenerated', dirName: 'Neocities'}]},
    { type: 'category', link: {type: 'doc', id:'Instructions/TCP'}, label: 'TCP', className: 'TCP', items:[{type: 'autogenerated', dirName: 'TCP'}]},
    { type: 'category', link: {type: 'doc', id:'Instructions/RCON'}, label: 'RCON', className: 'RCON', items:[{type: 'autogenerated', dirName: 'RCON'}]},
  ]
}
 ],
};
