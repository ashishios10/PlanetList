//
//  PlanetListViewModel.swift
//  PlanetList
//
//  Created by Ashish Patel on 2024/10/11.
//

import SwiftUI
import Utilities
import Models
import Networking

/// MARK: - PlanetList ViewModel
final class PlanetListViewModel: ObservableObject {
    @Published var state: LoadingState<LoadedViewModel> = .idle
    @Published var showErrorAlert = false
    private let repository: PlanetRepository
    
    init(_ repository: PlanetRepository = PlanetRepositoryImplementation()) {
        self.repository = repository
    }
    
    public struct LoadedViewModel: Equatable {
        static func == (lhs: PlanetListViewModel.LoadedViewModel, rhs: PlanetListViewModel.LoadedViewModel) -> Bool {
            lhs.id == rhs.id
        }
        let id: String
        let planets: [Planet]
    }
    
    @MainActor
    func performFetchPlanets() async {
        do {
            let response = try await self.repository.fetchPlanets(pageNo: 1)
            if let planets = response.planets, !planets.isEmpty {
                self.state = .success(.init(id: UUID().uuidString, planets: planets))
            } else {
                self.showErrorAlert = true
                self.state = .failed(ErrorViewModel(message: ErrorMessage.invalidResponse.rawValue))
            }
        } catch {
            self.showErrorAlert = true
            self.state = .failed(ErrorViewModel(message: error.localizedDescription)) }
    }
}
