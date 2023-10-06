//
//  MockLeagueRepository.swift
//  TestFDJTests
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
@testable import TestFDJ
import XCTest

class LeagueRepositoryMock: LeagueRepository {
    var leagues: Result<[League], Error>!
    var teams: Result<[Team], Error>!

    func getAllLeagues() -> AnyPublisher<[League], Error> {
        return Future<[League], Error> { promise in
            promise(self.leagues)
        }
        .eraseToAnyPublisher()
    }

    func getTeamsFromLeague(leagueName: String) -> AnyPublisher<[TestFDJ.Team], Error> {
        return Future<[Team], Error> { promise in
            promise(self.teams)
        }.eraseToAnyPublisher()
    }
}
