import SwiftUI

//first view of the app
struct Home: View {

    //var for the score
    @State var score = 0
    @State var isBlinking = false

    var body: some View {
        ZStack {
            Color("Primary")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                
                Text("BIENVENIDO")
                    .scaleEffect(isBlinking ? 1.2 : 1)
                    .opacity(isBlinking ? 0 : 100)
                    .frame(width: 250, height: 50, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                            self.isBlinking.toggle()
                        }
                    }
                    .padding()
                
                //button to start the quiz
                NavigationLink(destination: QuizView()) {
                    Text("EMPEZAR QUIZ")
                        .scaleEffect(isBlinking ? 1.2 : 1)
                        .opacity(isBlinking ? 0 : 100)
                        .frame(width: 250, height: 50, alignment: .center)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                
                HStack {
                    //display your score
                    NavigationLink(destination: ProgressView()) {
                        Text("Ver Progreso")
                            .scaleEffect(isBlinking ? 1.2 : 1)
                            .opacity(isBlinking ? 0 : 100)
                            .frame(width: 250, height: 50, alignment: .center)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                }

                }
            }
            // VStack
            .navigationBarTitle("Quiz", displayMode: .inline)
        }
        // NavigationView
        
    }
    // BODY
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

