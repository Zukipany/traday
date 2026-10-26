// Source code is private. This file shows only its types and signatures.

@_exported import Foundation

public typealias OSStatus = Int32
public typealias CFString = String
public typealias CFTypeRef = AnyObject
public typealias CFDictionary = [String: Any]

public let errSecSuccess: OSStatus
public let errSecItemNotFound: OSStatus
public let kSecClass: CFString
public let kSecClassGenericPassword: CFString
public let kSecAttrService: CFString
public let kSecAttrAccount: CFString
public let kSecReturnData: CFString
public let kSecMatchLimit: CFString
public let kSecMatchLimitOne: CFString
public let kSecValueData: CFString
public let kSecAttrAccessible: CFString
public let kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly: CFString

public func SecItemCopyMatching(_ query: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus { /* private */ }
public func SecItemAdd(_ attributes: CFDictionary, _ result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus { /* private */ }
public func SecItemDelete(_ query: CFDictionary) -> OSStatus { /* private */ }
