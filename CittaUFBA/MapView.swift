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
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: rotas[selectedBus]!.caminho) {location in
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
            
            VStack {
                HStack {
                    Text("Selecione uma rota:")
                        .font(.headline)
                    
                    Spacer()
                    
                    Picker("Selecione uma rota", selection: $selectedBus) {
                        ForEach(Bus.allCases) {bus in
                            Text(bus.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(20)
                
                Spacer()
                
                Button("HORÁRIOS") {
                    isPresented.toggle()
                }.sheet(isPresented: $isPresented) {
                    VStack{
                        List {
                            Section {
                                ForEach(rotas[selectedBus]!.horarios, id: \.self) {
                                    horario in Text("\(horario)")
                                        .padding()
                                }
                            } header: {
                                Text("Horários*  \(selectedBus.rawValue.capitalized)")
                            }
                            .headerProminence(.increased)
                            
                            Section {
                                Text("* sujeito às condições de trânsito")
                                Text("** último horário a entrar em são lazáro")
                                Text("*** passa pelo portão principal de ondina")
                            } header: {
                                Text("Legenda")
                            }
                        }
                    }
                }
                .buttonStyle(BlueButton())
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
