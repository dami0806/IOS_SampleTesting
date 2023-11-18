import Foundation

func solution(_ num_list: [Int], _ n: Int) -> [Int] {
    var result = [Int]()
    for i in stride(from: 0, to: num_list.count, by: n) {
        result.append(num_list[i])
    }
    return result
}
