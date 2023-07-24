//
//  HomeView.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 24/7/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        MapView()
            .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    } 
}
