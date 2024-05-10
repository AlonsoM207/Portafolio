//
//  ClassifierViewModel.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 11/10/23.
//
/*
import Foundation

final class ClassifierViewModel2: ObservableObject {
    @Published var classifierData: [Classification2] = []
    @Published var dataWhenAboutTapped:Int = 0
    
    func loadJSON() {
        print("load JSON")
        if let url = Bundle.main.url(forResource: "mydata2", withExtension: "geojson") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                classifierData = try decoder.decode([Classification2].self, from: jsonData)
            } catch {
                print(error)
            }
        } else {
            print("could not find data")
        }
    }
    
    func getPredictionData2(label: String) -> Classification2 {
        return classifierData.filter { $0.label == label }.first ?? Classification2()
    }
}
*/
