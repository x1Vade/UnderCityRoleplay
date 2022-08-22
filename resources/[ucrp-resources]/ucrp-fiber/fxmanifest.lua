








fx_version "cerulean"

games { "gta5" }

description "Sanyo Fiber"

version "0.1.0"

ui_page 'nui/index.html'

files {
    'nui/**/*',
}

server_scripts {
    "@ucrp-lib/server/sv_npx.js",
    "@ucrp-lib/server/sv_rpc.js",
    "@ucrp-lib/server/sv_sql.js",
    "@ucrp-lib/shared/sh_cacheable.js",
    "@ucrp-lib/server/sv_asyncExports.js",
    "server/*.js",
}

client_scripts {
    "@ucrp-lib/client/cl_rpc.js",
    "client/*.js",
}
