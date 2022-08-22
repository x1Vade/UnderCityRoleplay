Config = Config or {}

Config.FavoritedItems = {}
Config.PinnedTargets = {}
Config.AdminSettings = {}

-- Customizable

Config.MenuDebug = false

Config.AdminMenus = {
    {
        ['Id'] = 'player',
        ['Name'] = 'Player',
        ['Items'] = {
            {
                ['Id'] = 'noclip',
                ['Name'] = 'Noclip',
                ['Event'] = 'Admin:Toggle:Noclip',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'debug',
                ['Name'] = 'Debug',
                ['Event'] = 'Admin:Toggle:Debug',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            ----- Give car command
            {
                ['Id'] = 'giveCar',
                ['Name'] = 'Give Car',
                ['Event'] = 'Admin:GiveCar',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'model',
                        ['Name'] = 'Model',
                        ['Type'] = 'input',
                        ['Value'] = '',
                    },
                    {
                        ['Id'] = 'plate',
                        ['Name'] = 'Custom Plate (Leave empty for random plate)',
                        ['Type'] = 'input',
                        ['Value'] = '',
                    },
                },
            },
            {
                ['Id'] = 'changeModel',
                ['Name'] = 'Change Model',
                ['Event'] = 'Admin:Change:Model',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'model',
                        ['Name'] = 'Model',
                        ['Type'] = 'input',
                        ['Value'] = '',
                    },
                },
            },
            {
                ['Id'] = 'rmodel',
                ['Name'] = 'Reset Model',
                ['Event'] = 'Admin:Reset:Model',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'clothing',
                ['Name'] = 'Clothing',
                ['Event'] = 'Admin:Open:Clothing',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'armor',
                ['Name'] = 'Armor',
                ['Event'] = 'ucrp-admin/client/armor-up',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'food-drink',
                ['Name'] = 'Food & Drink',
                ['Event'] = 'Admin:Food:Drink',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'godmode',
                ['Name'] = 'Godmode',
                ['Event'] = 'Admin:Godmode',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'opinventory',
                ['Name'] = 'Open Inventory',
                ['Event'] = 'Admin:OpenInv',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'revive',
                ['Name'] = 'Revive',
                ['Event'] = 'Admin:Revive',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'reviveRadius',
                ['Name'] = 'Revive in Radius',
                ['Event'] = 'ucrp-admin:ReviveInDistance',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'removeStress',
                ['Name'] = 'Remove Stress',
                ['Event'] = 'Admin:Remove:Stress',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
        }
    },
    {
        ['Id'] = 'utility',
        ['Name'] = 'Utility',
        ['Items'] = {
            -- {
            --     ['Id'] = 'playerblips',
            --     ['Name'] = 'Player Blips',
            --     ['Event'] = 'Admin:Toggle:PlayerBlips',
            --     ['EventType'] = 'Client',
            --     ['Collapse'] = false,
            -- },
            {
                ['Id'] = 'playernames',
                ['Name'] = 'Player Names',
                ['Event'] = 'Admin:Toggle:PlayerNames',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },

            {
                ['Id'] = 'weathertime',
                ['Name'] = 'Weather/Time',
                ['Event'] = 'Admin:WeatherAndTime:Change',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'weather',
                        ['Name'] = 'Weather',
                        ['Type'] = 'text-choice',
                        ['Choices'] = {
                            {
                                Text = 'EXTRASUNNY'
                            },
                            {
                                Text = 'CLEAR'
                            },
                            {
                                Text = 'CLEARING'
                            },
                            {
                                Text = 'CLOUDS'
                            },
                            {
                                Text = 'OVERCAST'
                            },
                            {
                                Text = 'FOGGY'
                            },
                            {
                                Text = 'SMOG'
                            },
                            {
                                Text = 'RAIN'
                            },
                            {
                                Text = 'THUNDER'
                            },
                        },
                    },
                    {
                        ['Id'] = 'time',
                        ['Name'] = 'Time (0 -24)',
                        ['Type'] = 'text-choice',
                    },
                },
            },
            {
                ['Id'] = 'deleteVehicle',
                ['Name'] = 'Delete Vehicle',
                ['Event'] = 'Admin:Delete:Vehicle',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'spawnVehicle',
                ['Name'] = 'Spawn Vehicle',
                ['Event'] = 'Admin:Spawn:Vehicle',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'model',
                        ['Name'] = 'Model',
                        ['Type'] = 'text-choice',
                        -- ['Choices'] = GetAddonVehicles()
                    },
                },
            },
            {
                ['Id'] = 'setvehGaragestate',
                ['Name'] = 'Set Vehicle State',
                ['Event'] = 'ucrp-admin:setvehstate',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'plate',
                        ['Name'] = 'Plate',
                        ['Type'] = 'input-choice',
                    },
                },
            },
            {
                ['Id'] = 'fixVehicle',
                ['Name'] = 'Fix Vehicle',
                ['Event'] = 'Admin:Fix:Vehicle',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'bennysMenu',
                ['Name'] = 'Bennys',
                ['Event'] = 'Admin:Bennys:Menu',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'devSpawn',
                ['Name'] = 'Set Dev Spawn',
                ['Event'] = 'Admin:SetDevSpawn',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'teleport',
                ['Name'] = 'Teleport',
                ['Event'] = 'Admin:Teleport',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'type',
                        ['Name'] = 'Type',
                        ['Type'] = 'input-choice',
                        ['Choices'] = {
                            {
                                Text = 'Goto'
                            },
                            {
                                Text = 'Bring'
                            }
                        }
                    },
                },
            },
            {
                ['Id'] = 'teleportCoords',
                ['Name'] = 'Teleport Coords',
                ['Event'] = 'Admin:Teleport:Coords',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'x-coord',
                        ['Name'] = 'X Coord',
                        ['Type'] = 'input',
                        ['InputType'] = 'number',
                    },
                    {
                        ['Id'] = 'y-coord',
                        ['Name'] = 'Y Coord',
                        ['Type'] = 'input',
                        ['InputType'] = 'number',
                    },
                    {
                        ['Id'] = 'z-coord',
                        ['Name'] = 'Z Coord',
                        ['Type'] = 'input',
                        ['InputType'] = 'number',
                    },
                },
            },
            {
                ['Id'] = 'teleportMarker',
                ['Name'] = 'Teleport Marker',
                ['Event'] = 'Admin:Teleport:Marker',
                ['EventType'] = 'Client',
                ['Collapse'] = false,
            },
            {
                ['Id'] = 'chatSay',
                ['Name'] = 'cSay',
                ['Event'] = 'Admin:Chat:Say',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'message',
                        ['Name'] = 'Message',
                        ['Type'] = 'input',
                        ['InputType'] = 'text',
                    }
                }
            },
            {
                ['Id'] = 'copyCoords',
                ['Name'] = 'Copy Coords',
                ['Event'] = 'Admin:Copy:Coords',
                ['Collapse'] = true,
                ['Options'] = {
                    {
            
                        ['Id'] = 'type',
                        ['Name'] = 'Type',
                        ['Type'] = 'input-choice',             
                        ['Choices'] = {
                            {
                                Text = 'vector3(0.0, 0.0, 0.0)'
                            },
                            {
                                Text = 'vector4(0.0, 0.0, 0.0, 0.0)'
                            },
                            {
                                Text = '0.0, 0.0, 0.0'
                            },
                            {
                                Text = '0.0, 0.0, 0.0, 0.0'
                            },
                            {
                                Text = 'X = 0.0, Y = 0.0, Z = 0.0'
                            },
                            {
                                Text = 'x = 0.0, y = 0.0, z = 0.0'
                            },
                            {
                                Text = 'X = 0.0, Y = 0.0, Z = 0.0, H = 0.0'
                            },
                            {
                                Text = 'x = 0.0, y = 0.0, z = 0.0, h = 0.0'
                            },
                            {
                                Text = '["X"] = 0.0, ["Y"] = 0.0, ["Z"] = 0.0'
                            },
                            {
                                Text = '["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0'
                            },
                            {
                                Text = '["X"] = 0.0, ["Y"] = 0.0, ["Z"] = 0.0, ["H"] = 0.0'
                            },
                            {
                                Text = '["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0'
                            }
                        }
                    },
                },
            },
        }
    },

    {
        ['Id'] = 'fun',
        ['Name'] = 'Fun',
        ['Items'] = {
            {
                ['Id'] = 'flingPlayer',
                ['Name'] = 'Fling Player',
                ['Event'] = 'Admin:Fling:Player',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'drunkPlayer',
                ['Name'] = 'Make Player Drunk',
                ['Event'] = 'Admin:Drunk',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'animalattackPlayer',
                ['Name'] = 'Animal Attack',
                ['Event'] = 'Admin:Animal:Attack',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'setfirePlayer',
                ['Name'] = 'Set On Fire',
                ['Event'] = 'Admin:Set:Fire',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                },
            },
            {
                ['Id'] = 'fartPlayer',
                ['Name'] = 'Fart Sound',
                ['Event'] = 'Admin:Fart:Player',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'fart',
                        ['Name'] = 'Fart',
                        ['Type'] = 'input-choice',
                        ['Choices'] = {
                            {
                                Text = 'Fart'
                            },
                            {
                                Text = 'Wet Fart'
                            },
                        },
                    },
                },
            },
        }
    },
    {
        ['Id'] = 'user',
        ['Name'] = 'User',
        ['Items'] = {
            {
                ['Id'] = 'setjob',
                ['Name'] = 'Request Job',
                ['Event'] = 'Admin:Request:Job',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'job',
                        ['Name'] = 'Job',
                        ['Type'] = 'text-choice',
                        ['Choices'] = {
                            {
                                Text = 'police'
                            },
                            {
                                Text = 'ems'
                            },
                            {
                                Text = 'burger_shot'
                            },
                            {
                                Text = 'uwu_cafe'
                            },
                            {
                                Text = 'tuner_carshop'
                            },
                            {
                                Text = 'galaxy_nc'
                            },
                            {
                                Text = 'hayes_autos'
                            },
                            {
                                Text = 'car_shop'
                            },
                            {
                                Text = 'gambinos'
                            },
                        },
                    },
                },
            },
            {
                ['Id'] = 'setgang',
                ['Name'] = 'Set Gang',
                ['Event'] = 'Admin:Request:Gang',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'gang',
                        ['Name'] = 'Gang',
                        ['Type'] = 'text-choice',
                        ['Choices'] = GetGangs()
                    },
                    {
                        ['Id'] = 'rank',
                        ['Name'] = 'Rank ( 5 is the boos rank )',
                        ['Type'] = 'input',
                    },
                },
            },
            {
                ['Id'] = 'giveItem',
                ['Name'] = 'Give Item',
                ['Event'] = 'Admin:GiveItem',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'item',
                        ['Name'] = 'Item',
                        ['Type'] = 'input',
                        -- ['Choices'] = GetInventoryItems()
                    },
                    {
                        ['Id'] = 'amount',
                        ['Name'] = 'Amount',
                        ['Type'] = 'input',
                        ['InputType'] = 'number',
                    },
                },
            },
            {
                ['Id'] = 'banPlayer',
                ['Name'] = 'Ban Player',
                ['Event'] = 'Admin:Ban',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'expire',
                        ['Name'] = 'Expire',
                        ['Type'] = 'input-choice',
                        ['Choices'] = {
                            {
                                Text = '1 Hour'
                            },
                            {
                                Text = '6 Hours'
                            },
                            {
                                Text = '12 Hours'
                            },
                            {
                                Text = '1 Day'
                            },
                            {
                                Text = '3 Days'
                            },
                            {
                                Text = '1 Week'
                            },
                            {
                                Text = 'Permanent'
                            }
                        }
                    },
                    {
                        ['Id'] = 'reason',
                        ['Name'] = 'Reason',
                        ['Type'] = 'input',
                        ['InputType'] = 'text',
                    },
                },
            },
            {
                ['Id'] = 'kickPlayer',
                ['Name'] = 'Kick Player',
                ['Event'] = 'Admin:Kick',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                    {
                        ['Id'] = 'reason',
                        ['Name'] = 'Reason',
                        ['Type'] = 'input',
                        ['InputType'] = 'text',
                    },
                },
            },
            {
                ['Id'] = 'spectate',
                ['Name'] = 'Spectate Player',
                ['Event'] = 'Admin:Toggle:Spectate',
                ['EventType'] = 'Client',
                ['Collapse'] = true,
                ['Options'] = {
                    {
                        ['Id'] = 'player',
                        ['Name'] = 'Player',
                        ['Type'] = 'input-choice',
                        ['PlayerList'] = true,
                    },
                }
            },

            
        }
    },
}