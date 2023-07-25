//
//  LocationSearchView.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 24/7/2023.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText: String = ""
    @Binding var mapState: MapViewStat
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(Color(.systemGroupedBackground))
                        .frame(width: 6, height: 6)
                }
                VStack {
                    TextField("Curent Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            Divider()
                .padding(.vertical)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchCell(
                            title: result.title,
                            subtitle: result.subtitle
                        )
                        .onTapGesture {
                            withAnimation(.spring()) {
                                viewModel.selectLocation(result)
                                mapState = .locationSelected
                            }
                        }
                    }
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.noInput))
            .environmentObject(LocationSearchViewModel())
    }
}
