//
//  ServiceInfoController.swift
//  VKServices
//
//  Created by Алёна Максимова on 17.02.2023.
//

import Foundation
import UIKit

class ServiceInfoController: UIViewController {
    
    var serviceDescription = Service()
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var serviceLink: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = serviceDescription.name!
        details.text = serviceDescription.description!
        serviceLink.text = serviceDescription.service_url!
        icon.downloaded(from: serviceDescription.icon_url!)
    }
    //icon, name, desc, link
    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
