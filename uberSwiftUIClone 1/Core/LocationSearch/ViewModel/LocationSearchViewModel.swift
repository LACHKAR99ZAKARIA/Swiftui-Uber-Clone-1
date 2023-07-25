//
//  LocationSearchViewModel.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 24/7/2023.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    // MARK:  Proprietés
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime : String?
    @Published var dropOfTime : String?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    var userLocation : CLLocationCoordinate2D?
    // MARK:  LifeCycle
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    // MARK:  Helpers
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
//        self.selectedLocation = location
        locationSearch(forLocalSearchComplition: localSearch) { responce, error in
            if let error = error {
                print("\(error)")
                return
            }
            guard let item = responce?.mapItems.first else {
                return
            }
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordination: coordinate)
//            print("coordinate : \(coordinate)")
        }
    }
    func locationSearch(forLocalSearchComplition localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    func computeRidePrice(forType type: RideType) -> Double {
        guard let coordinate = selectedUberLocation?.coordination else { return 0.0}
        guard let userLocation = self.userLocation else { return 0.0}
        let startLocalisatio = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let tripDistanceInMeters = startLocalisatio.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }
    // MARK:  get route
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
        let userPlacement = MKPlacemark(coordinate: userLocation)
        let destPlacement = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacement)
        request.destination = MKMapItem(placemark: destPlacement)
        let direction = MKDirections(request: request)
        direction.calculate { respoce, error in
            if let error = error {
                print("Debug Faild: \(error)")
                return
            }
            guard let route = respoce?.routes.first else {
                return
            }
            self.configurePickupAndDropofTime(with: route.expectedTravelTime)
            completion(route)
        }
    }
    func configurePickupAndDropofTime(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        pickupTime = formatter.string(from: Date())
        dropOfTime = formatter.string(from: Date() + expectedTravelTime)
    }
}

// MARK:  MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
