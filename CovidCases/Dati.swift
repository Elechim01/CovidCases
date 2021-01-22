//
//  Dati.swift
//  CovidCases
//
//  Created by Michele on 21/01/21.
//

import Foundation
import SwiftUI
import UIKit

struct Country : Codable {
    var country: String
    var updated: Double
    var cases : Double
    var active: Double
    var recovered: Double
    var countryInfo : CountryInfo
}
struct CountryInfo : Codable {
    var _id : Int
    var iso2 : String
    var iso3 : String
    var lat : Int
    var long : Int
    var flag : String
}
class getData: ObservableObject {
    @Published var data : Country!
    init(country : String) {
        updateData(country: country)
    }
    func updateData(country: String) {
        let url = "https://corona.lmao.ninja/v3/covid-19/countries/\(country)"
        print(url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error != nil{
                print(error?.localizedDescription ?? "Error")
                return
            }
            do{
                let json = try JSONDecoder().decode(Country.self, from: data!)
                DispatchQueue.main.async {
                    self.data = json
                }
            }catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
    func getValue(data: Double) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(from: NSNumber(value: data))!
    }
    func getImage(imageString : String) -> UIImage {
        let imageURL = URL(string: imageString)
        let imageData = try!Data(contentsOf: imageURL!)
        let image = UIImage(data: imageData)
        return image ?? UIImage()
    }

struct Indicator: UIViewRepresentable {
    func makeUIView(context : UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
    }
}

