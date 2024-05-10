//
//  Letras-Señas.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 21/09/23.
//
/*
import SwiftUI

struct LetrasSenias2: View {
    @EnvironmentObject var predictionStatus2: PredictionStatus2
    @StateObject private var model = LetrasViewModel()
    @StateObject var classifierViewModel2 = ClassifierViewModel2()
    private(set) var labelData: Classification2
    @State private var ansChosen = ""
    @State private var picture = 1
    @State private var colorLetra = "white"
    
    var body: some View {
        let predictionLabel = predictionStatus2.topLabel
            ZStack{
                // Color de fondo
                Color("Primary")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width: 350, height: 50)
                         
                            
                        Text("Busca una letra")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Text"))
                            .font(Font.custom("Oxygen-Regular", size: 30))
                         
                    }
                    .padding()
                    .offset(y: -30)
                    VStack{
                        LetraView(letra: letraList[picture], model: LetrasViewModel())
                    }
        
                    // DO NOT EDIT this section. This displays the classification camera
                    GeometryReader { geo in
                        VStack(alignment: .center) {
                            LiveCameraRepresentable2() {
                                predictionStatus2.setLivePrediction2(with: $0, label: $1, confidence: $2)
                            }
                            
                            //PredictionResultView(labelData: classifierViewModel.getPredictionData(label: predictionLabel))
                            
                        }// HStack
                        .onAppear(perform: classifierViewModel2.loadJSON)
                        .frame(width: geo.size.width)
                        
                        .offset(y: -80)
                    }
                    HStack{
                        ZStack{
                            Button(action: {
                                ansChosen = predictionLabel
                                print("button pressed")
                                if ansChosen == "A"{
                                    picture = 0
                                } else if ansChosen == "B"{
                                    picture = 1
                                } else if ansChosen == "C"{
                                    picture = 2
                                } else if ansChosen == "D"{
                                    picture = 3
                                } else if ansChosen == "E"{
                                    picture = 4
                                } else if ansChosen == "F"{
                                    picture = 5
                                } else if ansChosen == "G"{
                                    picture = 6
                                } else if ansChosen == "H"{
                                    picture = 7
                                } else if ansChosen == "I"{
                                    picture = 8
                                } else if ansChosen == "J"{
                                    picture = 9
                                } else if ansChosen == "K"{
                                    picture = 10
                                } else if ansChosen == "L"{
                                    picture = 11
                                } else if ansChosen == "LL"{
                                    picture = 12
                                } else if ansChosen == "M"{
                                    picture = 13
                                } else if ansChosen == "N"{
                                    picture = 14
                                } else if ansChosen == "Ñ"{
                                    picture = 15
                                } else if ansChosen == "O"{
                                    picture = 16
                                } else if ansChosen == "P"{
                                    picture = 17
                                } else if ansChosen == "Q"{
                                    picture = 18
                                } else if ansChosen == "R"{
                                    picture = 19
                                } else if ansChosen == "RR"{
                                    picture = 20
                                } else if ansChosen == "S"{
                                    picture = 21
                                } else if ansChosen == "T"{
                                    picture = 22
                                } else if ansChosen == "U"{
                                    picture = 23
                                } else if ansChosen == "V"{
                                    picture = 24
                                } else if ansChosen == "W"{
                                    picture = 25
                                } else if ansChosen == "X"{
                                    picture = 26
                                } else if ansChosen == "Y"{
                                    picture = 27
                                } else if ansChosen == "Z"{
                                    picture = 28
                                } else if ansChosen == "1"{
                                    picture = 29
                                } else if ansChosen == "2"{
                                    picture = 30
                                } else if ansChosen == "3"{
                                    picture = 31
                                } else if ansChosen == "4"{
                                    picture = 32
                                } else if ansChosen == "5"{
                                    picture = 33
                                } else if ansChosen == "6"{
                                    picture = 34
                                } else if ansChosen == "7"{
                                    picture = 35
                                } else if ansChosen == "8"{
                                    picture = 36
                                } else if ansChosen == "9"{
                                    picture = 37
                                } else if ansChosen == "10"{
                                    picture = 38
                                } else {
                                    print("UNKNOWN")
                                }
                                    }) {
                                        Image("Camara")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        
                                    }
                                    .buttonStyle(.borderedProminent)
                                        .tint(.green)
                                        

                        }
                        ShowSignView2(labelData: classifierViewModel2.getPredictionData2(label: predictionLabel))
                    }.offset(y: -50)
                }
            }
        
    }
}

struct LetrasSenias2_Previews: PreviewProvider {
    static var previews: some View {
        LetrasSenias2(labelData: Classification2())
    }
}
*/
