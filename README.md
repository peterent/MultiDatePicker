# MultiDatePicker - A SwiftUI Component

> Requires iOS 14, Xcode 12

Many applications have the need to pick a date. But what if you have an app that requires more than one date to be selected by the user? Perhaps you are writing a hotel reservation system or an employee scheduler and need the user to select starting and ending dates or just all the days they will be working this month. 

This is where `MultiDataPicker` comes in. The standard Apple `DatePicker` lets you pick a single day. `MultiDatePicker` lets you pick a single day, a collection of days, or a date range. Its all in how you set up the component.

The `ContentView` gives you examples of each type of selection mode `MultiDatePicker` is capable of. You need a variable to use for binding and then just use it:

> I've updated the code to let the selection determine the calendar presented. Before this update, the selections would appear, but the calendar would always show the month/year for the current date. With this update, the calendar reflects the selection.

### Single Day

```
@State var selectedDate = Date()
MultiDatePicker(singleDay: self.$selectedDate)
```
Whenever the user taps a date on the control's calendar the wrapped value will change. The calendar shows the month and year for the date given.

### Collection of Days

```
@State var manyDays = [Date]()
MultiDatePicker(anyDays: self.$manyDays)
```

Whenever the user taps on a date on the control's calendar the date will be selected and added to the wrapped collection. If the date is already selected, the tap will remove it from the collection and change the wrapped value of the binding. 

The calendar in the control will reflect the first date in the array; otherwise it will show the month/year for the current date.

### Date Range

```
@State var range: ClosedRange<Date>? = nil
MultiDatePicker(dateRange: self.$range)
```
The wrapped value of the binding only changes if two dates are selected. If a third date is picked, the wrapped value is reset to `nil` and the range is removed from the calendar leaving only the one date selected. The user has to tap another date to complete the range and change the wrapped value.

The calendar in the control will show the month/year for the first day of the range. If the range is nil it will show the current month/year.

## More Options

The `MultiDatePicker` has few other options you can pass into it to limit which days can be selected. 

The `includeDays` parameter can be one of `.allDays` (the default), `weekendOnly`, or `weekdaysOnly`. For example if you pass `includeDays=.weekdaysOnly` then all weekend days appear gray and cannot be selected.

You can also set a `minDate` and/or a `maxDate` (both of which default to `nil`). Dates before `minDate` or after `maxDate` cannot be selected and appear gray.

## Notes

You can find out more on my blog at http://www.keaura.com/blog but basically:

- Download this repository
- Build the app to test it out
- Copy the MultiDatePicker folder into your app source

I've put a bunch of comments throughout the code and it should be fairly easy to integrate.

I hope you find this useful.
