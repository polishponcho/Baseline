import SwiftUI

struct AddHobbyView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var hobbyListViewModel: HobbyListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var todaysDate = Date()
    
    var body: some View {
        VStack {
            TextField("Enter Hobby", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            
            Button(action: saveButtonPressed, label: {
                Text("Save Hobby".uppercased())
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            })
        }
        .padding(14)
        .navigationBarTitle("Add Hobby", displayMode: .inline)
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            hobbyListViewModel.addHobby(name: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 1 {
            alertTitle = "Your hobby name must be at least three characters"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddHobbyView()
        }
        .environmentObject(HobbyListViewModel())
    }
}
