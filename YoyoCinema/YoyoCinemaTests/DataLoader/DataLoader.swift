//
//  DataLoader.swift
//  YoyoCinemaTests
//
//  Created by Mohamed Kelany on 12/8/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

class DataLoader {
    static func getData() -> Data? {
        let testBundle = Bundle(for:  self)
        guard let path = testBundle.path(forResource: "data", ofType: "json") else {
            return nil
        }
        do {
            let content = try String(contentsOfFile: path)
            let data: Data? = content.data(using: .utf8) // non-nil
            return data
        } catch {
            return nil
        }
    }
}


