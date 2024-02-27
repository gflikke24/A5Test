//
//  AnalysisView.swift
//  A5Test
//
//  Created by Grace Flikke24 on 2/14/24.
//

import SwiftUI

struct AnalysisView: View {
    @EnvironmentObject private var vm: TextAnalysisLogic
    
    @State private var startAnimation: Bool = false
    
    var body: some View {
        analysisText
            .foregroundColor(.white)
            .padding()
            .frame(width: 340, height: 250)
            .background(.regularMaterial)
            .environment(\.colorScheme, .dark)
            .cornerRadius(10)
    }
}

#Preview {
    AnalysisView()
        .environmentObject(TextAnalysisLogic())
}

extension AnalysisView {
    private var analysisText: some View {
        VStack {
            Text("It sounds like you are feeling: ")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom)
                .onAppear { startAnimation = true }
                .opacity(startAnimation ? 1 : 0)
                .animation(.easeIn(duration: 1), value: startAnimation)
           
            Text(vm.sentiment)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.bottom)
                .onAppear { startAnimation = true }
                .opacity(startAnimation ? 1 : 0)
                .animation(.easeIn(duration: 2).delay(2), value: startAnimation)
            
            Text(vm.quote)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .onAppear { startAnimation = true }
                .opacity(startAnimation ? 1 : 0)
                .animation(.easeIn(duration: 1).delay(5), value: startAnimation)
        }
    }
}
