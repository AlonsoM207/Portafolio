//
//  MateSenias.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 21/09/23.
//

import SwiftUI

struct MateSenias: View {
    @EnvironmentObject var predictionStatus: PredictionStatus
    @StateObject var classifierViewModel = ClassifierViewModel()
    
    var body: some View {
        let predictionLabel = predictionStatus.topLabel
        ZStack{
            // Color de fondo
            Color("Primary")
                .edgesIgnoringSafeArea(.all)
            VStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(width: 300, height: 50)
                        .offset(y: -30)
                        .padding()
                    Text("Haz la seña correcta")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Text"))
                        .font(Font.custom("Oxygen-Regular", size: 30))
                    .offset(y: -30)
                }
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(width: 200, height: 60)
                        .offset(y: -55)
                        .padding()
                    Text("2 + ? = 5")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Text"))
                        .font(Font
                            .custom("Oxygen-Regular", size: 45))
                    .offset(y: -55)
                    
                }
                HStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .frame(width: 50, height: 50)
                            .offset(y: -100)
                            .padding()
                        Text("3")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Text"))
                            .font(Font.custom("Oxygen-Regular", size: 40))
                            .offset(y: -100)
                    }
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width: 50, height: 50)
                            .offset(y: -100)
                            .padding()
                        Text("1")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Text"))
                            .font(Font.custom("Oxygen-Regular", size: 40))
                            .offset(y: -100)
                    }
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width: 50, height: 50)
                            .offset(y: -100)
                            .padding()
                        Text("4")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Text"))
                            .font(Font.custom("Oxygen-Regular", size: 40))
                            .offset(y: -100)
                    }
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width: 50, height: 50)
                            .offset(y: -100)
                            .padding()
                        Text("6")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Text"))
                            .font(Font.custom("Oxygen-Regular", size: 40))
                            .offset(y: -100)
                    }
                    
                }
                // DO NOT EDIT this section. This displays the classification camera
                GeometryReader { geo in
                    VStack(alignment: .center) {
                        LiveCameraRepresentable() {
                            predictionStatus.setLivePrediction(with: $0, label: $1, confidence: $2)
                        }
                        
                        //PredictionResultView(labelData: classifierViewModel.getPredictionData(label: predictionLabel))
                        
                    }// HStack
                    .onAppear(perform: classifierViewModel.loadJSON)
                    .frame(width: geo.size.width)
                    .offset(x: 20)
                    .offset(y: -80)
                }
            }
        }
    }
}

struct MateSenias_Previews: PreviewProvider {
    static var previews: some View {
        MateSenias()
    }
}
