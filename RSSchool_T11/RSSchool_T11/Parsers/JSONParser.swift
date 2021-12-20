//
//  JSONParser.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 12.10.21.
//

import Foundation

class JSONParser<T: Decodable> {
    
    private func buildDecoder() -> JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    func parseData(_ data: Data, completion: @escaping (T?, Error?) -> ()) {
        do {
            let decoder = buildDecoder()
            let dataObject = try decoder.decode(T.self, from: data)
            completion(dataObject, nil)
        } catch let error {
            completion(nil, error)
        }
    }
}
