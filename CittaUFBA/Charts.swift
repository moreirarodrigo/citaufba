//
//  Charts.swift
//  CittaUFBA
//
//  Created by Student08 on 14/12/23.
//

import SwiftUI
import Charts

struct Ficha: Identifiable {
    var name: String
    var pessoas: Double
    var horarios: String?
    var count: Double?
    var id = UUID()
}

var name : [Ficha] = [
    .init(name: "B1", pessoas: 20),
    .init(name: "B2", pessoas: 31),
    .init(name: "B3", pessoas: 18),
    .init(name: "B4", pessoas: 34),
    .init(name: "B5", pessoas: 13),
    .init(name: "EXPRESSO", pessoas: 30)
]

var horarios = ["6:30", "7:30", "8:20", "9:10", "10:10", "11:20", "12:20", "13:10", "14:10", "15:10", "16:10", "17:20", "18:25**", "19:20", "20:20", "21:10", "21:50", "22:30"]

struct Charts: View {
    var body: some View {
        Chart {
            ForEach(name) { name in
                BarMark(
                    x: .value("Type", name.name),
                    y: .value("Total Count", name.pessoas)
                )
                .foregroundStyle(.linearGradient(colors: [.green, .red], startPoint: .bottom, endPoint: .top))
                .alignsMarkStylesWithPlotArea()
                .annotation(position: .top) {
                    Image(systemName: "figure.stand")
                        .foregroundColor(.blue)
                }

            }
         }
    }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        Charts()
    }
}
