import SwiftUI

@main
struct BaselineApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var listViewModel: HobbyListViewModel = HobbyListViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HobbyListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
//            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(listViewModel)
        }
    }
}
