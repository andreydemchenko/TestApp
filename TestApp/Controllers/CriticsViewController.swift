//
//  CriticsViewController.swift
//  TestApp
//
//  Created by andreydem on 24.09.2022.
//

import UIKit

class CriticsViewController: UIViewController {
    
    var result: CriticResponse?
    var critics = [CriticModel]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.nytimes.com/svc/movies/v2/critics/all.json?api-key=GW5a0tJfWOcfQ7k3dpQizIsrmpZ33Bmm")
        
        getData(from: url!)
        
        tableView.dataSource = self
    }
    
    private func getData(from url: URL) {
       
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong!")
                return
            }
            
            do {
                self.result = try JSONDecoder().decode(CriticResponse.self, from: data)
            }
            catch {
                print("failed to convert \(error)")
            }
            
            guard let json = self.result else {
                return
            }
            
            self.critics = json.results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    
        }
        
        task.resume()
        
    }

}

extension CriticsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        critics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CriticTableViewCell", for: indexPath) as! CriticTableViewCell
        cell.setup(with: critics[indexPath.row])
        return cell
    }
}
