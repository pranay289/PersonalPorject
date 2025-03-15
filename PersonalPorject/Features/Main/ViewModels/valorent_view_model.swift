import Foundation

//import SwiftUI
@MainActor
class ValorentViewModel: ObservableObject {
    @Published var jsonDataModel = ValorentModel()
    @Published var isLoading: Bool = false
    @Published var apiState: ApiState<ValorentModel?> = .isLoading

    //    init() {
    //        isLoading = false
    //    }

    func getValorentDatafromStore() async {
        self.apiState = .isLoading
        let result = await ValorentApiService.instance.getValorentAgents()
        switch result {

        case .success(let valorentData?):

            self.apiState = .succucs(data: valorentData)

        case .failure(let error):

            self.apiState = .isError(message: error)

        default:

            self.apiState = .isError(
                message: ServerException.unknownError(
                    message: "Something went wrong"))
        }

    }

    func getValorentAgentsAlamoFireStore() {
        self.apiState = .isLoading
        ValorentApiService.instance.getValorentAgentsAlamoFire {
            (result: Result<ValorentModel?, ServerException>) in
            switch result {
            case .success(let valorentData):
                self.apiState = .succucs(data: valorentData)
            case .failure(let error):
                self.apiState = .isError(message: error)

            }
        }
    }

    func getValorentData() async throws {

        do {

            self.isLoading = true

            let data = try await ValorentApiService.instance
                .fetchValorentData()
            guard let responseData = data else { return }

            self.jsonDataModel = responseData

            computePrimes(upTo: 20_000_000)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Code to execute after the delay
                self.isLoading = false
            }

            //            DispatchQueue.main.async{
            ////                self.jsonDataModel = responseData
            //                self.isLoading = false
            //            }
        } catch {
            throw error

        }

    }

}

func computePrimes(upTo limit: Int) {
    var primes: [Int] = []
    var isComputing = false
    isComputing = true

    // Dispatch the computation to a background queue to avoid blocking the main UI thread
    DispatchQueue.global(qos: .background).async {
        let primess = calculatePrimes(upTo: limit)

        // Switch back to the main thread to update the UI

        primes = primess
        isComputing = false
        print(isComputing)
    }

}

// A simple function to calculate prime numbers up to a certain limit
func calculatePrimes(upTo limit: Int) -> [Int] {
    var primes = [Int]()
    for number in 2...limit {
        primes.append(number * 2)
    }
    return primes
}
