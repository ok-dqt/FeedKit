//
//  SampleTests + Mocks.swift
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

struct Sample: Codable, Equatable {
  let header: Header
  let content: Content
  let footer: Footer

  struct Header: Codable, Equatable {
    let title: String
    let description: String
    let version: String
    let keywords: Keywords
    let namespace: Namespace

    init(
      title: String,
      description: String,
      version: String,
      keywords: Keywords,
      namespace: Namespace) {
      self.title = title
      self.description = description
      self.version = version
      self.keywords = keywords
      self.namespace = namespace
    }

    private enum CodingKeys: String, CodingKey {
      case title
      case description
      case version
      case keywords
      case namespace = "xmlns:ns"
    }

    struct Keywords: Codable, Equatable {
      let keyword: [String]
    }

    struct Namespace: Codable, Equatable {
      let title: String
      let description: String
      
      private enum CodingKeys: String, CodingKey {
        case title = "ns:title"
        case description = "ns:description"
      }
    }
  }

  struct Content: Codable, Equatable {
    let item: [Item]

    struct Item: Codable, Equatable {
      let attributes: Attributes
      let name: String
      let description: String
      let precision: Double
      let details: Details
      let xhtml: Xhtml

      private enum CodingKeys: String, CodingKey {
        case attributes = "@attributes"
        case name
        case description
        case precision
        case details
        case xhtml
      }

      init(
        attributes: Attributes,
        name: String,
        description: String,
        precision: Double,
        details: Details,
        xhtml: Xhtml) {
        self.attributes = attributes
        self.name = name
        self.description = description
        self.precision = precision
        self.details = details
        self.xhtml = xhtml
      }

      struct Attributes: Codable, Equatable {
        let id: Int
        let value: String
      }

      struct Details: Codable, Equatable {
        let detail: [String]
      }

      struct Xhtml: Codable, Equatable {
        let attributes: XhtmlAttributes
        let text: String

        init(attributes: XhtmlAttributes, text: String) {
          self.attributes = attributes
          self.text = text
        }

        private enum CodingKeys: String, CodingKey {
          case attributes = "@attributes"
          case text = "@text"
        }

        struct XhtmlAttributes: Codable, Equatable {
          let type: String
        }
      }
    }
  }

  struct Footer: Codable, Equatable {
    let notes: String
    let created: String
    let revision: Int
  }
}

extension SampleTests {
  var mock: Sample {
    .init(
      header: .init(
        title: "Sample Document",
        description: "This is a sample document.",
        version: "1.0",
        keywords: .init(
          keyword: [
            "Generic",
            "Placeholder",
          ]
        ),
        namespace: .init(
          title: "This title is a sample namespace element.",
          description: "This description is a sample namespace element."
        )
      ),
      content: .init(
        item: [
          .init(
            attributes: .init(
              id: 1,
              value: "01"
            ),
            name: "Item 1",
            description: "This is a sample description for Item 1.",
            precision: 1.11,
            details: .init(
              detail: [
                "Detail 1A",
                "Detail 1B",
              ]
            ),
            xhtml: .init(
              attributes: .init(
                type: "xhtml"
              ),
              text: """
              <div xmlns="http://www.w3.org/1999/xhtml"><p><strong>Some markings</strong><a href="http://www.example.org/">Example</a></p><div class="blockquote"><p>On a quote...</p></div></div>
              """
            )
          ),
          .init(
            attributes: .init(
              id: 2,
              value: "02"
            ),
            name: "Item 2",
            description: "This is a sample description for Item 2.",
            precision: 2.22,
            details: .init(
              detail: [
                "Detail 2A",
                "Detail 2B",
              ]
            ),
            xhtml: .init(
              attributes: .init(
                type: "xhtml"
              ),
              text: """
              <div xmlns="http://www.w3.org/1999/xhtml"><p><strong>Some markings</strong><a href="http://www.example.org/">Example</a></p><div class="blockquote"><p>On a quote...</p></div></div>
              """
            )
          ),
        ]
      ),
      footer: .init(
        notes: "These are additional notes for the document.",
        created: "2024-11-16",
        revision: 1
      )
    )
  }
}

extension SampleTests {
  var xmlNodeMock: XMLNode {
    .init(
      namespacePrefixes: [
        "ns": "http://example.ns/namespace",
      ],
      name: "sample",
      children: [
        .init(
          name: "header",
          children: [
            .init(
              name: "title",
              text: "Sample Document",
              children: [
                .init(
                  name: "@attributes",
                  children: [
                    .init(
                      name: "type",
                      text: "text"
                    ),
                  ]
                ),
              ]
            ),
            .init(
              name: "description",
              text: "This is a sample document."
            ),
            .init(
              name: "version",
              text: "1.0"
            ),
            .init(
              name: "keywords",
              children: [
                .init(
                  name: "keyword",
                  text: "Generic"
                ),
                .init(
                  name: "keyword",
                  text: "Placeholder"
                ),
              ]
            ),
            .init(
              name: "xmlns:ns",
              children: [
                .init(
                  name: "ns:title",
                  text: "This title is a sample namespace element."
                ),
                .init(
                  name: "ns:description",
                  text: "This description is a sample namespace element."
                ),
              ]
            ),
          ]
        ),
        .init(
          name: "content",
          children: [
            .init(
              name: "item",
              children: [
                .init(
                  name: "@attributes",
                  children: [
                    .init(
                      name: "id",
                      text: "1"
                    ),
                    .init(
                      name: "value",
                      text: "01"
                    ),
                  ]
                ),
                .init(
                  name: "name",
                  text: "Item 1"
                ),
                .init(
                  name: "description",
                  text: "This is a sample description for Item 1."
                ),
                .init(
                  name: "precision",
                  text: "1.11"
                ),
                .init(
                  name: "details",
                  children: [
                    .init(
                      name: "detail",
                      text: "Detail 1A"
                    ),
                    .init(
                      name: "detail",
                      text: "Detail 1B"
                    ),
                  ]
                ),
                .init(
                  name: "xhtml",
                  text: """
                  <div xmlns="http://www.w3.org/1999/xhtml"><p><strong>Some markings</strong><a href="http://www.example.org/">Example</a></p><div class="blockquote"><p>On a quote...</p></div></div>
                  """,
                  children: [
                    .init(
                      name: "@attributes",
                      children: [
                        .init(
                          name: "type",
                          text: "xhtml"
                        ),
                      ]
                    ),
                  ]
                ),
              ]
            ),
            .init(
              name: "item",
              attributes: [
                "id": "2",
                "value": "02",
              ],
              children: [
                .init(
                  name: "@attributes",
                  children: [
                    .init(
                      name: "id",
                      text: "2"
                    ),
                    .init(
                      name: "value",
                      text: "02"
                    ),
                  ]
                ),
                .init(
                  name: "name",
                  text: "Item 2"
                ),
                .init(
                  name: "description",
                  text: "This is a sample description for Item 2."
                ),
                .init(
                  name: "precision",
                  text: "2.22"
                ),
                .init(
                  name: "details",
                  children: [
                    .init(
                      name: "detail",
                      text: "Detail 2A"
                    ),
                    .init(
                      name: "detail",
                      text: "Detail 2B"
                    ),
                  ]
                ),
                .init(
                  name: "xhtml",
                  text: """
                  <div xmlns="http://www.w3.org/1999/xhtml"><p><strong>Some markings</strong><a href="http://www.example.org/">Example</a></p><div class="blockquote"><p>On a quote...</p></div></div>
                  """,
                  children: [
                    .init(
                      name: "@attributes",
                      children: [
                        .init(
                          name: "type",
                          text: "xhtml"
                        ),
                      ]
                    ),
                  ]
                ),
              ]
            ),
          ]
        ),
        .init(
          name: "footer",
          children: [
            .init(
              name: "notes",
              text: "These are additional notes for the document."
            ),
            .init(
              name: "created",
              text: "2024-11-16"
            ),
            .init(
              name: "revision",
              text: "1"
            ),
          ]
        ),
      ]
    )
  }
}
