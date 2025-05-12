//
//  TMDBService.swift
//  FFFinder
//
//  Created by ZZ on 2025.05.11.
//

import Foundation

class TMDBService {
    static let shared = TMDBService()
    private let baseURL = "https://api.themoviedb.org/3"
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    private let apiKey: String
    
    private init() {
        self.apiKey = "209a107f860379b817348998d5e9ca2c"
    }
    
    func searchMovie(title: String) async throws -> TMDBMovie? {
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? title
        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(encodedTitle)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
        
        // Return the first result if available
        return response.results.first
    }
    
    func getPosterURL(path: String) -> URL? {
        return URL(string: "\(imageBaseURL)\(path)")
    }
}

// TMDB API Response Models
struct TMDBResponse: Codable {
    let results: [TMDBMovie]
}

struct TMDBMovie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
} 
