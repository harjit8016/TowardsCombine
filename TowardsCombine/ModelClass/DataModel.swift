 
 
 import Foundation
 import Combine
 // MARK: - Welcome
 struct Welcome: Codable {
    let status: String
    let data: [Datum]
 }
 
 
 // MARK: - Datum
 struct Datum: Codable {
    let id, employeeName, employeeSalary, employeeAge: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
 }
 
 // MARK: - Helper functions for creating encoders and decoders
 
 func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
 }
 
 func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
 }
 
 
