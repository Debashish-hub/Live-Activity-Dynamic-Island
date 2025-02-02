//
//  ViewController.swift
//  TimeLiveActivity
//
//  Created by Debashish on 01/02/25.
//

import UIKit
import ActivityKit
struct TimeAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var timeText: String
    }
    var title: String
}
class ViewController: UIViewController {
    var currentActivity: Activity<TimeAttributes>?
    var timer: Timer?
    var elapsedSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startAction(_ sender: Any) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities are not enabled.")
            return
        }

        let attributes = TimeAttributes(title: "Live Timer")
        let initialState = TimeAttributes.ContentState(timeText: "00:00")

        do {
            currentActivity = try Activity.request(
                attributes: attributes,
                contentState: initialState,
                pushType: nil
            )
            print("Live Activity Started")
            startTimer() // To track the time
            showAlert(description: "Live Activity has started") // To show some Alert
        } catch {
            print("Error starting activity: \(error.localizedDescription)")
        }
    }
    func showAlert(description: String) {
        let alert = UIAlertController(title: "Alert", message: description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func startTimer() {
        timer?.invalidate() // Ensure no duplicate timers
        elapsedSeconds = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, let activity = self.currentActivity else { return }

            self.elapsedSeconds += 1
            let minutes = self.elapsedSeconds / 60
            let seconds = self.elapsedSeconds % 60
            let formattedTime = String(format: "%02d:%02d", minutes, seconds)
            Task {
                await activity.update(using: TimeAttributes.ContentState(timeText: formattedTime))
            }
        }
    }
    
    @IBAction func endAction(_ sender: Any) {
        Task {
            await currentActivity?.end()
            timer?.invalidate()
            print("Live Activity Ended")
            showAlert(description: "Live Activity Ended")
        }
    }
    
}

