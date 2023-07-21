//
//  MapView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = RestaurantViewModel<Restaurant>()

    // hardcoded to paris for now
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.8714949, longitude: 2.3644501), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: viewModel.models) { item in
            MapAnnotation(coordinate: item.geolocation.clLocation) {
                VStack {
                    Image(systemName: "mappin")
                        .foregroundColor(.red)
                    Text(item.name)
                        .font(.caption)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

class RestaurantAnnotation: NSObject, MKAnnotation {
    let title: String?
    let cuisine: String
    let coordinate: CLLocationCoordinate2D

    init(restaurant: Restaurant) {
        self.title = restaurant.name
        self.cuisine = restaurant.cuisine
        self.coordinate = CLLocationCoordinate2D(latitude: restaurant.geolocation.latitude, longitude: restaurant.geolocation.longitude)
        
        super.init()
    }
}
