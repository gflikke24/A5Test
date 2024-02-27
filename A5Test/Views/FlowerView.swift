//
//  FlowerView.swift
//  A5Test
//
//  Created by Grace Flikke24 on 2/21/24.
//

import SwiftUI

struct FlowerView: View {
    var body: some View {
        MainFlower()
    }
}

#Preview {
    FlowerView()
}

struct MainFlower: View {
    
    @State private var rPetal = false
    @State private var lPetal = false
    @State private var mrPetal = false
    @State private var mlPetal = false
    @State private var customShadow = false
        
    var body: some View {
        ZStack {
            ZStack {
                
                Image(systemName: "diamond")
                    .resizable()
                    .frame(width: 75, height: 175, alignment: .center)
                    .rotationEffect(.degrees(0), anchor: .bottom)
 
                Image(systemName: "diamond")
                    .resizable()
                    .frame(width: 75, height: 175, alignment: .center)
                    .foregroundColor(.white)
                
                Image(systemName: "diamond")
                    .resizable()
                    .frame(width: 75, height: 175, alignment: .center)
                    .rotationEffect(.degrees(mlPetal ? -25: -5), anchor: .bottom)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                    .onAppear {
                        mlPetal.toggle()
                    }
                    .foregroundColor(.white)
                
                Image(systemName: "diamond")
                    .resizable()
                    .frame(width: 75, height: 175, alignment: .center)
                    .foregroundColor(.white)
                
                Image(systemName: "diamond")
                    .resizable()
                    .frame(width: 75, height: 175, alignment: .center)
                    .rotationEffect(.degrees(mrPetal ? 25: 5), anchor: .bottom)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                    .onAppear {
                        mrPetal.toggle()
                    }
                    .foregroundColor(.white)
                
                Image(systemName: "diamond")
                    .resizable()
                    .frame(width: 75, height: 175, alignment: .center)
                    .rotationEffect(.degrees(lPetal ? -50: -10), anchor: .bottom)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                    .onAppear {
                        lPetal.toggle()
                    }
                    .foregroundColor(.white)
                
                Image(systemName: "diamond")
                    .resizable()
                    .frame(width: 75, height: 175, alignment: .center)
                    .rotationEffect(.degrees(rPetal ? 50: 10), anchor: .bottom)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                    .onAppear {
                        rPetal.toggle()
                    }
                    .foregroundColor(.white)
            }
            .shadow(color: Color(red: 0.91, green: 0.686, blue: 0.118), radius: customShadow ? 20 : 0)
            .hueRotation(Angle(degrees: customShadow ? 0 : 165))
            .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
            .onAppear() {
                customShadow.toggle()
            }
        }
        .frame(width: 300, height: 300, alignment: .center)
    }
}
