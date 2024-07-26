import SwiftUI

struct FoodLogView: View {
    @EnvironmentObject var foodLogStore: FoodLogStore

    var body: some View {
        NavigationView {
            List {
                ForEach(foodLogStore.foodLogs) { log in
                    VStack(alignment: .leading) {
                        Text(log.name).font(.headline)
                        Text(log.brand)
                        Text("\(log.calories) calories")
                        Text("\(log.date, formatter: DateFormatter.shortDateFormatter)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Food Log")
            .toolbar {
                EditButton()
            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        foodLogStore.foodLogs.remove(atOffsets: offsets)
        foodLogStore.saveToFile()
    }
}

extension DateFormatter {
    static var shortDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

struct FoodLogView_Previews: PreviewProvider {
    static var previews: some View {
        FoodLogView().environmentObject(FoodLogStore())
    }
}
