//
//  NetworkClient.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 05.12.2024.
//

import Foundation

protocol NetworkClientProtocol {
    func fetch<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkClientError>) -> Void)
}

final class NetworkClient: NetworkClientProtocol {
    func fetch<T: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<T, NetworkClientError>) -> Void
    ) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.network))
                return
            }

            guard let data = data else {
                completion(.failure(.empty))
                return
            }

            guard httpResponse.statusCode == 200 else {
                completion(.failure(.service(httpResponse.statusCode)))
                return
            }

            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.deserialize(error)))
            }
        }
        dataTask.resume()
    }
}
