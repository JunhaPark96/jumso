import Alamofire

class AFEventLogger: EventMonitor {
    let queue = DispatchQueue(label: "AFEventLogger")
    
    func requestDidResume(_ request: Request) {
        print("➡️ Request Started: \(request.description)")
        print("📤 Request Headers: \(request.request?.allHTTPHeaderFields ?? [:])")
        print("📄 Request Body: \(String(data: request.request?.httpBody ?? Data(), encoding: .utf8) ?? "No Body")")
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Any, AFError>) {
        print("✅ Response Received: \(response.response?.statusCode ?? 0)")
        if let data = response.data {
            print("📥 Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
        }
    }
}
