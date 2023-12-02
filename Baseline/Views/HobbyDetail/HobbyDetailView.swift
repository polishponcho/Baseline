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
    //calculate percentage of days completed since createDate
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(hobby.name)
                    .font(.largeTitle)
                    .bold()
                CalendarView(completedDates: hobby.completedDates)
                HobbyStatsView(numberOfCompletedDays: numberOfCompletedDays, streak: streak)
            }
        }
    }
}

struct HobbyStatsView : View {
    
    var numberOfCompletedDays: Int
    var streak: Int
    
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
            }
    }
}

struct HobbyDetailView_Previews: PreviewProvider {
    static var hobby1 = HobbyModel(name: "Yoga", createDate: Date.now, isCompleted: false, completedDates: [Date.now])
    
    static var previews: some View {
        HobbyDetailView(hobby: hobby1)
    }
}
