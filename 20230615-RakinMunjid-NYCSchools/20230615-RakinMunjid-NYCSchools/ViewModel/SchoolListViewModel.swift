//
//  SchoolListViewModel.swift
//  20230615-RakinMunjid-NYCSchools
//
//  Created by Rakin Munjid on 8/17/23.
//

import Foundation

public class SchoolListViewModel {
    var records: [NYCResource] = []
    var originalRecords: [NYCResource] = []

    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType = NetworkService()) {
        self.networkService = networkService
    }

    // Fetches the school records
    func fetchRecords(completion: @escaping ([NYCResource]?, Error?) -> Void) {
        networkService.fetchSchoolRecords { (records, error) in
            if let records = records {
                self.originalRecords = records
                self.records = records
                completion(records, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    // Filters the records alphabetically
    func filterAlphabetically() {
        records.sort { (record1, record2) -> Bool in
            guard let name1 = record1.name, let name2 = record2.name else {
                return false
            }
            return name1 < name2
        }
    }

    // Filters the records by borough
    func applyBoroughFilter(borough: String) {
        records = originalRecords.filter { record in
            guard let recordBorough = record.borough else { return false }
            return recordBorough.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == borough.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        }
    }

    // Clears the filter
    func clearFilter() {
        records = originalRecords
    }
}
