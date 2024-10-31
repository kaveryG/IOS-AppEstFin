//
//  ContentView.swift
//  AppEstFin
//
//  Created by Brandon Elib Martinez Santos on 31/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var consumos: [Consumo] = []
    @State private var idUsuario: Int = 1 // Cambia este valor según el id_usuario que desees probar
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            List(consumos, id: \.id_tarjeta) { consumo in
                VStack(alignment: .leading) {
                    Text("Tarjeta: \(consumo.nombre_tarjeta ?? "Sin nombre")")
                    Text("Total Gastos: \(consumo.totalGastos)")
                    Text("Total Cargos Fijos: \(consumo.totalCargosFijos)")
                    Text("Total a Pagar: \(consumo.totalAPagar)")
                }
            }
            .padding()
            
            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
            
            Button("Consultar Consumo") {
                fetchConsumo(idUsuario: idUsuario)
            }
        }
        .padding()
    }

    func fetchConsumo(idUsuario: Int) {
        guard let url = URL(string: "http://localhost:5287/api/Estimacion/ConsultarConsumo/\(idUsuario)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([Consumo].self, from: data)
                DispatchQueue.main.async {
                    self.consumos = decodedData
                    self.errorMessage = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
