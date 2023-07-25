//
//  MapView.swift
//  uberSwiftUIClone 1
//
//  Created by Zakarai Lachkar on 24/7/2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var mapState: MapViewStat
    @EnvironmentObject var viewModel: LocationSearchViewModel
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    // MARK:  update mapView
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput :
            context.coordinator.clearMapViewAndRecentUserLocation()
            break
        case .searchingForLocation :
            break
        case .locationSelected :
            if let coordinate = viewModel.selectedUberLocation?.coordination {
    //            print("selected location: \(coordinate)")
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        }
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapView {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent : MapView
        var userLocationCoordinate : CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
        // MARK:  route specifications
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        // MARK:  Helpers
        // MARK:  add Annocation
        func addAndSelectAnnotation (withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        // MARK:  configure Route
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else {
                return
            }
            parent.viewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                // MARK:  map Size
                let rec = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(
                    top: 64, left: 34, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rec), animated: true)
            }
        }
        func clearMapViewAndRecentUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let currentRegion = self.currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
