//
//  IParser.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit

public protocol IParser {
    func parse(_ data: Data) -> NSObject!
}

public class WeatherParser: IParser {
    public func parse(_ data: Data) -> NSObject! {
        return setReturnEntity(WeatherInfoEntity.self, fromData: data)
    }
}

public class WeeklyParser: IParser {
    public func parse(_ data: Data) -> NSObject! {
        return setReturnEntity(WeeklyInfoEntity.self, fromData: data)
    }
}

public class ErrorParser: IParser {
    public func parse(_ data: Data) -> NSObject! {
        return setReturnEntity(ErrorEntity.self, fromData: data)
    }
}

private func setReturnEntity<T: Codable>(_ entity: T.Type, fromData: Data) -> T? {
    do {
        return try JSONDecoder().decode(entity, from: fromData)
    } catch {
        print("Error Return Entity!")
    }
    return nil
}

