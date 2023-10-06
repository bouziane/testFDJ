//
//  LeagueRepositoryImplTests.swift
//  TestFDJTests
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
@testable import TestFDJ
import XCTest

class LeagueRepositoryImplTests: XCTestCase {
    var sut: LeagueRepositoryImpl!
    var mockDataSource: TheSportsDBDataSourceMock!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockDataSource = TheSportsDBDataSourceMock()
        sut = LeagueRepositoryImpl(leagueDataSource: mockDataSource)
        cancellables = []
    }
    
    override func tearDown() {
        sut = nil
        mockDataSource = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetAllLeagues_Success() {
        let expectedLeagues = [League(idLeague: "1", strLeague: "Premier League", strSport: "Football", strLeagueAlternate: "EPL")]
        mockDataSource.leaguesResult = .success(expectedLeagues)
        
        assertPublisher(sut.getAllLeagues(), completesWith: .success(expectedLeagues))
    }
    
    func testGetAllLeagues_Error() {
        let error = NSError(domain: "test", code: 0, userInfo: nil)
        mockDataSource.leaguesResult = .failure(error)
        
        assertPublisher(sut.getAllLeagues(), completesWith: .failure(error))
    }
    
    func testGetTeamsFromLeague_Success() {
        let expectedTeams = [Team(idTeam: "1", strTeam: "Manchester United",strTeamBadge: "UrlOfTeamBadge")]
        mockDataSource.teamsResult = .success(expectedTeams)
        
        assertPublisher(sut.getTeamsFromLeague(leagueName: "Premier League"), completesWith: .success(expectedTeams))
    }
    
    func testGetTeamsFromLeague_Error() {
        let error = NSError(domain: "test", code: 0, userInfo: nil)
        mockDataSource.teamsResult = .failure(error)
        
        assertPublisher(sut.getTeamsFromLeague(leagueName: "Premier League"), completesWith: .failure(error))
    }
}
