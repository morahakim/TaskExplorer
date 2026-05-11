//
//  TodoViewModel.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import Foundation
import Combine

@MainActor
final class TodoListViewModel: ObservableObject {

    @Published var todos: [Todo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: TodoRepository

    init(repository: TodoRepository = TodoRepository()) {
        self.repository = repository
    }

    func fetchTodos() async {

        isLoading = true
        errorMessage = nil

        do {
            todos = try await repository.fetchTodos()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func toggleTask(_ todo: Todo) {

        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else {
            return
        }

        todos[index].completed.toggle()

        repository.updateCompletion(
            taskId: todo.id,
            completed: todos[index].completed
        )
    }
}
