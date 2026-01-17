// Sources/KSComponents/KSComponents.swift
@_exported import SwiftUI

// Tokens
public enum KS {
    public enum Colors { }
    public enum Typography { }
    public enum Spacing { }
    public enum Shadows { }
    public enum Radius { }
    public enum Animation { }
}

// Re-export navigation component type aliases
public typealias KSTabBarItem = KSTabBar.TabItem
public typealias KSNavButton = KSNavBar.NavButton
public typealias KSBottomSheetDetent = KSBottomSheet<EmptyView>.Detent
