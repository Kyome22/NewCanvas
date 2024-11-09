/*
 ArraySlice+Extension.swift
 Domain

 Created by Takuto Nakamura on 2024/11/08.
 
*/

extension ArraySlice {
    func reduce<Result>(
        from initialResult: (Element) throws -> Result,
        successor updateAccumulatingResult: (inout Result, Element) throws -> ()
    ) rethrows -> Result {
        var array = self
        let initialResult = try initialResult(array.removeFirst())
        return try array.reduce(into: initialResult) {
            try updateAccumulatingResult(&$0, $1)
        }
    }
}
