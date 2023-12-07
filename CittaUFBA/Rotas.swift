//
//  Rotas.swift
//  CittaUFBA
//
//  Created by Student08 on 05/12/23.
//

import Foundation
import MapKit

struct Location : Identifiable {
    let id : UUID = UUID()
    let name : String
    let coordinate : CLLocationCoordinate2D
    let description : String
}

struct Route {
    let bus : Bus
    let caminho : [Location]
    let ida : [Location]
    let volta : [Location]
    let horarios : [String]
}

enum Bus : String, CaseIterable, Identifiable {
    case B1, B2, B3, B4, B5, EXPRESSO
    var id: Self { self }
}

var paradas : [String : Location] = [
    "PAF1": Location(name: "Pt. Estacionamento PAF I / Matemática", coordinate: CLLocationCoordinate2D(latitude: -13.001787223372643,longitude: -38.50695695922911), description: "Pt. Estacionamento PAF I / Matemática"),
    "RESIDENCIA5": Location(name: "Av. Garibalde Pt. R5", coordinate: CLLocationCoordinate2D(latitude: -12.999188055701158, longitude: -38.50590377061353), description: "Av. Garibaldi Pt. R5"),
    "VIADUTOVALEDOCANELA": Location(name: "Vale do Canela", coordinate: CLLocationCoordinate2D(latitude: -12.991324823379184, longitude: -38.51990744730723), description: "Vale do Canela"),
    "ARQUITETURA": Location(name: "Arquitetura", coordinate: CLLocationCoordinate2D(latitude: -12.997972331679389, longitude: -38.507776093506344), description: "Faculdade de Arquitetura"),
    "POLITECNICA": Location(name: "Politecnica", coordinate: CLLocationCoordinate2D(latitude: -12.998977275812774, longitude: -38.51083809347577), description: "Escola Politecnica"),
    "CRECHE": Location(name: "Creche", coordinate: CLLocationCoordinate2D(latitude: -12.995595881234435, longitude: -38.51571617080564), description: "Pt. Creche Canela"),
    "REITORIA": Location(name: "Reitoria", coordinate: CLLocationCoordinate2D(latitude: -12.99290908554212, longitude: -38.5188261253909), description: ""),
    
    "ESTGEOCIENCIAS": Location(name: "Estacionamento Geociências", coordinate: CLLocationCoordinate2D(latitude: -12.999318551881649, longitude: -38.50555647075596), description: "Estacionamento Geociências"),
    //    "ROTULAREISCATOLICOS": "",
    //    "ICS": "",
    "VIADUTOCAMPOGRANDE": Location(name: "Viaduto do Campo Grande", coordinate: CLLocationCoordinate2D(latitude: -12.988597101549608, longitude: -38.52071799363476
                                                                                                      ), description: ""),
    "SAOLAZARO": Location(name: "São Lázaro", coordinate: CLLocationCoordinate2D(latitude: -13.004976649183536, longitude: -38.51235961609195), description: "São Lázaro"),
    "RESIDENCIA1E2": Location(name: "Residencia 1 e 2 - Largo da vitória", coordinate: CLLocationCoordinate2D(latitude: -12.9896492, longitude: -38.5422639), description: ""),
    "DELICECIA": Location(name: "Ponto Deli&cia - acesso direito", coordinate: CLLocationCoordinate2D(latitude: -12.9896492, longitude: -38.5422639), description: ""),
    "VIADUTOFEDERACAO": Location(name: "Viaduto Federação", coordinate: CLLocationCoordinate2D(latitude: -12.9989208, longitude: -38.5201048), description: ""),
    "FACED": Location(name: "ADM / FACED", coordinate: CLLocationCoordinate2D(latitude: -12.9896492, longitude: -38.5422639), description: "Volta: ADM / FACED / Contábeis / Pavilhão de Aulas Canela / Acesso: DIREITO / ICS /"),
    "DIREITO": Location(name: "Faculdade de Direito da UFBA", coordinate: CLLocationCoordinate2D(latitude: -12.996230899927232, longitude: -38.52171499805207), description: ""),
    //    "ODONTOLOGIA": "",
    //    "VASGODAGAMA": "",
    //    "ORIXASCENTER": "",
    //    "ECONOMIA": "",
    //    "GABINETE": "",
    //    "PIEDADE": "",
    //    "CAMPOGRANDE": "",
    "BELASARTES": Location(name: "Belas Artes", coordinate: CLLocationCoordinate2D(latitude: -12.99071721705346, longitude: -38.519958770882475), description: "Belas Artes"),
    "RESIDENCIA3": Location(name: "Residência, R. Humberto de Campos", coordinate: CLLocationCoordinate2D(latitude: -12.99685570846989, longitude: -38.51883948011861), description: "Residencia 3"),
    "INSTFEMININOPOLITEAMA": Location(name: "Inst. Feminino (Politeama)", coordinate: CLLocationCoordinate2D(latitude: -12.9857454, longitude: -38.5220504), description: "Inst. Feminino (Politeama)"),
    "GEOCIENCIAS": Location(name: "Geociências", coordinate: CLLocationCoordinate2D(latitude: -12.9980058, longitude: -38.5097005), description: "Geociências")
]

var B1 : Route = Route(
    bus: .B1,
    caminho: [
        paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["VIADUTOVALEDOCANELA"]!, paradas["VIADUTOCAMPOGRANDE"]!,paradas["BELASARTES"]!, paradas["REITORIA"]!,
        paradas["CRECHE"]!, paradas["POLITECNICA"]!, paradas["SAOLAZARO"]!, paradas["ARQUITETURA"]!, paradas["ESTGEOCIENCIAS"]!,
    ],
    ida: [paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["VIADUTOVALEDOCANELA"]!, paradas["VIADUTOCAMPOGRANDE"]!,paradas["BELASARTES"]!, paradas["REITORIA"]!],
    volta: [paradas["REITORIA"]!, paradas["CRECHE"]!, paradas["POLITECNICA"]!, paradas["SAOLAZARO"]!, paradas["ARQUITETURA"]!, paradas["ESTGEOCIENCIAS"]!, paradas["PAF1"]!],
    horarios: ["6:10", "7:00", "7:50", "8:40", "9:30", "10:20", "11:10", "12:00", "12:50", "13:40", "14:40", "15:40", "16:30", "17:30", "18:20 **", "19:20", "19:50 ***", "20:20 ***", "21:00 ***", "21:40 ***", "22:15 ***"]
)

var EXPRESSO : Route = Route(
    bus: .EXPRESSO,
    caminho: [
        paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["VIADUTOFEDERACAO"]!, paradas["ARQUITETURA"]!, paradas["POLITECNICA"]!, paradas["CRECHE"]!, paradas["REITORIA"]!, paradas["ESTGEOCIENCIAS"]!
    ],
    ida: [paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["VIADUTOVALEDOCANELA"]!, paradas["VIADUTOCAMPOGRANDE"]!,paradas["BELASARTES"]!, paradas["REITORIA"]!],
    volta: [paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["VIADUTOVALEDOCANELA"]!, paradas["VIADUTOCAMPOGRANDE"]!,paradas["BELASARTES"]!, paradas["REITORIA"]!],
    horarios: ["6:30", "7:20", "8:00", "9:00", "9:50", "10:40", "11:30", "12:20", "13:10", "14:00", "14:50", "15:40", "16:30", "17:20", "18:10", "19:00", "19:50", "20:40"]
)

var B3 : Route = Route(
    bus: .B3,
    caminho: [paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["ARQUITETURA"]!, paradas["POLITECNICA"]!, paradas["SAOLAZARO"]!, paradas["CRECHE"]!, paradas["RESIDENCIA3"]!, paradas["DIREITO"]!, paradas["VIADUTOVALEDOCANELA"]!, paradas["ESTGEOCIENCIAS"]!],
    ida: [paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["ARQUITETURA"]!, paradas["POLITECNICA"]!, paradas["SAOLAZARO"]!, paradas["CRECHE"]!, paradas["RESIDENCIA3"]!, paradas["DIREITO"]!, paradas["VIADUTOVALEDOCANELA"]!, paradas["ESTGEOCIENCIAS"]!, paradas["PAF1"]!],
    volta: [paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["ARQUITETURA"]!, paradas["POLITECNICA"]!, paradas["SAOLAZARO"]!, paradas["CRECHE"]!, paradas["RESIDENCIA3"]!, paradas["DIREITO"]!, paradas["VIADUTOVALEDOCANELA"]!, paradas["ESTGEOCIENCIAS"]!, paradas["PAF1"]!],
    horarios: ["6:10", "7:10", "8:00", "8:50", "9:50", "10:40", "11:20", "12:00", "12:50", "13:50","14:50", "15:50", "16:50", "17:55", "19:00", "20:00", "20:50", "21:30", "22:15"])

var B2 : Route = Route(
    bus: .B2,
    caminho: [
        paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["VIADUTOFEDERACAO"]!, paradas["ARQUITETURA"]!,paradas["POLITECNICA"]!, paradas["CRECHE"]!,
        paradas["REITORIA"]!, paradas["INSTFEMININOPOLITEAMA"]!, paradas["RESIDENCIA1E2"]!, paradas["DELICECIA"]!, paradas["SAOLAZARO"]!, paradas["GEOCIENCIAS"]!,
    ],
    ida: [paradas["PAF1"]!, paradas["RESIDENCIA5"]!, paradas["VIADUTOFEDERACAO"]!, paradas["ARQUITETURA"]!, paradas["POLITECNICA"]!, paradas["CRECHE"]!, paradas["REITORIA"]!],
    volta: [paradas["INSTFEMININOPOLITEAMA"]!, paradas["RESIDENCIA1E2"]!, paradas["DELICECIA"]!, paradas["SAOLAZARO"]!, paradas["POLITECNICA"]!, paradas["ARQUITETURA"]!, paradas["GEOCIENCIAS"]!, paradas["PAF1"]!,],
    horarios: ["6:10", "7:10", "8:20", "9:20", "10:20", "11:20", "12:20", "13:30", "14:40", "15:40", "16:40", "17:40", "18:50**", "19:40", "20:30", "21:10", "22:30"]
)

var rotas : [Bus : Route] = [
    .B1 : B1,
    .B2 : B2,
    .B3 : B3,
    .B4 : B1,
    .B5 : B1,
    .EXPRESSO : EXPRESSO,
]

let geociencias = Location(name: "Geociencias", coordinate: CLLocationCoordinate2D(latitude: -12.9980058, longitude: -38.5097005), description: "Instituto de Geociencias")
let portaoPrincipalOndina = Location(name: "Portao Principal Ondina", coordinate: CLLocationCoordinate2D(latitude: -13.0044559, longitude: -38.510035), description: "")
let igeoResidenciaGaribalde = Location(name: "Igeo Residencia Garibalde", coordinate: CLLocationCoordinate2D(latitude: -12.9971221, longitude: -38.5108653), description: "")
let famed = Location(name: "Famed ICS", coordinate: CLLocationCoordinate2D(latitude: -12.9944802, longitude: -38.5230584), description: "")



