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
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var selectedApiData: ApiData? = nil

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                let isLandscape = geo.size.width > geo.size.height
                let columns = isLandscape ? 5 : 1
                let cellWidth: CGFloat = isLandscape ? 300 : geo.size.width
                let cellHeight: CGFloat = isLandscape ? 120 : geo.size.height
                ScrollView([.vertical, isLandscape ? .horizontal : []]) {
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(cellWidth), spacing: 10), count: columns), spacing: 10) {
                        ForEach(viewModel.apiDatas, id: \.id) { apiData in
                            NavigationLink(destination: Group {
                                if let selectedApiImage = viewModel.getUiImage(for: apiData) {
                                    ApiImageDetailView(image: selectedApiImage, userId: apiData.id)
                                }
                            }) {
                                ApiImageCellView(apiImage: viewModel.getUiImage(for: apiData))
                                    .frame(width: cellWidth, height: cellHeight)
                            }
                            .onAppear {
                                viewModel.loadMoreApiData(currentApiData: apiData)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear() {
            viewModel.loadInitialData()
        }
        .onReceive(networkMonitor.$isConnected) { isConnected in
            viewModel.handleNetworkConnectivityChange(isConnected: isConnected)
        }
    }
}

#Preview {
    MainView()
}
