//
//  FileLoader.swift
//  Advent2022
//
//  Created by Pavel Stepanov on 07.12.22.
//

import Foundation

enum FileLoader {
    static func load(filename name: String) -> Data? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            return nil
        }

        guard let json = try? Data(contentsOf: url) else {
            return nil
        }

        return json
    }
}
