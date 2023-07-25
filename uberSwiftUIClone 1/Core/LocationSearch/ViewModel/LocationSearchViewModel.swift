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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
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
            self.selectedLocationCoordinate = coordinate
//            print("coordinate : \(coordinate)")
        }
    }
    func locationSearch(forLocalSearchComplition localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
}

// MARK:  MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
