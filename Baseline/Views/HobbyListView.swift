import SwiftUI
import Foundation

struct HobbyListView: View {
    
    @EnvironmentObject var hobbyListViewModel: HobbyListViewModel
    
    //computed var that orders list of hobbies by current streak
    var orderedHobbyList: [HobbyModel] {
        return hobbyListViewModel.hobbies.sorted(by: { $0.calculateStreak() > $1.calculateStreak()})
    }
    
    func createDate() -> String {
        let today = Date.now
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .long
        return formatter1.string(from: today)
    }
    
    //TODO: Add progress bar to display how close to completing best streak
    //TODO: clear view if it is a new than the completed hobbies
    
    
    var body: some View {
        ZStack {
            if hobbyListViewModel.hobbies.isEmpty {
                NoHobbiesView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                VStack{
                    Text(createDate())
                        .font(.title)
                    List {
                        ForEach(orderedHobbyList.indices, id: \.self) { index in
                            NavigationLink(destination: HobbyDetailView(hobby: orderedHobbyList[index])) {
                                HobbyListRowView(hobby: orderedHobbyList[index])
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            var hobby = orderedHobbyList[index]
                                            hobbyListViewModel.updateHobby(hobby: &hobby)
                                        }
                                    }
                            }
                        }
                        //                    .onDelete(perform: hobbyListViewModel.deleteHobby)
//                        .onMove(perform: hobbyListViewModel.moveHobby)
                        .listStyle(PlainListStyle())
                    }
                    
                }
            }
        }
        .navigationBarItems(
//            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddHobbyView())
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HobbyListView()
        }
        .environmentObject(HobbyListViewModel())
    }
}
