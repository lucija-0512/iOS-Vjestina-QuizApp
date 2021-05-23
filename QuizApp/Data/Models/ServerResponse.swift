enum ServerResponse: Int {
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case badRequest = 400
    case ok = 200
    
    var description: String {
        switch self {
            case .unauthorized:
                return "401 UNAUTHORIZED"
            case .forbidden:
                return "403 FORBIDDEN "
            case .notFound:
                return "404 NOT FOUND"
            case .badRequest:
                return "400 BAD REQUEST"
            case .ok:
                return "200 OK"
        }
    }
}
