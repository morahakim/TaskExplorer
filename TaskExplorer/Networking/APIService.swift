//
//  APIService.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import Foundation

final class APIService: APIServiceProtocol {

    func fetchTodos() async throws -> [Todo] {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                throw APIError.invalidResponse
            }

            do {
                let todos = try JSONDecoder().decode([Todo].self, from: data)
                return todos
            } catch {
                throw APIError.decodingError
            }

        } catch {
            throw APIError.network(error)
        }
    }
}
