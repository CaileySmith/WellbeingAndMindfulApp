//
//  BoxBreathSwiftUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 16/02/2022.
//

import SwiftUI

//Struct - box breath
struct BoxBreathSwiftUIView: View {
        //Variables
        @State private var breatheIn = false
        @State private var breatheOut = false
        @State private var hold = true
        @State private var circularMotion = false
        @State private var displayHold = false
        @State private var displayBreathOut = false
        @State private var hideBreathIn = false
        @State private var displaySecondHold = false
        var colour = "green"
        var count = 0
        var repeatcount = 0
        var light = Color.init(red: 216/255, green: 238/255, blue: 227/255)
        var dark = Color.init(red: 109/255, green: 157/255, blue: 135/255)
        let screenBackground = Color.white
    
        //Animation Body
        var body: some View{
            ZStack {
                ZStack{
                    screenBackground.edgesIgnoringSafeArea(.all)
                    
                    ZStack{
                        //Center circles
                        dark
                        .clipShape(Circle())
                        .frame(width: 340, height: 340)
                        .opacity(0.5)
                        
                        dark
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                        .opacity(0.75)
                        
                        dark
                        .clipShape(Circle())
                        .frame(width: 260, height: 260)
                        
                        //region for hold
                        Circle()
                            .stroke(lineWidth: 5)
                            .frame(width: 370, height: 370)
                            .foregroundColor(light)
                        
                        //region for exhale
                        Circle()
                            .trim(from: 0, to: 1/4)
                            .stroke(lineWidth: 5)
                            .frame(width: 370, height: 370)
                            .foregroundColor(dark)
                            .rotationEffect(.degrees(-90))
                        
                        //region for inhale
                        Circle()
                            .trim(from: 0, to: 1/4)
                            .stroke(lineWidth: 5)
                            .frame(width: 370, height: 370)
                            .foregroundColor(dark)
                            .rotationEffect(.degrees(90))

                        ZStack {
                            //Rotating path
                            Circle()
                                .stroke()
                                .frame(width: 360, height: 360)
                                .opacity(0)
                            
                            //Rotating Capsule
                            Capsule()
                                .trim(from: 1/2, to: 1)
                                .frame(width: 25, height: 25)
                                .foregroundColor(dark)
                                .offset(y: 187)
                                .rotationEffect(.degrees(circularMotion ? 360 : 0))
                                .onAppear(){
                                    withAnimation(Animation.linear(duration: 16).repeatCount(repeatcount, autoreverses: false)){
                                        self.circularMotion = true
                                    }
                                }
                        }
                    }
                    .frame(width: 360, height: 360)
                        .scaleEffect(breatheIn ? 1 : 0.8)
                        .scaleEffect(hold ? 1 : 1)
                        .scaleEffect(breatheOut ? 0.8 : 1)
                        .onAppear(){
                            //expanding movement
                            withAnimation(Animation.linear(duration: 4)){
                                self.breatheIn.toggle()
                            }
                                
                            withAnimation(Animation.linear(duration: 4).delay(4)){
                                self.hold.toggle()
                            }
                                
                            withAnimation(Animation.linear(duration: 4).delay(8)){
                                self.breatheIn.toggle()
                            }
                                
                            withAnimation(Animation.linear(duration: 4).delay(12)){
                                self.hold.toggle()
                            }
                            //repeating
                            var x = 16.0
                            for _ in 1...(repeatcount-1){
                                withAnimation(Animation.linear(duration: 4).delay(x)){
                                    self.breatheIn.toggle()
                                    x = x + 4
                                }
                                
                                withAnimation(Animation.linear(duration: 4).delay(x)){
                                    self.hold.toggle()
                                    x = x + 4
                                }
                                
                                withAnimation(Animation.linear(duration: 4).delay(x)){
                                    self.breatheIn.toggle()
                                    x = x + 4
                                }
                                
                                withAnimation(Animation.linear(duration: 4).delay(x)){
                                    self.hold.toggle()
                                    x = x + 4
                                }
                            }
                        }
                    //text
                    ZStack{
                        Text("Breathe Out")
                            .foregroundColor(light)
                            .scaleEffect(1)
                            .opacity(displayBreathOut ? 1 : 0 )
                            .onAppear(){
                                withAnimation(Animation.easeInOut(duration: 0.4).delay(8)){
                                    self.displayBreathOut.toggle()
                                }
                                
                                withAnimation(Animation.easeInOut(duration: 0.4).delay(12)){
                                    self.displayBreathOut.toggle()
                                }
                                
                                var x = 24.0
                                for _ in 1...(repeatcount-1){
                                    withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                        self.displayBreathOut.toggle()
                                        x = x + 4
                                    }
                                    
                                    withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                        self.displayBreathOut.toggle()
                                        x = x + 12
                                    }
                                }
                            }
                        
                        Text("Hold")
                            .foregroundColor(light)
                            .scaleEffect(1)
                            .opacity(displaySecondHold ? 1 : 0 )
                            .onAppear(){
                                withAnimation(Animation.easeInOut(duration: 0.4).delay(12)){
                                    self.displaySecondHold.toggle()
                                }
                                
                                withAnimation(Animation.easeInOut(duration: 0.4).delay(16)){
                                    self.displaySecondHold.toggle()
                                }
                                
                                var x = 28.0
                                for _ in 1...(repeatcount-1) {
                                    withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                        self.displaySecondHold.toggle()
                                        x = x + 4
                                    }
                                    
                                    withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                        self.displaySecondHold.toggle()
                                        x = x + 12
                                    }
                                }
                            }
                        
                        Text("Hold")
                            .foregroundColor(light)
                            .scaleEffect(1)
                            .opacity(displayHold ? 1 : 0 )
                            .onAppear(){
                                withAnimation(Animation.easeInOut(duration: 0.4).delay(4)){
                                    self.displayHold.toggle()
                                }
                                
                                withAnimation(Animation.easeInOut(duration: 0.4).delay(8)){
                                    self.displayHold.toggle()
                                }
                                
                                var x = 20.0
                                for _ in 1...(repeatcount-1){
                                    withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                        self.displayHold.toggle()
                                        x = x + 4
                                    }
                                    
                                    withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                        self.displayHold.toggle()
                                        x = x + 12
                                    }
                                }
                            }
                        
                        Text("Breathe In")
                            .foregroundColor(light)
                            .opacity(hideBreathIn ? 0 : 1 )
                            .onAppear(){
                                withAnimation(Animation.easeInOut(duration: 0.4).delay(4)){
                                    self.hideBreathIn.toggle()
                                }
                                var x = 16.0
                                for _ in 1...(repeatcount-1){
                                    withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                        self.hideBreathIn.toggle()
                                        x = x + 4
                                    }
                                    
                                    withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                        self.hideBreathIn.toggle()
                                        x = x + 12
                                    }
                                }
                            }
                    }
                }
            }
        }
}
