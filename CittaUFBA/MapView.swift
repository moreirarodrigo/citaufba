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
    
    @State private var selectedLocation : Location = Location(name: "ADM / FACED", coordinate: CLLocationCoordinate2D(latitude: -12.9896492, longitude: -38.5422639), description: "Volta: ADM / FACED / Contábeis / Pavilhão de Aulas Canela / Acesso: DIREITO / ICS /")
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("Selecione uma rota:")
                
                Spacer()
                
                Picker("Selecione uma rota", selection: $selectedBus) {
                    ForEach(Bus.allCases) {bus in
                        Text(bus.rawValue)
                    }
                }.pickerStyle(.menu)
        
                Text("\(selectedBus.rawValue.capitalized)")
                
                Spacer()
            }.padding()
            
            Spacer()
            
            Text("Roteiro BUZUFBA")
                .font(.title)
            
                        Text(selectedLocation.name)
                            .font(.subheadline)
            
            Spacer()
            
            
            Map(coordinateRegion: $region, annotationItems: rotas[selectedBus]!.caminho) {location in
//                MapMarker(coordinate: location.coordinate)
                
                MapAnnotation(coordinate: location.coordinate) {
                    Circle()
                        .fill(.red
                        )
                        .frame(width: 30, height: 30)
                        .onTapGesture(count: 1) {
                            selectedLocation = location

                            isPresentedPoint.toggle()
                        }.sheet(isPresented: $isPresentedPoint) {
                            Text("\(selectedLocation.name)")
                                .font(.title)
                        }
                }
            }
            
            Spacer()
            
            Button("HORÁRIOS") {
                isPresented.toggle()
            }.sheet(isPresented: $isPresented) {
                VStack{
                    List {
                        Section(header: Text("Horários \(selectedBus.rawValue.capitalized)")) {
                            ForEach(rotas[selectedBus]!.horarios, id: \.self) {
                                horario in Text("\(horario)").padding()
                            }
                        }.headerProminence(.increased)
                    }
                }
            }
            .buttonStyle(BlueButton())
            .padding()
            //            ScrollView(.horizontal) {
            //                HStack {
            //                    ForEach(locations) {
            //                        location in Button(location.name) {
            //                            selectedLocation = location
            //
            //                            region.center = location.coordinate
            //                        }.buttonStyle(BlueButton())
            //                    }
            //                }
            //            }
            //            .padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
