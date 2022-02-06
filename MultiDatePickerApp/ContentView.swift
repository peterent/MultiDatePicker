//
//  ContentView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI
import MultiDatePicker

/**
 * This ContentView shows how to use MultiDatePicker as an in-line View. You could also use it as an overlay
 * or in a sheet.
 */
struct ContentView: View {
    
    // The MultiDatePicker can be used to select a single day, multiple days, or a date range. These
    // vars are used as bindings passed to the MultiDatePicker.
    @State private var selectedDate = Date()
    @State private var anyDays = [Date]()
    @State private var dateRange: ClosedRange<Date>? = nil
    
    // Another thing you can do with the MultiDatePicker is limit the range of dates that can
    // be selected.
    let testMinDate = Calendar.current.date(from: DateComponents(year: 2021, month: 4, day: 1))
    let testMaxDate = Calendar.current.date(from: DateComponents(year: 2021, month: 5, day: 30))
    
    // Used to toggle an overlay containing a MultiDatePicker.
    @State private var showOverlay = false
    
    var selectedDateAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
        
    var body: some View {
        TabView {
            
            // Here's how to select a single date, but limiting the range of dates than be picked.
            // The binding (selectedDate) will be whatever date is currently picked.
            VStack {
                Text("Single Day").font(.title).padding()
                MultiDatePicker(
                    singleDay: self.$selectedDate,
                    minDate: testMinDate,
                    maxDate: testMaxDate)
                Text(selectedDateAsString).padding()
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("Single")
            }
            
            // Here's how to select multiple, non-contiguous dates. Tapping on a date will
            // toggle its selection. The binding (anyDays) will be an array of zero or
            // more dates, sorted in ascending order. In this example, the selectable dates
            // are limited to weekdays.
            VStack {
                Text("Any Dates").font(.title).padding()
                MultiDatePicker(anyDays: self.$anyDays, includeDays: .weekdaysOnly)
                Text("Selected \(anyDays.count) Days").padding()
            }
            .tabItem {
                Image(systemName: "n.circle")
                Text("Any")
            }
            
            // Here's how to select a date range. Initially the range is nil. Tapping on
            // a date makes it the first date in the range, but the binding (dateRange) is
            // still nil. Tapping on another date completes the range and sets the binding.
            VStack {
                Text("Date Range").font(.title).padding()
                MultiDatePicker(dateRange: self.$dateRange)
                if let range = dateRange {
                    Text("\(range)").padding()
                } else {
                    Text("Select two dates").padding()
                }
            }
            .tabItem {
                Image(systemName: "ellipsis.circle")
                Text("Range")
            }
            
            // Here's how to put the MultiDatePicker into a pop-over/dialog using
            // the .overlay modifier (see below).
            VStack {
                Text("Pop-Over").font(.title).padding()
                Button("Selected \(anyDays.count) Days") {
                    withAnimation {
                        self.showOverlay.toggle()
                    }
                }.padding()
            }
            .tabItem {
                Image(systemName: "square.stack.3d.up")
                Text("Overlay")
            }
        }
        .onChange(of: self.selectedDate, perform: { date in
            print("Single date selected: \(date)")
        })
        .onChange(of: self.anyDays, perform: { days in
            print("Any days selected: \(days)")
        })
        .onChange(of: self.dateRange, perform: { dateRange in
            print("Range selected: \(String(describing: dateRange))")
        })
        
        // if you want to show the MultiDatePicker as an overlay somewhat similar to the Apple
        // DatePicker, you can blur the background a bit and float the MultiDatePicker above a
        // translucent background. Tapping outside of the MultiDatePicker removes it. Ideally
        // you'd make this a custom modifier if you were doing this throughout your app.
        .blur(radius: showOverlay ? 6 : 0)
        .overlay(
            ZStack {
                if self.showOverlay {
                    Color.black.opacity(0.25)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                self.showOverlay.toggle()
                            }
                        }
                    MultiDatePicker(anyDays: self.$anyDays)
                } else {
                    EmptyView()
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
