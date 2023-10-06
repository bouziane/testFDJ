//
//  TeamViewModel.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine

class TeamViewModel {
    private var getTeamsUseCase: GetTeamsFromLeagueUseCase
    private var cancellables: Set<AnyCancellable> = []
    @Published var teams: [Team] = []

    init(getTeamsUseCase: GetTeamsFromLeagueUseCase) {
        self.getTeamsUseCase = getTeamsUseCase
    }

    func fetchTeams(for leagueName: String) {
        getTeamsUseCase.execute(leagueName: leagueName).sink(receiveCompletion: { [weak self] completion in
            switch completion {
                case .finished:

                    break
                case .failure(let error):
                    print("Error fetching teams: \(error)")
            }
        }, receiveValue: { [weak self] teams in
            let sortedTeams = teams.sorted(by: { $0.strTeam.count < $1.strTeam.count })
            self?.teams = stride(from: 0, to: sortedTeams.count, by: 2).map { sortedTeams[$0] }

        }).store(in: &cancellables)
    }
}
