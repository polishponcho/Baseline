
import SwiftUI

struct CalendarView: View {
    @State var completedDates: [Date] = []
    
    var body: some View {
        HobbyCalendarViewRepresentable(completedDates: $completedDates)
    }
}
