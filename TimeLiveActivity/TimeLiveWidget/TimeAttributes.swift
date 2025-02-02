//
//  TimeAttributes.swift
//  TimeLiveWidgetExtension
//
//  Created by Debashish on 01/02/25.
//

import ActivityKit

struct TimeAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var timeText: String
    }
    var title: String
}

