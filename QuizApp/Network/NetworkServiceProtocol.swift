import UIKit
protocol NetworkServiceProtocol {
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void)
    func sendResult(_ result: QuizComplete, completionHandler: @escaping (ServerResponse) -> Void)
}
