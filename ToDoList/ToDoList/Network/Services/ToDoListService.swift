//
//  ToDoListService.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 05.12.2024.
//

import Foundation

protocol ToDoListServiceProtocol {
    func fetchToDoList(queue: DispatchQueue, completion: @escaping (Result<ToDoList, NetworkClientError>) -> Void)
}

final class ToDoListService: ToDoListServiceProtocol {
    private let networkClient = NetworkClient()

    func fetchToDoList(queue: DispatchQueue = .main, completion: @escaping (Result<ToDoList, NetworkClientError>) -> Void) {
        guard case let .success(urlRequest) = ToDoRequestBuilder().makeRequest() else {
            queue.async {
                completion(.failure(.request))
            }
            return
        }

        networkClient.fetch(request: urlRequest) { (result: Result<ToDoDTO, NetworkClientError>) in
            let toDoModel: Result<ToDoList, NetworkClientError>

            switch result {
            case let .success(responseData):
                if let toDoListReceived = ToDoList(response: responseData) {
                    toDoModel = .success(toDoListReceived)
                } else {
                    toDoModel = .failure(.incorrectData)
                }
            case let .failure(error):
                toDoModel = .failure(error)
            }
            queue.async {
                completion(toDoModel)
            }
        }
    }
}

final class ToDoRequestBuilder {
    private func makeURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dummyjson.com"
        components.path = "/todos"

        return components.url
    }

    fileprivate func makeRequest() -> Result<URLRequest, NetworkClientError> {
        guard let url = makeURL() else {
            return .failure(.request)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return .success(request)
    }
}
