import Foundation

enum ServerException: Error {
    // Network-related errors (NSURLSession and general networking issues)
    case timeout
    case notConnectedToInternet
    case cannotFindHost
    case cannotConnectToHost
    case badURL
    case serverError(code: Int)
    case forbidden
    case unauthorized
    case badRequest
    case unsupportedURL
    case networkFailure(message: String,code :Int)

    // Data and parsing-related errors
    case invalidData
    case invalidResponse
    case jsonParsingError
    case missingData

    // Authentication errors
    case authenticationFailed(message: String)
    case expiredToken
    case invalidToken

    // Other custom errors
    case unknownError(message: String)

    init(error: NSError) {
        switch error.code {
        case NSURLErrorTimedOut:
            self = .timeout
        case NSURLErrorNotConnectedToInternet:
            self = .notConnectedToInternet
        case NSURLErrorCannotFindHost:
            self = .cannotFindHost
        case NSURLErrorCannotConnectToHost:
            self = .cannotConnectToHost
        case NSURLErrorBadURL:
            self = .badURL
        case NSURLErrorUserAuthenticationRequired:
            self = .unauthorized
        case NSURLErrorBadServerResponse:
            self = .serverError(code: error.code)
        case NSURLErrorUnsupportedURL:
            self = .unsupportedURL
        case 401:  // HTTP 401 Unauthorized
            self = .unauthorized
        case 403:  // HTTP 403 Forbidden
            self = .forbidden
        case 400:  // HTTP 400 Bad Request
            self = .badRequest
        case 404:  // HTTP 404 Not Found
            self = .serverError(code: error.code)
        case 500...599:  // HTTP 5xx Server Errors
            self = .serverError(code: error.code)
        default:
            self = .networkFailure(message: "Invalid Url or Data", code: error.code)
        }
    }
}
