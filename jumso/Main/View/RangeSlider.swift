import SwiftUI

struct RangeSlider: View {
    @Binding var range: ClosedRange<Double>
    let bounds: ClosedRange<Double>
    let step: Double
    
    var body: some View {
        VStack {
            Slider(value: Binding (
                get: {range.lowerBound},
                set: {range = $0...range.upperBound}
            ), in:bounds.lowerBound...bounds.upperBound, step: step)
            
            Slider(value: Binding (
                get: {range.upperBound},
                set: {range = range.lowerBound...$0}
            ), in:bounds.lowerBound...bounds.upperBound, step: step)
        }
    }
}


struct ImprovedDoubleHandleSlider: View {
    @Binding var range: ClosedRange<Double>
    let bounds: ClosedRange<Double>
    let step: Double
    let trackHeight: CGFloat = 6
    let handleSize: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            let sliderWidth = geometry.size.width
            let totalRange = bounds.upperBound - bounds.lowerBound
            
            // 핸들의 현재 위치 계산
            let lowerOffset = CGFloat((range.lowerBound - bounds.lowerBound) / totalRange) * sliderWidth
            let upperOffset = CGFloat((range.upperBound - bounds.lowerBound) / totalRange) * sliderWidth
            
            ZStack {
                // 전체 트랙
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: trackHeight)
                
                // 활성 범위 트랙
                Capsule()
                    .fill(Color.blue)
                    .frame(width: upperOffset - lowerOffset, height: trackHeight)
                    .offset(x: (upperOffset + lowerOffset) / 2 - sliderWidth / 2)
                
                // 하한 핸들
                Circle()
                    .fill(Color.blue)
                    .frame(width: handleSize, height: handleSize)
                    .position(x: lowerOffset, y: handleSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let translation = max(0, min(gesture.location.x, upperOffset))
                                let percentage = translation / sliderWidth
                                let newValue = bounds.lowerBound + percentage * totalRange
                                range = max(bounds.lowerBound, min(newValue, range.upperBound - step))...range.upperBound
                            }
                    )
                
                // 상한 핸들
                Circle()
                    .fill(Color.blue)
                    .frame(width: handleSize, height: handleSize)
                    .position(x: upperOffset, y: handleSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let translation = max(lowerOffset, min(gesture.location.x, sliderWidth))
                                let percentage = translation / sliderWidth
                                let newValue = bounds.lowerBound + percentage * totalRange
                                range = range.lowerBound...min(bounds.upperBound, max(newValue, range.lowerBound + step))
                            }
                    )
            }
        }
        .frame(height: handleSize)
    }
}
