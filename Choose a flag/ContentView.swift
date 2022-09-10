//
//  ContentView.swift
//  Choose a flag
//
//  Created by karpo_dub on 10/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["UK", "USA", "Bangladesh", "Germany", "Argentina", "Brazil", "Canada", "Greece", "Sweden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = " "
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .green]), startPoint: .top, endPoint: .bottom)
            VStack(spacing: 30) {
                VStack {
                    Text("Choose a flag")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 125)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("\(scoreTitle)"), message: Text("Total on account: \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        .ignoresSafeArea()
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Right!"
            score += 1
        } else {
            scoreTitle = "Wrong! It's \(countries[number])"
            score = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
