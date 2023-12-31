import SwiftUI
import Foundation

struct HobbyListView: View {
    
    @EnvironmentObject var hobbyListViewModel: HobbyListViewModel
    
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
                        ForEach(hobbyListViewModel.hobbies.indices, id: \.self) { index in
                            NavigationLink(destination: HobbyDetailView(hobby: hobbyListViewModel.hobbies[index])) {
                                HobbyListRowView(hobby: hobbyListViewModel.hobbies[index])
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            var hobby = hobbyListViewModel.hobbies[index]
                                            hobbyListViewModel.updateHobby(hobby: &hobby)
                                        }
                                    }
                            }
                        }
                        //                    .onDelete(perform: hobbyListViewModel.deleteHobby)
                        .onMove(perform: hobbyListViewModel.moveHobby)
                        .listStyle(PlainListStyle())
                    }
                    
                }
            }
        }
        .navigationBarItems(
            leading: EditButton(),
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
