//
//  TodoCardView.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import SwiftUI

struct TodoCardView: View {

    let todo: Todo
    let onToggle: () -> Void

    var body: some View {

        HStack(spacing: 16) {

            Button {
                onToggle()
            } label: {

                Image(systemName: todo.completed
                      ? "checkmark.circle.fill"
                      : "circle")
                    .font(.system(size: 28))
                    .foregroundColor(todo.completed ? .green : .gray)
            }

            VStack(alignment: .leading, spacing: 8) {

                Text(todo.title.capitalized)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 8) {

                    Circle()
                        .fill(todo.completed ? .green : .orange)
                        .frame(width: 8, height: 8)

                    Text(todo.completed ? "Completed" : "Pending")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.6))
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.05),
                radius: 10,
                x: 0,
                y: 4)
        .swipeActions(edge: .trailing) {

            Button {
                onToggle()
            } label: {

                Label(
                    todo.completed ? "Undo" : "Complete",
                    systemImage: todo.completed
                    ? "arrow.uturn.backward"
                    : "checkmark"
                )
            }
            .tint(todo.completed ? .orange : .green)
        }
    }
}

