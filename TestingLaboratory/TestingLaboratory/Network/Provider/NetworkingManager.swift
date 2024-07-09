import Foundation

enum NetworkError: Error {
    case invalid
    case networkFail
    case decodedError
    case requestErr
    case serverErr
}

final class NetworkManager {
    let session: URLSessionProtocol
    let baseURL = "https://www.testwebpage.com/"
    
    /// test 환경에서는 다른 걸 사용할 수 있게 init 에서 주입받도록 한다.
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(
        for url: String,
        dataType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            guard let url = URL(string: url) else {
                completion(.failure(NetworkError.invalid))
                return
            }
            
            /// URLSessionDataTask을 얻는 과정
            let dataTask: URLSessionDataTaskProtocol = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data,
                   let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200..<205:
                        do {
                            let data = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(data))
                        } catch {
                            completion(.failure(NetworkError.decodedError))
                        }
                    case 400..<500:
                        completion(.failure(NetworkError.requestErr))
                    case 500:
                        completion(.failure(NetworkError.serverErr))
                    default:
                        completion(.failure(NetworkError.networkFail))
                    }
                } else {
                    completion(.failure(NetworkError.invalid))
                }
            }
            dataTask.resume() // 실제 네트워킹 시작
        }
}
