import Foundation

enum ApiError: Error{
    case badUrl
}

struct ApiService{
    static let shared = ApiService()

    let baseUrl = "https://api.openweathermap.org"
    let apiKey = "e6009d83b0e752ad55f488e1b31cebd1"

    func getWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        var urlComponents = URLComponents(string: "\(baseUrl)/data/2.5/weather")
        //    https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

        urlComponents?.queryItems = [
            .init(name: "lat", value: String(lat)),
            .init(name: "lon", value: String(lon)),
            .init(name: "appid", value: apiKey),
            .init(name: "units", value: "metric")
        ]

        guard let url = urlComponents?.url else {throw ApiError.badUrl}

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)

        let news = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return news
    }
    func getCoordinations(cityName: String) async throws -> CityResponse{
        var urlComponents = URLComponents(string: "\(baseUrl)/geo/1.0/direct")

        urlComponents?.queryItems = [
            .init(name: "q", value: cityName),
            .init(name: "limit", value: "5"),
            .init(name: "appid", value: apiKey)
        ]

        guard let url = urlComponents?.url else {throw ApiError.badUrl}

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)

        let coordinates = try JSONDecoder().decode(CityResponse.self, from: data)

        return coordinates
    }
}
