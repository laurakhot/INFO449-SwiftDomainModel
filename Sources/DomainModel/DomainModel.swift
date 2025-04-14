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
//        if self.currency == money.currency {
//            return Money(amount: self.amount - money.amount, currency: self.currency)
//        } else {
//            let convertedSelf = self.convert(money.currency)
//            return Money(amount: convertedSelf.amount - money.amount, currency: money.currency)
//        }
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
            return Int(hourlyRate) * hours
        }
    }
    
    public func raise(byPercent: Double) -> Void {
        switch type{
        case .Salary(let salary):
            self.type = .Salary(salary * (1 + UInt(byPercent)))
        case .Hourly(let hourlyRate):
            self.type = .Hourly(hourlyRate * (1 + byPercent))
        }
    }
    
    public func raise(byAmount: Double) -> Void {
        switch type {
        case .Salary(let salary):
            self.type = .Salary(salary + UInt(byAmount))
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
    var job: Job?
    var spouse: Person?
    
    public init(firstName: String, lastName: String, age: Int, job: Job? = nil, spouse: Person? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.job = job
        self.spouse = spouse
    }
    
    public func toString() -> String {
        return "Person: firstName: \(firstName), lastName: \(lastName), age: \(age), job: \(job?.title ?? "None"), spouse: \(spouse?.firstName ?? "None")"
    }
}

////////////////////////////////////
// Family
//
public class Family {
    
}
