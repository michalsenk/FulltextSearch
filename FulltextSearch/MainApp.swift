//
//  FulltextSearchApp.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
				store: Store(
					initialState: RootState(),
					reducer: rootReducer,
					environment: SystemEnvironment.dev(environment: RootEnvironment())))
        }
    }
}
