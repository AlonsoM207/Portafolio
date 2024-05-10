// ResultsView.swift

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var manager: QuizManager
    let elapsedTime: Int
    @Binding var navigateToQuiz: Bool
    @Binding var resetQuestions: Bool // Agrega esta propiedad

    var body: some View {
        VStack {
            Text("Resultados del Examen")
                .font(.largeTitle)
                .padding()

            Text("Tiempo Transcurrido: \(elapsedTime) segundos")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()

            Text("Respuestas Correctas: \(manager.correctAnswers)")
                .font(.headline)
                .foregroundColor(.green)
                .padding()

            Text("Respuestas Incorrectas: \(manager.incorrectAnswers)")
                .font(.headline)
                .foregroundColor(.red)
                .padding()

            Text("Puntuación: \(manager.score)%")
                .font(.headline)
                .padding()

            Spacer()

            Button(action: {
                // Configura resetQuestions en true para volver a contestar el examen
                resetQuestions = true
                
                navigateToQuiz = true
            }) {
                Text("Retomar Examen")
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color("QuestionColor"))
                            .frame(width: 200)
                    )
            }
        }
    }
}

