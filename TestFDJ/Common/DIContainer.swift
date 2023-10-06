//
//  DIContainer.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Foundation
class DIContainer {
    static let shared = DIContainer()

    func makeTheSportsDBDataSource() -> TheSportsDBDataSource {
        return TheSportsDBDataSource()
    }

    func makeLeagueRepository() -> LeagueRepository {
        return LeagueRepositoryImpl(leagueDataSource: makeTheSportsDBDataSource())
    }

    func makeGetAllLeaguesUseCase() -> GetAllLeaguesUseCase {
        return GetAllLeaguesUseCase(leagueRepository: makeLeagueRepository())
    }

    func makeGetTeamsFromLeagueUseCase() -> GetTeamsFromLeagueUseCase {
        return GetTeamsFromLeagueUseCase(leagueRepository: makeLeagueRepository())
    }
}
