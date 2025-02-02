//
//  TimeLiveWidgetBundle.swift
//  TimeLiveWidget
//
//  Created by Debashish on 01/02/25.
//

import WidgetKit
import SwiftUI

@main
struct TimeLiveWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimeLiveWidget()
        TimeLiveWidgetControl()
        TimeLiveWidgetLiveActivity()
    }
}
