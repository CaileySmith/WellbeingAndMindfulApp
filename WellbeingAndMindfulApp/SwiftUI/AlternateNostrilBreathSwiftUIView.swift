//
//  AlternateNostrilBreathSwiftUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 22/02/2022.
//

import SwiftUI

//Struct - Alternative nostril breath
struct AlternateNostrilBreathSwiftUIView: View {
    
    //Variables
    @State var growL = false
    @State var growR = false
    @State private var isLoading = false
    @State var g = false
    @State private var BreathOutL = false
    @State private var BreathOutR = false
    @State private var BreathInL = false
    @State private var BreathInR = false
    var colour = "green"
    var dark = Color.init(red: 109/255, green: 157/255, blue: 135/255)
    var light = Color.init(red: 216/255, green: 238/255, blue: 227/255)
    var repeatcount = 0
    
    //Animation body
    var body: some View {
        ZStack {
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 3)
                    .fill(light)
                    .frame(width: 100, height: 300)
                  
                    RoundedRectangle(cornerRadius: 3)
                        .fill(dark)
                        .frame(width: 100, height: growL ? 60 : 300)
                        .opacity(0.5)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(dark)
                        .frame(width: 100, height: growL ? 90 : 300)
                        .opacity(0.35)
     
                RoundedRectangle(cornerRadius: 3)
                    .fill(dark)
                    .frame(width: 100, height: growL ? 30 : 300)
                    .offset(x: 0, y: 0 )
                    .onAppear(){
                        withAnimation(Animation.easeInOut(duration: 6).delay(6)){
                            self.growL.toggle()
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 6).delay(12)){
                            self.growL.toggle()
                        }
                        var x = 30.0
                        for _ in 1...(repeatcount-1){
                            withAnimation(Animation.easeInOut(duration: 6).delay(x)){
                                self.growL.toggle()
                                x = x + 6
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 6).delay(x)){
                                self.growL.toggle()
                                x = x + 18
                            }
                        }
                    }
                    Text("In")
                        .foregroundColor(light)
                        .scaleEffect(1)
                        .opacity(BreathInL ? 1 : 0 )
                        .onAppear(){
                            withAnimation(Animation.easeInOut(duration: 0.6).delay(12)){
                                self.BreathInL.toggle()
                            }
                            withAnimation(Animation.easeInOut(duration: 0.6).delay(18)){
                                self.BreathInL.toggle()
                            }
                            var x = 36.0
                            for _ in 1...(repeatcount-1){
                                withAnimation(Animation.easeInOut(duration: 0.6).delay(x)){
                                    self.BreathInL.toggle()
                                    x = x + 6
                                }

                                withAnimation(Animation.easeInOut(duration: 0.6).delay(x)){
                                    self.BreathInL.toggle()
                                    x = x + 18
                                }
                            }
                        }
                    
                    Text("Out")
                        .foregroundColor(light)
                        .scaleEffect(1)
                        .opacity(BreathOutL ? 1 : 0 )
                        .onAppear(){
                            withAnimation(Animation.easeInOut(duration: 0.6).delay(6)){
                                self.BreathOutL.toggle()
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 0.6).delay(12)){
                                self.BreathOutL.toggle()
                            }
                            var x = 30.0
                            for _ in 1...(repeatcount-1){
                                withAnimation(Animation.easeInOut(duration: 0.6).delay(x)){
                                    self.BreathOutL.toggle()
                                    x = x + 6
                                }

                                withAnimation(Animation.easeInOut(duration: 0.6).delay(x)){
                                    self.BreathOutL.toggle()
                                    x = x + 18
                                }
                            }
                        }
            }
                ZStack{
                    RoundedRectangle(cornerRadius: 3)
                    .fill(light)
                    .frame(width: 100, height: 300)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(dark)
                        .frame(width: 100, height: growR ? 300 : 60)
                        .opacity(0.5)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(dark)
                        .frame(width: 100, height: growR ? 300 : 90)
                        .opacity(0.35)
     
                RoundedRectangle(cornerRadius: 3)
                    .fill(dark)
                    .frame(width: 100, height: growR ? 300 : 30)
                    .offset(x: 0, y: 0 )
                    .onAppear(){
                        withAnimation(Animation.easeInOut(duration: 6)){
                            self.growR.toggle()
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 6).delay(18)){
                            self.growR.toggle()
                        }
                        
                        var x = 24.0
                        for _ in 1...(repeatcount-1){
                            withAnimation(Animation.easeInOut(duration: 6).delay(x)){
                                self.growR.toggle()
                                x = x + 18
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 6).delay(x)){
                                self.growR.toggle()
                                x = x + 6
                            }
                        }
                    }
                    Text("In")
                        .foregroundColor(light)
                        .scaleEffect(1)
                        .opacity(BreathInR ? 1 : 0 )
                        .onAppear(){
                            withAnimation(Animation.easeInOut(duration: 0.6)){
                                self.BreathInR .toggle()
                            }
                            withAnimation(Animation.easeInOut(duration: 0.6).delay(6)){
                                self.BreathInR .toggle()
                            }
                            
                            var x = 24.0
                            for _ in 1...(repeatcount-1){
                                withAnimation(Animation.easeInOut(duration: 0.6).delay(x)){
                                    self.BreathInR.toggle()
                                    x = x + 6
                                }

                                withAnimation(Animation.easeInOut(duration: 0.6).delay(x)){
                                    self.BreathInR.toggle()
                                    x = x + 18
                                }
                            }
                        }
                    
                    Text("Out")
                        .foregroundColor(light)
                        .scaleEffect(1)
                        .opacity(BreathOutR  ? 1 : 0 )
                        .onAppear(){
                            withAnimation(Animation.easeInOut(duration: 0.6).delay(18)){
                                self.BreathOutR.toggle()
                            }
                            
                            withAnimation(Animation.easeInOut(duration: 0.6).delay(24)){
                                self.BreathOutR.toggle()
                            }
                            var x = 42.0
                            for _ in 1...(repeatcount-1){
                                withAnimation(Animation.easeInOut(duration: 0.6).delay(x)){
                                    self.BreathOutR.toggle()
                                    x = x + 6
                                }

                                withAnimation(Animation.easeInOut(duration: 0.6).delay(x)){
                                    self.BreathOutR.toggle()
                                    x = x + 18
                                }
                            }
                        }
                }
            }
        }
        .frame(width: 70, height: 300)
    }
}


