





-- Manifest

fx_version 'cerulean'
games {'gta5'}

client_script "@ucrp-errorlog/client/cl_errorlog.lua"
client_script "@ucrp-lib/client/cl_ui.lua"

client_script "@ucrp-lib/client/cl_polyhooks.lua"
--[[ dependencies {
  'ucrp-lib'
} ]]--

-- General
client_scripts {
  '@ucrp-lib/client/cl_rpc.lua',
  'client.lua',
  'client_trunk.lua',
  'evidence.lua',
  'client/beatmode.lua',
  'client/cl_*.lua'
}


server_scripts {
  "@ucrp-lib/server/sv_asyncExports.lua",
  '@ucrp-lib/server/sv_rpc.lua',
  '@ucrp-lib/server/sv_sql.lua',
  'server.lua',
  'server/beatmode.lua',
  'server/sv_vehicle.lua'
}

exports {
	'getIsInService',
	'getIsCop',
	'getIsCuffed'
} 
