//
//  quizModel.swift
//  Simple Quiz Game
//
//  Created by Alberto Panzera on 16/05/2020.
//

import Foundation


//structure of single quiz
struct QuizModel  {
    var img : String?
    var text : String?
    var answer : [String]
    //specify what is the correct answer
    var correct : Int?
}

//NOTE : answer is an array , array start from 0, not from 1
   //if correct is the first answer , set --> correct = 0
   // if correct is the second answer , set --> correct = 1
   //...




//final quiz is an array of quizmodel
var myQuiz1 : [QuizModel] = [

    QuizModel(img: "imgA",
        text: "¿Que letra representa la seña?",
        answer: ["h","a","y","u"],
        correct: 1),
        
        QuizModel(img: "imgB",
        text: "¿Que letra representa la seña?",
        answer: ["d","b","f","r"],
        correct: 1),
        
        QuizModel(img: "imgC",
        text: "¿Que letra representa la seña?",
        answer: ["x","y","c","z"],
        correct: 2),
        
        QuizModel(img: "imgD",
        text: "¿Que letra representa la seña?",
        answer: ["d","p","q","i"],
        correct: 0),
        
        QuizModel(img: "imgF",
        text: "¿Que letra representa la seña?",
        answer: ["t","f","w","a"],
        correct: 1),

        QuizModel(img: "imgG",
        text: "¿Que letra representa la seña?",
                  answer: ["f","g","w","a"],

        correct: 1),
        
        QuizModel(img: "imgH",
        text: "¿Que letra representa la seña?",
                  answer: ["f","f","w","h"],

        correct: 3),
    
        QuizModel(img: "imgI",
        text: "¿Que letra representa la seña?",
                  answer: ["f","f","i","a"],

        correct: 2),
    
        QuizModel(img: "imgJ",
        text: "¿Que letra representa la seña?",
                  answer: ["j","f","w","a"],

        correct: 0),
    
        QuizModel(img: "imgK",
        text: "¿Que letra representa la seña?",
                  answer: ["f","k","w","a"],

        correct: 1),
    
        QuizModel(img: "imgL",
        text: "¿Que letra representa la seña?",
        answer: ["l","f","w","a"],
        correct: 0),
    
        QuizModel(img: "imgM",
        text: "¿Que letra representa la seña?",
        answer: ["f","m","w","a"],
        correct: 1),
    
        QuizModel(img: "imgN",
        text: "¿Que letra representa la seña?",
        answer: ["f","f","n","a"],
        correct: 2),
    
        QuizModel(img: "imgS",
        text: "¿Que letra representa la seña?",
        answer: ["f","f","w","s"],
        correct: 3),
    
]



//func SaveScore(quiz : String , score : Int){
  //  UserDefaults.standard.set(score, forKey: quiz)
//}

//func LoadScore (quiz : String) -> Int{
  //  return UserDefaults.standard.integer(forKey: quiz)
//}


func SaveScore(quiz: String, score: Int) {
    var scores = UserDefaults.standard.array(forKey: quiz) as? [Int] ?? []
    scores.append(score)
    UserDefaults.standard.set(scores, forKey: quiz)
}

func LoadScores(quiz: String) -> [Int] {
    return UserDefaults.standard.array(forKey: quiz) as? [Int] ?? []
}
