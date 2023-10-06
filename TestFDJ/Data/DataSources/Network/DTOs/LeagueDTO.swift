//
//  LeagueDTO.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Foundation
struct LeagueDTO: Codable {
    let idLeague: String
    let strLeague: String
    let strSport: String
    let strLeagueAlternate: String?

    func toEntity() -> League {
        return League(idLeague: idLeague, strLeague: strLeague, strSport: strSport, strLeagueAlternate: strLeagueAlternate ?? "")
    }
}
