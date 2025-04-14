struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency: String
        
    public init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    public func convert(_ currName : String) -> Money {
        // normalizing to USD
        var usdVal = 0
        switch self.currency {
        case "GBP":
            usdVal = self.amount * 2
        case "EUR":
            usdVal = self.amount * 2 / 3
        case "CAN":
            usdVal = self.amount * 4 / 5
        default:
            usdVal = self.amount
        }
        
        switch currName {
        case "GBP":
            usdVal /= 2
        case "EUR":
            usdVal = Int(Double(usdVal) * 1.5)
        case "CAN":
            usdVal = Int(Double(usdVal) * 1.25)
        default:
            break
        }
        return Money(amount: usdVal, currency: currName)
        
    }
    
    public func add(_ money : Money) -> Money {
        if self.currency == money.currency {
            return Money(amount: self.amount + money.amount, currency: self.currency)
        } else {
            let convertedSelf = self.convert(money.currency)
            return Money(amount: convertedSelf.amount + money.amount, currency: money.currency)
        }
    }
    
    public func subtract(_ money : Money) -> Money {
        add(Money(amount: -money.amount, currency: money.currency))
    }
}



////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    public var title: String
    public var type: JobType
    
    public init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Salary(let salary):
            return Int(salary)
        case .Hourly(let hourlyRate):
            return Int(hourlyRate * Double(hours))
        }
    }
    
    public func raise(byPercent: Double) -> Void {
        switch type{
        case .Salary(let salary):
            self.type = .Salary(UInt(Double(salary) * (1 + byPercent)))
        case .Hourly(let hourlyRate):
            self.type = .Hourly(hourlyRate * (1 + byPercent))
        }
    }
    
    public func raise(byAmount: Double) -> Void {
        switch type {
        case .Salary(let salary):
            self.type = .Salary(UInt(Double(salary) + byAmount))
        case .Hourly(let hourlyRate):
            self.type = .Hourly(hourlyRate + byAmount)
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    public var firstName: String
    public var lastName: String
    public var age: Int
    var job: Job? {
        didSet {
            if self.age < 18 {
                job = nil
            }
        }
    }
    var spouse: Person? {
        didSet {
            if self.age < 18 {
                spouse = nil
            }
        }
    }
    
    public init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    public func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job?.title ?? "nil") spouse:\(spouse?.firstName ?? "nil")]"
    }

    // Prints with Optional wrapper so ternary better for formatting here but more verbose
    //    String(describing: job?.title)
    //    String(describing: spouse?.firstName)
}

////////////////////////////////////
// Family
//
public class Family {
    public var members: [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse != nil || spouse2.spouse != nil {
            return
        }
        self.members.append(spouse1)
        self.members.append(spouse2)
    }
    
    public func haveChild(_ child: Person) -> Bool {
        if self.members[0].age < 21 || self.members[1].age < 21 {
            return false
        }
        self.members.append(child)
        return true
    }
    
    public func householdIncome() -> Int {
        var totalIncome = 0
        for member in self.members {
            if let job = member.job {
                totalIncome += job.calculateIncome(2000)
            }
        }
        return totalIncome
        
    }
}
