//
//  Breath478SwiftUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 22/02/2022.
//

import SwiftUI

//Struct - 4-7-8 breath
struct Breath478SwiftUIView: View {
    
    //Variables
    @State private var breatheIn = false
    @State private var breatheOut = false
    @State private var hold = false
    @State private var circularMotion = false
    @State private var circularMotion2 = false
    @State private var circularMotion3 = false
    var colour = "green"
    var light = Color.init(red: 216/255, green: 238/255, blue: 227/255)
    var dark = Color.init(red: 109/255, green: 157/255, blue: 135/255)
    let screenBackground = Color.white
    var repeatcount = 0
    
    //Animation Body
    var body: some View{
        ZStack {
            ZStack{
                screenBackground.edgesIgnoringSafeArea(.all)
                ZStack{
                        dark //center circle
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .opacity(1)
                    
                    //in circle
                    Circle()
                        .stroke(lineWidth: 30)
                        .frame(width: 310, height: 310)
                        .foregroundColor(dark)
                        .opacity(0.25)
                    
                    //hold circle
                    Circle()
                        .stroke(lineWidth: 30)
                        .frame(width: 230, height: 230)
                        .foregroundColor(dark)
                        .opacity(0.5)
                    
                    //out circle
                    Circle()
                        .stroke(lineWidth: 30)
                        .frame(width: 150, height: 150)
                        .foregroundColor(dark)
                        .opacity(0.75)
                    
                    //hold
                    ZStack {
                        Circle()
                            .stroke()
                            .frame(width: 360, height: 360)
                            .opacity(0)
                        
                        Capsule()
                            .frame(width:30, height: 30)
                            .foregroundColor(dark)
                            .opacity(0.75)
                            .offset(y: -115)
                            .rotationEffect(.degrees(circularMotion2 ? 360 : 0))
                            .onAppear(){
                                withAnimation(Animation.linear(duration: 7).delay(4)){
                                    self.circularMotion2.toggle()
                                }
                                var x = 23.0
                                for _ in 1...(repeatcount-1){
                                    withAnimation(Animation.linear(duration: 7).delay(x)){
                                        self.circularMotion2.toggle()
                                    }
                                    x = x + 19
                                }
                            }
                    }
                    //out
                    ZStack {
                        Circle()
                            .stroke()
                            .frame(width: 360, height: 360)
                            .opacity(0)
                        
                        Capsule()
                            .frame(width:30, height: 30)
                            .foregroundColor(light)
                            .offset(y: -75)
                            .rotationEffect(.degrees(circularMotion3 ? 360 : 0))
                            .onAppear(){
                                withAnimation(Animation.linear(duration: 8).delay(11)){
                                    self.circularMotion3.toggle()
                                }
                                
                                var x = 30.0
                                for _ in 1...(repeatcount-1){
                                    withAnimation(Animation.linear(duration: 8).delay(x)){
                                        self.circularMotion3.toggle()
                                    }
                                    x = x + 19
                                }
                            }
                    }
                    
                    //in
                    ZStack {
                        Circle()
                            .stroke()
                            .frame(width: 360, height: 360)
                            .opacity(0)
                        
                        Capsule()
                            .frame(width:30, height: 30)
                            .foregroundColor(dark)
                            .offset(y: -155)
                            .rotationEffect(.degrees(circularMotion ? 360 : 0))
                            .onAppear(){
                                withAnimation(Animation.linear(duration: 4)){
                                    self.circularMotion.toggle()
                                }
                                var x = 19.0
                                for _ in 1...(repeatcount-1){
                                    withAnimation(Animation.linear(duration: 4).delay(x)){
                                        self.circularMotion.toggle()
                                    }
                                    x = x + 19
                                }
                               
                            }
                    }
                }

                ZStack{
                    Text("Breathe Out")
                        .foregroundColor(light)
                        .scaleEffect(1)
                        .opacity(breatheOut ? 1 : 0 )
                        .onAppear(){
                            withAnimation(Animation.easeInOut(duration: 0.8).delay(11)){
                                self.breatheOut.toggle()
                            }

                            withAnimation(Animation.easeInOut.delay(19)){
                                self.breatheOut.toggle()
                            }

                            var x = 30.0
                            for _ in 1...(repeatcount-1){
                                withAnimation(Animation.easeInOut(duration: 0.8).delay(x)){
                                    self.breatheOut.toggle()
                                    x = x + 8
                                }

                                withAnimation(Animation.easeInOut.delay(x)){
                                    self.breatheOut.toggle()
                                    x = x + 11
                                }
                            }
                        }

                    Text("Hold")
                        .foregroundColor(light)
                        .scaleEffect(1)
                        .opacity(hold ? 1 : 0 )
                        .onAppear(){
                            withAnimation(Animation.easeInOut(duration: 0.7).delay(4)){
                                self.hold.toggle()
                            }

                            withAnimation(Animation.easeInOut.delay(11)){
                                self.hold.toggle()
                            }

                            var x = 23.0
                            for _ in 1...(repeatcount-1){
                                withAnimation(Animation.easeInOut(duration: 0.7).delay(x)){
                                    self.hold.toggle()
                                    x = x + 7
                                }

                                withAnimation(Animation.easeInOut.delay(x)){
                                    self.hold.toggle()
                                    x = x + 12
                                }
                            }
                        }

                    Text("Breathe In")
                        .foregroundColor(light)
                        .scaleEffect(1)
                        .opacity(breatheIn ? 1 : 0 )
                        .onAppear(){
                            withAnimation(Animation.easeInOut(duration: 0.4)){
                                self.breatheIn.toggle()
                            }

                            withAnimation(Animation.easeInOut.delay(4)){
                                self.breatheIn.toggle()
                            }

                            var x = 19.0
                            for _ in 1...(repeatcount-1){
                                withAnimation(Animation.easeInOut(duration: 0.4).delay(x)){
                                    self.breatheIn.toggle()
                                    x = x + 4
                                }

                                withAnimation(Animation.easeInOut.delay(x)){
                                    self.breatheIn.toggle()
                                    x = x + 15
                                }
                            }
                        }
                }
                
            }
        }
    }

}

