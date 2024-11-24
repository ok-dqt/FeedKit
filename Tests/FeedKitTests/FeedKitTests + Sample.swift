//
//  FeedKitTests + XML.swift
//
//  Copyright (c) 2016 - 2024 Nuno Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

@testable import FeedKit

import Testing

extension FeedKitTests {
  @Test
  func xmlParser() {
    // Given
    let data = data(resource: "Sample", withExtension: "xml")
    let parser = XMLParser(data: data)
    let expected = Sample.xmlElementMock

    // When
    let actual = try? parser.parse().get().root

    // Then
    #expect(expected == actual)
  }

  @Test
  func xmlString() {
    // Given
    let data = data(resource: "Sample", withExtension: "xml")
    let expected = String(decoding: data, as: Unicode.UTF8.self)
    let document = XMLDocument(root: Sample.xmlElementMock)

    // When
    let actual = document.toXMLString(formatted: true)

    saveToDocuments(expected: expected, actual: actual)
    // Then
    #expect(expected == actual)
  }

  @Test
  func xmlDecoder() {
    // Given
    let decoder = XMLDecoder()
    let element = Sample.xmlElementMock
    let expected = Sample.mock

    // When
    let actual = try! decoder.decode(Sample.self, from: element)

    print(actual as Any)
    // Then
    #expect(expected == actual)
  }

  @Test
  func xmlEncoder() {
    // Given
    let encoder = XMLEncoder()
    let expected = Sample.xmlElementMock

    // When
    let actual = try! encoder.encode(value: Sample.mock)

    saveToDocuments(expected: expected.toXMLString(formatted: true), actual: actual.toXMLString(formatted: true))
    
    #expect(expected == actual)
  }
}
