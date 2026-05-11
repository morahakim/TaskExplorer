//
//  LocalRepository.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import Foundation

final class LocalRepository {

    private let key = "completed_tasks"

    func save(taskId: Int, completed: Bool) {
        var storage = UserDefaults.standard.dictionary(forKey: key) as? [String: Bool] ?? [:]

        storage["\(taskId)"] = completed

        UserDefaults.standard.set(storage, forKey: key)
    }

    func load(taskId: Int) -> Bool? {
        let storage = UserDefaults.standard.dictionary(forKey: key) as? [String: Bool]

        return storage?["\(taskId)"]
    }
}
