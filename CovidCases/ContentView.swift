//
//  ContentView.swift
//  CovidCases
//
//  Created by Michele on 21/01/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = getData(country: "canada")
    @State var country : String = "canada"
    var body: some View {
        ZStack{
            if self.data.data != nil{
                VStack{
                    Text("COVID-19 Virus")
                        .font(.system(size: 30))
                        .bold()
                    HStack{
                        TextField("Enter country here",text: $country)
                            .padding(10)
                            .font(Font.system(size: 15,weight: .medium,design: .serif))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue,lineWidth: 1))
                        Button(action: {
                            self.data.updateData(country: self.country)
                        }, label: {
                            Text("Enter")
                        })
                    }.frame(width: 250).padding()
                    Image(uiImage: getImage(imageString: data.data.countryInfo.flag))
                        .resizable()
                        .frame(width: 250,height: 125, alignment: .center)
                    Text("Total Cases \(getValue(data: self.data.data.cases))")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: 200, height: 175, alignment: .center)
                        .multilineTextAlignment(.center)
                    Text("Active Cases :\(getValue(data: self.data.data.active))")
                        .font(.headline)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.red)
                        .padding(20)
                    Text("Recoverd: \(getValue(data: self.data.data.cases))")
                        .font(.headline)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.green)
                    
                }
            }else{
                GeometryReader{geo in
                    VStack{
                        Indicator()
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
