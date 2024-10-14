//
//  PlanetListView.swift
//  PlanetList
//
//  Created by Ashish Patel on 2024/10/11.
//

import SwiftUI
import Utilities

/// MARK: - PlanetListView
struct PlanetListView: View {
    
    //Properties
    @ObservedObject var viewModel: PlanetListViewModel
    
    //View Body
    var body: some View {
        ZStack {
            let state = viewModel.state
            switch state {
            case .idle:
                Color.clear.onAppear(perform: loadData)
            case .loading:
                ProgressView()
            case .success(let loadedViewModel):
                VStack {
                    List {
                        ForEach(loadedViewModel.planets) { planet in
                            if let name = planet.name {
                                Text(name)
                                    .textDefaultSettings()
                            }
                        }
                    }
                }
                
            case .failed(let errorViewModel):
                Color.clear.alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(
                        title: Text("alert.Error".localized()),
                        message: Text(errorViewModel.message),
                        dismissButton: .default(Text("alert.okButton".localized()))
                    )
                }
            }
        }
        .navigationBarTitle("dashboard.title".localized(), displayMode: .large)
    }
    
    private func loadData() {
        viewModel.state = .loading
        Task(priority: .userInitiated) {
            await self.viewModel.performFetchPlanets()
        }
    }
}
