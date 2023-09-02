//
//  ContentView.swift
//  ComibineExample
//
//  Created by Gurjinder Singh on 02/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if let data = viewModel.dataS {
                Text(data.title)
                    .font(.largeTitle)
            } else {
                ProgressView("Loading Data")
            }
        }
        .padding()
        .task {
            await viewModel.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
