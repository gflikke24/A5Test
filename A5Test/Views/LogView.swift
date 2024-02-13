//
//  LogView.swift
//  A5Test
//
//  Created by Grace Flikke24 on 2/13/24.
//

import SwiftUI

struct LogView: View {
    var body: some View {
        Text("Log an Emotion or Mood")
            .font(.headline)
        VStack {
            Button {
            } label: {
                Text("emotion")
            }
            Button {
            } label: {
                Text("mood")
            }
        }
    }
}

#Preview {
    LogView()
}
