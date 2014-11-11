//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2015 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public enum Process {
  /// The list of command-line arguments with which the current
  /// process was invoked.
  public static let arguments: [String] = {
    // Use lazy initialization of static properties to safely initialize the
    // public 'arguments' property on first use.
    map(0..<Int(C_ARGC)) { i in 
      String.fromCStringRepairingIllFormedUTF8(C_ARGV[i]).0 ?? ""
    }
  }()
}

/// Intrinsic entry point invoked on entry to a standalone program's "main".
@transparent
public // COMPILER_INTRINSIC
func _didEnterMain(
  argc: Int32, argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>>
) {
  // Initialize the C_ARGC and C_ARGV variables with the values that were
  // passed in to main.
  C_ARGC = CInt(argc)
  C_ARGV = UnsafeMutablePointer(argv)
}
