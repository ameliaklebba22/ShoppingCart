
import UIKit

public struct ShopItem: Codable {
    var name: String
}

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   

    var shopList: [ShopItem] = []
    var cart: [ShopItem] = []

    var yn: Bool = true

    @IBOutlet weak var itemOutlet: UITextField!
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var cartOutlet: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        
        if let items = UserDefaults.standard.data(forKey: "theItems"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ShopItem].self, from: items){
                shopList = decoded
            }

        }
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.blue
        cell.textLabel?.text = shopList[indexPath.row].name
        return cell
        
    }
    
    
    
    @IBAction func addButton(_ sender: Any) {
        
        if shopList.count == 0{
            shopList.append(ShopItem(name: itemOutlet.text!))
            tableViewOutlet.reloadData()
            itemOutlet.text = ""
        }
       
        else{
            yn = true
            for blah in shopList{
                if blah.name == itemOutlet.text{
                let alert = UIAlertController(title: "error", message: "you already have this item added", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "okay", style: .cancel, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                yn = false
                    
        }
        }
            if yn == true{
                print(yn)
            shopList.append(ShopItem(name: itemOutlet.text!))
            tableViewOutlet.reloadData()
            itemOutlet.text = ""
            }
            
    }
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
          forRowAt indexPath: IndexPath) {
        
          if editingStyle == .delete {
              shopList.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
          }
      }

    
    @IBAction func saveButton(_ sender: Any) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(shopList){
            UserDefaults.standard.set(encoded, forKey: "theItems")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        cart.append(ShopItem(name: shopList[indexPath.row].name))
        print(cart[0].name)
        cartOutlet.text = ""
        for shawty in cart {
            cartOutlet.text = cartOutlet.text + "\(shawty.name) \n"
        }
        
        
        
        
        
        }

    
    
    
    
    
    

}
