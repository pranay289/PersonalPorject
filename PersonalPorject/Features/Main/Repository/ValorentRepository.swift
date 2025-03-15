import Foundation

protocol ValorentRepository {

    func getValorentAgents() async -> Result<ValorentModel?, ServerException>?
}
