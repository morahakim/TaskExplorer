//
//  TodoDetailView.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import SwiftUI

struct TodoDetailView: View {

    let todo: Todo
    let onToggle: () -> Void

    var body: some View {

        ZStack {

            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                ZStack {

                    Circle()
                        .fill(todo.completed
                              ? Color.green.opacity(0.15)
                              : Color.orange.opacity(0.15))
                        .frame(width: 120, height: 120)

                    Image(systemName:
                            todo.completed
                          ? "checkmark.circle.fill"
                          : "clock.fill")
                    .font(.system(size: 60))
                    .foregroundColor(todo.completed ? .green : .orange)
                }

                VStack(spacing: 12) {

                    Text(todo.title.capitalized)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)

                    Text(todo.completed
                         ? "This task has been completed."
                         : "This task is still pending.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                }

                Button {

                    onToggle()

                } label: {

                    Text(todo.completed
                         ? "Mark as Pending"
                         : "Mark as Completed")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .background(todo.completed ? .orange : .green)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 18))

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Task Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
