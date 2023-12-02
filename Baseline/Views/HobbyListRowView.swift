import SwiftUI

struct HobbyListRowView: View {
    
    let hobby: HobbyModel
    var streak: String {
        let currentStreak = hobby.calculateStreak()
        return currentStreak > 0 ? "\(currentStreak)" : ""
    }

    var body: some View {
        HStack {
            Image(systemName: hobby.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(hobby.isCompleted ? .green : .red)
            Text(hobby.name)
                .padding()
            Image(systemName: !streak.isEmpty ?  "flame" : "")
                .foregroundColor(.red)
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var item1 = HobbyModel(name: "Yoga", createDate: Date.now, isCompleted: false, completedDates: [])
    static var item2 = HobbyModel(name: "Guitar", createDate: Date.now, isCompleted: true, completedDates: [Date.now])
    
    static var previews: some View {
        Group {
            HobbyListRowView(hobby: item1)
            HobbyListRowView(hobby: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
