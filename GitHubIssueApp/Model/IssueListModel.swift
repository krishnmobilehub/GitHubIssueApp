//
// IssueListModel.swift
// GitHubIssueApp
//

import Foundation
import ObjectMapper
import CoreData

// MARK:- IssueListModel
public class IssueListModel: Mappable, NSCoding {
    
    public required init?(coder: NSCoder) {
        
    }
    
    public func encode(with coder: NSCoder) {
        
    }
    
    var assignee : Assignee?
    var assignees : [Assignee]?
    var authorAssociation : String?
    var body : String?
    var closedAt : AnyObject?
    var comments : Int?
    var commentsUrl : String?
    var createdAt : String?
    var eventsUrl : String?
    var htmlUrl : String?
    var id : Int?
    var labels : [Label]?
    var labelsUrl : String?
    var locked : Bool?
    var milestone : AnyObject?
    var nodeId : String?
    var number : Int?
    var pullRequest : PullRequest?
    var repositoryUrl : String?
    var state : String?
    var title : String?
    var updatedAt : String?
    var url : String?
    var user : Assignee?
    
    let entityName: String = CoreData.issueObject
    let managedContext = CoreDataManager.sharedInstance.getManagedContext()
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        assignee <- map["assignee"]
        assignees <- map["assignees"]
        authorAssociation <- map["author_association"]
        body <- map["body"]
        closedAt <- map["closed_at"]
        comments <- map["comments"]
        commentsUrl <- map["comments_url"]
        createdAt <- map["created_at"]
        eventsUrl <- map["events_url"]
        htmlUrl <- map["html_url"]
        id <- map["id"]
        labels <- map["labels"]
        labelsUrl <- map["labels_url"]
        locked <- map["locked"]
        milestone <- map["milestone"]
        nodeId <- map["node_id"]
        number <- map["number"]
        pullRequest <- map["pull_request"]
        repositoryUrl <- map["repository_url"]
        state <- map["state"]
        title <- map["title"]
        updatedAt <- map["updated_at"]
        url <- map["url"]
        user <- map["user"]
    }
    
    func saveObject() {
        let currentDate:String = Date().toString() ?? ""
        if let savedObjects = CoreDataManager.sharedInstance.fetchWithPredicate(entityName: CoreData.issueObject as NSString, predicate: NSPredicate(format: "date = \(currentDate) AND number = \(self.number ?? 0)")) as? [IssueList], savedObjects.count > 0 {
             self.update(object: savedObjects[0])
         } else {
            CoreDataManager.sharedInstance.deleteWithPrediecate(entityName: CoreData.issueObject as NSString,
                                                                predicate: NSPredicate(format: "number = \(self.number ?? 0)"))
            insertNewObject()
         }

     }
    
    func insertNewObject() {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let object: IssueList = NSManagedObject(entity: entity, insertInto: managedContext) as! IssueList

        self.update(object: object)
    }
    
    func update(object: IssueList) {
        object.id = Int64(self.id ?? 0)
        object.assignee = self.assignee
        object.assignees = self.assignees
        object.authorAssociation = self.authorAssociation
        object.body = self.body
        object.comments = Int64(self.comments ?? 0)
        object.createdAt = self.createdAt
        let currentDate:String = Date().toString() ?? ""
        object.date = currentDate
        object.number = Int64(self.number ?? 0)
        object.pullRequest = self.pullRequest
        object.state = self.state
        object.title = self.title
        object.updatedAt = self.updatedAt
        object.user = self.user
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

// MARK:- PullRequest
public class PullRequest: NSObject, Mappable, NSCoding  {
    
    var diffUrl : String?
    var htmlUrl : String?
    var patchUrl : String?
    var url : String?
    
    required public init?(map: Map){
        
    }

    @objc required public init(coder aDecoder: NSCoder) {
         diffUrl = aDecoder.decodeObject(forKey: "diff_url") as? String
         htmlUrl = aDecoder.decodeObject(forKey: "html_url") as? String
         patchUrl = aDecoder.decodeObject(forKey: "patch_url") as? String
         url = aDecoder.decodeObject(forKey: "url") as? String
    }

    @objc public func encode(with aCoder: NSCoder) {
        if diffUrl != nil{
            aCoder.encode(diffUrl, forKey: "diff_url")
        }
        if htmlUrl != nil{
            aCoder.encode(htmlUrl, forKey: "html_url")
        }
        if patchUrl != nil{
            aCoder.encode(patchUrl, forKey: "patch_url")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
    }

    public func mapping(map: Map) {
        diffUrl <- map["diff_url"]
        htmlUrl <- map["html_url"]
        patchUrl <- map["patch_url"]
        url <- map["url"]
    }
    
}

// MARK:- Label
class Label: Mappable {
    
    var color : String?
    var defaultField : Bool?
    var descriptionField : AnyObject?
    var id : Int?
    var name : String?
    var nodeId : String?
    var url : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        color <- map["color"]
        defaultField <- map["default"]
        descriptionField <- map["description"]
        id <- map["id"]
        name <- map["name"]
        nodeId <- map["node_id"]
        url <- map["url"]
    }
    
}

// MARK:- Assignee
public class Assignee: NSObject, Mappable, NSCoding  {
    
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

    required public init?(map: Map){
        
    }

    @objc required public init(coder aDecoder: NSCoder) {
         avatarUrl = aDecoder.decodeObject(forKey: "avatar_url") as? String
         eventsUrl = aDecoder.decodeObject(forKey: "events_url") as? String
         followersUrl = aDecoder.decodeObject(forKey: "followers_url") as? String
         followingUrl = aDecoder.decodeObject(forKey: "following_url") as? String
         gistsUrl = aDecoder.decodeObject(forKey: "gists_url") as? String
         gravatarId = aDecoder.decodeObject(forKey: "gravatar_id") as? String
         htmlUrl = aDecoder.decodeObject(forKey: "html_url") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         login = aDecoder.decodeObject(forKey: "login") as? String
         nodeId = aDecoder.decodeObject(forKey: "node_id") as? String
         organizationsUrl = aDecoder.decodeObject(forKey: "organizations_url") as? String
         receivedEventsUrl = aDecoder.decodeObject(forKey: "received_events_url") as? String
         reposUrl = aDecoder.decodeObject(forKey: "repos_url") as? String
         siteAdmin = aDecoder.decodeObject(forKey: "site_admin") as? Bool
         starredUrl = aDecoder.decodeObject(forKey: "starred_url") as? String
         subscriptionsUrl = aDecoder.decodeObject(forKey: "subscriptions_url") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         url = aDecoder.decodeObject(forKey: "url") as? String
    }

    @objc public func encode(with aCoder: NSCoder) {
        if avatarUrl != nil{
            aCoder.encode(avatarUrl, forKey: "avatar_url")
        }
        if eventsUrl != nil{
            aCoder.encode(eventsUrl, forKey: "events_url")
        }
        if followersUrl != nil{
            aCoder.encode(followersUrl, forKey: "followers_url")
        }
        if followingUrl != nil{
            aCoder.encode(followingUrl, forKey: "following_url")
        }
        if gistsUrl != nil{
            aCoder.encode(gistsUrl, forKey: "gists_url")
        }
        if gravatarId != nil{
            aCoder.encode(gravatarId, forKey: "gravatar_id")
        }
        if htmlUrl != nil{
            aCoder.encode(htmlUrl, forKey: "html_url")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if login != nil{
            aCoder.encode(login, forKey: "login")
        }
        if nodeId != nil{
            aCoder.encode(nodeId, forKey: "node_id")
        }
        if organizationsUrl != nil{
            aCoder.encode(organizationsUrl, forKey: "organizations_url")
        }
        if receivedEventsUrl != nil{
            aCoder.encode(receivedEventsUrl, forKey: "received_events_url")
        }
        if reposUrl != nil{
            aCoder.encode(reposUrl, forKey: "repos_url")
        }
        if siteAdmin != nil{
            aCoder.encode(siteAdmin, forKey: "site_admin")
        }
        if starredUrl != nil{
            aCoder.encode(starredUrl, forKey: "starred_url")
        }
        if subscriptionsUrl != nil{
            aCoder.encode(subscriptionsUrl, forKey: "subscriptions_url")
        }
        if type != nil {
            aCoder.encode(type, forKey: "type")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }

    }

    
    public func mapping(map: Map) {
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

