//
//  NetworkService.swift
//  20230615-RakinMunjid-NYCSchools
//
//  Created by Rakin Munjid on 8/16/23.
//

import Foundation

public protocol NetworkServiceType {
    func fetchSchoolData(completion: @escaping (Result<[SchoolSATData], Error>) -> Void)
    func fetchSchoolRecords(completion: @escaping ([NYCResource]?, Error?) -> Void) 
    // other methods...
}

enum NetworkError: Error {
    case invalidURL
    case noDataReceived
}

class NetworkService: NetworkServiceType {
//    private let baseURL: URL
    private let session: URLSession = .shared
    private let baseURL = URL(string: "https://data.cityofnewyork.us/resource")!
//    init(baseURL: URL = URL(string: "https://data.cityofnewyork.us/resource")!, session: URLSession = .shared) {
//        self.baseURL = baseURL
//        self.session = session
//    }

    func fetchSchoolRecords(completion: @escaping ([NYCResource]?, Error?) -> Void) {
        let endPoint = "s3k6-pzi2.json"
        let url = baseURL.appendingPathComponent(endPoint)

        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error ?? NetworkError.noDataReceived)
                return
            }

            do {
                let records = try JSONDecoder().decode([NYCResource].self, from: data)
                completion(records, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }

    func fetchSchoolData(completion: @escaping (Result<[SchoolSATData], Error>) -> Void) {
        let endPoint = "f9bf-2cp4.json"
        let url = baseURL.appendingPathComponent(endPoint)

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noDataReceived))
                return
            }

            do {
                let schools = try JSONDecoder().decode([SchoolSATData].self, from: data)
                completion(.success(schools))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}



