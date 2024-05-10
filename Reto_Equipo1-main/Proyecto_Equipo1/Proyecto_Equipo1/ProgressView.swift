//
//  ProgressView.swift
//  Simple Quiz Game
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct BarChart: View {
    var scores: [Int]
    var maxScore: Int

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 2) {
                ForEach(self.scores, id: \.self) { score in
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: CGFloat(score) / CGFloat(self.maxScore) * geometry.size.height)
                }
            }
        }
    }
}

struct ProgressView: View {
    var allScores: [Int] = LoadScores(quiz: "myQuiz1")
    var lastScores: [Int] {
        Array(allScores.suffix(5))
    }
    let maxScore = 5 // Asumiendo que el puntaje máximo posible es 5

    var body: some View {
        VStack {
            List(lastScores, id: \.self) { score in
                Text("Score: \(score)")
            }
            
            Divider()
            
            Text("Score over Last 5 Attempts")
                .font(.headline)
                .padding(.top)
            
            BarChart(scores: lastScores, maxScore: maxScore)
                .frame(height: 200)
                .padding(.horizontal)
            
        }
        .navigationTitle("Progress")
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}

