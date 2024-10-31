//
//  Consumo.swift
//  AppEstFin
//
//  Created by Brandon Elib Martinez Santos on 31/10/24.
//

import Foundation

struct Consumo: Codable {
    var id_tarjeta: Int
    var nombre_tarjeta: String?
    var totalGastos: Decimal
    var totalCargosFijos: Decimal
    var totalAPagar: Decimal
}
