import SwiftUI

class QuizManager: ObservableObject {
    @Published var mockQuestion = [
        Question(title: " ¿Qué vehiculo representa la seña? ", answer: "A", options: ["A", "B", "C", "D"]),
        Question(title: " ¿Qué lugar representa la seña? ", answer: "A", options: ["A", "B", "C", "D"]),
        Question(title: " ¿Qué letra representa la seña? ", answer: "A", options: ["A", "B", "C", "D"]),
        Question(title: " ¿Que numero representa la seña? ", answer: "A", options: ["A", "B", "C", "D"])
    ]
    
    @Published var currentQuestionIndex = 0
    @Published var isQuizActive = false
    @Published var timer: Timer?
    @Published var elapsedTime = 0
    
    @Published var correctAnswers = 0
    @Published var incorrectAnswers = 0
    @Published var score = 0
    
    init() {
        startTimer()
    }
    
    func startTimer() {
        isQuizActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.elapsedTime += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isQuizActive = false
    }
    
    func canSubmitQuiz() -> Bool {
        return mockQuestion.filter({ $0.selection == nil }).isEmpty
    }
    
    func gradeQuiz() -> String {
        stopTimer()
        
        var correct: CGFloat = 0
        for question in mockQuestion {
            if question.answer == question.selection {
                correct += 1
            }
        }
        return "\((correct / CGFloat(mockQuestion.count)) * 100) %"
    }
}

struct QuestionGame: View {
    @StateObject var manager = QuizManager()
    @State private var showResults = false
    @State private var navigateToQuiz = false
    @State private var _resetQuestions: Bool = false // Variable para reiniciar las preguntas

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            TabView {
                ForEach(manager.mockQuestion.indices, id: \.self) { index in
                    VStack {
                        Spacer()
                        Text("Pregunta \(index + 1) de \(manager.mockQuestion.count)")
                        QuestionView(question: $manager.mockQuestion[index])
                        Text("Tiempo transcurrido: \(manager.elapsedTime) segundos")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.top)
                        Spacer()
                        
                        if let lastQuestion = manager.mockQuestion.last,
                           lastQuestion.id == manager.mockQuestion[index].id {
                            Button {
                                manager.stopTimer()
                                _ = manager.elapsedTime
                                manager.correctAnswers = manager.mockQuestion.filter { $0.answer == $0.selection }.count
                                manager.incorrectAnswers = manager.mockQuestion.count - manager.correctAnswers
                                manager.score = Int((CGFloat(manager.correctAnswers) / CGFloat(manager.mockQuestion.count)) * 100)
                                
                                showResults = true
                            } label: {
                                Text("Submit")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .fill(Color("QuestionColor"))
                                            .frame(width: 340)
                                    )
                            }
                            .buttonStyle(.plain)
                            .disabled(!manager.canSubmitQuiz())
                            .background(
                                NavigationLink("", destination: ResultsView(elapsedTime: manager.elapsedTime, navigateToQuiz: $navigateToQuiz, resetQuestions: $_resetQuestions), isActive: $showResults)
                                    .opacity(0)
                                    .frame(width: 0, height: 0)
                            )
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onAppear {
                // Restablecer el objeto de preguntas si _resetQuestions es verdadero
                if _resetQuestions {
                    manager.mockQuestion = [
                        Question(title: " ¿Qué vehiculo representa la seña? ", answer: "A", options: ["A", "B", "C", "D"]),
                        Question(title: " ¿Qué lugar representa la seña? ", answer: "A", options: ["A", "B", "C", "D"]),
                        Question(title: " ¿Qué letra representa la seña? ", answer: "A", options: ["A", "B", "C", "D"]),
                        Question(title: " ¿Que numero representa la seña? ", answer: "A", options: ["A", "B", "C", "D"])
                    ]
                    // Desactivar _resetQuestions después de reiniciar el examen
                    _resetQuestions = false
                }
                manager.startTimer()
            }
            .onDisappear {
                manager.stopTimer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .font(.title)
                .foregroundColor(.primary)
        })
        .environmentObject(manager)
    }
}


struct QuestionGame_Previews: PreviewProvider {
    static var previews: some View {
        QuestionGame()
    }
}

