//
//  LeagueViewModel.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
import Foundation

class LeagueViewModel {
    private let getAllLeaguesUseCase: GetAllLeagues
    private var cancellables: Set<AnyCancellable> = []
    @Published var leagues: [League] = []


    init(getAllLeaguesUseCase: GetAllLeagues) {
        self.getAllLeaguesUseCase = getAllLeaguesUseCase
    }

    func fetchLeagues() {
        getAllLeaguesUseCase.execute()
            .sink(receiveCompletion: { [weak self] completion in

                switch completion {
                    case .finished:

                        break
                    case .failure(let error):
                        print("Error fetching leagues: \(error)")
                }
            }, receiveValue: { [weak self] leagues in
               // print("Received leagues: \(leagues)")
                self?.leagues = leagues
            })
            .store(in: &cancellables)
    }
}
