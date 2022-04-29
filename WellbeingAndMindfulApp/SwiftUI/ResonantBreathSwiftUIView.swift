//
//  ResonantBreathSwiftUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 22/02/2022.
//

import SwiftUI

//Struct - resonant breath
struct ResonantBreathSwiftUIView: View {
    
    //Variables
    @State var animate = false
    @State private var displayHold = false
    @State private var displayBreathOut = false
    @State private var hideBreathIn = false
    @State private var displaySecondHold = false
    var dark = Color.init(red: 109/255, green: 157/255, blue: 135/255)
    var light = Color.init(red: 216/255, green: 238/255, blue: 227/255)
    var repeatcount = 0
    var colour = "green"
    
    //Animation body
    var body: some View {
        ZStack{
            ZStack{
                Circle().fill(dark.opacity(0.25)).frame(width: 300, height: 300).scaleEffect(self.animate ? 1:0.3)
                
                Circle().fill(dark.opacity(0.35)).frame(width: 250, height: 250).scaleEffect(self.animate ? 1:0.3)
                
                Circle().fill(dark.opacity(0.45)).frame(width: 200, height: 200).scaleEffect(self.animate ? 1:0.3)
                
                Circle().fill(dark.opacity(0.55)).frame(width: 150, height: 150).scaleEffect(self.animate ? 1:0.3)
                
                Circle().fill(dark).frame(width: 100, height: 100)
            }.onAppear{
                self.animate.toggle()
            }
            .animation(Animation.linear(duration: 5).repeatCount((repeatcount*2), autoreverses: true))
        

        ZStack{
            Text("Breathe Out")
                .foregroundColor(light)
                .scaleEffect(1)
                .opacity(displayBreathOut ? 1 : 0 )
                .onAppear(){
                    withAnimation(Animation.easeInOut(duration: 0.5).delay(5)){
                        self.displayBreathOut.toggle()
                    }
                    
                    withAnimation(Animation.easeInOut(duration: 0.5).delay(10)){
                        self.displayBreathOut.toggle()
                    }
                    
                    var x = 15.0
                    for _ in 1...(repeatcount-1){
                        withAnimation(Animation.easeInOut(duration: 0.5).delay(x)){
                            self.displayBreathOut.toggle()
                            x = x + 5
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 0.5).delay(x)){
                            self.displayBreathOut.toggle()
                            x = x + 5
                        }
                    }
                }

            Text("Breathe In")
                .foregroundColor(light)
                .opacity(hideBreathIn ? 0 : 1 )
                .onAppear(){
                    withAnimation(Animation.easeInOut(duration: 0.5).delay(5)){
                        self.hideBreathIn.toggle()
                    }
                    var x = 10.0
                    for _ in 1...(repeatcount-1){
                        withAnimation(Animation.easeInOut(duration: 0.5).delay(x)){
                            self.hideBreathIn.toggle()
                            x = x + 5
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 0.5).delay(x)){
                            self.hideBreathIn.toggle()
                            x = x + 5
                        }
                    }
                }
        }
    }
}
}


