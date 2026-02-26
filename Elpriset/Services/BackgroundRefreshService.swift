import BackgroundTasks
import WidgetKit
import ElprisetShared

enum BackgroundRefreshService {
    static let taskIdentifier = ElectricityConstants.backgroundTaskIdentifier

    static func registerTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskIdentifier, using: nil) { task in
            handleRefresh(task: task as! BGAppRefreshTask)
        }
    }

    static func scheduleRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: taskIdentifier)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
        try? BGTaskScheduler.shared.submit(request)
    }

    private static func handleRefresh(task: BGAppRefreshTask) {
        scheduleRefresh()

        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }

        WidgetCenter.shared.reloadAllTimelines()
        task.setTaskCompleted(success: true)
    }
}
