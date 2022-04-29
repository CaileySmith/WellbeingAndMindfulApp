//
//  DiaphragmaticBreathSwiftUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 22/02/2022.
//

import SwiftUI

//Struct - Diaphragmatic breath
struct DiaphragmaticBreathSwiftUIView: View {
    
    //Variables
    @State var scaleInOut = false
    @State var rotateInOut = false
    @State var moveInOut = false
    @State private var displayHold = false
    @State private var displayBreathOut = false
    @State private var hideBreathOut = false
    @State private var hideBreathIn = false
    var colour = "green"
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
            .animation(Animation.easeInOut(duration: 8).repeatCount((repeatcount*2), autoreverses: true))
            .onAppear(){
                self.rotateInOut.toggle()
                self.scaleInOut.toggle()
                self.moveInOut.toggle()
            }
            Spacer()
            ZStack{
                Text("Breathe Out")
                    .foregroundColor(light)
                    .scaleEffect(1)
                    .opacity(displayBreathOut ? 1 : 0 )
                    .onAppear(){
                        withAnimation(Animation.easeInOut(duration: 0.8).delay(8)){
                            self.displayBreathOut.toggle()
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 0.8).delay(16)){
                            self.displayBreathOut.toggle()
                        }
                        
                        var x = 24.0
                        for _ in 1...(repeatcount-1){
                            withAnimation(Animation.easeInOut(duration: 0.8).delay(x)){
                                self.displayBreathOut.toggle()
                                x = x + 8
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 0.8).delay(x)){
                                self.displayBreathOut.toggle()
                                x = x + 8
                            }
                        }
                    }

                Text("Breathe In")
                    .foregroundColor(light)
                    .opacity(hideBreathIn ? 0 : 1 )
                    .onAppear(){
                        withAnimation(Animation.easeInOut(duration: 0.8).delay(8)){
                            self.hideBreathIn.toggle()
                        }
                        var x = 16.0
                        for _ in 1...(repeatcount-1){
                            withAnimation(Animation.easeInOut(duration: 0.8).delay(x)){
                                self.hideBreathIn.toggle()
                                x = x + 8
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 0.8).delay(x)){
                                self.hideBreathIn.toggle()
                                x = x + 8
                            }
                        }
                    }
            }

        }
    }
}


