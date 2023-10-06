//
//  GetTeamsFromLeagueUseCase.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Foundation
import Combine

protocol GetTeamsFromLeague {
    func execute(leagueName: String) -> AnyPublisher<[Team], Error> 
}

class GetTeamsFromLeagueUseCase: GetTeamsFromLeague {
    private let leagueRepository: LeagueRepository

    init(leagueRepository: LeagueRepository) {
        self.leagueRepository = leagueRepository
    }

    func execute(leagueName: String) -> AnyPublisher<[Team], Error> {
        return leagueRepository.getTeamsFromLeague(leagueName: leagueName)
    }
}
