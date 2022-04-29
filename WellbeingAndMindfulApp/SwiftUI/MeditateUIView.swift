//
//  MeditateUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 25/02/2022.
//

import SwiftUI

//Struct - Meditate
struct MeditateUIView: View {
    
    //Variables
    @State var scaleInOut = false
    @State var rotateInOut = false
    @State var moveInOut = false
    @State private var displayHold = false
    @State private var displayBreathOut = false
    @State private var hideBreathOut = false
    @State private var hideBreathIn = false
    var colour = "green"
    var length = 0.0
    var track = 0
    @State var counter = Text("0:00")
    @State var mins: Int = 0
    @State var seconds: Int = 0
    @State var timer: Timer? = nil
    var dark = Color.init(red: 109/255, green: 157/255, blue: 135/255)
    var light = Color.init(red: 216/255, green: 238/255, blue: 227/255)
    var repeatcount = 0
    
    //Animation body
    var body: some View {
        ZStack{
            Spacer()
            ZStack{
                ZStack{
                    Circle().fill(dark)
                    .frame(width: 200, height: 200, alignment: .center)
                    .offset(y: moveInOut ? -40 : 0)
                    
                    Circle().fill(dark)
                    .frame(width: 200, height: 200, alignment: .center)
                    .offset(y: moveInOut ? 40 : 0)
                }
                .opacity(0.25)
                
                ZStack{
                    Circle().fill(dark)
                    .frame(width: 200, height: 200, alignment: .center)
                    .offset(y: moveInOut ? -40 : 0)
                    
                    Circle().fill(dark)
                    .frame(width: 200, height: 200, alignment: .center)
                    .offset(y: moveInOut ? 40 : 0)
                }
                .opacity(0.25).rotationEffect(.degrees(60))
                
                ZStack{
                    Circle().fill(dark)
                    .frame(width: 200, height: 200, alignment: .center)
                    .offset(y: moveInOut ? -40 : 0)
                    
                    Circle().fill(dark)
                    .frame(width: 200, height: 200, alignment: .center)
                    .offset(y: moveInOut ? 40 : 0)
                }
                .opacity(0.25).rotationEffect(.degrees(120))
            }
            .rotationEffect(.degrees(rotateInOut ? 90 : 0))
            .scaleEffect(scaleInOut ? 1 : 0.8 )
            .animation(Animation.easeInOut(duration: 7).repeatForever(autoreverses: true))
            .onAppear(){
                self.rotateInOut.toggle()
                self.scaleInOut.toggle()
                self.moveInOut.toggle()
            }
            Spacer()
            Text("\(mins):\(seconds)")
                .foregroundColor(light)

        }
        .onAppear(){
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
              if self.seconds == 59 {
                self.seconds = 0
                self.mins = self.mins + 1
              } else {
                self.seconds = self.seconds + 1
              }
                if track == 0 {
                    if Double(self.mins) == self.length {
                                        timer?.invalidate()
                    }
                }else {
                    var wholeNumberPart: Double = 0.0
                    let temp = self.length/60
                    let fractionalPart = modf(temp, &wholeNumberPart)
                    if (fractionalPart * 100 == Double(self.seconds) && wholeNumberPart == Double(self.mins)){
                        timer?.invalidate()
                    }
                }
            }
        }
    }
}

