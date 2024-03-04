import SwiftUI

@available(iOS 15.0, *)
extension SCToolTipView {
    public enum SCToolTipArrowAlignment {
        case TopLeft
        case TopCenter
        case TopRight
        case MidLeft
        case MidRight
        case BottomLeft
        case BottomCenter
        case BottomRight
        
        
        var degress: Angle {
            switch self {
            case .TopLeft, .TopCenter, .TopRight:
                return .degrees(0)
            case .MidLeft:
                return .degrees(-90)
            case .MidRight:
                return .degrees(90)
            case .BottomLeft, .BottomCenter, .BottomRight:
                return .degrees(180)
            }
        }
    }
}

@available(iOS 15.0, *)
public struct SCToolTipView: View {
    
    var description: String
    var arrowAlignment: SCToolTipArrowAlignment = .BottomCenter
    var showCancelButton: Bool = true
    
    var onTapGesture: (() -> ())
    
    public init(description: String, arrowAlignment: SCToolTipArrowAlignment = .BottomCenter, showCancelButton: Bool = true, onTapGesture: @escaping () -> Void) {
        self.description = description
        self.arrowAlignment = arrowAlignment
        self.showCancelButton = showCancelButton
        self.onTapGesture = onTapGesture
    }
    
    public var body: some View {
        
        ZStack {
            
            topLeftView
            topCenterView
            topRightView
            
            midView
            
            switch arrowAlignment {
            case .BottomLeft:
                bottomView(alignment: .leading)
            case .BottomCenter:
                bottomView(alignment: .center)
            case .BottomRight:
                bottomView(alignment: .trailing)
            default:
                EmptyView()
            }
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTapGesture()
        }
        
        
    }
    
    private var topLeftView: some View {
        VStack(alignment: .leading, spacing: -0.1) {
            
            switch arrowAlignment {
            case .TopLeft:
                triangleView()
                    .padding(.leading, 15)
                    .zIndex(20)
                titleView
            default:
                EmptyView()
            }
        }
    }
    
    private var topCenterView: some View {
        VStack(spacing: -0.1) {
            switch arrowAlignment {
            case .TopCenter:
                triangleView()
                    .zIndex(20)
                titleView
            default:
                EmptyView()
            }
        }
    }
    
    private var topRightView: some View {
        VStack(alignment: .trailing, spacing: -0.1) {
            switch arrowAlignment {
            case .TopRight:
                triangleView()
                    .padding(.trailing, 15)
                    .zIndex(20)
                titleView
            default:
                EmptyView()
            }
        }
    }
    
    private var midView: some View {
        HStack(spacing: 0) {
            switch arrowAlignment {
            case .MidLeft:
                triangleView()
                    .offset(x: 1.322, y: 0)
                    .zIndex(20)
                titleView
            case .MidRight:
                titleView
                triangleView()
                    .offset(x: -1.322, y: 0)
                    .zIndex(20)
            default:
                EmptyView()
            }
        }
    }
    
    private func bottomView(alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: -0.1) {
            switch arrowAlignment {
            case .BottomLeft:
                titleView
                triangleView()
                    .padding(.leading, 15)
                    .zIndex(20)
            case .BottomCenter:
                titleView
                triangleView()
            case .BottomRight:
                titleView
                triangleView()
                    .padding(.trailing, 15)
                    .zIndex(20)
            default:
                EmptyView()
            }
        }
    }
    
    private func triangleView() -> some View {
        ZStack {
            
            Triangle()
                .foregroundStyle((Color(hexString: "#484848") ?? .white).opacity(1))
            
            TriangleBorder()
                .stroke(.white.opacity(0.7), lineWidth: 0.5)
            
        }.frame(width: 8.69, height: 7)
            .rotationEffect(arrowAlignment.degress)
    }
    
    private var titleView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle((Color(hexString: "#484848") ?? .white).opacity(1))
            
            RoundedRectBorder(aligment: arrowAlignment)
                .stroke(.white.opacity(0.7), lineWidth: 0.5)
                .zIndex(1)
            
            Text(description)
                .font(.system(size: 13, weight: .medium))
                .lineSpacing(5)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .multilineTextAlignment(.center)
            
            VStack {
                
                HStack {
                 Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .font(.system(size: 10, weight: .medium))
                        .padding(.top, 5)
                        .padding(.trailing, 3)
                }
                Spacer()
                
            }
            .opacity(showCancelButton ? 1 : 0)
        }
        .fixedSize()
    }
}

@available(iOS 13.0, *)
extension Color {
    init?(hexString: String) {
        
        let rgbaData = getrgbaData(hexString: hexString)
        
        if(rgbaData != nil){
            
            self.init(
                .sRGB,
                red:     Double(rgbaData!.r),
                green:   Double(rgbaData!.g),
                blue:    Double(rgbaData!.b),
                opacity: Double(rgbaData!.a)
            )
            return
        }
        return nil
    }
    
    
}

private func getrgbaData(hexString: String) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? {

    var rgbaData : (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? = nil

    if hexString.hasPrefix("#") {

        let start = hexString.index(hexString.startIndex, offsetBy: 1)
        let hexColor = String(hexString[start...]) // Swift 4

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {

            rgbaData = { // start of a closure expression that returns a Vehicle
                switch hexColor.count {
                case 8:

                    return ( r: CGFloat((hexNumber & 0xff000000) >> 24) / 255,
                             g: CGFloat((hexNumber & 0x00ff0000) >> 16) / 255,
                             b: CGFloat((hexNumber & 0x0000ff00) >> 8)  / 255,
                             a: CGFloat( hexNumber & 0x000000ff)        / 255
                           )
                case 6:

                    return ( r: CGFloat((hexNumber & 0xff0000) >> 16) / 255,
                             g: CGFloat((hexNumber & 0x00ff00) >> 8)  / 255,
                             b: CGFloat((hexNumber & 0x0000ff))       / 255,
                             a: 1.0
                           )
                default:
                    return nil
                }
            }()

        }
    }

    return rgbaData
}

@available(iOS 15.0, *)
struct RoundedRectBorder: Shape {
    
    var aligment: SCToolTipView.SCToolTipArrowAlignment
    
    init(aligment: SCToolTipView.SCToolTipArrowAlignment) {
        self.aligment = aligment
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        switch aligment {
        case .BottomCenter:
            path = bottomCenterView(rect: rect)
        default:
            path = midLeftView(rect: rect)
        }
        
        return path
    }
    
    private func midLeftView(rect: CGRect) -> Path {
        var path = Path()
        
        let centerX = rect.midX
        let bottomY = rect.maxY
        
        path.addArc(center: CGPoint(x: rect.minX + 5, y: rect.minY + 5), radius: 5, startAngle: Angle(degrees: 280), endAngle: Angle(degrees: 180), clockwise: true)
        
            path.addLine(to: CGPoint(x: rect.minX, y: bottomY - 5))
            
            // Exclude the bottom center part from the border
        
        path.addArc(center: CGPoint(x: rect.minX + 5, y: rect.maxY - 5), radius: 5, startAngle: Angle(degrees: -180), endAngle: Angle(degrees: 100), clockwise: true)
        
            path.addLine(to: CGPoint(x: centerX, y: bottomY)) // Adjust the value as needed
        path.move(to: CGPoint(x: centerX, y: bottomY)) // Adjust the value as needed
        
        path.addArc(center: CGPoint(x: rect.maxX - 5, y: rect.maxY - 5), radius: 5, startAngle: Angle(degrees: 100), endAngle: Angle(degrees: 0), clockwise: true)
            
            path.addLine(to: CGPoint(x: rect.maxX, y: bottomY - 5))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 5))
        
        path.addArc(center: CGPoint(x: rect.maxX - 5, y: rect.minY + 5), radius: 5, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: -90), clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.minX + 5.9, y: rect.minY))

        return path
    }
    
    private func bottomCenterView(rect: CGRect) -> Path {
        
        var path = Path()
        
        let centerX = rect.midX
        let bottomY = rect.maxY
        
        path.addArc(center: CGPoint(x: rect.minX + 5, y: rect.minY + 5), radius: 5, startAngle: Angle(degrees: 280), endAngle: Angle(degrees: 180), clockwise: true)
        
            path.addLine(to: CGPoint(x: rect.minX, y: bottomY - 5))
            
            // Exclude the bottom center part from the border
        
        path.addArc(center: CGPoint(x: rect.minX + 5, y: rect.maxY - 5), radius: 5, startAngle: Angle(degrees: -180), endAngle: Angle(degrees: 100), clockwise: true)
        
            path.addLine(to: CGPoint(x: centerX - 4, y: bottomY)) // Adjust the value as needed
        path.move(to: CGPoint(x: centerX + 4, y: bottomY)) // Adjust the value as needed
        
        path.addArc(center: CGPoint(x: rect.maxX - 5, y: rect.maxY - 5), radius: 5, startAngle: Angle(degrees: 100), endAngle: Angle(degrees: 0), clockwise: true)
            
            path.addLine(to: CGPoint(x: rect.maxX, y: bottomY - 5))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 5))
        
        path.addArc(center: CGPoint(x: rect.maxX - 5, y: rect.minY + 5), radius: 5, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: -90), clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.minX + 5.9, y: rect.minY))

        return path
    }
}

@available(iOS 13.0, *)
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

@available(iOS 13.0, *)
struct TriangleBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        return path
    }
}
