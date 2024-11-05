//
//  QuoteData.swift
//  QuoteWidgetExtension
//
//  Created by Tùng Đoàn on 21/10/2024.
//

import Foundation


struct Quote: Decodable {
    var index: Int
    var link: String
    var text: String
}

func loadQuoteJson() -> [Quote] {
    if let url = Bundle.main.url(forResource: "zetquote", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([Quote].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return []
}
