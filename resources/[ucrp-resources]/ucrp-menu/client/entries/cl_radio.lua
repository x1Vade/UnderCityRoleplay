local GeneralEntries, SubMenu = MenuEntries['general'], {}

local MenuOptions = {
  {
      id = 'radio:switchChannel1',
      title = "1",
      icon = "#general-door-keyFob",
      event = "ChannelSet",
      parameters = { "1" }
  },
  {
      id = 'radio:switchChannel2',
      title = "2",
      icon = "#general-door-keyFob",
      event = "ChannelSet",
      parameters = { "2" }
  },
  {
      id = 'radio:switchChannel3',
      title = "3",
      icon = "#general-door-keyFob",
      event = "ChannelSet",
      parameters = { "3" }
  },
  {
      id = 'radio:switchChannel4',
      title = "4",
      icon = "#general-door-keyFob",
      event = "ChannelSet",
      parameters = { "4" }
  },
  {
      id = 'radio:switchChannel5',
      title = "5",
      icon = "#general-door-keyFob",
      event = "ChannelSet",
      parameters = { "5" }
  },
  {
      id = 'radio:switchChannel6',
      title = "6",
      icon = "#general-door-keyFob",
      event = "ChannelSet",
      parameters = { "6" }
  },
}

Citizen.CreateThread(function()
  for index, data in ipairs(MenuOptions) do
      SubMenu[index] = data.id
      MenuItems[data.id] = {data = data}
  end
  GeneralEntries[#GeneralEntries+1] = {
      data = {
          id = "radio:switchChannel",
          icon = "#general-door-keyFob",
          title = "Radio",
      },
      subMenus = SubMenu,
      isEnabled = function()
          return isPolice and not isDead
      end,
  }
end)
