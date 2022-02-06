import XCTest
@testable import MultiDatePicker

final class MultiDatePickerTests: XCTestCase {
	func testMonthDataModel() throws {
		let model = MDPModel()
		let dateComponents = DateComponents(year: 2020, month: 11, day: 1)
		model.controlDate = Calendar.current.date(from: dateComponents)!
		XCTAssertTrue(model.numDays == 30)
	}
	
	func testSingleDaySelection() throws {
		let dateComponents = DateComponents(year: 2020, month: 11, day: 1)
		let singleDay = Calendar.current.date(from: dateComponents)
		XCTAssertNotNil(singleDay)
		
		let model = MDPModel(singleDay: .constant(singleDay!), includeDays: .allDays, minDate: nil, maxDate: nil)
		model.controlDate = singleDay!
		
		let dom = MDPDayOfMonth(index: 0, day: 1, date: singleDay, isSelectable: true, isToday: false)
		model.selectDay(dom)
		let isSelected = model.isSelected(dom)
		XCTAssertTrue(isSelected)
	}
	
	func testSelectionInRange() throws {
		let dateComponents = DateComponents(year: 2020, month: 10, day: 15)
		let singleDay = Calendar.current.date(from: dateComponents)
		XCTAssertNotNil(singleDay)
		
		let minDate = Calendar.current.date(from: DateComponents(year: 2020, month: 10, day: 1))
		XCTAssertNotNil(minDate)
		
		let maxDate = Calendar.current.date(from: DateComponents(year: 2020, month: 10, day: 30))
		XCTAssertNotNil(maxDate)
		
		let model = MDPModel(singleDay: .constant(singleDay!), includeDays: .allDays, minDate: minDate!, maxDate: maxDate!)
		model.controlDate = singleDay!
		
		// date should be between the min and max dates
		
		let dom = model.dayOfMonth(byDay: 15)
		XCTAssertNotNil(dom)
		XCTAssertTrue(dom!.isSelectable)
	}
	
	func testSelectionNotInRange() throws {
		let dateComponents = DateComponents(year: 2020, month: 10, day: 15)
		let singleDay = Calendar.current.date(from: dateComponents)
		XCTAssertNotNil(singleDay)
		
		let minDate = Calendar.current.date(from: DateComponents(year: 2020, month: 10, day: 10))
		XCTAssertNotNil(minDate)
		
		let maxDate = Calendar.current.date(from: DateComponents(year: 2020, month: 10, day: 20))
		XCTAssertNotNil(maxDate)
		
		let model = MDPModel(singleDay: .constant(singleDay!), includeDays: .allDays, minDate: minDate!, maxDate: maxDate!)
		model.controlDate = singleDay!
		
		// date should outside the min and max date range
		
		let dom = model.dayOfMonth(byDay: 1)
		XCTAssertNotNil(dom)
		XCTAssertFalse(dom!.isSelectable)
	}
}
