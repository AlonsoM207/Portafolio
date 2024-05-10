//
//  LetrasView.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 03/10/23.
//

import SwiftUI

struct LetrasView: View {
    
    @StateObject private var model = LetrasViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Primary")
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(spacing: 16) {
                        if model.isLoading {
                            ProgressView()
                                .padding(32)
                                .controlSize(.large)
                        } else {
                            
                            ForEach(model.letras) { letra in
                                NavigationLink(value: letra) {
                                    HStack(spacing: 32) {
                                        Text(letra.name)
                                            .foregroundColor(Color("TextAlt"))
                                            .font(Font.custom("Oxygen-Regular", size: 33))
                                            .multilineTextAlignment(.leading)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    }
                                    .padding()
                                    .background(Color("red"), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    
                                    
                                }
                                .buttonStyle(.plain)
                                
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Señas")
            .navigationDestination(for: Letra.self) {letra in
                LetraView(letra: letra, model: LetrasViewModel())
            }
            .onAppear(perform: downloadLetras)
        }
    }
    
    func downloadLetras() {
        Task {
            do {
                try await model.downloadLetras()
            } catch {
                
            }
        }
    }
}

struct LetrasView_Previews: PreviewProvider {
    static var previews: some View {
        //NavigationStack{
            LetrasView()
        //}
    }
}
