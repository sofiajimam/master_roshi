//
//  SegmentedView.swift
//  Roshi
//
//  Created by Omar Sánchez on 16/03/24.
//

import SwiftUI

struct SegmentNumber: View {
    let number: Int
    
    var body: some View {
        Rectangle()
            .fill(Color.red)
            .frame(width: 16, height: 16)
            .overlay(
                Text("\(number)")
                    .foregroundColor(.white)
            )
    }
}

struct SegmentedView: View {
    let image: NSImage
    let boxes: [[Double]]

    var body: some View {
        Image(nsImage: image)
            .resizable()
            .overlay(
                GeometryReader { geometry in
                    ForEach(0..<boxes.count, id: \.self) { index in
                        let box = boxes[index]
                        let x = CGFloat(box[0]) * geometry.size.width - (CGFloat(box[2]) * geometry.size.width / 2)
                        let y = CGFloat(box[1]) * geometry.size.height - (CGFloat(box[3]) * geometry.size.height / 2)
                        let width = CGFloat(box[2]) * geometry.size.width
                        let height = CGFloat(box[3]) * geometry.size.height
                        ZStack(alignment: .topLeading) {
                            Rectangle()
                                .path(in: CGRect(x: x, y: y, width: width, height: height))
                                .stroke(Color.red, lineWidth: 2)
                            SegmentNumber(number: index)
                                .alignmentGuide(.leading) { _ in -x }
                                .alignmentGuide(.top) { _ in -y }
                        }
                    }
                }
            )
    }
}

#Preview {
    SegmentedView(image: NSImage(), boxes: [[0.495849609375, 0.578125, 0.625, 0.23486328125], [0.49169921875, 0.8955078125, 0.23291015625, 0.0968017578125], [0.8701171875, 0.09356689453125, 0.15673828125, 0.064453125], [0.296875, 0.165283203125, 0.329345703125, 0.0260162353515625], [0.67529296875, 0.29736328125, 0.13818359375, 0.1339111328125], [0.042755126953125, 0.0850830078125, 0.044708251953125, 0.046112060546875], [0.417236328125, 0.09130859375, 0.247802734375, 0.03204345703125], [0.446533203125, 0.08978271484375, 0.042877197265625, 0.0301666259765625], [0.425048828125, 0.272705078125, 0.498046875, 0.10760498046875], [0.421142578125, 0.1630859375, 0.31640625, 0.025299072265625], [0.269775390625, 0.09210205078125, 0.2108154296875, 0.0294647216796875], [0.4423828125, 0.2705078125, 0.317138671875, 0.037567138671875], [0.09344482421875, 0.9296875, 0.1666259765625, 0.1268310546875], [0.12841796875, 0.08563232421875, 0.046661376953125, 0.03680419921875], [0.48291015625, 0.77294921875, 0.09442138671875, 0.031707763671875]])
}
