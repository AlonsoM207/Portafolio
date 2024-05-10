//
//  DeletrearConSeñas.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 21/09/23.
//

import SwiftUI

struct DeletrearConSenias: View {
    var body: some View {
            ZStack{
                // Color de fondo
                Color("Primary")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width: 450, height: 70)
                        Text("Deletrea este objeto usando señas")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Text"))
                            .font(Font
                                .custom("Oxygen-Regular", size: 35))
                    }
                    Image("Placeholder2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(width: 300, height: 70)
                            .padding()
                        Text("M _ _ _ _ _ _")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Text"))
                            .font(Font
                            .custom("Oxygen-Regular", size: 35))
                    
                    }
                Image("Signs")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 250)
                }
            }
        }
}

struct DeletrearConSenias_Previews: PreviewProvider {
    static var previews: some View {
        DeletrearConSenias()
    }
}
