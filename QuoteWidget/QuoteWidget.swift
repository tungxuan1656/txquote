//
//  QuoteWidget.swift
//  QuoteWidget
//
//  Created by Tùng Đoàn on 21/10/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
  
  let placeholderEntry = QuoteEntry(date: Date(), text: "Tâm lý", link: "txquote://")
  
  func placeholder(in context: Context) -> QuoteEntry {
    return placeholderEntry
  }
  
  func getSnapshot(in context: Context, completion: @escaping (QuoteEntry) -> ()) {
    completion(placeholderEntry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [QuoteEntry] = []
    let listQuotes = loadQuoteJson()
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for i in 0...10 {
      let quote = listQuotes.randomElement()
      let date = Calendar.current.date(byAdding: .minute, value: i * 10, to: currentDate)!
      let entry = QuoteEntry(date: date, text: quote?.text ?? "#", link: quote?.link ?? "txquote://")
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct QuoteEntry: TimelineEntry {
  let date: Date
  let text: String
  let link: String
}

struct QuoteWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    Link(destination: URL(string: entry.link)!) {
      VStack {
        Text("Jess Tản Mạn").font(.headline).padding(.bottom, 16).foregroundColor(.white)
        Text(entry.text).font(.caption).lineSpacing(5).foregroundColor(.white)
      }
    }
  }
}

struct QuoteWidget: Widget {
  let kind: String = "QuoteWidget"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      if #available(iOS 17.0, *) {
        QuoteWidgetEntryView(entry: entry)
          .containerBackground(Color(red: 32/255, green: 33/255, blue: 36/255), for: .widget)
      } else {
        QuoteWidgetEntryView(entry: entry)
          .padding()
          .background().foregroundColor(Color(red: 32/255, green: 33/255, blue: 36/255))
      }
    }
    .configurationDisplayName("Trading")
    .description("Các chia sẻ được lấy từ Jess Tản Mạn của Thầy Zet Under. Tất cả điều hoàn toàn free")
  }
}
