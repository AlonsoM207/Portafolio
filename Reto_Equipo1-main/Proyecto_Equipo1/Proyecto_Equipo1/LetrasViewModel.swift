//
//  LetrasViewModel.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 03/10/23.
//

import Foundation
import Combine

class LetrasViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var letras = letraList
    
    func downloadLetras() async throws {
        isLoading = true
        do {
            /*
             //Real request
             let url = URL(string "")!
             let urlRequest = URLRequest(url:url)
             let (data, response) = try await URLSession.shared.data(for:Request)
             let decoder = JSONDecoder()
             let items = try decoder.decode([Planet].self, from data)
             */
            
            // Simulate request
            try await Task.sleep(for: .seconds(1))
            
            isLoading = false
            letras = letraList
            
        } catch {
            isLoading = false
            print("LetrasViewModel Error:", error.localizedDescription)
            throw error
        }
    }
}

let letraList = [
    Letra(name: "A", gifile: "SA"),
    Letra(name: "B", gifile: "SB"),
    Letra(name: "C", gifile: "SC"),
    Letra(name: "D", gifile: "SD"),
    Letra(name: "E", gifile: "SE"),
    Letra(name: "F", gifile: "SF"),
    Letra(name: "G", gifile: "SG"),
    Letra(name: "H", gifile: "SH"),
    Letra(name: "I", gifile: "SI"),
    Letra(name: "J", gifile: "SJ"),
    Letra(name: "K", gifile: "SK"),
    Letra(name: "L", gifile: "SL"),
    Letra(name: "LL", gifile: "SLL"),
    Letra(name: "M", gifile: "SM"),
    Letra(name: "N", gifile: "SN"),
    Letra(name: "Ñ", gifile: "SÑ"),
    Letra(name: "O", gifile: "SO"),
    Letra(name: "P", gifile: "SP"),
    Letra(name: "Q", gifile: "SQ"),
    Letra(name: "R", gifile: "SR"),
    Letra(name: "RR", gifile: "SRR"),
    Letra(name: "S", gifile: "SS"),
    Letra(name: "T", gifile: "ST"),
    Letra(name: "U", gifile: "SU"),
    Letra(name: "V", gifile: "SV"),
    Letra(name: "W", gifile: "SW"),
    Letra(name: "X", gifile: "SX"),
    Letra(name: "Y", gifile: "SY"),
    Letra(name: "Z", gifile: "SZ"),
    Letra(name: "1", gifile: "S1"),
    Letra(name: "2", gifile: "S2"),
    Letra(name: "3", gifile: "S3"),
    Letra(name: "4", gifile: "S4"),
    Letra(name: "5", gifile: "S5"),
    Letra(name: "6", gifile: "S6"),
    Letra(name: "7", gifile: "S7"),
    Letra(name: "8", gifile: "S8"),
    Letra(name: "9", gifile: "S9"),
    Letra(name: "10", gifile: "S10"),
]
