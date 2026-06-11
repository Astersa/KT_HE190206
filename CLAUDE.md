# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run the app
flutter run

# Run on a specific device
flutter run -d windows
flutter run -d chrome

# Build
flutter build apk
flutter build windows

# Analyze / lint
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart
```

## Architecture

This is a Flutter e-commerce demo app with a 3-tab bottom navigation (`MainScreen`).

### Data flow
- `ProductDAO` holds an in-memory list of `Product` objects (no external DB or network calls).
- `MainScreen` owns `_selectedProduct` state. When the user taps a product in `HomeTab`, `onProductSelected(Product)` is called — this updates state and switches to tab index 1 (Product Detail).
- Tab switching is done via `IndexedStack`; there is no `Navigator.push` between tabs.

### Key files
| File | Role |
|------|------|
| `lib/main.dart` | Entry point, `MaterialApp` setup |
| `lib/main_screen.dart` | Shell: AppBar, `BottomNavigationBar`, `IndexedStack`, owns selected-product state |
| `lib/home_tab.dart` | Search bar + responsive product grid/list; calls `onProductSelected` callback |
| `lib/product_card.dart` | Card widget used in both grid (vertical) and list (horizontal) layouts; discount tag is a `Stack`/`Positioned` overlay on the image |
| `lib/product_detail_screen.dart` | Product detail content; `showAsScreen: false` skips the inner `Scaffold` (used when rendered inside `IndexedStack`) |
| `lib/product.dart` | `Product` model; `discountedPrice` is a computed getter |
| `lib/product_dao.dart` | In-memory data source; `getAllProduct()` and `findProductByName()` |

### Layout behavior
- `HomeTab` uses `OrientationBuilder` + `LayoutBuilder` to switch between `ListView` (1 column, portrait narrow) and `GridView` (2–3 columns).
- `ProductCard` renders horizontally (`horizontal: true`) in list mode and vertically in grid mode.
- `ProductDetailScreen` with `showAsScreen: true` (default) wraps content in a `Scaffold` with AppBar — intended for direct `Navigator.push` use if needed in the future.

### Naming quirk
`Product.discontPercen` (typo for "discountPercent") is the discount percentage field — do not rename without updating all references.
