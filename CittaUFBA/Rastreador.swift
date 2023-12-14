//
//  Rastreador.swift
//  CittaUFBA
//
//  Created by Student08 on 14/12/23.
//

import SwiftUI
import MapKit

struct RastreadorView: View {
    
    @State private var local = [Location(name: "Posicao Atual", coordinate: CLLocationCoordinate2D(latitude: -12.981271577952414, longitude: -38.51717798212894), description: "Posicao atual do onibus")]
    
    @StateObject var vm = ViewModel()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -12.981271577952414, longitude: -38.51717798212894),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var body: some View {
        VStack{
            Map(coordinateRegion: $region, annotationItems: local){ ondeesta in
               
                MapAnnotation(coordinate: ondeesta.coordinate) {
                    Text("")
                        .frame(width: 20, height: 20)
                        .background(Color.yellow)
                        .clipShape(Circle())
                }
            }
            .frame(width: 400, height:850)
//            .ignoresSafeArea()
            
        } .onAppear() {
            
            var a = 0.0
            var x = 0.0
            var y = 0.0
            
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true){ t in
                vm.fetch()
                 a += 1
                
                x = Double("-38.5104505")!
                y = Double("-13.0011624")!
                
                for (index, _) in local.enumerated() {
//                    local[index].coordinate = CLLocationCoordinate2D(latitude: Double(vm.posicao!.latitude) ?? 0.0, longitude: Double(vm.posicao!.longitude) ?? 0.0)
                    
                    local[index].coordinate = CLLocationCoordinate2D(latitude: (y + (a * 0.002)), longitude: x + (a * 0.002))
                    
                    region.center = local[index].coordinate
                }
            }
        }
    }
}

struct RastreadorView_Previews: PreviewProvider {
    static var previews: some View {
        
        RastreadorView()
    }
}
