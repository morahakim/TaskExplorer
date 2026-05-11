//
//  ContentView.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import SwiftUI

struct TodoListView: View {

    @StateObject private var viewModel = TodoListViewModel()

    @State private var searchText = ""
    @State private var selectedFilter: TaskFilter = .all

    private var filteredTodos: [Todo] {

        let filtered: [Todo]

        switch selectedFilter {
        case .all:
            filtered = viewModel.todos

        case .completed:
            filtered = viewModel.todos.filter { $0.completed }

        case .pending:
            filtered = viewModel.todos.filter { !$0.completed }
        }

        if searchText.isEmpty {
            return filtered
        }

        return filtered.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var completedCount: Int {
        viewModel.todos.filter { $0.completed }.count
    }

    private var progress: Double {
        guard !viewModel.todos.isEmpty else { return 0 }
        return Double(completedCount) / Double(viewModel.todos.count)
    }

    var body: some View {

        NavigationStack {

            ZStack {

                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                Group {

                    if viewModel.isLoading {

                        ProgressView()
                            .scaleEffect(1.2)
                    }
                    else if let error = viewModel.errorMessage {

                        VStack(spacing: 16) {

                            Image(systemName: "wifi.exclamationmark")
                                .font(.system(size: 50))
                                .foregroundColor(.red)

                            Text(error)
                                .multilineTextAlignment(.center)

                            Button("Retry") {
                                Task {
                                    await viewModel.fetchTodos()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    }
                    else {

                        ScrollView(showsIndicators: false) {

                            VStack(spacing: 20) {

                                progressSection

                                filterSection

                                if filteredTodos.isEmpty {
                                    emptyState
                                }
                                else {

                                    LazyVStack(spacing: 16) {

                                        ForEach(filteredTodos) { todo in

                                            NavigationLink {

                                                TodoDetailView(
                                                    todo: todo,
                                                    onToggle: {
                                                        withAnimation(.spring()) {
                                                            viewModel.toggleTask(todo)
                                                        }
                                                    }
                                                )

                                            } label: {

                                                TodoCardView(
                                                    todo: todo,
                                                    onToggle: {
                                                        withAnimation(.spring()) {
                                                            viewModel.toggleTask(todo)
                                                        }
                                                    }
                                                )
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        .refreshable {
                            await viewModel.fetchTodos()
                        }
                    }
                }
            }
            .navigationTitle("Task Explorer")
            .searchable(text: $searchText,
                        prompt: "Search tasks...")
        }
        .task {
            await viewModel.fetchTodos()
        }
    }
}

//MARK: ProgressBar
extension TodoListView {

    private var progressSection: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                VStack(alignment: .leading, spacing: 6) {

                    Text("Task Progress")
                        .font(.headline)

                    Text("\(completedCount) of \(viewModel.todos.count) completed")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                ZStack {

                    Circle()
                        .fill(Color.green.opacity(0.15))
                        .frame(width: 50, height: 50)

                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                }
            }

            ProgressView(value: progress)
                .tint(.green)
                .scaleEffect(y: 1.5)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.05),
                radius: 10,
                x: 0,
                y: 4)
    }
}


//MARK: FilterSection
extension TodoListView {

    private var filterSection: some View {

        Picker("", selection: $selectedFilter) {

            ForEach(TaskFilter.allCases, id: \.self) { filter in

                Text(filter.rawValue)
                    .tag(filter)
            }
        }
        .pickerStyle(.segmented)
    }
}


//MARK: EmptyState
extension TodoListView {

    private var emptyState: some View {

        VStack(spacing: 20) {

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 70))
                .foregroundColor(.green)

            Text("No Tasks Found")
                .font(.title3.bold())

            Text("Try changing your search or filter.")
                .foregroundColor(.secondary)
        }
        .padding(.top, 80)
    }
}

#Preview {
    TodoListView()
}
