//
//  OnboardingView.swift
//  ArduinoCommands
//
//  Created by User on 2023-11-05.
//

import SwiftUI

@available(iOS 16.0, *)
struct OnboardingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var currentPage = 0
    @State private var currentBackgroundColor = UIColor(hexString: "#3854A7")
    
    let backgroundColors = [UIColor(hexString: "#3854A7"), UIColor(hexString: "#163A80"), UIColor(hexString: "#4EAADC")]
    
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPageView(currentPage: $currentPage, imageName: "arduinchikStudy", subtitle: "More than 100 articles", title: "Learn, practice and read.", description: "You can read and learn a lot of new things about Arduino IDE and Wring programming framework. All Articles are available for reading Offline.", onDismiss: {
                presentationMode.wrappedValue.dismiss()
            })
                .tag(0)
            OnboardingPageView(currentPage: $currentPage, imageName: "arduinchikPro", subtitle: "New Features", title: "Screenshots and Code Snippets", description: "Each article provides circuits examples and code snippets. Each article can be customized for the most comfortable reading via Redaing Mode.", onDismiss: {
                presentationMode.wrappedValue.dismiss()
            })
                .tag(1)
            OnboardingPageView(currentPage: $currentPage, imageName: "arduinchikPlaying", subtitle: "Play and Learn", title: "Learn Arduino by playing", description: "Discover the world of programming with our friend Arduinchik. Our user-friendly platform offers a wide range of commands to enhance your programming skills.", onDismiss: {
                presentationMode.wrappedValue.dismiss()
            })
                .tag(2)
        }
        .padding(.bottom, -35)
        .background(Color(currentBackgroundColor))
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onChange(of: currentPage) { newPage in
            withAnimation(.easeInOut(duration: 0.3)) {
                currentBackgroundColor = backgroundColors[newPage]
            }
        }
    }
}

@available(iOS 16.0, *)
struct OnboardingPageView: View {
    
    @Binding var currentPage: Int
    let imageName: String
    let subtitle: String
    let title: String
    let description: String
    var onDismiss: () -> Void
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                
                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "multiply")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.white.opacity(0.8))
                        .frame(width: 28, height: 28)
                        .background(Color(UIColor(hexString: "#424548")).opacity(0.5))
                        .cornerRadius(radius: 14, corners: .allCorners)
                        .padding(.trailing, 25)
                }
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            ZStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    Circle()
                        .foregroundStyle(Color.red.opacity(0.9))
                        .blur(radius: 90)
                        .frame(width: 135, height: 135)
                        .padding(.trailing, 20)
                        .padding(.bottom, -40)
                }
                
                VStack {
                    
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .padding(.top, -200)
                        .padding(.bottom, 5)
                    
                    Text(subtitle.uppercased())
                        .foregroundStyle(Color.white.opacity(0.7))
                        .font(Font.system(size: 14, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 40)
                        .padding([.bottom], 4)
                        .padding([.top], 30)
                    
                    Text(title)
                        .foregroundStyle(Color(.white))
                        .font(Font.system(size: 30, weight: .bold))
                        .frame(width: 300)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 40)
                        .padding([.bottom], 10)
                    
                    Text(description)
                        .font(Font(UIFont.ACFont(ofSize: 16, weight: .regular)))
                        .foregroundStyle(Color(.white))
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 60)
                        .lineSpacing(6)
                        .frame(height: 120)
                        .padding(.bottom, 60)
                    
                    ACPageControl(numberOfPages: 3, currentPage: currentPage)
                        .padding(.bottom, 60)
                        .frame(maxWidth: .infinity, maxHeight: 10)
                }
                .frame(height: 550)
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(Color(UIColor(hexString: "#424548")).opacity(0.5))
                        .blur(radius: 1)
                        .cornerRadius(radius: 30, corners: [.topLeft, .topRight])
                )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}




















struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}


extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}









struct ACPageControl: View {
    var numberOfPages: Int
    var currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages) { page in
                Circle()
                    .fill(page == currentPage ? Color.white : Color(UIColor.systemGray2))
                    .frame(width: 7, height: 7)
            }
        }
    }
}
