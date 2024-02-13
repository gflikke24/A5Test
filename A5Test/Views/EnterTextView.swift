//
//  EnterTextView.swift
//  A5Test
//
//  Created by Grace Flikke24 on 2/13/24.
//

import SwiftUI

struct EnterTextView: View {
    @State private var response: String = ""
    
    var body: some View {
        Text("Describe your feeling or mood")
        
        VStack {
            TextField("enter text here", text: $response)
            Button {
                
            } label: {
                Text("continue")
            }
        }
        
        VStack {
            Text("It sounds like you are feeling...")
        }
    }
}

#Preview {
    EnterTextView()
}
