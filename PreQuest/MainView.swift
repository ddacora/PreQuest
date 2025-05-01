//
//  ContentView.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/1/25.
//

import SwiftUI
import Alamofire
import Combine

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    MainView()
}
