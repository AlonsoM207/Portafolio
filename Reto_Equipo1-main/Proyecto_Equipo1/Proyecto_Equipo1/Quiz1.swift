import SwiftUI

struct QuizView: View {
    @State private var currentQuestionIndex: Int = 0
    @State private var score: Int = 0
    @State private var showFinalView: Bool = false
    @State private var randomQuizzes: [QuizModel] = []
    @State private var navigateToGameSelect: Bool = false

    var body: some View {
        ZStack {
            Color("Primary")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 20) {
                // Cuando todas las preguntas han sido contestadas, se muestra FinalView
                if currentQuestionIndex >= randomQuizzes.count {
                    FinalView(score: score)
                } else {
                    let question = randomQuizzes[currentQuestionIndex]
                    
                    Image(question.img!)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                    
                    Text(question.text!)
                    
                    ForEach(0..<question.answer.count, id: \.self) { index in
                        Button(action: {
                            // Lógica para verificar respuesta
                            if question.correct == index {
                                score += 1
                            }
                            
                            // Pasar a la siguiente pregunta
                            currentQuestionIndex += 1
                            
                            // Si hemos contestado todas las preguntas, mostrar FinalView
                            if currentQuestionIndex == randomQuizzes.count {
                                showFinalView = true
                            }
                        }) {
                            Text(question.answer[index])
                                .padding()
                                .frame(width: 250, height: 50, alignment: .center)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }

                NavigationLink("", destination: GameSelect(), isActive: $navigateToGameSelect)
            }
            .onAppear {
                randomQuizzes = Array(myQuiz1.shuffled().prefix(5))
            }
            .foregroundColor(Color(uiColor: .secondaryLabel))
            .padding(.horizontal, 20)
            .frame(width: 330, height: 550, alignment: .leading)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(20)
            .shadow(color: Color(uiColor: .label).opacity(0.2), radius: 15)
            .navigationTitle("Quiz Game")
            .alert(isPresented: $showFinalView) {
                Alert(title: Text("Quiz Completado"),
                      message: Text("Tu puntuaión es: \(score)"),
                      primaryButton: .default(Text("Volver a tomar el quiz")) {
                        SaveScore(quiz: "myQuiz1", score: score)
                        randomQuizzes = Array(myQuiz1.shuffled().prefix(5))
                        // Resetting for the next quiz session
                        currentQuestionIndex = 0
                        score = 0
                      },
                      secondaryButton: .default(Text("Volver a Menú")) {
                        self.navigateToGameSelect = true
                      }
                )
            }
        }
    }
}
