//
//  ViewController.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    private var viewModel: LeagueViewModel!
    private var cancellables: Set<AnyCancellable> = []
    var container: DIContainer = .shared

    private var leagues: [League] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var filteredLeagues: [League] = [] {
        didSet {
            tableView.isHidden = filteredLeagues.isEmpty
            tableView.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var emptyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self

        viewModel = LeagueViewModel(getAllLeaguesUseCase: container.makeGetAllLeaguesUseCase())
        viewModel.$leagues
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] leagues in
                self?.leagues = leagues
                self?.filteredLeagues = leagues

            })
            .store(in: &cancellables)

        viewModel.fetchLeagues()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath)
        cell.textLabel?.text = filteredLeagues[indexPath.row].strLeague
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let league = filteredLeagues[indexPath.row]
        showTeams(for: league.strLeague)
    }

    private func showTeams(for leagueName: String) {
        // Assuming you're using Storyboards and have a segue set up
        performSegue(withIdentifier: "showTeams", sender: leagueName)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTeams",
           let leagueName = sender as? String,
           let teamsVC = segue.destination as? TeamsViewController
        {
            teamsVC.viewModel = TeamViewModel(getTeamsUseCase: container.makeGetTeamsFromLeagueUseCase())
            teamsVC.viewModel.fetchTeams(for: leagueName)
        }
    }

    // Search Part

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredLeagues = viewModel.leagues
        } else {
            filteredLeagues = leagues.filter { league in
                league.strLeague.lowercased().contains(searchText.lowercased()) ||
                    league.strLeagueAlternate.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        filteredLeagues = []
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}
