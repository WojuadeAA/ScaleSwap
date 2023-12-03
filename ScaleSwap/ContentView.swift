//
//  ContentView.swift
//  ScaleSwap
//
//  Created by Wojuade Abdul Afeez on 03/12/2023.
//

import SwiftUI
//An app that converts from other  temp values to celcius i.e output selector is not needed

struct ContentView: View {
    
    @State var inputValue : Double
    @State var inputUnit : TempratureUnits
    @State var outputUnit : TempratureUnits
    @FocusState private var inputIsFocused : Bool
    var output : Double {
        return convert(value: inputValue, to: outputUnit)
    }
    
    
    func convert(value: Double, to unit: TempratureUnits) -> Double {
            switch (inputUnit, unit) {
            case (.celcius, .farenheit):
                return (value * 9/5) + 32
            case (.celcius, .kelvin):
                return value + 273.15
            case (.farenheit, .celcius):
                return (value - 32) * 5/9
            case (.farenheit, .kelvin):
                return (value - 32) * 5/9 + 273.15
            case (.kelvin, .celcius):
                return value - 273.15
            case (.kelvin, .farenheit):
                return (value - 273.15) * 9/5 + 32
            default:
                return value
            }
        }
    
   
    init() {
        self.inputValue = 0
        self.inputUnit = .celcius
        self.outputUnit = .farenheit
    }
    var body: some View {
        NavigationStack{
            Form{
                Section("Convert"){
                    Picker("Select Input Unit",selection:  $inputUnit){
                        ForEach(TempratureUnits.allCases, id: \.self){ unit in
                            Text(unit.toString())
                        }
                      }.pickerStyle(.segmented)
                    TextField("Input", value: $inputValue, format: .number).focused($inputIsFocused)
                    
                }
                
                Section("Output"){
                    Picker("Select Output Unit",selection:  $outputUnit){
                        ForEach(TempratureUnits.allCases, id: \.self){ unit in
                            Text(unit.toString())
                        }
                      }.pickerStyle(.segmented)
                    Text(output,format:.number)
                    
                }
            }.navigationTitle("Convert Temperatures").font(.subheadline).toolbar{
                if inputIsFocused {
                    Button("Done"){
                        inputIsFocused = false
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
    
    
}

enum TempratureUnits: CaseIterable{
    case celcius, farenheit, kelvin
    
    func toString () -> String {
        switch (self){
        case .kelvin:
            return "Kelvin"
        case .farenheit:
            return "Farenheit"
        case .celcius:
            return "Celcius"
        }
    }
}

