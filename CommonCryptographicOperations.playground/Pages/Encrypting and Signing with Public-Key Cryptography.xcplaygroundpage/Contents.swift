/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Shows how to use public-key cryptography.
*/

/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Encrypting and Signing with Public-Key Cryptography
 
 Consider a case where a sender wants to send a signed, encrypted message to a receiver,
 but sender and receiver don’t share a symmetric key. The receiver knows the signing key of
 the sender and the sender knows the encryption key of the receiver.
 */
import CryptoKit
import Foundation

// Create a salt for key derivation.
let protocolSalt = "CryptoKit Playgrounds Putting It Together".data(using: .utf8)!

/// Generates an ephemeral key agreement key and performs key agreement to get the shared secret and derive the symmetric encryption key.
func encrypt(_ data: Data, to theirEncryptionKey: Curve25519.KeyAgreement.PublicKey, signedBy ourSigningKey: Curve25519.Signing.PrivateKey) throws ->
    (ephmeralPublicKeyData: Data, ciphertext: Data, signature: Data) {
        let ephemeralKey = Curve25519.KeyAgreement.PrivateKey()
        let ephemeralPublicKey = ephemeralKey.publicKey.rawRepresentation
        
        let sharedSecret = try ephemeralKey.sharedSecretFromKeyAgreement(with: theirEncryptionKey)
        
        let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                                salt: protocolSalt,
                                                                sharedInfo: ephemeralPublicKey +
                                                                    theirEncryptionKey.rawRepresentation +
                                                                    ourSigningKey.publicKey.rawRepresentation,
                                                                outputByteCount: 32)
        
        let ciphertext = try ChaChaPoly.seal(data, using: symmetricKey).combined
        let signature = try ourSigningKey.signature(for: ciphertext + ephemeralPublicKey + theirEncryptionKey.rawRepresentation)
        
        return (ephemeralPublicKey, ciphertext, signature)
}

enum DecryptionErrors: Error {
    case authenticationError
}

/// Generates an ephemeral key agreement key and the performs key agreement to get the shared secret and derive the symmetric encryption key.
func decrypt(_ sealedMessage: (ephmeralPublicKeyData: Data, ciphertext: Data, signature: Data),
             using ourKeyEncryptionKey: Curve25519.KeyAgreement.PrivateKey,
             from theirSigningKey: Curve25519.Signing.PublicKey) throws -> Data {
    let data = sealedMessage.ciphertext + sealedMessage.ephmeralPublicKeyData + ourKeyEncryptionKey.publicKey.rawRepresentation
    guard theirSigningKey.isValidSignature(sealedMessage.signature, for: data) else {
        throw DecryptionErrors.authenticationError
    }
    
    let ephemeralKey = try Curve25519.KeyAgreement.PublicKey(rawRepresentation: sealedMessage.ephmeralPublicKeyData)
    let sharedSecret = try ourKeyEncryptionKey.sharedSecretFromKeyAgreement(with: ephemeralKey)
    
    let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self,
                                                            salt: protocolSalt,
                                                            sharedInfo: ephemeralKey.rawRepresentation +
                                                                ourKeyEncryptionKey.publicKey.rawRepresentation +
                                                                theirSigningKey.rawRepresentation,
                                                            outputByteCount: 32)
    
    let sealedBox = try! ChaChaPoly.SealedBox(combined: sealedMessage.ciphertext)
    
    return try ChaChaPoly.open(sealedBox, using: symmetricKey)
}
/*:
 Create a message to send.
 */
let message = "I'm building a terrific new app!".data(using: .utf8)!
/*:
 Create the sender's signing key.
 */
let senderSigningKey = Curve25519.Signing.PrivateKey()
let senderSigningPublicKey = senderSigningKey.publicKey
/*:
 Create the receiver's encryption key.
 */
let receiverEncryptionKey = Curve25519.KeyAgreement.PrivateKey()
let receiverEncryptionPublicKey = receiverEncryptionKey.publicKey
/*:
 The sender encrypts the message using the receiver’s public encryption key, and signs with the sender’s private signing key.
 */
let sealedMessage = try! encrypt(message, to: receiverEncryptionPublicKey, signedBy: senderSigningKey)
/*:
 The receiver decrypts the message with the private encryption key, and verifies the signature with the sender’s public signing key.
 */
let decryptedMessage = try? decrypt(sealedMessage, using: receiverEncryptionKey, from: senderSigningPublicKey)
print("The following message was successfully decrypted: \(String(data: decryptedMessage!, encoding: .utf8)!)")
//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
