//
//  ContentViewModel.swift
//  ComibineExample
//
//  Created by Gurjinder Singh on 02/09/23.
//

import Foundation
import Combine

struct DataType: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
// Without Combine
//class ContentViewModel: ObservableObject {
//    @Published var data: DataType?
////    private var cancellabel: AnyCancellable?
//    func fetchData() async {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url!)
//            let decodedData = try JSONDecoder().decode(DataType.self, from: data)
//            DispatchQueue.main.async {
//                self.data = decodedData
//            }
//        } catch {
//            print("Error received: \(error)")
//        }
//    }
//}

// With combine
class ContentViewModel: ObservableObject {
    @Published var dataS: DataType?
    
     var cancellabel: AnyCancellable?
    
    func fetchData() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
            print("Invalid url")
            return
        }
        cancellabel = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DataType.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    print("Data fetched successfully")
                }
            } receiveValue: { data in
                self.dataS = data
            }
    }
}
