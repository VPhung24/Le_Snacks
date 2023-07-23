//
//  MapView.swift
//  LeSnacks
//
//  Created by Vivian Phung on 7/21/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    let address: String
    @State var showRestaurant: Restaurant?
    @StateObject private var viewModel = LeSnacksModelsViewModel<Restaurant>()

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
                .onTapGesture {
                    self.showRestaurant = item
                }
            }

        }
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
        .onAppear {
            viewModel.fetch(endpoint: .restaurants)
        }
        .tabItem {
            Label("Find", systemImage: "map.fill")
        }
        .sheet(isPresented: .constant($showRestaurant.wrappedValue != nil)) {
            RestaurantView(address: address, restaurant: showRestaurant!)
            .presentationDetents([.fraction(0.3)])
            .presentationDragIndicator(.visible)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(address: "0xafe50ddc4dabf67e6e1e8262c880fc5d3d34be1b")
    }
}
