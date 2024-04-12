//
//  WeatherService.swift
//  Weatherly
//
//  Created by Noam Efergan on 01/05/2021.
//

import Foundation

struct WeatherService {

    // MARK: - API Methods

    ///Method used to fetch the weather data from the API
    func getWeatherData(location: String, completion: @escaping (_ data: Weather? , _ error: String?) -> Void) {
        let urlString = Constants.baseAPIurl + Secrets.API_KEY + "&q=\(location)&days=3&aqi=no&alerts=no"
        guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlStringEncoded) else {
            completion(nil, Constants.errorSomethingWentWrong)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // Checks if an error has happened
            OperationQueue.main.addOperation {
                if error != nil {
                    completion(nil, error!.localizedDescription)
                    return
                }
                // Try to decode the data as a Weather object
                guard let _data = data,
                      let goodResponse = try? JSONDecoder().decode(Weather.self, from: _data)
                else {
                    completion(nil, Constants.errorSomethingWentWrong)
                    return
                }

//                do {
//                    let decoder = JSONDecoder()
//                    let goodResponse = try decoder.decode(Weather.self, from: data!)
//                    print(goodResponse as Any)
//
//                    // No error has happened, and the data was decoded properly to a Weather object
//                    completion(goodResponse, nil)
//                } catch DecodingError.dataCorrupted(let context) {
//                    print(context)
//                } catch DecodingError.keyNotFound(let key, let context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch DecodingError.valueNotFound(let value, let context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch DecodingError.typeMismatch(let type, let context) {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch {
//                    print("error: ", error)
//                }

                // No error has happened, and the data was decoded properly to a Weather object
                completion(goodResponse, nil)
                return
            }
        }.resume()
    }
}
