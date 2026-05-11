//
//  Todo.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import Foundation

struct Todo: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    var completed: Bool
}

enum TaskFilter: String, CaseIterable {
    case all = "All"
    case completed = "Completed"
    case pending = "Pending"
}
