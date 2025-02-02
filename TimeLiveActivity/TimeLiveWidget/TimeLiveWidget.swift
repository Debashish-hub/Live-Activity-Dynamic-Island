//
//  TimeLiveWidget.swift
//  TimeLiveWidget
//
//  Created by Debashish on 01/02/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct TimeLiveWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct TimeLiveWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeAttributes.self) { context in
            VStack {
                Text("Elapsed Time:")
                Text(context.state.timeText)
                    .font(.title)
                    .bold()
            }
            .padding()
            .activityBackgroundTint(.cyan)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("⏳ Timer")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.timeText)
                        .font(.title2)
                        .bold()
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Live Timer Running")
                        .font(.caption)
                }
            } compactLeading: {
                Text("⏳")
            } compactTrailing: {
                Text(context.state.timeText)
            } minimal: {
                Text("⏳")
            }
        }
    }
}

#Preview(as: .systemSmall) {
    TimeLiveWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
