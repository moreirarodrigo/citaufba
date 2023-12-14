import SwiftUI
import MapKit
    
struct TestView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -12.981271577952414, longitude: -38.51717798212894),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    @State private var isPresented: Bool = false
    @State private var selectedBus: Bus = Bus.B1

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Text("Selecione uma rota:")

                Spacer()

                Picker("Selecione uma rota", selection: $selectedBus) {
                    ForEach(Bus.allCases) { bus in
                        Text(bus.rawValue)
                    }
                }
                .pickerStyle(.menu)

                Spacer()
            }
            .padding()

            Spacer()

            Text("Roteiro BUZUFBA")
                .font(.title)

            Spacer()

            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: Binding.constant(selectedBus == .B1 ? .follow : .none), annotationItems: rotas[selectedBus]!.caminho) { location in
                MapMarker(coordinate: location.coordinate, tint: .red)
                
            }
            .overlay(
                // Desenha a polyline da rota em azul
                Polyline(route: rotas[selectedBus]!.ida, color: .blue)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            )
            .overlay(
                // Desenha a polyline da rota em vermelho
                Polyline(route: rotas[selectedBus]!.volta, color: .red)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            )

            Spacer()

            Button("HORÁRIOS") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                VStack {
                    List {
                        Section {
                            ForEach(rotas[selectedBus]!.horarios, id: \.self) { horario in
                                Text("\(horario)").padding()
                            }
                        }
                        header: {
                            Text("Horários*  \(selectedBus.rawValue.capitalized)")
                        }
                        .headerProminence(.increased)

                        Section {
                            Text("* sujeito às condições de trânsito")
                            Text("** último horário a entrar em são lazáro")
                            Text("*** passa pelo portão principal de ondina")
                        }
                        header: {
                            Text("Legenda")
                        }
                    }
                }
            }
            .buttonStyle(BlueButton())
            .padding()
            .ignoresSafeArea()
        }
    }
}

struct Polyline: Shape {
    var route: [Location]
    var color: Color

    func path(in rect: CGRect) -> Path {
        var path = Path()

        guard route.count > 1 else {
            return path
        }

        if let firstCoordinate = route.first?.coordinate {
            path.move(to: CGPoint(x: firstCoordinate.longitude, y: firstCoordinate.latitude))
        }

        for location in route.dropFirst() {
            let point = CGPoint(x: location.coordinate.longitude, y: location.coordinate.latitude)
            path.addLine(to: point)
        }

        return path
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
