//
//  MonthView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI

struct MDPMonthView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    let cellSize: CGFloat = 30
    
    @State private var showMonthYearPicker = false
    @State private var testDate = Date()
    
    func showPrevMonth() {
        withAnimation {
            monthDataModel.decrMonth()
            showMonthYearPicker = false
        }
    }
    
    func showNextMonth() {
        withAnimation {
            monthDataModel.incrMonth()
            showMonthYearPicker = false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                MonthYearPickerButton(isPresented: self.$showMonthYearPicker)
                Spacer()
                Button( action: {showPrevMonth()} ) {
                    Image(systemName: "chevron.left").font(.title2)
                }.padding()
                Button( action: {showNextMonth()} ) {
                    Image(systemName: "chevron.right").font(.title2)
                }.padding()
            }
            .padding(.leading, 18)
            
            GeometryReader { reader in
                if showMonthYearPicker {
                    MonthYearPicker(date: monthDataModel.controlDate) { (month, year) in
                        self.monthDataModel.show(month: month, year: year)
                    }
                }
                else {
                    MonthContentView()
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.accentColor, lineWidth: 1)
        )
        .padding()
        .frame(width: 300, height: 300)
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MDPMonthView()
            .environmentObject(MDPModel())
    }
}
