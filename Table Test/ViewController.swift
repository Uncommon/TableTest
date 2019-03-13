import Cocoa

class ViewController: NSViewController {
  @IBOutlet weak var tableView: NSTableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    tableView.setDraggingSourceOperationMask(.every, forLocal: false)
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

extension ViewController: NSTableViewDelegate
{
  struct ColumnID
  {
    static let file = NSUserInterfaceItemIdentifier("File")
    static let other = NSUserInterfaceItemIdentifier("Other")
  }
  
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
  {
    guard let identifier = tableColumn?.identifier,
          let cell = tableView.makeView(withIdentifier: identifier, owner: self) as? NSTableCellView
    else { return nil }
    
    switch identifier {
      case ColumnID.file:
        cell.textField?.stringValue = "Name"
        cell.imageView?.image = NSImage(named: .colorPanel)
      case ColumnID.other:
        cell.textField?.stringValue = "Stuff"
      default:
        return nil
    }
    return cell
  }
}

extension ViewController: NSTableViewDataSource
{
  func numberOfRows(in tableView: NSTableView) -> Int
  {
    return 1
  }
  
  func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting?
  {
    return NSPasteboardItem(pasteboardPropertyList: "some text", ofType: .string)
  }
}
