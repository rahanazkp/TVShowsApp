//
//  VideoShow.swift
//  TVShowsApp
//
//  Created by hipoint on 9/23/21.
//

import Foundation
struct VideoShow: Codable {
    var name: String
    var image: [String:String]
    var summary: String
    var status: String
    var runtime: Int
    var premiered: String
    var officialSite: String
    var url: String
    enum CodingKeys: String, CodingKey {
            case name = "name"
            case image = "image"
            case summary = "summary"
            case status = "status"
            case premiered = "premiered"
            case runtime = "runtime"
            case officialSite = "officialSite"
            case url = "url"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
            image = try values.decodeIfPresent([String:String].self, forKey: .image)!
            summary = try values.decodeIfPresent(String.self, forKey: .summary) ?? ""
            status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
            premiered = try values.decodeIfPresent(String.self, forKey: .premiered) ?? ""
            runtime = try values.decodeIfPresent(Int.self, forKey: .runtime) ?? 0
            officialSite = try values.decodeIfPresent(String.self, forKey: .officialSite) ?? ""
            url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        }
}
