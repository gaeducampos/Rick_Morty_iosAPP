//
//  NetworkingManager.swift
//  Rick_And_Morty_Programmatic
//
//  Created by Gabriel Campos on 6/2/23.
//

import Foundation
import Combine

class NetworkProvider {
    enum Constants {
        static let baseUrl = URL(string: "https://rickandmortyapi.com/api")!
    }
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: String)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL. \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    

    
    func request(for request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap ({ try self.handleURLResponse(output: $0, request: request) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func request<Value: Decodable>(
        for request: URLRequest,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Value, Error> {
        self.request(for: request)
            .decode(type: Value.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    
    func handleURLResponse(
        output: URLSession.DataTaskPublisher.Output,
        request: URLRequest
    ) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: request.url?.absoluteString ?? "")
        }
        
        return output.data
    }
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}


extension URLRequest {
    static var baseRequest: URLRequest {
        URLRequest(url: NetworkProvider.Constants.baseUrl)
    }
    
    
    func add(path: String) -> URLRequest {
        var request = self
        
        guard var url = request.url else {
            return self
        }
        
        url.appendPathComponent(path)
        
        request.url = url
        
        return request
    }
    
    func addParameters(value: String, name: String) -> URLRequest {
        var request = self
        
        guard let url = url else {
            return self
        }
        
        var urlParameters = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        var items = urlParameters?.queryItems ?? []
        
        items.append(
            URLQueryItem(name: name, value: value)
        )
        
        urlParameters?.queryItems = items
        
        request.url = urlParameters?.url
        
        return request
    }
}
