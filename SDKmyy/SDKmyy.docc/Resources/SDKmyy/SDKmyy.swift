//
//  SDKmyy.swift
//  
//
//  Created by Creonit on 21.06.2024.
//

import Foundation

public class MySDK {

    public static let shared = MySDK()

    private init() {
        // Регистрация URLProtocol при инициализации SDK
        registerURLProtocol()
    }

    private func registerURLProtocol() {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [InterceptingURLProtocol.self] + (config.protocolClasses ?? [])
        URLSession.shared = URLSession(configuration: config)

        let ephemeralConfig = URLSessionConfiguration.ephemeral
        ephemeralConfig.protocolClasses = [InterceptingURLProtocol.self] + (ephemeralConfig.protocolClasses ?? [])
        URLSession.shared = URLSession(configuration: ephemeralConfig)

        let backgroundConfig = URLSessionConfiguration.background(withIdentifier: "custom_background_config")
        backgroundConfig.protocolClasses = [InterceptingURLProtocol.self] + (backgroundConfig.protocolClasses ?? [])
        URLSession.shared = URLSession(configuration: backgroundConfig)
    }

    public func startIntercepting() {
        // Здесь можно добавить дополнительную логику
        print("MySDK is now intercepting network requests.")
    }
}

class InterceptingURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        // Перехватываем все запросы
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        // Логирование запроса
        if let url = request.url {
            print("Intercepted request to URL: \(url.absoluteString)")
        }

        // Создаем новый запрос и отправляем его
        let newTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let error = error {
                self.client?.urlProtocol(self, didFailWithError: error)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        }
        newTask.resume()
    }

    override func stopLoading() {
        // Останавливаем загрузку запроса (если необходимо)
    }
}
