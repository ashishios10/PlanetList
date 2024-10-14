//
//  PlanetListApp.swift
//  PlanetList
//
//  Created by Ashish Patel on 2024/10/11.
//

import SwiftUI

@main
struct PlanetListApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView {
                PlanetListView(viewModel: PlanetListViewModel())
                    .onAppear {
                        if let documentsPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                            print(documentsPathString)
                            //This gives you the string formed path 
                        }

                    }
            }
        }
        
    }
}
