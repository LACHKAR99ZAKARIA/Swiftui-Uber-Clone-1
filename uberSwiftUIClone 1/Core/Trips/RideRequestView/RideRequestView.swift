//
//  RideRequestView.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 25/7/2023.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedUberType: RideType = .uberX
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        VStack {
            //
            Capsule()
                .foregroundColor(Color(.systemGray))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray))
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill(Color(.tertiarySystemGroupedBackground))
                        .frame(width: 8, height: 8)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        if let location = viewModel.selectedUberLocation {
                            Text(location.title)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(viewModel.pickupTime ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)
                    HStack {
                        Text("destination Location")
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                        Text(viewModel.dropOfTime ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 10)
            }
            .padding()
            Divider()
            Text("SUGGESTEED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases ,id: \.self) { type in
                        VStack(alignment: .leading) {
                            Image(type.imgName)
                                .resizable()
                                .scaledToFit()
                            VStack(alignment: .leading , spacing: 4) {
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(viewModel.computeRidePrice(forType: type).toCurrency())
                                    .font(.system(size: 9, weight: .semibold))
                            }
                            .padding(15)
                        }
                        .frame(width: 110, height: 170)
                        .background(Color(type == selectedUberType ? .systemBlue : .systemGroupedBackground))
                        .foregroundColor(type == selectedUberType ? .white : .gray)
                        .scaleEffect(type == selectedUberType ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation {
                                selectedUberType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            Divider()
                .padding(.vertical, 8)
            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(6)
                    .foregroundColor(.white)
                    .padding(.leading)
                Text("**** 1234")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .padding()
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .padding(.horizontal)
            Button {
                
            } label: {
                Text("Confirm Ride")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 24)
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
            .environmentObject(LocationSearchViewModel())
    }
}
