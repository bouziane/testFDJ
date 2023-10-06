//
//  GetAllLeaguesUseCase.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
import Foundation

protocol GetAllLeagues {
    func execute() -> AnyPublisher<[League], Error>
}

final class GetAllLeaguesUseCase: GetAllLeagues {
    private let leagueRepository: LeagueRepository
    init(leagueRepository: LeagueRepository) {
        self.leagueRepository = leagueRepository
    }

    func execute() -> AnyPublisher<[League], Error> {
        leagueRepository.getAllLeagues().eraseToAnyPublisher()
    }
}
