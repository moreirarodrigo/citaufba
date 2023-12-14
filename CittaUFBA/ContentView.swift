//
//  ContentView.swift
//  CittaUFBA
//
//  Created by Student08 on 04/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var directions : [String] = ["a", "b", "c"]
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Ônibus", systemImage: "bus")
                }
            MapaRota(directions: directions)
                .tabItem {
                    Label("Rotas", systemImage: "map")
                }
            Horarios()
                .tabItem {
                    Label("Horários", systemImage: "clock")
                }
            RastreadorView()
                .tabItem {
                    Label("Rastrear", systemImage: "magnifyingglass")
                }
            Charts()
                .tabItem {
                    Label("Gráficos", systemImage: "chart.bar.xaxis")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
