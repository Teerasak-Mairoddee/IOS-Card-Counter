//
//  ContentView.swift
//  codeacademy
//
//  Created by Teerasak Mairoddee on 17/02/2023.
//

import SwiftUI

var counter = 0
var runningCount = 0
var casinoDeckAmount = 4
var totalCards = casinoDeckAmount * 52
var remainingDecks = casinoDeckAmount
var trueCount = 0
var oneUnit = 25
var betAdvice = oneUnit
var currency = "£"
var outputAdvice: String = "Bet minimum bet, Low advantage"


struct ContentView: View {
    
    @State var runningCountText = Text("0")
    @State var trueCountText = Text("0")
    @State var adviceText = Text("Start Counting!")
    @State var prevLabel = Label("Last Count: Zero", systemImage: "arrowtriangle.left.circle")
    
    
    var body: some View {
        
        VStack {
            
            Group{
                    trueCountText.fontWeight(.black).padding(.top, 10.0)
                
                    runningCountText
                    .fontWeight(.medium)
                    .foregroundColor(Color.green)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/).padding(.top, 10.0)
                
                    adviceText.fontWeight(.bold).padding(.top, 20.0)
                
                    //Count Up
                    Button{
                    runningCountText = Text(countCard(value: +1, cards:totalCards))
                    trueCountText = Text(String(trueCount))
                    adviceText = Text(outputAdvice)
                    prevLabel = Label("Last Count: Up", systemImage: "arrowtriangle.left.circle")
                    }label:{
                        VStack{
                            //Text("TEST")//Display above
                            Label(" 2, 3, 4, 5, 6 ", systemImage: "dpad.up.filled")
                        }
                    }.padding(.top, 100.0).buttonStyle(.borderedProminent)
                
                    //Count Zero
                    Button{
                        totalCards -= 1
                        print(totalCards)
                        prevLabel = Label("Last Count: Zero", systemImage: "arrowtriangle.left.circle")
                    }label:{
                        Label("    7, 8, 9        ", systemImage: "circle.circle.fill")
                    }.padding(.top, 60.0).buttonStyle(.borderedProminent)
                    
                    //Count Down
                    Button{
                    runningCountText = Text(countCard(value: -1, cards: totalCards))
                    trueCountText = Text(String(trueCount))
                    adviceText = Text(outputAdvice)
                    prevLabel = Label("Last Count: Down", systemImage: "arrowtriangle.left.circle")
                    }label:{
                        Label("10, J, K, Q, A", systemImage: "dpad.down.filled")
                    }.padding(.top, 60.0).buttonStyle(.borderedProminent)
                
                
                
                
            }
            
            //Rest Option
            Group{
                prevLabel.padding(.top, 100.0)
                Button {
                    counter = 0
                    runningCount = 0
                    casinoDeckAmount = 8
                    totalCards = casinoDeckAmount * 52
                    remainingDecks = casinoDeckAmount
                    trueCount = 0
                    oneUnit = 25
                    betAdvice = oneUnit
                    currency = "£"
                    outputAdvice = "Bet minimum bet, Low advantage"
                    runningCountText = Text(String(runningCount))
                    trueCountText = Text(String(trueCount))
                    adviceText = Text(outputAdvice)
                }label:{
                    Label("Reset", systemImage: "rectangle.on.rectangle.circle.fill")
                }.foregroundColor(Color.red).padding(.top, 10.0)
            }
        }
        
        
        

       
    }
}


//Card Count Calculations
func countCard(value: Int, cards: Int)->String{
    
    totalCards -= 1
    runningCount = runningCount + value
    
    var output = String(runningCount)
    var cardsOutput = String(cards)
    print(output)
    
    print("Cards: ",cardsOutput)
    
    var remDeckCalc = Double(cards)/Double(52)
    remainingDecks = Int(remDeckCalc.rounded(.down))
    
    print("Remaining Decks: ",remainingDecks)
    
    var trueCountCalc = runningCount / remainingDecks
    trueCount = trueCountCalc
    print("True Count: ",trueCount)
    //Amount to Bet = (True Count – 1) * Betting Unit if less than 1 bet min. MIT Strategy
    betAdvice = (trueCount - 1) * oneUnit
    
    if (trueCount < 2) {
      // block of code if condition is true
        print("Bet minimum bet, Low advantage")
        outputAdvice = "Bet minimum bet, Low advantage.\n\nLow cards incoming!"
    }
    if(trueCount == 2) {
        print("Bet 1 unit: ",currency,betAdvice)
        outputAdvice = "Bet 1 unit: "+String(currency)+String(betAdvice)+".\n\nPotential High cards"
    }
    if(trueCount > 2){
        print("Bet ",String(trueCount - 1)," units: ",currency,betAdvice)
        outputAdvice = "Bet "+String(trueCount - 1)+" units: "+String(currency)+String(betAdvice)+".\n\nHigh cards incoming"
    }
    
    
    
    return (output)
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
