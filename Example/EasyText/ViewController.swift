//
//  ViewController.swift
//  EasyText
//
//  Created by Nemocdz on 07/25/2019.
//  Copyright (c) 2019 Nemocdz. All rights reserved.
//

import UIKit
import EasyText

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text:EasyText = """
        default
        \("font is 20pt", .font(.systemFont(ofSize: 20)))
        \("color is blue", .color(.blue))
        \("paragraghStyle can set, paragraphSpacing is 2, lineSpacing is 10, alignment is center", .paragrahStyle(builder:{
            $0.paragraphSpacing = 2
            $0.alignment = .center
            $0.lineSpacing = 10
        }))
        \("shadow offset is 2 * 2", .shadow(builder:{
            $0.shadowOffset = CGSize(width: 2, height: 2)
        }))
        \("kern is 3", .kern(3))
        you can add a image
        \(image: UIImage(named: "swift")!, bounds: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        you can add a website link
        \("https://swift.org", .link("https://swift.org"))
        \("underline single and yellow color", .underline(style: .single, color: .yellow))
        \("stroke width 2 and red color", .stroke(width: 2, color: .red))
        \("strikethrough single and pink color", .strikethrough(style: .single, color: .systemPink))
        \("unsupport attributed key can use this", EasyText.Style(attributeKeyValue: (.ligature, 1), (.backgroundColor, UIColor.orange)))
        \(easyText:"\("support nest easyText", .color(.green))", .font(.systemFont(ofSize: 18)))
        """

        textView.attributedText = text.attributedString
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

