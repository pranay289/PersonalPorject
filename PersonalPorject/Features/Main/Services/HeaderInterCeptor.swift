

import Alamofire
import SwiftUI
import os

final class HeaderInterCeptor : RequestInterceptor {
    init() {}
    let logger = Logger(subsystem: "com.PersonalProject.app", category: "api_response")
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //add your token or do your stuff
//        request.setValue(T##value: String?##String?, forHTTPHeaderField: T##String)
        logger.info("Fetched data: \(request)")
        completion(.success(request))
    }
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
            completion(.doNotRetry)
    }
    
}
