//
//  DetailReviewViewController.swift
//  TestApp
//
//  Created by andreydem on 24.09.2022.
//

import UIKit

class DetailReviewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var displaytitle: UILabel!
    
    @IBOutlet weak var summaryShort: UITextView!
    
    @IBOutlet weak var link: UITextView!
    
    var reviewDetails: ReviewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    private func setData() {
        imageView.downloaded(from: reviewDetails?.multimedia.src ?? "", contentMode: .center)
        displaytitle.text = reviewDetails?.display_title
        summaryShort.text = reviewDetails?.summary_short
        if let url = reviewDetails?.link.url {
            setLink(url: url)
        }
    }
    
    private func setLink(url: String) {
        let attributedString = NSMutableAttributedString(string: url)
        attributedString.addAttribute(.link, value: url, range: NSRange(location: 0, length: url.count))
        link.attributedText = attributedString
    }
    
}
