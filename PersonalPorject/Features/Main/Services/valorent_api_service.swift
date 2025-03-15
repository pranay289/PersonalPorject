import Foundation

class ValorentApiService: ValorentRepository {

    static let instance = ValorentApiService()

    private init() {}

    func getValorentAgents() async -> Result<ValorentModel?, ServerException>? {
        guard let urlData = URL(string: "https://valorant-api.com/v1/agents/")
        else {
            fatalError("issue with url")
        }
        var request = URLRequest(url: urlData)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let resultData: Result<ValorentModel?, ServerException>? =
            await safeApiCall(request)
        return resultData
    }

    func getValorentAgentsAlamoFire(
        completion: @escaping (Result<ValorentModel?, ServerException>) -> Void
    ) {
        guard let urlData = URL(string: "https://valorant-api.com/v1/agents/")
        else {
            fatalError("issue with url")
        }
        let request = URLRequest(url: urlData)
        return safeApiCallAlomFire(request: request, method: ApiMethod.get) {
            (result: Result<ValorentModel?, ServerException>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }

        }
    }

    func fetchValorentData() async throws -> ValorentModel? {

        guard let urlData = URL(string: "https://valorant-api.com/v1/agents/")

        else {
            fatalError("issue with url")
        }

        var request = URLRequest(url: urlData)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let (data, _) = try await URLSession.shared.data(
                for: request)
            //            let httpResponse = response as? HTTPURLResponse
            //            if httpResponse?.statusCode != 200 {
            //
            //                switch httpResponse?.statusCode {
            //                case 404:
            //                    throw ServerException.serverError(
            //                        code: 404, message: "Api host not found")
            //                case 500:
            //                    throw ServerException.badRequest()
            //
            //                }
            //            }
            //            let data2 = try  decoder.decode(ValorentModel.self, from: data)
            //            print(data2)

            return try? decoder.decode(ValorentModel.self, from: data)

        } catch let error as NSError {
            let result = ServerException.init(error: error)
            throw result
        }

    }

}
