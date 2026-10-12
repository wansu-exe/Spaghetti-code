# Atomic Design Refactor: Justification Write-up

**Folder structure**

```
lib/
├── main.dart                      (app shell: MaterialApp -> CatalogPage)
├── models/product.dart            (Product model + category constants)
├── logic/product_validators.dart  (pure validation rules, no Flutter)
└── ui/
    ├── atoms/        11 files
    ├── molecules/     8 files
    ├── organisms/     4 files
    ├── templates/     1 file
    └── pages/         1 file
```

## Responsibility inventory (Task 1) and level assignment (Task 2)

Heading text, app-bar title, icon tile, name/category/price text, filled button, delete icon, search input, form text input, dropdown input -> Atoms.
Search heading+input, name/category/price stack, cart+delete buttons, each form field with its spacing -> Molecules.
App bar, product card, catalog list, add-product form -> Organisms.
Scaffold + scroll + slot layout -> Template.
Product list, search query, id counter, add/delete -> Page.

## Atoms (StatelessWidget, no logic, no state; they only render what they are given)

**SectionTitle**: Atom. A single `Text` with the 20px bold black87 style used for "Search Products", "Catalog" and "Add New Product". It is one indivisible element with no children widgets of its own, takes only a string, and holds no state or logic, which is the definition of an atom. It replaces three copy-pasted inline `Text` styles.

**AppBarTitle**: Atom. One white, bold `Text` for the app-bar title. It is a single primitive element with a fixed style, takes a string, and has no behaviour. It is separate from SectionTitle because its colour and role (on the indigo bar) differ.

**ProductIconBadge**: Atom. A 56x56 rounded tinted box around one `Icon`. Although it is a Container plus an Icon, the pair is a single visual primitive (an icon tile) that cannot be broken into anything meaningful on its own, and it takes only an `IconData`. It has no state or logic.

**ProductNameText**: Atom. A single `Text` styled 16px semi-bold for a product's name. One element, one style, no logic.

**ProductCategoryText**: Atom. A single 13px grey `Text` for the category label. Same reasoning: one primitive, parameterised only by its string.

**ProductPriceText**: Atom. A single bold indigo `Text`. It receives the price and formats it as `PHP 0.00`. That is presentation only (no calculation, no data access), so it is still a pure render element and stays stateless.

**PrimaryButton**: Atom. The indigo/white `ElevatedButton` used by both "Add to Cart" and "Submit Product". It accepts a `child`, an `onPressed` callback and optional padding, and contains no logic: pressing it simply calls whatever the parent passed. It removes the duplicated `styleFrom` block.

**DeleteIconButton**: Atom. A red `delete_outline` `IconButton`. It has one element and one callback. The decision to delete is made elsewhere; the atom only renders and forwards the tap.

**SearchTextField**: Atom. A plain `TextField` with a hint and an `onChanged` callback. It is a single input primitive and holds no state itself (the original field was also uncontrolled), so it stays stateless.

**AppTextFormField**: Atom. A reusable `TextFormField` configured via label, controller, validator, keyboard type, max lines and label alignment. It serves the name, price and description inputs. It does not contain validation rules; the validator is passed in, so the atom stays logic-free.

**AppDropdownFormField**: Atom. A `DropdownButtonFormField<String>` that receives its items, current value and `onChanged` from outside. It is the dropdown equivalent of AppTextFormField: a single input primitive with no state or rules of its own.

## Molecules (small groups of atoms acting as one unit; no business logic or data fetching)

**SearchBox**: Molecule. It combines two atoms (SectionTitle and SearchTextField) plus spacing into one "labelled search input" unit. It is a simple group with a single purpose, holds no state, and forwards `onChanged` upward.

**ProductInfo**: Molecule. It stacks ProductNameText, ProductCategoryText and ProductPriceText (with 4px gaps) into the text block of a product. It is purely a composition of atoms with no behaviour. It is too big to be an atom and too small and self-contained to be a section of the UI (organism).

**ProductActions**: Molecule. It groups PrimaryButton ("Add to Cart") and DeleteIconButton in a column. It takes two callbacks and contains no logic of its own, so it is a molecule: a small set of atoms with one shared job (the row's actions).

**ProductNameField**, **ProductPriceField**, **ProductCategoryField**, **ProductDescriptionField**: Molecules. Each wraps an input atom (AppTextFormField or AppDropdownFormField) together with the form's field-to-field gap, and fixes the domain-specific configuration (label text, numeric keyboard for price, three lines and aligned label for description, the dropdown's label). This lets the form organism read as four named fields instead of raw `TextFormField`s. The validators and the category list come in as parameters, so the molecules contain no validation rules or data.

## Organisms (distinct UI sections; may hold local logic but not own core data)

**CatalogAppBar**: Organism. A `PreferredSizeWidget` that builds the app's top bar from the AppBarTitle atom and the brand colour. It is a self-contained, standalone section of the screen rather than a group of related atoms. It has no state or data.

**ProductCard**: Organism. It assembles ProductIconBadge, ProductInfo and ProductActions inside the bordered, shadowed card container. It is a complete, distinct section of the interface that is repeated per item. It receives a `Product` and an `onDelete` callback, so it does not own the data. Showing the "Added X to cart" SnackBar is purely local UI behaviour, which organisms are allowed to contain, so that logic lives here and not in the Page.

**ProductCatalog**: Organism. It renders the "Catalog" heading and one ProductCard per product it is given. It is a self-contained section built from a molecule-level heading and repeated organisms. It receives the (already filtered) list and a delete callback, but owns neither the list nor the filter.

**AddProductForm**: Organism. This is the decision the activity asks for in Task 4. It owns the *form* state only (the `Form` key, text controllers, selected category), runs validation through `ProductValidators`, resets the fields, and shows the green confirmation SnackBar. These are local logic and local UI feedback, which the rules allow organisms to hold. It does **not** own the product list: on a valid submit it calls `onSubmit(name, price, category, description)`, and the Page decides how to store the product. This keeps the split as follows: validation rules -> `logic/product_validators.dart`; form state + feedback -> organism; real data mutation (add to list, increment id, clear search filter) -> Page.

## Template

**CatalogTemplate**: Template. It defines the screen's layout (Scaffold, scroll view, padding, vertical order, spacing and divider) with four named slots: `appBar`, `search`, `catalog` and `form`. It receives only `Widget`s and imports neither the `Product` model nor any data class. It decides *where* things go, never *what* goes there, so it meets the template rule.

## Page

**CatalogPage**: Page. It is the only widget that holds the real product list, the search query and the next-id counter. It filters products for the search, implements add and delete, and wires everything downward through the template. It is built from the template and organisms/molecules, not raw atoms, so no level is skipped.

## Supporting (non-UI) files

**models/product.dart**: A typed `Product` class replaces the original `Map<String, dynamic>`, plus the category constants. **logic/product_validators.dart**: the original name and price validators moved verbatim into pure functions, so the rules (same messages, same order of checks) are removed from the widget tree and are unit-testable.

## Behaviour preserved

Same seed data and ids (next id 8); case-insensitive "contains" search; same validation messages; on submit the product is appended with the `inventory_2` icon, the search filter is reset to empty, fields are cleared, category state resets to Electronics, and the green "`<name>` added to catalog!" SnackBar appears; "Add to Cart" shows "Added `<name>` to cart"; delete removes by id; same styling values everywhere.

Two original quirks are deliberately **kept** because the activity requires identical behaviour:
1. After a successful submit, the search *text* remains visible in the search box even though the filter is reset (the search field is uncontrolled in the original).
2. After a successful submit, the category state resets to Electronics but the dropdown still *displays* the previously selected value (`DropdownButtonFormField.initialValue` is only read on first build). Submitting again without touching the dropdown would therefore add "Electronics" while the dropdown still shows the old choice. This looks like a latent bug in the starter; a one-line fix would be to give the dropdown a `ValueKey(_selectedCategory)`, but I left it alone to keep parity with the baseline.

## Where I was unsure how to classify

1. **The four field molecules** (e.g. ProductNameField). Each is a thin wrapper around one input atom plus spacing, so it is arguable they should be atoms (configuration of an atom) or should not exist at all (the organism could use AppTextFormField directly). I made them molecules because they bundle an input with its form-specific config and layout gap, and because the rubric asks for each field to be a reusable atom/molecule. The honest weakness: the "group of atoms" is one atom plus a `SizedBox`.
2. **ProductPriceText formatting `PHP 0.00`.** Formatting a number could be seen as logic. I kept it in the atom because it is pure presentation (no data access, no decisions), but a stricter reading would pass a preformatted string.
3. **ProductIconBadge** is a Container + Icon, which could be read as a molecule. I treated it as one atom because the two parts only make sense together as a single icon tile.
4. **Validators in organism vs molecule.** Validation is not "business logic" in the strict sense, but putting it in molecules would risk breaking the "molecules have no business logic" rule, so the rules live in `logic/` and are injected by the organism.
5. **Add-to-cart SnackBar in ProductCard.** It could be wired through the Page, but it touches no app data, so I kept it as local organism logic.
6. **CatalogAppBar** as an organism: it is small, but it is a standalone section rather than a group inside another component.
