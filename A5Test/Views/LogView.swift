//
//  LogView.swift
//  A5Test
//
//  Created by Grace Flikke24 on 2/13/24.
//

import SwiftUI

struct LogView: View {
    @EnvironmentObject private var vm: TextAnalysisLogic
    
    @State private var showCheck1 = false
    @State private var showCheck2 = false
    @State private var nextOffset = 200
    @State private var color = Color(.lightGray)
    @State private var currentTime = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("forestBackground")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Text("Log an Emotion or Mood")
                        .padding()
                        .padding(.top)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .offset(x: 0, y: -170)
                    VStack {
                        emotionButton
                        moodButton
                        
                        nextButton
                            .offset(x: 0, y: CGFloat(nextOffset))
                            .animation(.easeInOut(duration: 0.65), value: nextOffset)
                    }
                    .offset(x: 0, y: -50)
                }
            }
        }
    }
}

#Preview {
    LogView()
        .environmentObject(TextAnalysisLogic())
}

extension LogView {
    private var emotionButton: some View {
        Button {
            showCheck1.toggle()
            showCheck2 = false
            nextOffset = 0
            color = Color(red: 0.91, green: 0.686, blue: 0.118)
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "clock")
                            .tint(.gray)
                        Text("Emotion")
                            .tint(.gray)
                    }
                    Text("How you feel right now")
                        .tint(.white)
                    Text(currentTime, style: .time)
                        .tint(.gray)
                }
                .padding()
                
                if showCheck1 {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .offset(x: 65)
                        .foregroundStyle(Color(red: 0.91, green: 0.686, blue: 0.118))
                }
            }
        }
        .frame(width: 350, height: 100, alignment: .leading)
        .background(.regularMaterial)
        .environment(\.colorScheme, .dark)
        .cornerRadius(10)
        .padding(.bottom)
    }
    
    private var moodButton: some View {
        Button {
            showCheck2.toggle()
            showCheck1 = false
            nextOffset = 0
            color = Color(red: 0.91, green: 0.686, blue: 0.118)
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "sun.haze")
                        Text("Mood")
                    }
                    .foregroundStyle(.gray)
                    Text("How you've felt overall today")
                        .foregroundStyle(.white)
                }
                .padding()
                
                if showCheck2 {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .offset(x: 26)
                        .foregroundStyle(Color(red: 0.91, green: 0.686, blue: 0.118))
                }
            }
        }
        .frame(width: 350, height: 100, alignment: .leading)
        .background(.regularMaterial)
        .environment(\.colorScheme, .dark)
        .cornerRadius(10)
        .padding(.bottom)
    }
    
    private var nextButton: some View {
        NavigationLink(destination: EnterTextView()) {
            Text("Next")
                .frame(width: 275)
                .font(.headline)
        }
        .buttonStyle(.bordered)
        .background(color)
        .cornerRadius(50)
        .foregroundColor(.black)
    }
}
