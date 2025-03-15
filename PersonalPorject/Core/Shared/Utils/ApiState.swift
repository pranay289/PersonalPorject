

enum ApiState<T> {
    case isLoading
    case isError(message: ServerException)
    case succucs(data: T)
}
//
//struct ApiState<T>{
//    let isLoading: Bool
//    let iserror: String
//    let succucs: T
//
//    init(isLoading: Bool, error: String, succucs: T) {
//        self.isLoading = isLoading
//        self.error = error
//        self.succucs = succucs
//    }
//
//}
