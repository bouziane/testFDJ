//
//  GetAllLeaguesUseCaseTests.swift
//  TestFDJTests
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine

@testable import TestFDJ
import XCTest

final class GetAllLeaguesUseCaseTests: XCTestCase {
    var sut: GetAllLeaguesUseCase!
    var leagueRepositoryMock: LeagueRepositoryMock!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        
        leagueRepositoryMock = LeagueRepositoryMock()
        sut = GetAllLeaguesUseCase(leagueRepository: leagueRepositoryMock)
        cancellables = []
    }

    override func tearDownWithError() throws {
        sut = nil
        leagueRepositoryMock = nil
        cancellables = nil
    }

    func testGetAllLeagues_Success() {
        let expectedLeagues = [League(idLeague: "1", strLeague: "Premier League", strSport: "Football", strLeagueAlternate: "EPL")]
        leagueRepositoryMock.leagues = .success(expectedLeagues)

        assertPublisher(sut.execute(), completesWith: .success(expectedLeagues))
    }

    func testGetAllLeagues_Error() {
        let error = NSError(domain: "testError", code: 1, userInfo: nil)
        leagueRepositoryMock.leagues = .failure(error)

        assertPublisher(sut.execute(), completesWith: .failure(error))
    }
}
