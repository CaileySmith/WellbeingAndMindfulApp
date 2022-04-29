//
//  HomeSwiftUIView.swift
//  WellbeingAndMindfulApp
//
//  Created by Cailey Smith on 29/04/2022.
//

import SwiftUI

struct HomeSwiftUIView: View {
    @State var currentDate: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20) {
                //custom date picker...
                CustomDatePickerSwiftUIView(currentDate: $currentDate)
                
            }
            .padding(.vertical)
            .frame(width: 414, height: 896)
        }
    }
}
//
//struct HomeSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeSwiftUIView()
//    }
//}
