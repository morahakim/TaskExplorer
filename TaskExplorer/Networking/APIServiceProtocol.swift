//
//  APIServiceProtocol.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import Foundation

protocol APIServiceProtocol {
    func fetchTodos() async throws -> [Todo]
}
