import UIKit

enum Importance: String {
    case irrelevant
    case normal
    case important
}

struct Note: CustomStringConvertible {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?

    public init(uid: String = UUID().uuidString, title: String, content: String,
                color: UIColor = UIColor.white, importance: Importance, selfDestructionDate: Date? = nil) {
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }

    var description: String {
        return "uid: \(uid), title: \(title), content: \(content), " +
            "color: \(color), importance: \(importance), selfDestructionDate: \(selfDestructionDate as Optional)"
    }
}

let emptyNote = Note(title: "", content: "", importance: Importance.irrelevant, selfDestructionDate: Date())
print(emptyNote)

extension Note {
    static func parse(json: [String: Any]) ->Note? {
        let colorComponents = json["color"]! as! [String: CGFloat]
        let color = UIColor(
            red: colorComponents["red"]!,
            green: colorComponents["green"]!,
            blue: colorComponents["blue"]!,
            alpha: colorComponents["alpha"]!
        )
        return Note(
            uid: json["uid"]! as! String,
            title: json["title"]! as! String,
            content: json["content"]! as! String,
            color: color,
            importance: json["importance"]! as! Importance,
            selfDestructionDate: json["selfDestructionDate"]! as! Date
        )
    }

    var json: [String: Any] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let selfDestructionDate: String = self.selfDestructionDate == nil ? "nil" : String(self.selfDestructionDate!.timeIntervalSince1970)
        return [
            "uid": self.uid,
            "title": self.title,
            "content": self.content,
            "color": ["red": red, "green": green, "blue": blue, "alpha": alpha],
            "importance": self.importance.rawValue,
            "selfDestructionDate": selfDestructionDate
        ]
    }
}

print(emptyNote.json)
