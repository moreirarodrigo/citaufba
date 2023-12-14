//
//  Horarios.swift
//  CittaUFBA
//
//  Created by Student08 on 14/12/23.
//

import SwiftUI

struct Horarios: View {
    @State var horarios : [String]?
    var body: some View {
        VStack{
            if (horarios == nil  ) {
                Text("Hello World")
            } else {
                List {
                    Section {
                        ForEach(horarios!, id: \.self) {
                            horario in Text(horario)
                        }
                    } header: {
                        Text("Horários")
                    }.headerProminence(.increased)
                    
                    Section {
                        Text("* sujeito às condições de trânsito")
                        Text("** último horário a entrar em são lazáro")
                        Text("*** passa pelo portão principal de ondina")
                    } header: {
                        Text("Legenda")
                    }
                }
            }
        }.onAppear(){
            horarios = Global.horarios
        }
    }
}

struct Horarios_Previews: PreviewProvider {
    static var previews: some View {
        Horarios()
    }
}
