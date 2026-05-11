//
//  TodoRepository.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import Foundation

protocol TodoRepositoryProtocol {
    func fetchTodos() async throws -> [Todo]
}

final class TodoRepository: TodoRepositoryProtocol {

    private let apiService: APIServiceProtocol
    private let storage: LocalRepository

    init(
        apiService: APIServiceProtocol = APIService(),
        storage: LocalRepository = LocalRepository()
    ) {
        self.apiService = apiService
        self.storage = storage
    }

    func fetchTodos() async throws -> [Todo] {

        var todos = try await apiService.fetchTodos()

        todos = todos.map { todo in
            var updated = todo

            if let localStatus = storage.load(taskId: todo.id) {
                updated.completed = localStatus
            }

            return updated
        }

        return todos
    }

    func updateCompletion(taskId: Int, completed: Bool) {
        storage.save(taskId: taskId, completed: completed)
    }
}
