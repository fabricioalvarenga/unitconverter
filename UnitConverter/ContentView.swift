//
//  ContentView.swift
//  UnitConverter
//
//  Created by FABRICIO ALVARENGA on 28/06/22.
//

import SwiftUI

struct ContentView: View {
    private enum Units: String, CaseIterable {
        case milimeters, centimeters, meters, kilometers
    }
    
    @State private var convertFrom = Units.meters
    @State private var convertTo = Units.kilometers
    @State private var numberToConvert: Double? = 0.0
    @FocusState private var convertFromIsFocused: Bool
    
    private var result: Double {
        var n: Double
        var b: Double
        var r: Double
        
        n = (numberToConvert ?? 0.0)
        
        switch convertFrom {
        case .milimeters: b = n
        case .centimeters: b = n * 100
        case .meters: b = n * 1_000
        case .kilometers: b = n * 1_000_000
        }
        
        switch convertTo {
        case .milimeters: r = b
        case .centimeters: r = b / 100
        case .meters: r = b / 1_000
        case .kilometers: r = b / 1_000_000
        }
        
        return r
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Convert From", selection: $convertFrom) {
                        ForEach(Units.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert From")
                }
                
                Section {
                    Picker("Convert To", selection: $convertTo) {
                        ForEach(Units.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert To")
                }
                
                Section {
                    TextField("Enter a value to convert", value: $numberToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($convertFromIsFocused)
                }
                
                Section {
                    Text("\(result)")
                }
            }
             .navigationTitle("Unit Converter")
             .toolbar {
                 ToolbarItemGroup(placement: .keyboard) {
                     Spacer()
                     
                     Button("Done") {
                         convertFromIsFocused = false
                     }
                 }
             }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
