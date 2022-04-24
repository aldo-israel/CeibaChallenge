//
//  ContentView.swift
//  CeibaChallenge
//
//  Created by Aldo Israel Navarro on 4/23/22.
//

import SwiftUI
import CoreData

struct UsersView: View {

    @ObservedObject var viewModel = UsersViewModel()
    
    @State var goToPosts = false
    @State var selectedUserId = 0
    @State var selectedUser: UsersResponse?
    @State var searchText = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(
            keyPath: \User.id,ascending: true)],
        animation: .default)
    
    private var savedUsers: FetchedResults<User>
    
    init() {
        if !savedUsers.isEmpty {
            viewModel.fillUsers(savedUsers: savedUsers)
        } else {
            viewModel.getUsers()
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                HeaderViewWithoutBackButton(title: "Lista de usuarios")
                
                SearchBar(text: $searchText)
                
                if !viewModel.filteredUsers.isEmpty {
                    UserList(users: $viewModel.filteredUsers,
                             goToPosts: $goToPosts,
                             selectedUser: $selectedUser)
                } else if !viewModel.users.isEmpty && searchText.isEmpty {
                    UserList(users: $viewModel.users,
                             goToPosts: $goToPosts,
                             selectedUser: $selectedUser)
                } else {
                    Spacer()
                    Text("No hay resultados...")
                        .font(.body)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
        }
        .navigate(to: PostsView(selectedUser: selectedUser),
                  when: $goToPosts)
        .onChange(of: searchText, perform: {
            s in
            
            viewModel.filterUsers(searchText: s)
        })
        .onReceive(viewModel.$users, perform: {
            users in
            
            // Saving downloaded users
            if savedUsers.isEmpty {
                for user in users {
                    let newUser = User(context: viewContext)
                
                    newUser.id = Int16(user.id ?? 0)
                    newUser.username = user.username
                    newUser.name = user.name
                    newUser.website = user.website
                    newUser.email = user.email
                    newUser.phone = user.phone

                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
        })
    }
}


struct UserList: View {
    @Binding var users: [UsersResponse]
    @Binding var goToPosts: Bool
    @Binding var selectedUser: UsersResponse?

    var body: some View {
        ScrollView {
            ForEach($users, id: \.id) {
                user in
                UserRow(user: user,
                        goToPosts: $goToPosts,
                        selectedUser: $selectedUser)
            }
        }.background(Color.white)
    }
}

struct UserRow: View {
    @Binding var user: UsersResponse
    @Binding var goToPosts: Bool
    @Binding var selectedUser: UsersResponse?
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(user.name ?? "")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity,
                                      maxHeight: 22,
                                      alignment: .leading)
                .foregroundColor(Color.accentColor)
            
            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(Color.accentColor)
                Text(user.phone ?? "")
            }.frame(maxWidth: .infinity,
                    maxHeight: 22,
                    alignment: .leading)
            
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(Color.accentColor)
                Text(user.email ?? "")
            }.frame(maxWidth: .infinity,
                    maxHeight: 22,
                    alignment: .leading)
            
            Text("VER PUBLICACIONES").bold().frame(maxWidth: .infinity,
                                      maxHeight: 22,
                                      alignment: .trailing)
            .foregroundColor(Color.accentColor)
            .onTapGesture {
                goToPosts = true
                selectedUser = user
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
