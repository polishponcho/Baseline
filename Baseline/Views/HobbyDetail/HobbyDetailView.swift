import SwiftUI

struct HobbyDetailView : View {
    
    let hobby: HobbyModel
    var numberOfCompletedDays: Int {
        hobby.completedDates.count
    }
    var streak: Int {
        let currentStreak = hobby.calculateStreak()
        return currentStreak
    }
    
    var longestStreak: Int {
        print("calculating longest streak...")
        let longestStreak = hobby.calculateLongestStreak()
        return longestStreak
    }
    //calculate percentage of days completed since createDate
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(hobby.name)
                    .font(.largeTitle)
                    .bold()
                CalendarView(completedDates: hobby.completedDates)
                HobbyStatsView(numberOfCompletedDays: numberOfCompletedDays, streak: streak, longestStreak: longestStreak)
            }
        }
    }
}

struct HobbyStatsView : View {
    
    var numberOfCompletedDays: Int
    var streak: Int
    var longestStreak: Int
    
    var body: some View {

            VStack {
                HStack {
                    Text("Total days: \(numberOfCompletedDays)")
                        .padding()
                    Spacer()
                    Image(systemName: "flame")
                        .foregroundColor(.red)
                    Text("\(streak)")
                        .padding()
                }
                HStack {
                    Text("Longest Streak: \(longestStreak)")
                }
            }
    }
}

struct HobbyDetailView_Previews: PreviewProvider {
    static var hobby1 = HobbyModel(name: "Yoga", createDate: Date.now, isCompleted: false, completedDates: [Date.now])
    
    static var previews: some View {
        HobbyDetailView(hobby: hobby1)
    }
}
