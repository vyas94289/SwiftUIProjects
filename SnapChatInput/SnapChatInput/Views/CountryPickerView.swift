//
//  CountryPickerView.swift
//  SnapChatInput
//
//  Created by Gaurang on 02/05/22.
//

import SwiftUI
import Combine

class CountrySection: Identifiable {
    var id: String = ""
    var countries: [CountryInfo] = []
}

struct CountryPickerView: View {
    
    @Binding var country: CountryInfo
    
    @State private var showList: Bool = false
    
    var body: some View {
        Button(action: {
            showList.toggle()
        }, label: {
            VStack(spacing: 6) {
                HStack {
                    Text("\(country.flag) \(country.name)")
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(.gray)
                }
                .font(.footnote)
                Color.themeGray.frame(height: 1)
            }
        })
            .sheet(isPresented: $showList, content: {
                CountryListView(dismiss: $showList, country: $country)
            })
    }
}

struct CountryListView: View {
    @Binding var dismiss: Bool
    @Binding var country: CountryInfo
    @State var searchText = ""
    @State var coountrySections: [CountrySection] = []
    private let countries = CountryInfo.getCountriesFromBundle()
    
    var body: some View {
        NavigationView {
            List(coountrySections) { section in
                Section(content: {
                    ForEach(section.countries, id: \.code) { country in
                        Button.init("\(country.flag) \(country.name)") {
                            self.country = country
                            self.dismiss.toggle()
                        }
                    }
                }, header: {
                    Text(section.id)
                })
            }
            .searchable(text: $searchText)
            .navigationBarTitle(Text("Country or Region"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                dismiss.toggle()
                }, label: {
                    Image(systemName: "chevron.down")
                })
            )
        }.onChange(of: searchText) { newValue in
            createCountrySection()
        }.task {
            createCountrySection()
        }
    }
    
    func createCountrySection() {
        var countries: [CountryInfo] = []
        if searchText.isEmpty {
            countries = self.countries
        } else {
            countries = self.countries
                .filter({$0.name.lowercased()
                    .contains(searchText.lowercased())})
        }
        var sectionArray: [CountrySection] = []
        for country in countries {
            let letter = String(country.name.first ?? "A")
        
            if let section = sectionArray.first(where: {$0.id == letter}) {
                section.countries.append(country)
            } else {
                let section = CountrySection()
                section.id = letter
                section.countries.append(country)
                sectionArray.append(section)
            }
        }
        self.coountrySections = sectionArray
    }
}
