





fx_version 'bodacious'
games { 'rdr3', 'gta5' }

client_scripts {
    'client/*.lua',
    '@ucrp-lib/client/cl_rpc.lua',
}


server_scripts {
    'server/*.lua',
    '@ucrp-lib/server/sv_rpc.lua',
}

lua54 'yes'

export 'harness'