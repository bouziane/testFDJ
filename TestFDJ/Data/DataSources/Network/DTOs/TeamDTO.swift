//
//  TeamDTO.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Foundation
struct TeamDTO: Codable {
    let idTeam: String
    let strTeam: String
    let strTeamBadge: String

    func toEntity() -> Team {
        return Team(idTeam: idTeam, strTeam: strTeam, strTeamBadge: strTeamBadge)
    }
}
