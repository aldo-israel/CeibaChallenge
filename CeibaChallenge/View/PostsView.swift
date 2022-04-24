//
//  PostsView.swift
//  CeibaChallenge
//
//  Created by Aldo Israel Navarro on 4/23/22.
//

import SwiftUI

struct PostsView: View {

    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = PostsViewModel()
    
    @State var goToPost = false
    @State var selectedPost: PostsResponse?
    var selectedUser: UsersResponse?
    
    var userName = ""
    
    init(selectedUser: UsersResponse?) {
        if let user = selectedUser {
            self.selectedUser = user
            self.userName = user.name ?? ""
            viewModel.getPostsBy(userId: user.id ?? 0)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(presentationMode: _presentationMode,
                    title: userName)
                
                VStack() {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(Color.accentColor)
                        Text(selectedUser?.phone ?? "")
                    }.frame(maxWidth: .infinity,
                            maxHeight: 22,
                            alignment: .leading)
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color.accentColor)
                        Text(selectedUser?.email ?? "")
                    }.frame(maxWidth: .infinity,
                            maxHeight: 22,
                            alignment: .leading)
                }.padding()
                
                PostsList(posts: $viewModel.posts,
                          goToPost: $goToPost,
                          selectedPost: $selectedPost)
            }
        }
    }
}

struct PostsList: View {
    @Binding var posts: [PostsResponse]
    @Binding var goToPost: Bool
    @Binding var selectedPost: PostsResponse?

    var body: some View {
        ScrollView {
            ForEach($posts, id: \.id) {
                post in
                PostRow(post: post,
                        goToPosts: $goToPost,
                        selectedPost: $selectedPost)
            }
        }.background(Color.white)
    }
}

struct PostRow: View {
    @Binding var post: PostsResponse
    @Binding var goToPosts: Bool
    @Binding var selectedPost: PostsResponse?
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(post.title ?? "")
                .font(.title)
                .bold()
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .foregroundColor(Color.accentColor)
            
            Text(post.body ?? "")
                .font(.body)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
