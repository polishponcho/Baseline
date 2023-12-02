import SwiftUI

struct HobbyCalendarViewRepresentable: UIViewRepresentable {
    @Binding var completedDates: [Date]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.delegate = context.coordinator
        
        return calendarView
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        print("updating UI View")
    }
    
    class Coordinator : NSObject, UICalendarViewDelegate {
        var parent: HobbyCalendarViewRepresentable
        
        init(_ uiCalendarView: HobbyCalendarViewRepresentable) {
            parent = uiCalendarView
        }
        
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            guard let date = dateComponents.date else {
                return nil
            }
            
            // Check if the date is in the completedDates array
            if parent.completedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                return UICalendarView.Decoration.default(color: .systemGreen, size: .large)
            }
            
            return nil
        }
    }
}
