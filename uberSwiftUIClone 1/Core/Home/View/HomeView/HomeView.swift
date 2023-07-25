//
//  HomeView.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 24/7/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = false
    @State private var mapState = MapViewStat.noInput
    var body: some View {
        ZStack(alignment: .top) {
            MapView(mapState: $mapState)
                .ignoresSafeArea()
            
            if mapState == .searchingForLocation {
                LocationSearchView(mapState: $mapState)
            } else if mapState == .noInput {
                LocationSearchArchvationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            mapState = .searchingForLocation
                        }
                    }
            }
            MapViewActionButton(
                mapState: $mapState
            )
                .padding(.leading)
                .padding(.top,  4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocationSearchViewModel())
    } 
}
