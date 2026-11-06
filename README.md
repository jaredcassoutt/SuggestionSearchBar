# SuggestionSearchBar
This is a search bar that inherits from UISearchBar. It has a UITableView populated with suggestions underneath.


## Usage
In order to implement it, the SuggestionSearchBar.swift file should be added to your project. Next the following should be added to your view controller where ```allPossibilities``` should be the list that you want to be filtered through in a search. The search uppercases what the user types before matching, so list the items in uppercase. Additionally, ```searchClicked(text:)``` should include the code you wish to occur when you select search or select an item in the list.
```
import UIKit

class ViewController: UIViewController {

    var allPossibilities = ["GREEN","YELLOW","BLUE","RED"]
    
    lazy var suggestionsListContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchBar = SuggestionSearchBar(
        del: self,
        suggestionsListContainer: suggestionsListContainer,
        dropDownPossibilities: allPossibilities,
        clickAction: dropDownItemClickedAction
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        setUpSuggestionsListContainer()
    }
}

extension ViewController: SuggestionSearchBarProtocol, UISearchBarDelegate {
    
    var searchPlaceholder: String {
        get {return "Search..."}
        set {}
    }
    
    var dropDownItems: [String] {
        get {return allPossibilities}
        set {}
    }
    
    func searchClicked(text: String) {
        //put what ever you want here to happen when search is clicked
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchClicked(text: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }   
}

```
