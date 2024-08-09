import SwiftUI

struct LoginView: View {
    @State private var enteredID = ""
    @State private var pw = ""
    @State private var user = ""
    @State private var isInvalidID = false
    @State private var isRedirecting = false
    @State private var isMenuVisible = false
    
    private let loginExpirationKey = "LoginExpirationKey"
    private let enteredIDKey = "EnteredIDKey"
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.red, Color.pink, Color.orange]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 225, height: 225)
                        .cornerRadius(10)
                        .offset(y: 50)
                    
                    HStack {
                        Text("Senior")
                            .font(.system(size: 35))
                            .foregroundColor(.white)
                            .padding(.top, 75)
                            .fontWeight(.bold)
                        
                        Text("Connect")
                            .font(.system(size: 35))
                            .padding(.top, 75)
                            .foregroundColor(Color(#colorLiteral(red: 0.9137254902, green: 0.2549019608, blue: 0.2549019608, alpha: 1)))
                            .fontWeight(.bold)
                    }
                    
                    Text("Connecting seniors with their caregivers.")
                        .font(.system(size: 20).weight(.semibold).italic())
                        .foregroundColor(.white)
                        .padding(.top, 1)
                    
                    Spacer(minLength: 175)
                    
                    TextField("Username", text: $user)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onAppear {
                            if let savedID = UserDefaults.standard.string(forKey: enteredIDKey) {
                                enteredID = savedID
                            }
                        }
                    
                    TextField("Password", text: $pw)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onAppear {
                            if let savedID = UserDefaults.standard.string(forKey: enteredIDKey) {
                                enteredID = savedID
                            }
                        }
                    
                    TextField("Device ID", text: $enteredID)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onAppear {
                            if let savedID = UserDefaults.standard.string(forKey: enteredIDKey) {
                                enteredID = savedID
                            }
                        }
                    
                    Button(action: {
                        if enteredID == "7VT" {
                            isRedirecting = true
                            isInvalidID = false
                            print("Valid ID entered: \(enteredID)")
                            
                            UserDefaults.standard.set(enteredID, forKey: enteredIDKey)
                            let expirationDate = Date().addingTimeInterval(0)
                            UserDefaults.standard.set(expirationDate, forKey: loginExpirationKey)
                        } else {
                            // Invalid ID entered
                            isInvalidID = true
                            print("Invalid ID")
                        }
                    }) {
                        Text("Submit")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(
                                gradient: Gradient(colors: [Color.red, Color.pink, Color.orange]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .offset(y: 25)
                    }
                    .disabled(enteredID.isEmpty)
                    .opacity(enteredID.isEmpty ? 0.5 : 1.0)
                    
                    if isInvalidID {
                        Text("Invalid ID")
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .padding(.top, 5)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .background(
                NavigationLink(destination: HomeView(), isActive: $isRedirecting) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            // if login exp after certain date check ??
            if let expirationDate = UserDefaults.standard.object(forKey: loginExpirationKey) as? Date,
               expirationDate < Date()
            {
                // try to remove exp login not sure if works
                UserDefaults.standard.removeObject(forKey: loginExpirationKey)
                UserDefaults.standard.removeObject(forKey: enteredIDKey)
                isRedirecting = false
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
