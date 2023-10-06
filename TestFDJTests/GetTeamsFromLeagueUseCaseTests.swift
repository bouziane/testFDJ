//
//  GetTeamsFromLeagueUseCaseTests.swift
//  TestFDJTests
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
@testable import TestFDJ
import XCTest

final class GetTeamsFromLeagueUseCaseTests: XCTestCase {
    var sut: GetTeamsFromLeagueUseCase!
    var leagueRepositoryMock: LeagueRepositoryMock!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        leagueRepositoryMock = LeagueRepositoryMock()
        sut = GetTeamsFromLeagueUseCase(leagueRepository: leagueRepositoryMock)
        cancellables = []
    }

    override func tearDownWithError() throws {
        sut = nil
        leagueRepositoryMock = nil
        cancellables = nil
    }

    func testGetTeamsFromLeague_Success() {
        let expectedTeams = [Team(idTeam: "1", strTeam: "Manchester United", strTeamBadge: "UrlOfTeamBadge")]
        leagueRepositoryMock.teams = .success(expectedTeams)

        assertPublisher(sut.execute(leagueName: "Premier League"), completesWith: .success(expectedTeams))
    }

    func testGetTeamsFromLeague_Error() {
        let error = NSError(domain: "testError", code: 1, userInfo: nil)

        leagueRepositoryMock.teams = .failure(error)
        assertPublisher(sut.execute(leagueName: "Premier League"),
                        completesWith: .failure(error))
    }
}
