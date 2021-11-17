//
//  Newsfeed.swift
//  GeekBrains-VK-SwiftUI
//
//  Created by Владимир on 17.10.2021.
//

import Foundation


final class NewsfeedService: Decodable {
    
    var response: ResponseObj
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    public func buildNewsfeedList() -> [NewsfeedViewModel] {
        var newsfeed: [NewsfeedViewModel] = []
        
        for item in response.items {
            let type: String = item.type
            var ownerId: Int = -1
            var ownerName: String = ""
            var avatar: String = ""
            
            
            /// Определяем владельца каждой новости
            /// Владельцем может быть группа из массива groups или пользовател из массива profiles
            ///     - item.sourceId больше 0 — новость от пользователя
            ///     - item.sourceId меньше 0 — новость от  группы
            if item.sourceId > 0 {
                let profile = response.profiles.first { $0.id == item.sourceId }
                ownerId = item.sourceId
                ownerName = (profile?.firstName ?? "") + " " + (profile?.lastName ?? "")
                avatar = profile?.photo50 ?? ""
            } else {
                let groups = response.groups.first { $0.id == abs(item.sourceId) }
                ownerId = item.sourceId
                ownerName = groups?.name ?? ""
                avatar = groups?.photo50 ?? ""
            }
            
            var photo: (url: URL?, aspectRatio: Float) = (nil, 0)
            switch item.attachments?.first?.type {
            case "photo":
                photo = getPhotoMaxSize(array: item.attachments?.first?.photo?.sizes)
            case "link":
                photo = getPhotoMaxSize(array: item.attachments?.first?.link?.photo?.sizes)
            case "podcast":
                photo = getPhotoMaxSize(array: item.attachments?.first?.podcast?.podcastInfo?.cover?.sizes)
            case "video":
                photo = getPhotoMaxSize(array: item.attachments?.first?.video?.image)
            case "doc":
                photo = getPhotoMaxSize(array: item.attachments?.first?.doc?.preview?.photo?.sizes)
                
            default :
                photo = (nil, 0)
            }
            
            let news = NewsfeedViewModel(type: type,
                                         id: item.postId,
                                         ownerId: ownerId,
                                         name: ownerName,
                                         avatar: URL(string: avatar),
                                         date: item.date,
                                         likes: item.likes,
                                         comments: item.comments,
                                         reposts: item.reposts,
                                         views: item.views,
                                         text: item.text,
                                         photo: photo)

            newsfeed.append(news)
        }
        NewsfeedViewModel.nextFrom = response.nextFrom ?? NewsfeedViewModel.nextFrom
        return newsfeed
    }
    
    
    private func getPhotoMaxSize(array: [PhotoSizesProtocol]?) -> (url: URL?, aspectRatio: Float) {
        guard let array = array else { return (url: nil, aspectRatio: 0) }
        
        var index = 0
        var maxSize = 0
        for (i, size) in array.enumerated() {
            let greater = max(size.width, size.height)
            if maxSize < greater {
                index = i
                maxSize = greater
            }
        }
        
        let aspectRatio = Float(array[index].height) / Float(array[index].width)
        return (url: URL(string: array[index].url), aspectRatio: aspectRatio)
    }
    
    
    
    class ResponseObj: Decodable {
        var items:      [ItemsNewsfeed]
        var profiles:   [NewsProfiles]
        var groups:     [NewsGroups]
        var nextFrom:   String?
        
        enum CodingKeys: String, CodingKey {
            case items
            case profiles
            case groups
            case nextFrom = "next_from"
        }
        
        
        //  MARK: - ItemsNewsfeed
        //
        class ItemsNewsfeed: Codable {
            var type:       String
            var sourceId:   Int
            var date:       TimeInterval
            var postId:     Int
            var postType:   String
            var text:       String?

            var comments:   SocialActivity.Comments?
            var likes:      SocialActivity.Likes?
            var reposts:    SocialActivity.Reposts?
            var views:      SocialActivity.Views?

            var attachments: [Attachments]?

            enum CodingKeys: String, CodingKey {
                case type
                case sourceId   = "source_id"
                case date
                case postId     = "post_id"
                case postType   = "post_type"
                case text
                case comments
                case likes
                case reposts
                case views
                case attachments
            }
            
            
            //  MARK:   - Attachments
            class Attachments: Codable {
                var type:       String
                var photo:      PhotoAttachments?
                var link:       LinkAttachments?
                var podcast:    PodcastAttachments?
                var video:      VideoAttachments?
                var doc:        DocAttachments?

                enum CodingKeys: String, CodingKey {
                    case type
                    case photo
                    case link
                    case podcast
                    case video
                    case doc
                }
                
                
                //  MARK:   - DocAttachments
                class DocAttachments: Codable {
                    var id:         Int
                    var ownerId:    Int
                    var title:      String?
                    var size:       Int64?
                    var ext:        String?
                    var date:       TimeInterval?
                    var type:       Int
                    var url:        String?
                    var preview:    PreviewDocAttachments?
                    var accessKey:  String?
                    
                    enum CodingKeys: String, CodingKey {
                        case id
                        case ownerId = "owner_id"
                        case title
                        case size
                        case ext
                        case date
                        case type
                        case url
                        case preview
                        case accessKey = "access_key"
                    }
                    
                    
                    //  MARK:   - PreviewDocAttachments
                    class PreviewDocAttachments: Codable {
                        var photo: PhotoPreviewDocAttachments?
                        var video: VideoPreviewDocAttachments?
                        
                        enum CodingKeys: String, CodingKey {
                            case photo
                            case video
                        }
                        
                        
                        //  MARK:   - PhotoPreviewDocAttachments
                        class PhotoPreviewDocAttachments: Codable {
                            var sizes: [DocPhotoSizes]?
                            
                            enum CodingKeys: String, CodingKey {
                                case sizes
                            }
                            
                            
                            //  MARK:   - DocPhotoSizes
                            class DocPhotoSizes: Codable, PhotoSizesProtocol {
                                var width:  Int
                                var height: Int
                                var url:    String
                                var type:   String?
                                
                                enum CodingKeys: String, CodingKey {
                                    case width
                                    case height
                                    case url = "src"
                                    case type
                                }
                            }
                        }
                        
                        
                        //  MARK:   - VideoPreviewDocAttachments
                        class VideoPreviewDocAttachments: Codable {
                            var src:        String?
                            var width:      Int?
                            var height:     Int?
                            var fileSize:   Int64?
                            
                            enum CodingKeys: String, CodingKey {
                                case src
                                case width
                                case height
                                case fileSize = "file_size"
                            }
                        }
                    }
                }
                
                
                //  MARK:   - VideoAttachments
                class VideoAttachments: Codable {
                    var accessKey:      String?
                    var date:           TimeInterval
                    var description:    String?
                    var id:             Int
                    var ownerId:        Int
                    var title:          String?
                    var trackCode:      String?
                    var platform:       String?
                    var duration:       Int?
                    var image:          [ImageSizeVideoAttachments]?
                   
                    enum CodingKeys: String, CodingKey {
                        case accessKey      = "access_key"
                        case date
                        case description
                        case id
                        case ownerId        = "owner_id"
                        case title
                        case trackCode      = "track_code"
                        case platform
                        case image
                        case duration
                    }
                    
                    
                    //  MARK:   - ImageSizeVideoAttachments
                    class ImageSizeVideoAttachments: Codable, PhotoSizesProtocol {
                        var width:      Int
                        var height:     Int
                        var url:        String
                        var padding:    Int?
                        
                        enum CodingKeys: String, CodingKey {
                            case width
                            case height
                            case url
                            case padding = "with_padding"
                        }
                    }
                }
                
                
                //  MARK:   - PodcastAttachments
                class PodcastAttachments: Codable {
                    var artist:         String
                    var id:             Int
                    var ownerId:        Int
                    var title:          String?
                    var trackCode:      String?
                    var url:            String?
                    var date:           TimeInterval
                    var podcastInfo:    PodcastInfo?
                    
                    enum CodingKeys: String, CodingKey {
                        case artist
                        case id
                        case ownerId        = "owner_id"
                        case title
                        case trackCode      = "track_ode"
                        case url
                        case date
                        case podcastInfo    = "podcast_info"
                    }
                    
                    
                    //  MARK:   - PodcastInfo
                    class PodcastInfo: Codable {
                        var cover: PodcastCover?
                        
                        enum CodingKeys: String, CodingKey {
                            case cover
                        }
                        
                        
                        //  MARK:   - PodcastCover
                        class PodcastCover: Codable {
                            var sizes: [PhotoSizes]
                            
                            enum CodingKeys: String, CodingKey {
                                case sizes
                            }
                        }
                    }
                }
                
                
                //  MARK:   - LinkAttachments
                class LinkAttachments: Codable {
                    var url:            String
                    var title:          String?
                    var caption:        String?
                    var description:    String?
                    var photo:          PhotoAttachments?
                    
                    enum CodingKeys: String, CodingKey {
                        case url
                        case title
                        case caption
                        case description
                        case photo
                    }
                }
                
                
                //  MARK:   - PhotoAttachments
                class PhotoAttachments: Codable {
                    var id:         Int
                    var albumId:    Int
                    var date:       TimeInterval
                    var ownerId:    Int
                    var hasTags:    Bool?
                    var accessKey:  String?
                    var sizes:      [PhotoSizes]
                    var text:       String?
                    
                    enum CodingKeys: String, CodingKey {
                        case id
                        case albumId    = "album_id"
                        case date
                        case ownerId    = "owner_id"
                        case hasTags    = "has_tags"
                        case accessKey  = "access_key"
                        case sizes
                        case text
                    }
                }
            }
        }
        
        
        //  MARK:   - NewsProfiles
        //
        class NewsProfiles: Codable {
            var id:         Int
            var firstName:  String
            var lastName:   String?
            var sex:        Int?
            var screenName: String?
            var photo50:    String?
            var online:     Int?
            var onlineInfo: OnlineInfo?
            
            enum CodingKeys: String, CodingKey {
                case id
                case firstName  = "first_name"
                case lastName   = "last_name"
                case sex
                case screenName = "screen_name"
                case photo50    = "photo_50"
                case online
                case onlineInfo = "online_info"
            }
            
            
            //  MARK:   - OnlineInfo
            class OnlineInfo: Codable {
                var visible:    Bool
                var isOnline:   Bool
                var isMobile:   Bool
                
                enum CodingKeys: String, CodingKey {
                    case visible
                    case isOnline = "is_online"
                    case isMobile = "is_mobile"
                }
            }
        }
        
        
        //  MARK:   - NewsGroups
        //
        class NewsGroups: Codable {
            var id:         Int
            var name:       String
            var screenName: String?
            var isClosed:   Int?
            var type:       String?
            var photo50:    String?
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case screenName = "screen_name"
                case isClosed   = "is_closed"
                case type
                case photo50    = "photo_50"
            }
        }
    }
}
