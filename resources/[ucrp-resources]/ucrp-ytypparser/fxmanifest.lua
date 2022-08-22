





fx_version 'cerulean'
games {'gta5'}

-- dependency "ucrp-base"


client_script "@ucrp-errorlog/client/cl_errorlog.lua"


client_script {
	'util/xml.lua',
	'client/ytyp/*',
	'client/cl_ytyp.lua',
	
}

exports {
	'request',
} 