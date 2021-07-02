//
//  FruitsRepository.swift
//  subject_MVC15
//
//  Created by 長谷川孝太 on 2021/07/02.
//

import Foundation

struct FruitsArrayRepository {
    private static let fruitsArrayKey = "fruitsArray"

    /// 保存の成功・失敗を返すため、Bool値を返す
    func save(newFruitsArray: [Fruit]) -> Bool {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        guard let newFA = try? jsonEncoder.encode(newFruitsArray) else {
            return false
        }
        UserDefaults.standard.set(newFA, forKey: Self.fruitsArrayKey)
        return true
    }

    /// 読み込みの成功・失敗を返すため、オプショナル型を返す
    func load() -> [Fruit]? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let newFA = UserDefaults.standard.data(forKey: Self.fruitsArrayKey),
              let newFruitsArray = try? jsonDecoder.decode([Fruit].self, from: newFA) else {
            return nil
        }
        return newFruitsArray
    }
}
