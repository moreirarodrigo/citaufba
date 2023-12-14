//
//  MapaRota.swift
//  CittaUFBA
//
//  Created by Student08 on 14/12/23.
//

import SwiftUI

struct MapaRota: View {
    @State var directions : [String]?
    var showDirections = false
    
    var body: some View {
        VStack{
            if (directions == nil) {
                Text("Selecione uma rota !!!")
            } else {
                List {
                    Section {
                        ForEach(directions!, id: \.self) { direction in
                            Text(direction)
                        }
                    } header: {
                        Text("Rotas")
                    }.headerProminence(.increased)
                }
            }
        }.onAppear(){
            directions = Global.teste
        }
    }
}

struct MapaRota_Previews: PreviewProvider {
    static var previews: some View {
        MapaRota()
    }
}
