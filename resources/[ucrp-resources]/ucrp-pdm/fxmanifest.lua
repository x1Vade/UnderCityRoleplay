fx_version 'bodacious'
game 'gta5'
resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"



server_script {
  '@ucrp-lib/client/cl_main.lua',
  '@mysql-async/lib/MySQL.lua',
  "server/*.lua"
} 

client_scripts {
  '@ucrp-lib/server/sv_main.lua',
    "@PolyZone/client.lua",
    "@ucrp-errorlog/client/cl_errorlog.lua",
    "client/*.lua"
  }
