//
//  TheSportsDBDataSourceMock.swift
//  TestFDJTests
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
import Foundation

@testable import TestFDJ

class TheSportsDBDataSourceMock: TheSportsDBDataSource {
    var leaguesResult: Result<[League], Error>!
    var teamsResult: Result<[Team], Error>!

    override func getAllLeagues() -> AnyPublisher<[League], Error> {
        return Future<[League], Error> { promise in
            promise(self.leaguesResult)
        }
        .eraseToAnyPublisher()
    }

    override func getTeamsFromLeague(leagueName: String) -> AnyPublisher<[Team], Error> {
        return Future<[Team], Error> { promise in
            promise(self.teamsResult)
        }
        .eraseToAnyPublisher()
    }
}
