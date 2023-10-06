//
//  TheSportDBDataSource.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//
import Combine
import Foundation

class TheSportsDBDataSource {
    private let baseURL: URL

    init() {
        if let baseURLString = AppConfig.shared.fetchConfigValue(forKey: "TheSportsDBBaseURL"),
           let url = URL(string: baseURLString)
        {
            self.baseURL = url
        } else {
            fatalError("Failed to fetch the base URL from Config.plist.")
        }
    }

    func getAllLeagues() -> AnyPublisher<[League], Error> {
        let endpoint = "/all_leagues.php"
        let requestURL = baseURL.appendingPathComponent(endpoint)

        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .tryMap { data, _ -> [League] in
                let leaguesResponseDTO = try JSONDecoder().decode(LeaguesResponseDTO.self, from: data)
                return leaguesResponseDTO.leagues.map { $0.toEntity() }
            }
            .eraseToAnyPublisher()
    }

    func getTeamsFromLeague(leagueName: String) -> AnyPublisher<[Team], Error> {
        let endpoint = "/search_all_teams.php"
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "l", value: leagueName)]

        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .tryMap { data, _ -> [Team] in
                let teamsResponseDTO = try JSONDecoder().decode(TeamsResponseDTO.self, from: data)
                return teamsResponseDTO.teams.map { $0.toEntity() }
            }
            .eraseToAnyPublisher()
    }
}

struct LeaguesResponseDTO: Codable {
    let leagues: [LeagueDTO]
}

struct TeamsResponseDTO: Codable {
    let teams: [TeamDTO]
}

struct LeagueDTO: Codable {
    let idLeague: String
    let strLeague: String
    let strSport: String
    let strLeagueAlternate: String?

    func toEntity() -> League {
        return League(idLeague: idLeague, strLeague: strLeague, strSport: strSport, strLeagueAlternate: strLeagueAlternate ?? "")
    }
}

struct TeamDTO: Codable {
    let idTeam: String
    let strTeam: String
    let strTeamBadge: String

    func toEntity() -> Team {
        return Team(idTeam: idTeam, strTeam: strTeam, strTeamBadge: strTeamBadge)
    }
}
