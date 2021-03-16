//
//  SymbolCodeTranslator.swift
//  pg5601_8002
//
//  Created by 8002 on 28/02/2021.
//

import Foundation

func symbolCodeToPlainText(symbolCode: String) -> String {
    
    switch symbolCode {
    case "clearsky_day", "clearsky_night":
        return "Clear skies"
    case "cloudy":
        return "Cloudy"
    case "fair_day", "fair_night":
        return "Fair"
    case "fog":
        return "Foggy"
    case "heavyrain":
        return "Heavy rain"
    case "heavyrainandthunder":
        return "Heavy rain and thunder"
    case "heavyrainshower_day", "heavyrainshower_night":
        return "Heavy rainshowers"
    case "heavyrainshowersandthunder_day", "heavyrainshowersandthunder_night":
        return "Heavy rainshowers and thunder"
    case "heavysleet":
        return "Heavy sleet"
    case "heavysleetandthunder" :
        return "Heavy sleet and thunder"
    case "heavysleetshowers_day", "heavysleetshowers_night":
        return "Heavy sleetshowers"
    case "heavysleetshowersandthunder_day", "heavysleetshowersandthunder_night":
        return "Heavy sleetshowers and thunder"
    case "heavysnow":
        return "Heavy snow"
    case "heavysnowandthunder":
        return "Heavy snow and thunder"
    case "heavysnowshowers_day", "heavysnowshowers_night" :
        return "Heavy snowshowers"
    case "heavysnowshowersandthunder_day", "heavysnowshowersandthunder_night":
        return "Heavy snowshowers and thunder"
    case "lightrain":
        return "Light rain"
    case "lightrainandthunder":
        return "Light rain and thunder"
    case "lightrainshowers_day", "lightrainshowers_night":
        return "Light rainshowers"
    case "lightrainshowersandthunder_day", "lightrainshowersandthunder_night":
        return "Light rainshowers and thunder"
    case "lightsleet":
        return "Light sleet"
    case "lightsleetandthunder":
        return "Light sleet and thunder"
    case "lightsleetshowers_day", "lightsleetshowers_night":
        return "Light sleetshowers"
    case "lightssleetshowersandthunder_day", "lightssleetshowersandthunder_night":
        return "Light sleetshowers and thunder"
    case "lightsnow":
        return "Light snow"
    case "lightsnowandthunder":
        return "Light snow and thunder"
    case "lightsnowshowers_day", "lightsnowshowers_night":
        return "Light snowshowers"
    case "lightsnowshowersandthunder_day", "lightsnowshowersandthunder_night":
        return "Light snowshowers and thunder"
    case "partlycloudy_day", "partlycloudy_night":
        return "Partly cloudy"
    case "rain":
        return "Rain"
    case "rainandthunder":
        return "Rain and thunder"
    case "rainshowers_day", "rainshowers_night":
        return "Rainshowers"
    case "rainshowersandthunder_day", "rainshowersandthunder_night":
        return "Rainshowers and thunder"
    case "sleet":
        return "Sleet"
    case "sleetandthunder":
        return "Sleet and thunder"
    case "sleetshowers_day", "sleetshowers_night":
        return "Sleetshowers"
    case "sleetshowersandthunder_day", "sleetshowersandthunder_night":
        return "Sleetshowers and thunder"
    case "snow" :
        return "Snow"
    case "snowandthunder":
        return "Snow and thunder"
    case "snowshowers_day", "snowshowers_night":
        return "Snowshowers"
    case "snowshowersandthunder_day", "snowshowersandthunder_night":
        return "Snowshowers and thunder"
    default:
        return "Could not locate weather data"
    }
}

