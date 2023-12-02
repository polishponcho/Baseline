import Foundation

class HobbyListViewModel: ObservableObject {
    
    @Published var hobbies: [HobbyModel] = [] {
        didSet {
            saveHobbies()
        }
    }
    let hobbysKey: String = "hobbys_list"
    init() {
        getHobbies()
        checkCompletion()
    }
    
    func getHobbies() {
        guard
            let data = UserDefaults.standard.data(forKey: hobbysKey),
            let savedHobbies = try? JSONDecoder().decode([HobbyModel].self, from: data)
        else { return }
        
        self.hobbies = savedHobbies
    }
    
    func deleteHobby(indexSet: IndexSet) {
        hobbies.remove(atOffsets: indexSet)
    }
    
    func moveHobby(from: IndexSet, to: Int) {
        hobbies.move(fromOffsets: from, toOffset: to)
    }
    
    func addHobby(name: String) {
        let newHobby = HobbyModel(name: name, createDate: Date.now, isCompleted: false, completedDates: [])
        hobbies.append(newHobby)
    }
    
    func updateHobby(hobby: inout HobbyModel) {
        if let index = hobbies.firstIndex(where: {$0.id == hobby.id }) {
            hobby = hobby.updateCompletion()
            hobbies[index] = hobby
        }
    }
    
    func saveHobbies() {
        if let encodedData = try? JSONEncoder().encode(hobbies) {
            UserDefaults.standard.set(encodedData, forKey: hobbysKey)
        }
    }

    func checkCompletion() {
        for index in 0..<hobbies.count {
            if hobbies[index].isCompleted && !hobbies[index].completedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: Date.now) }) {
                hobbies[index].isCompleted = false
            }
        }
    }
}
