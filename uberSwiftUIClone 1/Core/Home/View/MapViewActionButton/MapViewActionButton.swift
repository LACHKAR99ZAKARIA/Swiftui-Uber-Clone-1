//
//  MapViewActionButton.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 24/7/2023.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewStat
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            imageNameForState(mapState)
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black ,radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    func actionForState(_ state: MapViewStat) {
        switch state {
        case .noInput :
//            mapState = .searchingForLocation
            print("no input")
        case .searchingForLocation :
            mapState = .noInput
        case .locationSelected :
            mapState = .noInput
        }
    }
    func imageNameForState(_ state: MapViewStat) -> Image {
        switch state {
        case .noInput :
            return Image(systemName: "line.3.horizontal")
        case .searchingForLocation :
            return Image(systemName: "arrow.left")
        case .locationSelected :
            return Image(systemName: "arrow.left")
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
