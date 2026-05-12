
Architecture Explanation:
A. Pattern Used
This project uses the MVVM (Model-View-ViewModel) architecture combined with:

1. Repository Pattern
Protocol based Dependency Injection
Swift Concurrency (async/await)

2. The goal of this architecture is to create a codebase that is:
- scalable
- testable
- maintainable
- easy to understand

Why MVVM?
MVVM works naturally with SwiftUI because SwiftUI is already state driven and reactive.

B. Architecture Layers
1. Model Layer
The Model layer represents the application data

Responsibilities:
- Represent API response data
- Conform to Decodable
- Remain UI-independent

2. Networking Layer
The Networking layer handles communication with the remote API using URLSession

Responsibilities:
- Fetch remote data
- Handle networking errors
- Decode JSON response
- Keep networking logic isolated from UI

3. Repository Layer
The Repository layer acts as the single source of truth between:
- Networking
- Local persistence
- ViewModels

Responsibilities:
- Fetch todos from API
- Merge remote data with local completion state
- Abstract data source implementation details

4. Persistence Layer
The Persistence layer stores local task completion changes

Responsibilities:
- Save task completion state locally
- Restore saved completion state

5. ViewModel Layer
The ViewModel acts as the bridge between:
- Business/data logic
- SwiftUI views

Responsibilities:
- Manage UI state
- Fetch data from repository
- Expose observable properties to the UI
- Handle loading and error states
- Handle task completion toggle

6. View Layer
Responsibilities:
- Render UI
- Display observable ViewModel state
- Handle user interactions

The View layer intentionally contains minimal business logic


AI Usage Report

1. AI Tools Used
The following AI tools were used during development:
ChatGPT

2. Tasks Assisted by AI
AI assistance was primarily used for:
- discussing MVVM structure and folder organization
- refining UI/UX ideas for SwiftUI
- improving README documentation wording

AI was also used as a secondary reference when comparing implementation approaches and evaluating tradeoffs

3. Decisions Made Manually
The following decisions and implementations were made manually:
- repository structure and dependency flow
- state management strategy
- UI composition and visual styling
- task filtering/search flow
- local persistence behavior
- testing structure and mocking strategy
- error handling behavior
- naming conventions and code organization

Code generated or suggested by AI was reviewed, adjusted, and integrated selectively based on project requirements and maintainability considerations

4. Limitations & Corrections Applied
Several AI-generated suggestions required refinement before integration:
simplifying overengineered approaches that were unnecessary for the project scope
improving state update flow for cleaner MVVM separation
refining UI spacing, hierarchy, and component composition
