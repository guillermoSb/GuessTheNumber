//
//  ContentView.swift
//  GuessTheNumber
//
//  Created by Guille on 5/05/21.
//

import SwiftUI

struct ContentView: View {
  @State private var randomNumber = 0.0;
  @State private var userGuess = "";
  @State private var alertShowing = false;
  @State private var alertText = "";
    var body: some View {
      ZStack {
        VStack{
          Text("Guess The Number")
            .font(.system(size: 35, weight: .bold, design: .rounded))
          
          Slider(value: $randomNumber, in: 0...100) { (editing) in
            // Current editing
          }
          .disabled(true)
          TextField("Your Guess", text: $userGuess)
            .keyboardType(.numberPad)
            .padding(.all)
            .cornerRadius(3)

          Button("Guess!") {
            // 1. Verificar si el usuario adivinó correctamente
            if Double(userGuess) == randomNumber {
              alertShowing = true
              self.alertText = "Has adivinado!"
            } else {
              alertShowing = true
              let error = abs(Int(randomNumber) - (Int(userGuess) ?? 0))
              self.alertText = "No has adivinado. El correcto es \(randomNumber) - has fallado por \(error)"
            }
          }
          .alert(isPresented: $alertShowing, content: {
            Alert(title: Text("Resultado"), message: Text(self.alertText), dismissButton: .default(Text("Intentar otra vez"), action: {
              self.randomNumber = createRandomNumber()
            }))
          })
        
        }
        
      }
      .padding(.all)
      
    }
}

// Crea un numero random de 1 a 100
func createRandomNumber () -> Double {
  let randomNumber = Int.random(in: 0...100)
  return Double(randomNumber)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
