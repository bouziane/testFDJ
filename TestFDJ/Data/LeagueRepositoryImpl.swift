//
//  LeagueRepository.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
import Foundation

class LeagueRepositoryImpl: LeagueRepository {
    private let theSportsDBDataSource: TheSportsDBDataSource
    
    init(leagueDataSource: TheSportsDBDataSource) {
        self.theSportsDBDataSource = leagueDataSource
    }
    
    func getAllLeagues() -> AnyPublisher<[League], Error> {
        return theSportsDBDataSource.getAllLeagues()
    }
    
    func getTeamsFromLeague(leagueName: String) -> AnyPublisher<[Team], Error> {
        return theSportsDBDataSource.getTeamsFromLeague(leagueName: leagueName)
    }
}
