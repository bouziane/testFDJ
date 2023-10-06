//
//  ff.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
import Foundation

protocol LeagueRepository {
    func getAllLeagues() -> AnyPublisher<[League], Error>

    func getTeamsFromLeague(leagueName: String) -> AnyPublisher<[Team], Error>
}
