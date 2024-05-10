//
//  LetraView.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 03/10/23.
//

import SwiftUI

struct LetraView: View {
    let letra: Letra
    @ObservedObject var model: LetrasViewModel
    var body: some View {
        ZStack{
            Color("Primary")
            VStack{
                WebViewWithGIF(urlString: letra.gifile)
            }
        }
    }
}

struct LetraView_Previews: PreviewProvider {
    static var previews: some View {
        LetraView(letra: letraList[0], model: .init())
    }
}
