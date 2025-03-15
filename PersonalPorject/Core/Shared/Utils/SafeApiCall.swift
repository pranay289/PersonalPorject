import Alamofire
import Foundation
import os

let version = ProcessInfo.processInfo.operatingSystemVersion
let isAtLeastiOS15 = version.majorVersion >= 15

enum ApiMethod {
    case get
    case post
    case put
}

/// This will use third party library `Alamofire`
/// which is easy to use and implement
///  for example
///
///  ```
///  AF.request(url,method)
///
///  ```
///
func safeApiCallAlomFire<T: Codable>(
    request: URLRequest, method: ApiMethod,
    completion: @escaping (
        Result<T, ServerException>
    ) -> Void
) {

    guard let cutomReq = request.url else {
        return
    }

    let logger = Logger(
        subsystem: "com.PersonalProject.app", category: "api_response")

    var result: DataRequest
    switch method {

    case .get:
        result = AF.request(
            cutomReq, method: .get, interceptor: HeaderInterCeptor()
        ).validate().cURLDescription {
            description in
            logger.info("curl \(description)")
        }
    case .post:
        result = AF.request(
            cutomReq, method: .post, interceptor: HeaderInterCeptor())
    case .put:
        result = AF.request(
            cutomReq, method: .put, interceptor: HeaderInterCeptor())
    }
    result.response(completionHandler: {
        responsData in
        switch responsData.result {
        case .success(let response):
            guard let responseData = response else {
                completion(
                    .failure(
                        ServerException.unknownError(
                            message: "response is null")))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(
                    T.self, from: responseData)
                completion(
                    .success(decodedData))
                let data = try prettyPrintJSON(responseData)
                logger.info(
                    "loggerInfo \(data ?? "No data")"
                )
                //                if let jsonString = String(
                //                    data: prettyPrintedData, encoding: .utf8)
                //                {
                //
                //                }

            } catch let error as NSError {
                debugPrint(
                    String(data: responseData, encoding: .utf8)
                        ?? "nothing received")
                completion(.failure(ServerException(error: error)))
            }

        case .failure(let error as NSError):

            let res = ServerException(error: error)
            completion(.failure(res))
        }
    })

    //        result.validate().responseJSON { response in
    //            switch response.result {
    //            case .success(let data):
    //
    //            }
    //        }

}

// Function to pretty-print JSON
func prettyPrintJSON(_ data: Data) throws -> String? {
    // Attempt to serialize the data into a JSON object
    if let jsonObject = try? JSONSerialization.jsonObject(
        with: data, options: [])
    {
        // Try to pretty-print the JSON
        let prettyData = try JSONSerialization.data(
            withJSONObject: jsonObject, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8)
    }
    return nil
}
/// Normal Api call using predefine method like
///
///```URLSession.shared.data(for:url)```
///
///
func safeApiCall<T: Codable>(
    _ url: URLRequest
        //    completion: @escaping (Result<T, ServerException>) -> Void

) async -> Result<T, ServerException>? {
    let decoder = JSONDecoder()

    if isAtLeastiOS15 {
        do {
            let (responseData, _) = try await URLSession.shared.data(for: url)
            let resData = try decoder.decode(T.self, from: responseData)
            return .success(resData)

        } catch let error as NSError {
            let result = ServerException(error: error)

            return .failure(result)

        } catch let decodingError {
            print("Decoding error: \(decodingError.localizedDescription)")
            if let decodingError = decodingError as? DecodingError {
                switch decodingError {
                case .typeMismatch(let type, let context):
                    print(
                        "Type mismatch error. Expected type: \(type), Context: \(context)"
                    )
                case .valueNotFound(let type, let context):
                    print(
                        "Value not found. Expected type: \(type), Context: \(context)"
                    )
                case .keyNotFound(let key, let context):
                    print(
                        "Key not found. Missing key: \(key), Context: \(context)"
                    )
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context)")
                @unknown default:
                    print("Unknown decoding error")
                }
            }

        }
    } else {
        //        URLSession.shared.dataTask(with: url) {
        //            (data, response, error) in
        //
        //            if let error = error as NSError? {
        //                let result = ServerException(error: error)
        //                completion(.failure(result))
        //                return
        //            }
        //            do {
        //
        //                let resData = try decoder.decode(T.self, from: data!)
        //                completion(.success(resData))
        //            } catch {
        //                completion(
        //                    .failure(
        //                        .unknownError(message: "issue with decoding \(error)")))
        //            }
        //
        //        }.resume()
    }

    return nil
}
