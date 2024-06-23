import SwiftUI

struct WelcomeItem: View {
    @Binding var currentPage: Int
    @Binding var showWelcome: Bool
    var isLast: Bool
    var imageName: String
    var title: String
    var subTitle: String
    var totalPages: Int
    
    var body: some View {
        VStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(title)
                .font(.title)
                .multilineTextAlignment(.center)
                .bold()
                .padding(.bottom)
            
            Text(subTitle)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            HStack {
                if !isLast {
                    Button {
                        showWelcome = false
                    } label: {
                        Text("Skip")
                    }
                    
                    Spacer()
                    
                    Button {
                        if currentPage < totalPages - 1 {
                            currentPage += 1
                        }
                    } label: {
                        Text("Next")
                    }
                }
                
                if isLast {
                    Button {
                        showWelcome = false
                    } label: {
                        Text("Start")
                            .frame(width: 340, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }
        }
        
        .padding()
    }
}
