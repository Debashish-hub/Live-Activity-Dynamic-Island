//
//  TimeLiveWidgetLiveActivity.swift
//  TimeLiveWidget
//
//  Created by Debashish on 01/02/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimeLiveWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TimeLiveWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeLiveWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TimeLiveWidgetAttributes {
    fileprivate static var preview: TimeLiveWidgetAttributes {
        TimeLiveWidgetAttributes(name: "World")
    }
}

extension TimeLiveWidgetAttributes.ContentState {
    fileprivate static var smiley: TimeLiveWidgetAttributes.ContentState {
        TimeLiveWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TimeLiveWidgetAttributes.ContentState {
         TimeLiveWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TimeLiveWidgetAttributes.preview) {
   TimeLiveWidgetLiveActivity()
} contentStates: {
    TimeLiveWidgetAttributes.ContentState.smiley
    TimeLiveWidgetAttributes.ContentState.starEyes
}
