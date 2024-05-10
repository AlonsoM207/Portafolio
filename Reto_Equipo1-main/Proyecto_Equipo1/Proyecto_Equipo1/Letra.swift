//
//  Letra.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 03/10/23.
//

import Foundation

struct Letra {
    let name: String
    let gifile: String
}

extension Letra: Identifiable, Hashable {
    var id: String { name }
}
