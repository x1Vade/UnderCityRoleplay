RegisterNetEvent('FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop:spawnVehicle')
local vehshop_blips = {}
local financedPlates = {}
local FullBuyPlates = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local commissionbuy = 0
local insideVehShop = false
local rank = 0

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 2500, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 2500, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 10000, description = {}, model = "rumpo"},
				{name = "Food Truck New", costs = 2500, description = {}, model = "taco"},
				{name = "Best Bud Van", costs = 20000, description = {}, model = "nspeedo"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 150, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 2500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 2600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 2900, description = {}, model = "tribike3"},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
				{name = "S Class", description = ''},
				{name = "A Class", description = ''},
				{name = "B Class", description = ''},
				{name = "C Class", description = ''},
				{name = "D Class", description = ''},
				{name = "Off Road", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 2500, description = {}, model = "taxi"},
				{name = "Flatbed", costs = 2500, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 10000, description = {}, model = "rumpo"},
				{name = "Patriot Stretch", costs = 10000, description = {}, model = "patriot2"},
				{name = "Stretch", costs = 10000, description = {}, model = "stretch"},
				{name = "Taco Van", costs = 2500, description = {}, model = "taco"},
			}
		},
		["sclass"] = {
			title = "sclass",
			name = "sclass",
			buttons = {	
				{name = "Bravado Gauntlet Classic", costs = 250000, description = {}, model = "gauntlet3"},
				{name = "Grotti Furia", costs = 500000, description = {}, model = "furia"},
				{name = "Vapid Peyote Gasser", costs = 185000, description = {}, model = "peyote2"},
				{name = "Vulcar Nebula Turbo", costs = 250000, description = {}, model = "nebula"},
				{name = "Grotti Turismo Classic", costs =450000, description = {}, model = "turismo2"},
				{name = "Itali GTO", costs = 650000, description = {}, model = "italigto"},
				{name = "Itali RSX", costs = 550000, description = {}, model = "italirsx"},
				{name = "Gauntlet HELFIRE", costs = 450000, description = {}, model = "gauntlet4"},
				{name = "Comet SR", costs = 250000, description = {}, model = "comet5"},
				{name = "Dominator GTX", costs = 550000, description = {}, model = "dominator3"},
				{name = "Jester Retro", costs = 550000, description = {}, model = "jester3"},
				{name = "Jester RR", costs = 550000, description = {}, model = "Jester4"},
				{name = "Dominator ASP", costs = 450000, description = {}, model = "Dominator7"},
				{name = "Vectre", costs = 350000, description = {}, model = "Vectre"},
				{name = "Sultan RS", costs = 334000, description = {}, model = "SultanRS"},
				{name = "ZR350", costs = 400000, description = {}, model = "ZR350"},
				{name = "Elegy Retro Custom", costs = 550000, description = {}, model = "elegy"},
				{name = "Progen T20", costs = 650000, description = {}, model = "T20"},
				{name = "Remus", costs = 280000, description = {}, model = "Remus"},
				{name = "RT3000", costs = 350000, description = {}, model = "RT3000"},
				{name = "Dominator GTT", costs = 250000, description = {}, model = "DOMINATOR8"},
				{name = "Annis Euros", costs = 350000, description = {}, model = "EUROS"},
				{name = "Futo GTX", costs = 200000, description = {}, model = "Futo2"},
				{name = "Calico GTF", costs = 400000, description = {}, model = "Calico"},
				{name = "Comet S2", costs = 520000, description = {}, model = "COMET6"},
				{name = "UBERMACHT Cypher", costs = 520000, description = {}, model = "Cypher"},
				{name = "Growler", costs = 350000, description = {}, model = "Growler"},
				{name = "Sultan RS classic", costs = 350000, description = {}, model = "Sultan3"},
				{name = "Banshee 900R", costs = 450000, description = {}, model = "banshee2"},
				{name = "Coquette D10", costs = 950000, description = {}, model = "coquette4"},
				{name = "Schlagen GT", costs = 335000, description = {}, model = "Schlagen"},
				{name = "Infernus Classic", costs = 400000, description = {}, model = "infernus2"},
				{name = "Deviant", costs = 490000, description = {}, model = "deviant"},
				{name = "Grotti Turismo R", costs = 450000, description = {}, model = "turismor"},
				{name = "Previon", costs = 425000, description = {}, model = "Previon"},
			}
		},
		["aclass"] = {
			title = "aclass",
			name = "aclass",
			buttons = {
				{name = "Pegassi Toros", costs = 145000, description = {}, model = "toros"},
				{name = "Dewbauchee Seven-70", costs = 177000, description = {}, model = "seven70"},
				{name = "Dewbauchee Specter", costs = 155000, description = {}, model = "specter"},
				{name = "Dewbauchee Specter Sport", costs = 170000, description = {}, model = "specter2"},
				{name = "Dinka Jester", costs = 130000, description = {}, model = "jester"},
				{name = "Bravado Banshee", costs = 130000, description = {}, model = "banshee"},
				{name = "Invetero Coquette", costs = 115000, description = {}, model = "coquette"},
				{name = "Obey 9F", costs = 100000, description = {}, model = "ninef"},
				{name = "Ocelot Locust", costs = 125000, description = {}, model = "locust"},
				{name = "Obey 9F Cabrio", costs = 120000, description = {}, model = "ninef2"},
				{name = "Albany Alpha", costs = 100000, description = {}, model = "alpha"},
				{name = "Grotti Bestia GTS", costs = 160000, description = {}, model = "bestiagts"},
				{name = "Grotti Carbonizzare", costs = 110000, description = {}, model = "carbonizzare"},
				{name = "Pfister Comet", costs = 130000, description = {}, model = "comet2"},
				{name = "Pfister Comet Retro", costs = 150000, description = {}, model = "comet3"},
				{name = "Benefactor Feltzer", costs = 125000, description = {}, model = "feltzer2"},
				{name = "Lampadati Furore GT", costs = 100000, description = {}, model = "furoregt"},
				{name = "Dewbauchee Massacro", costs = 150000, description = {}, model = "massacro"},
				{name = "Ocelot Pariah", costs = 123000, description = {}, model = "pariah"},
				{name = "Dewbauchee Rapid GT", costs = 100000, description = {}, model = "rapidgt"},
				{name = "Dewbauchee Rapid GT Cabrio", costs = 120000, description = {}, model = "rapidgt2"},
				{name = "Hijak Ruston", costs = 160000, description = {}, model = "ruston"},
				{name = "Benefactor Schwartzer", costs = 105000, description = {}, model = "schwarzer"},
				{name = "Benefactor Surano", costs = 125000, description = {}, model = "surano"},
				{name = "Enus Cognoscenti Cabrio", costs = 130000, description = {}, model = "cogcabrio"},
				{name = "Ocelot F620", costs = 120000, description = {}, model = "f620"},
				{name = "Lampadati Felon GT", costs = 120000, description = {}, model = "zion"},
				{name = "Ubermacht Zion", costs = 110000, description = {}, model = "furoregt"},
				{name = "Ubermacht Zion Cabrio", costs = 120000, description = {}, model = "zion2"},
				{name = "Enus Windsor", costs = 200000, description = {}, model = "windsor"},
				{name = "Grotti Brioso R/A", costs = 90000, description = {}, model = "brioso"},
				{name = "Coil Voltic", costs = 104000, description = {}, model = "voltic"},
				{name = "Vapid Dominator", costs = 160000, description = {}, model = "dominator"},
				{name = "Enus Stafford", costs = 100000, description = {}, model = "stafford"},
				{name = "Vapid Blade", costs = 100000, description = {}, model = "blade"},
				{name = "Imponte Dukes", costs = 90000, description = {}, model = "dukes"},
				{name = "Declasse Vamos", costs = 100000, description = {}, model = "vamos"},
				{name = "Vapid Ellie", costs = 105000, description = {}, model = "ellie"},
				{name = "Imponte Ruiner", costs = 140000, description = {}, model = "ruiner"},
				{name = "Declasse Sabre Turbo", costs = 130000, description = {}, model = "sabregt"},
				{name = "Vapid Slamvan", costs = 50000, description = {}, model = "slamvan"},
				{name = "Vapid Slamvan Custom", costs = 76000, description = {}, model = "slamvan3"},
				{name = "Kanjo", costs = 135000, description = {}, model = "kanjo"},
				{name = "Elegy RH8", costs = 150000, description = {}, model = "elegy2"},
				{name = "Penumbra FF", costs = 250000, description = {}, model = "Penumbra2"},
				{name = "Ober Tailgater S", costs = 200000, description = {}, model = "Tailgater2"},
				{name = "Ocelot Jugular", costs = 200000, description = {}, model = "Jugular"},
				{name = "Drafter", costs = 200000, description = {}, model = "Drafter"},
			}
		},
		["bclass"] = {
			title = "bclass",
			name = "bclass",
			buttons = {
				{name = "Lampadati Komoda", costs = 105000, description = {}, model = "komoda"},
				{name = "Dinka Blista", costs = 30000, description = {}, model = "blista"},
				{name = "Albany VSTR", costs = 115000, description = {}, model = "vstr"},
				{name = "Dinka Sugoi", costs = 90000, description = {}, model = "sugoi"},
				{name = "Karin Kuruma", costs = 55000, description = {}, model = "kuruma"},
				{name = "Vapid GB200", costs = 60000, description = {}, model = "gb200"},
				{name = "Lampadati Tropos Rally", costs = 65000, description = {}, model = "tropos"},
				{name = "Bollokon Prairie", costs = 90000, description = {}, model = "prairie"},
				{name = "Annis Savestra", costs = 65000, description = {}, model = "savestra"},
				{name = "Ubermacht Sentinel", costs = 55000, description = {}, model = "sentinel"},
				{name = "Ubermacht Sentinel XS", costs = 55000, description = {}, model = "sentinel2"},
				{name = "Ubermacht Zion Classic", costs = 70000, description = {}, model = "zion3"},
				{name = "Bravado Buffalo", costs = 68000, description = {}, model = "buffalo"},
				{name = "Bravado Buffalo S", costs = 85000, description = {}, model = "buffalo2"},				
				{name = "Enus Windsor Drop", costs = 105000, description = {}, model = "windsor2"},
				{name = "Shyster Fusilade", costs = 75000, description = {}, model = "fusilade"},
				{name = "Karin Futo", costs = 65000, description = {}, model = "futo"},
				{name = "Revolter", costs = 110000, description = {}, model = "revolter"},
				{name = "Ubermacht Schafter", costs = 100000, description = {}, model = "schafter2"},
				{name = "Enus Cognoscenti", costs = 85000, description = {}, model = "cognoscenti"},
				{name = "Enus Cognoscenti 55", costs = 105000, description = {}, model = "cog55"},
				{name = "Cheval Fugitive", costs = 50000, description = {}, model = "fugitive"},
				{name = "Karin Intruder", costs = 50000, description = {}, model = "intruder"},
				{name = "Declasse Premier", costs = 30000, description = {}, model = "premier"},
				{name = "Zirconium Stratum", costs = 131000, description = {}, model = "stratum"},
				{name = "Enus Super Diamond", costs = 80000, description = {}, model = "superd"},
				{name = "Obey Tailgater", costs = 70000, description = {}, model = "tailgater"},
				{name = "Dewbauchee Exemplar", costs = 120000, description = {}, model = "exemplar"},
				{name = "Ocelot Jackal", costs = 130000, description = {}, model = "jackal"},
				{name = "Ubermacht Oracle", costs = 86000, description = {}, model = "oracle"},
				{name = "Ubermacht Oracle XS", costs = 120000, description = {}, model = "oracle2"},
				{name = "Lampadati Felon", costs = 85000, description = {}, model = "felon"},
				{name = "Coil Raiden", costs = 140000, description = {}, model = "raiden"},
				{name = "Cheval Surge", costs = 60000, description = {}, model = "surge"},
				{name = "Ubermacht Rebla", costs = 100000, description = {}, model = "rebla"},
				{name = "Lampadati Novak", costs = 110000, description = {}, model = "novak"},				
				{name = "Gallivanter Baller LE", costs = 140000, description = {}, model = "baller3"},
				{name = "Benefactor Dubsta Mandem", costs = 130000, description = {}, model = "dubsta2"},
				{name = "Benefactor Dubsta", costs = 110000, description = {}, model = "dubsta"},
				{name = "Bravado Gresley", costs = 90000, description = {}, model = "gresley"},
				{name = "Enus Huntley S", costs = 115000, description = {}, model = "huntley"},
				{name = "Obey Rocoto", costs = 45000, description = {}, model = "rocoto"},
				{name = "Benefactor Serrano", costs = 100000, description = {}, model = "serrano"},
				{name = "Benefactor XLS", costs = 105500, description = {}, model = "xls"},
				{name = "Vapid Scuffvan Custom", costs = 80000, description = {}, model = "minivan2"},
				{name = "Weeny Issi Sport", costs = 75500, description = {}, model = "issi7"},
				{name = "Lampadati Michelli GT", costs = 60000, description = {}, model = "michelli"},
				{name = "Vapid Retinue", costs = 100000, description = {}, model = "retinue"},
				{name = "Vapid Retinue MkII", costs = 120000, description = {}, model = "retinue2"},
				{name = "Nagasaki Outlaw", costs = 135000, description = {}, model = "outlaw"},
				{name = "Maxwell Vagrant", costs = 10000, description = {}, model = "vagrant"},
				{name = "Karin Everon", costs = 45000, description = {}, model = "everon"},
				{name = "Vapid Trophy Truck", costs = 90000, description = {}, model = "trophytruck"},
				{name = "Vapid Desert Raid", costs = 95000, description = {}, model = "trophytruck2"},
				{name = "Vapid Slamvan", costs = 45000, description = {}, model = "cheburek"},
				{name = "RUNE Cheburek", costs = 40000, description = {}, model = "zion3"},
				{name = "Albany Buccaneer", costs = 70000, description = {}, model = "buccaneer"},
				{name = "Albany Buccaneer Custom", costs = 100000, description = {}, model = "buccaneer2"},				
				{name = "Vapid Clique", costs = 50000, description = {}, model = "clique"},
				{name = "Willard Faction", costs = 65000, description = {}, model = "faction"},
				{name = "Declasse Impaler", costs = 50000, description = {}, model = "impaler"},
				{name = "Imponte Nightshade", costs = 87000, description = {}, model = "nightshade"},
				{name = "Imponte Phoenix", costs = 55000, description = {}, model = "phoenix"},
				{name = "Cheval Picador", costs = 42000, description = {}, model = "picador"},
				{name = "Bravado Rat-Truck", costs = 55000, description = {}, model = "ratloader2"},
				{name = "Declasse Sabre Turbo Custom", costs = 110000, description = {}, model = "sabregt2"},
				{name = "Declasse Stallion", costs = 77000, description = {}, model = "stalion"},
				{name = "Declasse Tulip", costs = 85000, description = {}, model = "tulip"},
				{name = "Declasse Vigero", costs = 90000, description = {}, model = "vigero"},
				{name = "Albany Virgo", costs = 65000, description = {}, model = "virgo"},
				{name = "Benefactor Stirling GT", costs = 125000, description = {}, model = "feltzer3"},
				{name = "Invetero Coquette Classic", costs = 115000, description = {}, model = "coquette2"},
				{name = "Invetero Coquette Blackfin", costs = 125000, description = {}, model = "coquette3"},
				{name = "Grotti GT500", costs = 105000, description = {}, model = "gt500"},
				{name = "Declasse Mamba", costs = 106000, description = {}, model = "mamba"},
				{name = "Grotti Stinger", costs = 145000, description = {}, model = "stinger"},
				{name = "Grotti Stinger GT", costs = 120000, description = {}, model = "stingergt"},
				{name = "Ocelot Swinger", costs = 110000, description = {}, model = "swinger"},
				{name = "Lampadati Viseris", costs = 130000, description = {}, model = "viseris"},
				{name = "Dewbauchee Rapid GT Classic", costs = 135000, description = {}, model = "rapidgt3"},
				{name = "HK Warrener", costs = 135000, description = {}, model = "Warrener2"},
			}
		},
		["cclass"] = {
			title = "cclass",
			name = "cclass",
			buttons = {
				{name = "Dinka Blista Compact", costs = 25000, description = {}, model = "blista2"},
				{name = "Karin Asterope", costs = 30000, description = {}, model = "asterope"},
				{name = "Vulcar Ingot", costs = 28000, description = {}, model = "ingot"},
				{name = "Albany Primo", costs = 40000, description = {}, model = "primo"},
				{name = "Albany Primo Custom", costs = 42000, description = {}, model = "primo2"},
				{name = "Vapid Stanier", costs = 34000, description = {}, model = "stanier"},
				{name = "Vulcar Warrener", costs = 30500, description = {}, model = "warrener"},
				{name = "Albany Washington", costs = 32500, description = {}, model = "washington"},
				{name = "Weeny Issi", costs = 31500, description = {}, model = "issi2"},
				{name = "Benefactor Panto", costs = 30000, description = {}, model = "panto"},
				{name = "Declasse Rhapsody", costs = 32500, description = {}, model = "rhapsody"},
				{name = "Gallivanter Baller", costs = 80000, description = {}, model = "baller"},
				{name = "Gallivanter Baller 2", costs = 120000, description = {}, model = "baller2"},
				{name = "Karin BeeJay XL", costs = 36000, description = {}, model = "bjxl"},
				{name = "Albany Cavalcade", costs = 50000, description = {}, model = "cavalcade"},
				{name = "Albany Cavalcade 2", costs = 70000, description = {}, model = "cavalcade2"},
				{name = "Fathom FQ-2", costs = 34000, description = {}, model = "fq2"},
				{name = "Karin 190z", costs = 100000, description = {}, model = "z190"},
				{name = "Lampadati Casco", costs = 67000, description = {}, model = "casco"},
				{name = "Declasse Granger", costs = 70000, description = {}, model = "granger"},
				{name = "Emperor Habanero", costs = 57500, description = {}, model = "habanero"},
				{name = "Dundreary Landstalker", costs = 35000, description = {}, model = "landstalker"},
				{name = "Vapid Radius", costs = 24500, description = {}, model = "radi"}, 
				{name = "Canis Seminole", costs = 35000, description = {}, model = "seminole"},
				{name = "Bravado Youga", costs = 17000, description = {}, model = "youga"},
				{name = "Vapid Caracara", costs = 67000, description = {}, model = "caracara2"},
				{name = "Vapid Contender", costs = 77000, description = {}, model = "contender"},
				{name = "Bravado Rumpo Custom", costs = 29000, description = {}, model = "rumpo3"},
				{name = "Benefactor Streiter", costs = 39000, description = {}, model = "streiter"},
				{name = "Canis Mesa", costs = 22000, description = {}, model = "mesa"},
				{name = "Canis Mesa Lifted", costs = 56000, description = {}, model = "mesa3"},
				{name = "Pfister Comet Safari", costs = 57000, description = {}, model = "comet4"},
				{name = "BF Bifta", costs = 15000, description = {}, model = "bifta"},
				{name = "Coil Brawler", costs = 50000, description = {}, model = "brawler"},
				{name = "Benefactor Dubsta 6x6", costs = 85000, description = {}, model = "dubsta3"},
				{name = "BF Dune Buggy", costs = 20000, description = {}, model = "dune"},
				{name = "Canis Freecrawler", costs = 50000, description = {}, model = "freecrawler"},
				{name = "Canis Kamacho", costs = 60000, description = {}, model = "kamacho"},
				{name = "Karin Rebel", costs = 40000, description = {}, model = "rebel2"},
				{name = "Vapid Guardian", costs = 60000, description = {}, model = "guardian"},
				{name = "Bravado Bison", costs = 30000, description = {}, model = "bison"},
				{name = "Vapid Bobcat XL", costs = 38000, description = {}, model = "bobcatxl"},
				{name = "Vapid Riata", costs = 50000, description = {}, model = "riata"},
				{name = "Benefactor Glendale", costs = 30000, description = {}, model = "glendale"},
				{name = "Vulcar Fagaloa", costs = 100000, description = {}, model = "fagaloa"},
				{name = "Weeny Issi Classic", costs = 55000, description = {}, model = "issi3"},
				{name = "Willard Faction Donk", costs = 40000, description = {}, model = "faction3"},
				{name = "Vapid Chino", costs = 45000, description = {}, model = "chino"},
				{name = "Vapid Chino Custom", costs = 57000, description = {}, model = "chino2"},
				{name = "Vapid Hotknife", costs = 25000, description = {}, model = "hotknife"},
				{name = "Albany Roosevelt", costs = 50000, description = {}, model = "btype"}, 
				{name = "Albany Roosevelt Valor", costs = 60000, description = {}, model = "btype3"},
				{name = "Truffade Z-Type", costs = 50000, description = {}, model = "ztype"},
				{name = "Declasse Moonbeam", costs = 15000, description = {}, model = "moonbeam"},
				{name = "Declasse Moonbeam Custom", costs = 20000, description = {}, model = "moonbeam2"},
			}
		},
		["dclass"] = {
			title = "dclass",
			name = "dclass",
			buttons = {
				{name = "Declasse Asea", costs = 15000, description = {}, model = "asea"},
				{name = "Declasse Emperor", costs = 22500, description = {}, model = "emperor"},
				{name = "Dundreary Regina", costs = 10000, description = {}, model = "regina"},
				{name = "Chariot Romero Hearse", costs = 50000, description = {}, model = "romero"},
				{name = "Vapid Minivan", costs = 17000, description = {}, model = "minivan"},
				{name = "Bravado Paradise", costs = 19000, description = {}, model = "paradise"},
				{name = "Brute Pony", costs = 12000, description = {}, model = "pony"},
				{name = "Bravado Rumpo News", costs = 4000, description = {}, model = "rumpo"},	
				{name = "Bravado Rumpo HerrKutz", costs = 9000, description = {}, model = "rumpo2"},
				{name = "Vapid Speedo", costs = 10000, description = {}, model = "speedo"},
				{name = "Brute Camper", costs = 16000, description = {}, model = "camper"},
				{name = "Declasse Burrito", costs = 12000, description = {}, model = "burrito3"},
				{name = "Canis Kalahari", costs = 16000, description = {}, model = "kalahari"},
				{name = "Declasse Burrito G", costs = 20000, description = {}, model = "gburrito"},
				{name = "Declasse Burrito G2", costs = 13000, description = {}, model = "gburrito2"},
				{name = "Karin Dilettante", costs = 18500, description = {}, model = "dilettante"},
				{name = "Canis Bodhi", costs = 16000, description = {}, model = "bodhi2"},
				{name = "Declasse Rancher XL", costs = 20000, description = {}, model = "rancherxl"},
				{name = "Bravado Duneloader", costs = 14000, description = {}, model = "dloader"},
				{name = "Vapid Sadler", costs = 10000, description = {}, model = "sadler"},
				{name = "Vapid Sandking", costs = 22000, description = {}, model = "sandking2"},
				{name = "Vapid Sandking XL", costs = 35000, description = {}, model = "sandking"},
				{name = "Weeny Dynasty", costs = 23500, description = {}, model = "dynasty"},
				{name = "BF Surfer", costs = 8000, description = {}, model = "surfer"},
				{name = "Albany Hermes", costs = 13000, description = {}, model = "hermes"},
				{name = "Vapid Hustler", costs = 15000, description = {}, model = "hustler"},
				{name = "Albany Virgo Custom", costs = 40000, description = {}, model = "virgo2"},
				{name = "Albany Virgo Classic", costs = 30000, description = {}, model = "virgo3"},
				{name = "Albany Manana", costs = 30000, description = {}, model = "manana"},
				{name = "Declasse Voodoo", costs = 30000, description = {}, model = "voodoo"},		
				{name = "Vapid Peyote", costs = 35000, description = {}, model = "peyote"},
				{name = "Declasse Tornado", costs = 22000, description = {}, model = "tornado"},
				{name = "Declasse Tornado Cabrio", costs = 30000, description = {}, model = "tornado2"},
				{name = "Declasse Tornado Custom", costs = 35000, description = {}, model = "tornado5"},
				{name = "Lampadati Pigalle", costs = 10000, description = {}, model = "pigalle"},				
				{name = "Bravado Youga Classic", costs = 16000, description = {}, model = "youga2"},
			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "Bifta", costs = 31000, description = {}, model = "bifta"},
				{name = "Blazer", costs = 7000, description = {}, model = "blazer"},
				{name = "Blazer Sport", costs = 21000, description = {}, model = "blazer4"},
				{name = "Bodhi", costs = 16000, description = {}, model = "bodhi2"},
				{name = "Brawler", costs = 24000, description = {}, model = "brawler"},
				{name = "Caracara", costs = 31000, description = {}, model = "caracara2"},
				{name = "Desert Raid", costs = 41000, description = {}, model = "trophytruck2"},
				{name = "Dubsta 6x6", costs = 50000, description = {}, model = "dubsta3"},
				{name = "Dune Buggy", costs = 20000, description = {}, model = "dune"},
				{name = "Everon", costs = 43000, description = {}, model = "everon"},
				{name = "Freecrawler", costs = 48000, description = {}, model = "freecrawler"},
				{name = "Guardian", costs = 32000, description = {}, model = "guardian"},
				{name = "Hellion", costs = 50000, description = {}, model = "hellion"},
				-- {name = "Injection", costs = 999999, description = {}, model = "bfinjection"},
				{name = "Kamacho", costs = 31000, description = {}, model = "kamacho"},
				{name = "Lifted Mesa", costs = 35000, description = {}, model = "mesa3"},
				{name = "Outlaw", costs = 40000, description = {}, model = "outlaw"},
				{name = "Rebel", costs = 21000, description = {}, model = "rebel2"},
				{name = "Riata", costs = 35000, description = {}, model = "riata"},
				{name = "Sandking", costs = 35000, description = {}, model = "sandking"},
				{name = "Trophy Truck", costs = 42000, description = {}, model = "trophytruck"},
				{name = "Vagrant", costs = 41000, description = {}, model = "vagrant"},
				{name = "Yosemite Rancher", costs = 999999, description = {}, model = "yosemite3"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Baller", costs = 20000, description = {}, model = "baller"},
				{name = "Baller 2", costs = 25000, description = {}, model = "baller2"},
				{name = "Baller LE", costs = 41000, description = {}, model = "baller3"},
				{name = "Baller LE LWB", costs = 45000, description = {}, model = "baller4"},
				--{name = "BeeJay XL", costs = 999999, description = {}, model = "bjxl"},
				-- {name = "Cavalcade", costs = 999999, description = {}, model = "cavalcade"},
				{name = "Cavalcade 2", costs = 30000, description = {}, model = "cavalcade2"},
				{name = "Contender", costs = 55000, description = {}, model = "contender"},
				{name = "Dubsta", costs = 40000, description = {}, model = "dubsta"},
				-- {name = "FQ 2", costs = 999999, description = {}, model = "fq2"},
				{name = "Granger", costs = 26000, description = {}, model = "granger"},
				{name = "Gresley", costs = 35000, description = {}, model = "gresley"},
				-- {name = "Habanero", costs = 999999, description = {}, model = "habanero"},
				{name = "Huntley S", costs = 42000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 26000, description = {}, model = "landstalker"},
				{name = "Landstalker XL", costs = 32000, description = {}, model = "landstalker2"},
				{name = "Mesa", costs = 29000, description = {}, model = "mesa"},
				{name = "Novak", costs = 42000, description = {}, model = "novak"},
				{name = "Patriot", costs = 25000, description = {}, model = "patriot"},
				{name = "Radius", costs = 22000, description = {}, model = "radi"},
				{name = "Rebla", costs = 40000, description = {}, model = "rebla"},
				{name = "Rocoto", costs = 40000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 21000, description = {}, model = "seminole"},
				--{name = "Seminole Frontier", costs = 999999, description = {}, model = "seminole2"},
				-- {name = "Serrano", costs = 999999, description = {}, model = "serrano"},
				{name = "Toros", costs = 65000, description = {}, model = "toros"},
				{name = "XLS", costs = 40000, description = {}, model = "xls"},
			}
		},
		["motorcycles"] = {
			title = "motorcycles",
			name = "motorcycles",
			buttons = {
				{name = "Akuma", costs = 35000, description = {}, model = "AKUMA"}, 
				{name = "Avarus", costs = 30000, description = {}, model = "avarus"},
				{name = "Bagger", costs = 30000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 25000, description = {}, model = "bati"},
				{name = "BF400", costs = 20000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 35000, description = {}, model = "carbonrs"},
				{name = "Chimera", costs = 40000, description = {}, model = "chimera"},
				--{name = "Cliffhanger", costs = 999999, description = {}, model = "cliffhanger"},
				{name = "Daemon (Lost)", costs = 25000, description = {}, model = "daemon"},
				{name = "Daemon", costs = 30000, description = {}, model = "daemon2"},
				{name = "Defiler", costs = 40000, description = {}, model = "defiler"},
				--{name = "Diabolus", costs = 999999, description = {}, model = "diablous"},
				--{name = "Diabolus Custom", 999999 = 38000, description = {}, model = "diablous2"},
				{name = "Double-T", costs = 40000, description = {}, model = "double"},
				{name = "Enduro", costs = 20000, description = {}, model = "enduro"},
				{name = "Esskey", costs = 30000, description = {}, model = "esskey"},
				{name = "Faggio", costs = 5000, description = {}, model = "faggio2"},
				--{name = "Faggio Mod", costs = 999999, description = {}, model = "faggio3"},
				{name = "Faggio Sport", costs = 5000, description = {}, model = "faggio"},
				--{name = "FCR 1000", costs = 999999, description = {}, model = "fcr"},
				--{name = "FCR 1000 Custom", costs = 999999, description = {}, model = "fcr2"},
				{name = "Gargoyle", costs = 35000, description = {}, model = "gargoyle"},
				{name = "Hakuchou", costs = 56000, description = {}, model = "hakuchou"},
				{name = "Hakuchou Drag", costs = 63000, description = {}, model = "hakuchou2"},
				{name = "Hexer", costs = 35000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 35000, description = {}, model = "innovation"},
				{name = "Lectro", costs = 35000, description = {}, model = "lectro"},
				{name = "Manchez", costs = 25000, description = {}, model = "manchez"},
				{name = "Nightblade", costs = 48000, description = {}, model = "nightblade"},
				{name = "Nemesis", costs = 25000, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 30000, description = {}, model = "pcj"},
				-- {name = "Rampant Rocket", costs = 999999, description = {}, model = "rrocket"},
				-- {name = "Rat Bike", costs = 999999, description = {}, model = "ratbike"},
				{name = "Ruffian", costs = 30000, description = {}, model = "ruffian"},
				--{name = "Sanchez", costs = 999999, description = {}, model = "sanchez2"},
				{name = "Sanchez (Livery)", costs = 15000, description = {}, model = "sanchez"},
				{name = "Sanctus", costs = 38000, description = {}, model = "sanctus"},
				{name = "Sovereign", costs = 40000, description = {}, model = "sovereign"},
				{name = "Stryder", costs = 55000, description = {}, model = "stryder"},
				-- {name = "Thrust", costs = 999999, description = {}, model = "thrust"},
				{name = "Vader", costs = 25000, description = {}, model = "vader"},
				--{name = "Vindicator", costs = 999999, description = {}, model = "vindicator"},
				{name = "Vortex", costs = 25000, description = {}, model = "vortex"},
				{name = "Wolfsbane", costs = 45000, description = {}, model = "wolfsbane"},
				{name = "Zombie Bobber", costs = 40000, description = {}, model = "zombiea"},
				{name = "Zombie Chopper", costs = 42000, description = {}, model = "zombieb"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 550, description = {}, model = "bmx"},
				--{name = "Unicycle", costs = 75, description = {}, model = "unicycle"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 2500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 2600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 2900, description = {}, model = "tribike3"},
			}
		},
	}
}




local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-33.737,-1102.322,26.422},
		inside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
		outside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
	}
}

local carspawns = {
	[1] =  { ['x'] = -54.23,['y'] = -1096.54,['z'] = 26.43,['h'] = 228.89, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = -49.9,['y'] = -1083.77,['z'] = 27.3,['h'] = 200.33, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = -36.86,['y'] = -1093.07,['z'] = 27.3,['h'] = 106.71, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = -42.66,['y'] = -1101.57,['z'] = 27.3,['h'] = 282.07, ['info'] = ' Car Spot 4' },
	[5] =  { ['x'] = -47.52,['y'] =  -1092.68,['z'] = 27.3,['h'] = 188.61, ['info'] = ' Car Spot 5' },
}

local carTable = {
	[1] = { ["model"] = "gauntlet", ["baseprice"] = 100000, ["commission"] = 15 }, 
	[2] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[5] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	carTable[currentCarSpawnLocation]["model"] = model
	carTable[currentCarSpawnLocation]["baseprice"] = price
	carTable[currentCarSpawnLocation]["name"] = name
	TriggerServerEvent("carshop:table",carTable)
end



local myspawnedvehs = {}

RegisterNetEvent("car:testdrive")
AddEventHandler("car:testdrive", function()
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end	

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end
	
	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-51.51, -1077.96, 26.92, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,-23.53, -1094.75, 26.83,true,false)
		local vehplate = "CAR"..math.random(10000,99999) 
		SetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		local plt = GetVehicleNumberPlateText(veh)
		TriggerEvent("keys:addNew",veh, plt)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		myspawnedvehs[veh] = true
	else

		TriggerEvent("DoLongHudText","A car is on the spawn point.",2)

	end

end)

RegisterCommand('finance', function()
	TriggerEvent('finance')
end)
	
RegisterCommand("testdrive", function(source)
	TriggerEvent("car:testdrive")
end)

RegisterNetEvent("finance")
AddEventHandler("finance", function()
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end	
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)	
	TriggerServerEvent("finance:enable",vehplate)
end)

RegisterNetEvent("finance:enableOnClient")
AddEventHandler("finance:enableOnClient", function(addplate)
	financedPlates[addplate] = true
	Citizen.Wait(60000)
	financedPlates[addplate] = nil
end)	




RegisterCommand('enablebuy', function()
	TriggerEvent('buy')
end)

RegisterNetEvent("buy")
AddEventHandler("buy", function()
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end	
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)	
	TriggerServerEvent("buy:enable",vehplate)
end)

RegisterNetEvent("buy:enableOnClient")
AddEventHandler("buy:enableOnClient", function(addplate)
	FullBuyPlates[addplate] = true
	Citizen.Wait(60000)
	FullBuyPlates[addplate] = nil
end)	








RegisterNetEvent("commission")
AddEventHandler("commission", function(newAmount)
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("carshop:table",carTable)

		end
	end
end)

RegisterNetEvent("ucrp-vehicleshop:returnTable")
AddEventHandler("ucrp-vehicleshop:returnTable", function(newTable)

	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()

end)

local hasspawned = false

local spawnedvehicles = {}
local vehicles_spawned = false
function BuyMenu()
	for i = 1, #carspawns do

		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end

			
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) then
				local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
				local addplate = GetVehicleNumberPlateText(veh)
				if FullBuyPlates[addplate] ~= nil then
					TriggerEvent("DoLongHudText","Attempting Purchase")
					AttemptBuy(i,false)
				else
					TriggerEvent("DoLongHudText", "You need a sales rep to help you")
				end
			end

			if IsControlJustReleased(0,23) or IsDisabledControlJustReleased(0,23) then
				local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
				local addplate = GetVehicleNumberPlateText(veh)
				if financedPlates[addplate] ~= nil then
					TriggerEvent("DoLongHudText","Attempting Purchase")
					AttemptBuy(i,true)
				else
					TriggerEvent("DoLongHudText", "You need a sales rep to help you")
				end
			end
		end
	end
end

function AttemptBuy(tableid,financed)

	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local price = baseprice + (baseprice * commission/100)
	local vehname = GetDisplayNameFromVehicleModel(model)
	if baseprice > 200000 and not financed then
		TriggerEvent("DoLongHudText","This vehicle must be financed.",2)
		return
	end
	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerServerEvent('CheckMoneyForVeh', vehname, model, price, financed)
	commissionbuy = (baseprice * commission/200)

end



function OwnerMenu()

	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
				TriggerEvent("DoLongHudText","We Opened")
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end

end

function DrawPrices()
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local rank = exports["isPed"]:GroupRank("car_shop")
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if rank > 0 then
				if financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price/3) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy | [F] to Finance ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy. ")
				end
			else
				if financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " $" .. math.ceil(price) .. " upfront, $" .. math.ceil(price/3) .. " over 10 weeks, [F] to finance. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " ")
				end			
			end
		end
	end
end
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
function SpawnSaleVehicles()
	if not hasspawned then
		TriggerServerEvent("carshop:requesttable")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles(true)
	hasspawned = true
	for i = 1, #carTable do
		local model = GetHashKey(carTable[i]["model"])
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]-1,carspawns[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)

		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		SetVehicleNumberPlateText(veh, i .. "CARSALE")
	end
	vehicles_spawned = true
end

function DespawnSaleVehicles(pDontWait)
	if pDontWait == nil and not pDontWait then
		Wait(15000)
	end
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
end




Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {18,"Enter"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
end)

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipScale(blip, 0.7)
			SetBlipColour(blip, 3)
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false

				if #(vector3(-45.98,-1082.97, 26.27) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(-45.98,-1082.97, 26.27,"["..Controlkey["generalUse"][2].."] return vehicle")
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if insideVehShop then
						currentlocation = b
						if not vehicles_spawned then
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 25 then
							DrawPrices()
						end

						if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) <= 1 then

							inrange = true
						end

						if vehshop.opened == true then
							DisplayHelpText('~g~'..Controlkey["generalUse"][2]..'~s~ or ~g~'..Controlkey["generalUseSecondary"][2]..'~s~ Accepts ~g~Arrows~s~ Move ~g~Backspace~s~ Exit')
						end

						if rank > 0 then
							OwnerMenu()
						end

						BuyMenu()
						

					else
						if vehicles_spawned then
							DespawnSaleVehicles()
						end
						Citizen.Wait(1000)
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	
	if ownerMenu then
		vehshop = vehshopOwner	
	else
		vehshop = vehshopDefault
	end


	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])




	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end
local endingCreator = false
function CloseCreator(name, veh, price, financed)
	Citizen.CreateThread(function()
		if not endingCreator then
			endingCreator = true
			local ped = LocalPed()
			if not boughtcar then
				local pos = currentlocation.pos.entering
				SetEntityCoords(ped,pos[1],pos[2],pos[3])
				FreezeEntityPosition(ped,false)
				SetEntityVisible(ped,true)
			else			
				local name = name	
				local vehicle = veh
				local price = price		
				local veh = GetVehiclePedIsUsing(ped)
				local model = GetEntityModel(veh)
				local colors = table.pack(GetVehicleColours(veh))
				local extra_colors = table.pack(GetVehicleExtraColours(veh))

				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
				local pos = currentlocation.pos.outside

				FreezeEntityPosition(ped,false)
				RequestModel(model)
				while not HasModelLoaded(model) do
					Citizen.Wait(0)
				end
				personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
				SetModelAsNoLongerNeeded(model)

				if name == "rumpo" then
					SetVehicleLivery(personalvehicle,0)
				end

				if name == "taxi" then
					SetVehicleExtra(personalvehicle, 8, 0)
					SetVehicleExtra(personalvehicle, 9, 0)
					SetVehicleExtra(personalvehicle, 5, 1)
				end



				for i,mod in pairs(mods) do
					SetVehicleModKit(personalvehicle,0)
					SetVehicleMod(personalvehicle,i,mod)
				end

				SetVehicleOnGroundProperly(personalvehicle)

				local plate = GetVehicleNumberPlateText(personalvehicle)
				SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
				local id = NetworkGetNetworkIdFromEntity(personalvehicle)
				SetNetworkIdCanMigrate(id, true)
				Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
				SetVehicleColours(personalvehicle,colors[1],colors[2])
				SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
				TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
				TriggerEvent("keys:addNew", model, plate)
				local vehname = GetDisplayNameFromVehicleModel(model)
				SetEntityVisible(ped,true)			
				local primarycolor = colors[1]
				local secondarycolor = colors[2]	
				local pearlescentcolor = extra_colors[1]
				local wheelcolor = extra_colors[2]
				TriggerServerEvent('BuyForVeh', plate, vehname, vehicle, price, financed)
				DespawnSaleVehicles()
				SpawnSaleVehicles()
				Citizen.Wait(4000)
				TriggerServerEvent("garages:loaded:in")
			end
			vehshop.opened = false
			vehshop.menu.from = 1
			vehshop.menu.to = 10
			endingCreator = false
		end
	end)
end


RegisterNetEvent("carshop:failedpurchase")
AddEventHandler("carshop:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)


RegisterNetEvent("ucrp-vehicleshop:setPlate")
AddEventHandler("ucrp-vehicleshop:setPlate", function(vehicle, plate)
	SetVehicleNumberPlateText(vehicle, plate)
	Citizen.Wait(1000)
	TriggerEvent("keys:addNew", vehicle, plate)

	TriggerServerEvent('garages:SetVehOut', vehicle, plate)
	TriggerServerEvent('veh.getVehicles', plate, vehicle)
	TriggerServerEvent("garages:CheckGarageForVeh")

	local plt = GetVehicleNumberPlateText(vehicle)
	TriggerServerEvent("request:illegal:upgrades",plate)

end)




function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,51,122,181,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(250,250,250, 255)
	else
		SetTextColour(0, 0, 0, 255)
		
	end
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,51,122,181,250)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255, 255, 255,250) 
	end
	

end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end



function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Cycles" then
			OpenMenu('cycles')
		end
	elseif this == "vehicles" then
		if btn == "S Class" then
			OpenMenu('sclass')
		elseif btn == "A Class" then
			OpenMenu('aclass')
		elseif btn == "Job Vehicles" then
			OpenMenu('jobvehicles')
		elseif btn == "B Class" then
			OpenMenu('bclass')
		elseif btn == "C Class" then
			OpenMenu('cclass')
		elseif btn == "D Class" then
			OpenMenu("dclass")
		elseif btn == "Off Road" then
			OpenMenu('offroad')
		end
	elseif this == "jobvehicles" or this == "sclass" or this == "aclass" or this == "bclass" or this == "cclass" or this == "dclass" or this == "supercars" or this == "muscle" or this == "offroad" or this == "suvs" or this == "vans" or this == "industrial" or this == "cycles" or this == "motorcycles" then

		if ownerMenu then

			updateCarTable(button.model,button.costs,button.name)

		else

			TriggerServerEvent('CheckMoneyForVeh',button.name, button.model, button.costs)

		end
		
	end

end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "sclass" or vehshop.currentmenu == "aclass" or vehshop.currentmenu == "bclass" or vehshop.currentmenu == "cclass" or vehshop.currentmenu == "dclass" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

function resetscaleform(topspeed,handling,braking,accel,resetscaleform,i)
    scaleform = RequestScaleformMovie(resetscaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

	topspeedc = topspeed / 20
	handlingc = handling / 20
	brakingc = braking / 20
	accelc = accel / 20

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString("LOADING")
    PushScaleformMovieFunctionParameterString("Brand New Vehicle")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Handling")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Downforce")


	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
    PushScaleformMovieFunctionParameterInt( (20 * i)-1 )

	PopScaleformMovieFunctionVoid()

end


--[[Citizen]]--
function Initialize(scaleform,veh,vehname)

    scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString(vehname)
    PushScaleformMovieFunctionParameterString("Brand New Vehicle")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Handling")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Downforce")

	local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 4)
    local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
    local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
    local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 

    if topspeed > 100 then
    	topspeed = 100
    end
    if handling > 100 then
    	handling = 100
    end
    if braking > 100 then
    	braking = 100
    end
    if accel > 100 then
    	accel = 100
    end
    Citizen.Trace(topspeed)
    Citizen.Trace(handling)
    Citizen.Trace(braking)
    Citizen.Trace(accel)

    PushScaleformMovieFunctionParameterInt( topspeed )
    PushScaleformMovieFunctionParameterInt( handling )
    PushScaleformMovieFunctionParameterInt( braking )
    PushScaleformMovieFunctionParameterInt( accel )
    PopScaleformMovieFunctionVoid()

    return scaleform
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				local br = button.rank ~= nil and button.rank or 0
				if rank >= br and i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then

						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)

					end
					y = y + 0.04
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "sclass" or vehshop.currentmenu == "aclass" or vehshop.currentmenu == "bclass" or vehshop.currentmenu == "cclass" or vehshop.currentmenu == "dclass" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)


								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

	


								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}

									local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								    local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								    local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								    local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end


								-- not sure why it doesnt refresh itself, but blocks need to be set to their maximum 20 40 60 80 100 before a new number is pushed.
								for i = 1, 5 do
								 	scaleform = resetscaleform(topspeed,handling,braking,accel,"mp_car_stats_01",i)
							        x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
							        Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x-1,y+1.8,z+7.0, 0.0, 180.0, 90.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0)
								end

								scaleform = Initialize("mp_car_stats_01",fakecar.car,fakecar.model)
							end
						end
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					 x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
		        	Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
		       		x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
		       		Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
		    end

		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)

AddEventHandler('FinishMoneyCheckForVeh', function(name, vehicle, price,financed)	
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price, financed)
	local plt = GetVehicleNumberPlateText(vehicle)
	TriggerEvent("keys:addNew",vehicle, plt)
end)

ShowVehshopBlips(true)
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		--326 car blip 227 225
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

AddEventHandler('vehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		local plate = GetVehicleNumberPlateText(veh)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
		TriggerEvent('ucrp-vehicleshop:setPlate', veh, plate)
	end
end)

RegisterNetEvent("ucrp-vehicleshop:update:plate")
AddEventHandler("ucrp-vehicleshop:update:plate", function(plate)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	SetVehicleNumberPlateText(veh, plate)
	local NPlate = GetVehicleNumberPlateText(veh)
	Citizen.Wait(100)
	TriggerEvent("keys:addNew",veh, NPlate)
end)


local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)

local vehshopLoc = PolyZone:Create({
	vector2(-17.224317550659, -1125.9611816406),
	vector2(-70.010810852051, -1128.2976074219),
	vector2(-76.185691833496, -1127.8470458984),
	vector2(-79.25121307373, -1123.7583007813),
	vector2(-79.670585632324, -1118.4036865234),
	vector2(-59.549613952637, -1063.388671875),
	vector2(-1.2465063333511, -1081.7679443359),
}, {
    name = "ucrp-vehicleshop",
    minZ = 0,
    maxZ = 40.5,
    debugGrid = false,
    gridDivisions = 25
})

local HeadBone = 0x796e;
Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetPedBoneCoords(plyPed, HeadBone)
        local inPoly = vehshopLoc:isPointInside(coord)
        -- if true, then player just entered zone
        if inPoly and not insideVehShop then
            insideVehShop = true
        elseif not inPoly and insideVehShop then
            insideVehShop = false
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if insideVehShop then
            rank = exports["isPed"]:GroupRank("car_shop")
            Citizen.Wait(10000)
        end
    end
end)

RegisterNetEvent("ucrp-vehicleshop:repo:success")
AddEventHandler("ucrp-vehicleshop:repo:success", function()
	local veh = GetVehiclePedIsIn(PlayerPedId())
	if veh ~= 0 then
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
		TriggerEvent("DoLongHudText", "You have successfully repod the vehicle")
	end
end)


RegisterNetEvent("search:list:repo")
AddEventHandler("search:list:repo", function()
	local valid = exports["ucrp-keyboard"]:KeyboardInput({
		header = "Search Repo List",
		rows = {
			{
				id = 0,
				txt = "Vehicle Plate Number"
			},
		}
	})
	if valid then
		TriggerServerEvent("ucrp-vehicleshop:checkrepo", valid[1].input)
	end
end)
