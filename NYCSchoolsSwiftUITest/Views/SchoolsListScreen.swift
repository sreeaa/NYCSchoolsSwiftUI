//
//  SchoolsListScreen.swift
//  NYCSchoolsSwiftUITest
//
//  Created by Akshitha atmakuri on 7/10/23.
//

import SwiftUI

struct SchoolsListScreen: View {
    @StateObject private var viewModel = SchoolListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.search(), id: \.dbn) { school in
                    NavigationLink {
                        SchoolDetailScreen(school: school, results: resultsFor(school))
                    } label: {
                        SchoolListItem(school: school)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("NYC Schools")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchData()
            }
            .searchable(text: $viewModel.searchString, tokens: $viewModel.searchTokens, placement: .automatic, prompt: "Search") { token in
                token.tokenView
            }
            .toolbar {
                navigationTitle
            }
        }
    }
    
    @ToolbarContentBuilder
    var navigationTitle: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("")
        }
        ToolbarItem(placement: .navigationBarLeading) {
            Text("NYC schools")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .foregroundColor(.publicNavy)
                .padding(.bottom, 6)
        }
    }
}

extension SchoolsListScreen {
    func resultsFor(_ school: School) -> TestResults? {
        viewModel.testResults[school.dbn]
    }
}

struct SchoolsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        SchoolsListScreen()
    }
}
