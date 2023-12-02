import Foundation

struct HobbyModel: Identifiable, Codable {
    //TODO: Add time spent engaging in hobby
    let id: String
    let name: String
    var createDate: Date
    var isCompleted: Bool
    var completedDates: [Date]
    
    init(id: String = UUID().uuidString, name: String, createDate: Date, isCompleted: Bool, completedDates: [Date]) {
        self.id = id
        self.name = name
        self.createDate = createDate
        self.isCompleted = isCompleted
        self.completedDates = completedDates
    }
    
    //TODO: Needs to remove date if date has already been completed
    mutating func updateCompletion() -> HobbyModel {
        let hobbyCompletion = !isCompleted
        let dates = getDate(hobbyCompletion: hobbyCompletion)
        
        self.isCompleted = hobbyCompletion
        self.completedDates = dates
        
        return HobbyModel(id: id, name: name, createDate: createDate, isCompleted: hobbyCompletion, completedDates: dates)
    }

    func getDate(hobbyCompletion: Bool) -> [Date] {
        var newCompletedDates: [Date] = []

        let formatter = DateFormatter()
        formatter.dateStyle = .full

        if hobbyCompletion {
            // Check if the Date.now is already in the completedDates array
            if !completedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: Date.now) }) {
                newCompletedDates = completedDates + [Date.now]
            } else {
                newCompletedDates = completedDates
            }
        } else {
            newCompletedDates = completedDates.filter { !Calendar.current.isDate($0, inSameDayAs: Date.now) }
        }

        return newCompletedDates
    }
    
    func calculateStreak() -> Int {
        var streak = 0
        var currentDate = Date.now
        for date in completedDates.reversed() {
            if Calendar.current.isDateInToday(date) {
                streak += 1
                continue
            }
            currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            if !Calendar.current.isDate(currentDate, inSameDayAs: date) {
                break
            }
            streak += 1
        }
        
        return streak
    }

}
