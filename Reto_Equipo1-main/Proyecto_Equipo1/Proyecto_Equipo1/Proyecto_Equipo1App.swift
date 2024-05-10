//
//  Proyecto_Equipo1App.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 11/09/23.
//

import SwiftUI

@main
struct Proyecto_Equipo1App: App {
    
    @StateObject private var predictionStatus = PredictionStatus()
    //@StateObject private var predictionStatus2 = PredictionStatus2()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(predictionStatus)
                //.environmentObject(predictionStatus2)
        }
    }
}
