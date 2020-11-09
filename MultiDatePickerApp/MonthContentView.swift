//
//  MonthContentView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

struct MDPContentView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    let cellSize: CGFloat = 30
    
    let columns = [
        GridItem(.fixed(30), spacing: 2),
        GridItem(.fixed(30), spacing: 2),
        GridItem(.fixed(30), spacing: 2),
        GridItem(.fixed(30), spacing: 2),
        GridItem(.fixed(30), spacing: 2),
        GridItem(.fixed(30), spacing: 2),
        GridItem(.fixed(30), spacing: 2)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(0..<monthDataModel.dayNames.count, id: \.self) { index in
                Text(monthDataModel.dayNames[index].uppercased())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            ForEach(0..<monthDataModel.days.count, id: \.self) { index in
                if monthDataModel.days[index].day == 0 {
                    Text("")
                        .frame(minHeight: cellSize, maxHeight: cellSize)
                } else {
                    //DayOfMonthView(index: index)
                    DayOfMonthView(dayOfMonth: monthDataModel.days[index])
                }
            }
        }.padding(.bottom, 10)
    }
}

struct MonthContentView_Previews: PreviewProvider {
    static var previews: some View {
        MDPContentView()
    }
}
