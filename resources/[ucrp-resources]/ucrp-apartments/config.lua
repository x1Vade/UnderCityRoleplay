
MenuData = {
  apartment_check = {
    {
      title = "Apartment",
      description = "Forclose Apartment",
      key = "judge",
      children = {
          { title = "Yes", action = "ucrp-apartments:handler", key = { forclose = true} },
          { title = "No", action = "ucrp-apartments:handler", key = { forclose = false } },
      }
    }
  }
}
