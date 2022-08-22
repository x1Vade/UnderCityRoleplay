








fx_version 'cerulean'

games { 'gta5' }

client_script "@ucrp-sync/client/lib.lua"
client_script "@ucrp-lib/client/cl_ui.lua"

client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  'client/cl_*.lua'
}

server_script "@ucrp-lib/server/sv_npx.js"
server_scripts {
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_rpc.js',
  '@ucrp-lib/server/sv_sql.lua',
  '@ucrp-lib/server/sv_sql.js',
  "@ucrp-lib/server/sv_asyncExports.lua",
  'config.lua',
  'server/sv_*.lua',
}

ui_page "./UI/index.html"

files{
    "./UI/index.html",
    "./UI/main.css",
    "./UI/main.js",
}