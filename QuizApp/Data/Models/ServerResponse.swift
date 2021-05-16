enum ServerResponse: Int, Codable {
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case badRequest = 400
    case ok = 200
}
