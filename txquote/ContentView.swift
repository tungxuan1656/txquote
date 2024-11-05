//
//  ContentView.swift
//  txquote
//
//  Created by Tùng Đoàn on 05/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String = "Jess Tản Mạn"
    var listQuotes = loadQuoteJson()
    
    var body: some View {
        ScrollView {
            Text(message).font(.footnote).lineSpacing(5)
        }
        .padding()
        .onOpenURL { incomingURL in
            print("App was opened via URL: \(incomingURL)")
            
            if (incomingURL.absoluteString.starts(with: "txquote://quote?source=trade&index=")) {
                let index = String(incomingURL.absoluteString.replacingOccurrences(of: "txquote://quote?source=trade&index=", with: ""))
                
                self.message = listQuotes[(Int(index) ?? 1) - 1].text
                print("get index", String(index))
            }
        }
    }
}

#Preview {
    ContentView()
}
