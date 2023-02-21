//
//  ContentView.swift
//  Flag
//
//  Created by user on 21.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Argentina", "Bangladesh", "Brazil", "China", "Colombian", "Egypt", "Europe", "France", "Germany", "Greece", "India", "Indonesia", "Iran", "Italia", "Mexico", "Phiippines", "Russia", "Sweden", "Thailand"].shuffled()

    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple, .white, .blue]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                VStack(spacing: 10) {
                    Text("Выбери флаг")
                        .foregroundColor(.black)
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                    Text(countries[correctAnswer])
                        .foregroundColor(.black)
                        .font(.largeTitle)
                    ForEach(0..<4) { number in
                        Button {
                            self.flagTapped(number)
                            self.showingScore = true
                        } label: {
                            Image(self.countries[number])
                                .resizable()
                                .frame(width: 200, height: 150)
                                .cornerRadius(20)
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white, lineWidth: 3))
                        }
                    }
                    Text("Общий счет \(score)")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
            }.alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Общий счет \(score)"), dismissButton: .default(Text("Продолжить")) {
                    self.askQuestion()
                })
            }
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...3)
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильный ответ!"
            score += 1
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[number])"
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
