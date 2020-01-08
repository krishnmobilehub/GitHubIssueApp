//
// IssueDetailModel.swift
// GitHubIssueApp
//

import Foundation
import ObjectMapper

class IssueDetailModel: Mappable {
    var authorAssociation : String?
    var body : String?
    var createdAt : String?
    var htmlUrl : String?
    var id : Int?
    var issueUrl : String?
    var nodeId : String?
    var updatedAt : String?
    var url : String?
    var user : User?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        authorAssociation <- map["author_association"]
        body <- map["body"]
        createdAt <- map["created_at"]
        htmlUrl <- map["html_url"]
        id <- map["id"]
        issueUrl <- map["issue_url"]
        nodeId <- map["node_id"]
        updatedAt <- map["updated_at"]
        url <- map["url"]
        user <- map["user"]
    }
}

class User: Mappable {
    
    var avatarUrl : String?
    var eventsUrl : String?
    var followersUrl : String?
    var followingUrl : String?
    var gistsUrl : String?
    var gravatarId : String?
    var htmlUrl : String?
    var id : Int?
    var login : String?
    var nodeId : String?
    var organizationsUrl : String?
    var receivedEventsUrl : String?
    var reposUrl : String?
    var siteAdmin : Bool?
    var starredUrl : String?
    var subscriptionsUrl : String?
    var type : String?
    var url : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        avatarUrl <- map["avatar_url"]
        eventsUrl <- map["events_url"]
        followersUrl <- map["followers_url"]
        followingUrl <- map["following_url"]
        gistsUrl <- map["gists_url"]
        gravatarId <- map["gravatar_id"]
        htmlUrl <- map["html_url"]
        id <- map["id"]
        login <- map["login"]
        nodeId <- map["node_id"]
        organizationsUrl <- map["organizations_url"]
        receivedEventsUrl <- map["received_events_url"]
        reposUrl <- map["repos_url"]
        siteAdmin <- map["site_admin"]
        starredUrl <- map["starred_url"]
        subscriptionsUrl <- map["subscriptions_url"]
        type <- map["type"]
        url <- map["url"]
    }
}
