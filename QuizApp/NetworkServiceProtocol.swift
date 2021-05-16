import UIKit
protocol NetworkServiceProtocol {
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void)
    func executeUrlPostRequest(_ request: URLRequest, completionHandler: @escaping (ServerResponse) -> Void)
}
