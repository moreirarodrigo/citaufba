//
//  ContentView.swift
//  CitaUFBA
//
//  Created by Student13 on 05/12/23.
//

import SwiftUI
import Foundation
import MapKit

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -12.981271577952414, longitude: -38.51717798212894),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State private var isPresented : Bool = false
    
    @State private var isPresentedPoint : Bool = false
    
    @State private var selectedBus : Bus = Bus.B1
    
    @State private var selectedRoute : Route = rotas[.B1]!
    
    var coordinates = rotas[.B1]!.caminho.map { (location) ->
        CLLocationCoordinate2D in return location.coordinate
    }
    
    @State private var selectedLocation : Location = Location(name: "ADM / FACED", coordinate: CLLocationCoordinate2D(latitude: -12.9896492, longitude: -38.5422639), description: "Volta: ADM / FACED / Contábeis / Pavilhão de Aulas Canela / Acesso: DIREITO / ICS /")
    
    @State private var directions : [String] = []
    @State private var showDirections = false
    
    var body: some View {
        ZStack {
            MapsView(directions: $directions, selectedBus: $selectedBus, ida: false)
            
            VStack {
                HStack {
                    Text("Selecione uma rota:")
                        .font(.headline)
                    
                    Spacer()
                    
                    Picker("Selecione uma rota", selection: $selectedBus) {
                        ForEach(Bus.allCases) {
                            bus in
                            Text(bus.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    .onReceive([self.selectedBus].publisher.first()) { _ in
                        Global.horarios = rotas[selectedBus]!.horarios
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(20)
                
                Spacer()
            }
        }
    }
}

struct MapsView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var directions: [String]
    @Binding var selectedBus: Bus
    @State var ida : Bool
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Configurar o mapa, adicionar marcadores, etc.
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Atualizar o mapa conforme necessário
        if let route = rotas[selectedBus] {
            context.coordinator.updateMapView(uiView, with: route, ida: ida)
        }
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        var parent: MapsView
        
        init(parent: MapsView) {
            self.parent = parent
        }
        
        func updateMapView(_ mapView: MKMapView, with route: Route, ida : Bool) {
            mapView.removeAnnotations(mapView.annotations)
            mapView.removeOverlays(mapView.overlays)
            
            // Adicionar anotações para todas as paradas do caminho
            for location in route.ida {
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                annotation.title = location.name
                mapView.addAnnotation(annotation)
            }
            
            // Criar a solicitação de direções e calcular a rota apenas se for o ônibus selecionado
            let request = MKDirections.Request()
            request.requestsAlternateRoutes = true
            request.transportType = .automobile
            
            if(ida){
                if let firstLocation = route.ida.first, let lastLocation = route.ida.last {
                    request.source = MKMapItem(placemark: MKPlacemark(coordinate: firstLocation.coordinate))
                    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: lastLocation.coordinate))
                    
                    let directions = MKDirections(request: request)
                    directions.calculate { response, error in
                        guard let route = response?.routes.first else { return }
                        mapView.addOverlay(route.polyline)
                        mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
                        self.parent.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
                        Global.teste = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
                    }
                }
            } else{
                if let firstLocation = route.volta.first, let lastLocation = route.volta.last {
                    request.source = MKMapItem(placemark: MKPlacemark(coordinate: firstLocation.coordinate))
                    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: lastLocation.coordinate))
                    
                    let directions = MKDirections(request: request)
                    directions.calculate { response, error in
                        guard let route = response?.routes.first else { return }
                        mapView.addOverlay(route.polyline)
                        mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
                        self.parent.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
                        Global.teste = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
                    }
                    
                    
                    
                }
                
            }
            
            
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
