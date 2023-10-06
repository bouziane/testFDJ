//
//  ResponsesDTO.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Foundation
struct LeaguesResponseDTO: Codable {
    let leagues: [LeagueDTO]
}

struct TeamsResponseDTO: Codable {
    let teams: [TeamDTO]
}
