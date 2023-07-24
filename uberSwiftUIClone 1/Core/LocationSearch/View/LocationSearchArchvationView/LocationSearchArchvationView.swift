//
//  LocationSearchView.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 24/7/2023.
//

import SwiftUI

struct LocationSearchArchvationView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            Text("Wher to?")
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50 )
        .background(
            Rectangle()
                .fill(.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchArchvationView()
    }
}
