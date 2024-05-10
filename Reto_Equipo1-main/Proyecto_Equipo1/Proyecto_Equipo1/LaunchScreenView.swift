//
//  IntroView.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 13/10/23.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
            ZStack{
                // Color de fondo
                Color("Primary")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    //Logo de la aplicación
                    Image("Placeholder")
                        .resizable()
                        .cornerRadius(100)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .offset(y:-50)
                    // Título de la aplicación
                    Text("Aprendiendo con Señas")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Text"))
                        .font(Font
                            .custom("Oxygen-Regular", size:45))
                        .offset(y:-60)
                    // Botón que lleva a la página principal de la app
                    NavigationLink(destination: TabView2()) {
                        Text("Iniciar")
                            .font(.system(size: 35))
                    } .buttonStyle(.borderedProminent)
                        .tint(.pink)
                }
                    
            }
    }
}

struct launchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
