//
//  EnterTextView.swift
//  A5Test
//
//  Created by Grace Flikke24 on 2/13/24.
//

import SwiftUI

struct EnterTextView: View {
    @EnvironmentObject private var vm: TextAnalysisLogic
    
    @State public var textInput: String  = ""
    @State private var textHeight: CGFloat = 75
    @State private var expandTextBox = false
  
    var body: some View {
        ZStack {
            Image("forestBackground")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 3.5)
            
            VStack {
                FlowerView()
                    .offset(x: 0, y: -80)
                    .padding()
                    
                if vm.showTextView {
                    textBox
                        .offset(x: 0, y: -40)
                        .padding()
                }
                
                VStack {
                    if vm.showAnalysisView {
                        AnalysisView()
                            .transition(.move(edge: .trailing))
                    }
                }
            }
        }
    }
}


#Preview {
    EnterTextView()
        .environmentObject(TextAnalysisLogic())
}

extension EnterTextView {
    private var textBox: some View {
        VStack {
            Text("Describe your feeling or mood")
                .foregroundStyle(.white)
                .font(.title)
                .offset(x: 0, y: -75)
                .padding(.top)
            
            TextField("enter text here", text: $textInput, axis: .vertical)
                .padding()
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        vm.saveTextInput(text: textInput)
                        vm.analyzePhrase()
                        vm.showTextView.toggle()
                        vm.showAnalysisView.toggle()
                    } label: {
                        Text("continue")
                    }
                    .offset(x: 0, y: textInput.isEmpty ? 25 : 85)
                    .padding()
                }
                .frame(maxHeight: textInput.isEmpty ? 75: 150, alignment: .topLeading)
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding(.bottom)
        }
    }
}

