





fx_version 'bodacious'
games { 'rdr3', 'gta5' }


server_export 'AddJob' 
client_script "@ucrp-sync/client/lib.lua"
client_script "@ucrp-lib/client/cl_ui.lua"

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/cursor.png',
	'html/background.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
}


client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
  "@PolyZone/client.lua",
}


server_scripts {
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_sql.lua',
  'server/sv_*.lua',
}