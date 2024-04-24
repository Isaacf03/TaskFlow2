import SwiftUI

struct CalendarView: View {
    @State private var selectedDate: Int?
    
    var body: some View {
        ScrollView(.horizontal){
            HStack {
                Text("Selected Date: \(selectedDate != nil ? "\(selectedDate!)" : "None")")
                
                // Display the calendar
                HStack {
                    ForEach(monthsInYear(), id: \.self) { month in
                        MonthView(month: month, selectedDate: $selectedDate)
                    }
                }
            }
            .padding()
        }
    }
    
    // Function to get an array of Date objects for each month in the current year
    private func monthsInYear() -> [Date] {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        var months: [Date] = []
        
        for month in 1...12 {
            var components = DateComponents()
            components.year = currentYear
            components.month = month
            let date = calendar.date(from: components)!
            months.append(date)
        }
        
        return months
    }
}

struct MonthView: View {
    var month: Date
    @Binding var selectedDate: Int?
    
    var body: some View {
        VStack {
            Text(month, formatter: monthFormatter)
                .font(.headline)
                .padding(.top)
            
            // Display days of the week
            HStack(spacing: 10) {
                ForEach(1..<8, id: \.self) { day in
                    Text(dayOfWeekSymbol(day))
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            
            // Display days of the month
            HStack(spacing: 10) {
                ForEach(daysInMonth(), id: \.self) { day in
                    Text("\(day)")
                        .font(.subheadline)
                        .foregroundColor(day == selectedDate ? .blue : .primary)
                        .onTapGesture {
                            selectedDate = day
                        }
                }
            }

        }
        .padding()
        .border(Color.gray)

    }
    
    // Function to get an array of integers representing days in the month
    private func daysInMonth() -> [Int] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: month)!
        return Array(range)
    }
    
    // Date formatter to display month
    private let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    // Function to get the symbol of the day of the week
    private func dayOfWeekSymbol(_ day: Int) -> String {
        let calendar = Calendar.current
        let symbolIndex = (day - 1 + calendar.firstWeekday - 1) % 7
        return calendar.shortWeekdaySymbols[symbolIndex]
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

