//
//  APICallback.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import Foundation

class APICallback: NSObject {

    var completion: (NSObject) -> Void
    var error: (ErrorEntity) -> Void

    init(completion: @escaping (NSObject) -> Void, error: @escaping (ErrorEntity) -> Void) {
        self.completion = completion
        self.error = error
    }

    @objc func onLoaded(_ resultCompletion: NSObject) {
        completion(resultCompletion)
    }

    @objc func onError(_ resultError: ErrorEntity) {
        error(resultError)
    }
}

