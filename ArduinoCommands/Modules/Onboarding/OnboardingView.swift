//
//  OnboardingView.swift
//  ArduinoCommands
//
//  Created by User on 2023-11-05.
//

import SwiftUI

@available(iOS 16.0, *)
struct OnboardingView: View {
    @State private var currentPage = 0
    
    let backgroundColors = [UIColor(hexString: "#3854A7"), UIColor(hexString: "#163A80"), UIColor(hexString: "#4EAADC")]
    
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPageView(imageName: "arduinchikStudy", title: "Learn, practice and read.", description: "You can read and learn a lot of new things about Arduino IDE and Wring programming framework. All the articles use a clear and accessible language. All Articles are available for reading Offline.")
                .tag(0)
            OnboardingPageView(imageName: "arduinchikPro", title: "Screenshots, Code Snippets and customization.", description: "Each article about a particular command has screenshots with usage and code snippets with examples of how you can use it. Each article can be customized for the most comfortable reading.")
                .tag(1)
            OnboardingPageView(imageName: "arduinchikPlaying", title: "Learn by playing", description: "Discover the world of programming with interactive quizzes. Our user-friendly platform offers a wide range of programming languages and tasks to enhance your skills. Hone your programming knowledge, solve real-world problems, and track your programming progress.")
                .tag(2)
        }
        .padding(.bottom, -35)
        .background(Color(backgroundColors[currentPage]))
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

@available(iOS 16.0, *)
struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 250)
                .padding(.top, 40)
            
            Spacer()
            
            ZStack(alignment: .leading) {
                Circle()
                    .foregroundStyle(Color.yellow.opacity(0.8))
                    .blur(radius: 60)
                    .frame(width: 100, height: 100)
                    .padding(.trailing, 20)
                    .padding(.bottom, 90)
                
                VStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.white))
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 40)
                        .padding([.bottom], 10)
                        .padding([.top], 20)
                    
                    Text(description)
                        .font(.body)
                        .foregroundStyle(Color(.white))
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 40)
                        .padding(.bottom, 40)
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Text("Skip")
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 85, height: 20)
                                .padding()
                                .foregroundColor(Color(UIColor(hexString: "#7B61FF")))
                                .cornerRadius(radius: 8, corners: .allCorners)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(UIColor(hexString: "#7B61FF")), lineWidth: 1.4)
                                )
                        }
                        .padding(.leading, 40)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Next")
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 85, height: 20)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color(UIColor(hexString: "#7B61FF")))
                                .cornerRadius(radius: 12, corners: .allCorners)
                        }
                        .padding(.trailing, 40)
                    }
                    .padding(.bottom, 60)
                }
                .frame(height: 500)
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



















struct VisualEffectView: UIViewRepresentable {
    let effect: UIVisualEffect

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: effect)
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
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
