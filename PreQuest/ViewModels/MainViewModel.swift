//
//  MainViewModel.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/1/25.
//

import Foundation
import Combine
import UIKit

class MainViewModel: ObservableObject {
    @Published var apiDatas: [ApiData] = []
    @Published var isOfflineMode: Bool = false
    private var isLoading = false
    
    private let repository = ApiRepository()
    private var cancellables = Set<AnyCancellable>()
    
    func loadInitialData() {
        fetchData()
    }
    
    func fetchData() {
        ApiService().fetchApiDatas()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isOfflineMode = true
                    self.apiDatas = self.repository.fetchAllApiDatas()
                }
            }, receiveValue: { [weak self] apiDatas in
                guard let self = self else { return }
                self.isOfflineMode = false
                self.isLoading = true
                self.repository.saveApiDatas(apiDatas)
                self.downloadImages(apiDatas: apiDatas)
            }).store(in: &cancellables)
    }
    
    func downloadImages(apiDatas: [ApiData]) {
        for apiData in apiDatas {
            if apiData.imageData == nil {
                guard let imageUrl = URL(string: apiData.url) else {
                    continue
                }
                Task {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        await MainActor.run {
                            if let updateApiData = self.repository.saveImageData(for: apiData.id, imageData: imageData) {
                                self.apiDatas.append(updateApiData)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getUiImage(for apiData: ApiData) -> UIImage? {
        guard let imageData = repository.getImageData(for: apiData.id),
              let uiImage = UIImage(data: imageData) else {
            return nil
        }
        return uiImage
    }
    
    func loadMoreData(currentApiData: ApiData) {
        guard !isLoading && !isOfflineMode else { return }
        guard let lastItem = apiDatas.last, currentApiData.id == lastItem.id else { return }
        fetchData()
    }
    
}
