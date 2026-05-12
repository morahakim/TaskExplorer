//
//  MockAPIService.swift
//  TaskExplorerTests
//
//  Created by mora hakim on 12/05/26.
//

import Foundation
@testable import TaskExplorer

final class MockAPIService: APIServiceProtocol {

    var todos: [Todo] = []

    func fetchTodos() async throws -> [Todo] {
        todos
    }
}
