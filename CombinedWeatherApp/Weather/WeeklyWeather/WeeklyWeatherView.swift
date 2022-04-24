

import SwiftUI

struct WeeklyWeatherView: View {
  var body: some View {
    NavigationView {
      List {
        searchField

        if viewModel.dataSource.isEmpty {
          emptySection
        } else {
          cityHourlyWeatherSection
          forecastSection
        }
      }
      .listStyle(GroupedListStyle())
      .navigationBarTitle("Weather ⛅️")
    }
  }

  
  /* 1
   The @ObservedObject property delegate establishes a connection between the WeeklyWeatherView and the WeeklyWeatherViewModel. This means that, when the WeeklyWeatherView‘s property objectWillChange sends a value, the view is notified that the data source is about to change and consequently the view is re-rendered.
   */
  
  @ObservedObject var viewModel: WeeklyWeatherViewModel

  init(viewModel: WeeklyWeatherViewModel) {
    self.viewModel = viewModel
  }

}

private extension WeeklyWeatherView {
  var searchField: some View {
    HStack(alignment: .center) {
      // 1 Your first bind! $viewModel.city establishes a connection between the values you’re typing in the TextField and the WeeklyWeatherViewModel‘s city property. Using $ allows you to turn the city property into a Binding<String>. This is only possible because WeeklyWeatherViewModel conforms to ObservableObject and is declared with the @ObservedObject property wrapper.
      TextField("e.g. Cupertino", text: $viewModel.city)
    }
  }

  var forecastSection: some View {
    Section {
      // 2 Initialize the daily weather forecast rows with their own ViewModels. Open DailyWeatherRow.swift to see how it works.
      ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
    }
  }

  var cityHourlyWeatherSection: some View {
    Section {
      NavigationLink(destination: viewModel.currentWeatherView) {
        VStack(alignment: .leading) {
          Text(viewModel.city)
          Text("Weather today")
            .font(.caption)
            .foregroundColor(.gray)
        }
      }
    }
  }

  var emptySection: some View {
    Section {
      Text("No results")
        .foregroundColor(.gray)
    }
  }
}
