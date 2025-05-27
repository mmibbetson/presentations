---
title: "What's in a Function Signature?"
author: mmibbetson
---

The Dotted Line
===============

A function signature defines the input and output of a function. It can include:

<!-- incremental_lists: true -->

- Parameters
- Returns
- Types
- Errors
- Access

Most languages meet this definition with some combination of these features; some languages have additional features as well.

Developers might intuitively understand a function signature as “the first line of the function, which defines the contract by which it can be invoked”. This latter understanding is important because the concept of a “contract” implies something about *the role the function signature plays in software design and development.*

<!-- end_slide -->

Jarring Javascript
==================

Let's start with an extremely minimalist function signature:

```javascript
function c(p, n) {}
```

<!-- incremental_lists: true -->

- It's a function
- It has two arguments
- ...
- That's it?

<!-- end_slide -->

```javascript
function changeName(person, name) {}
```

<!-- incremental_lists: true -->

- It's a function
- It has two arguments
- It changes the name of a person (probably)

<!-- end_slide -->

Documentation comments can immensely improve code understanding.

```javascript
/**
 * Changes the name of a person.
 *
 * @param {Object} person - The person whose name will be changed.
 * @param {String} name - The new name to assign to the person.
 * @throws {TypeError} if the input types are invalid.
 * @throws {Error} if the name is empty.
 */
function changeName(person, name) {}
```

<!-- incremental_lists: true -->

- It's a function
- It has two arguments, an `Object` and a `String`
- It can throw errors, specifically a `TypeError` or `Error`
- It changes the name of a person

But how rigidly enforced are the new parts of the contract?

<!-- end_slide -->

Typical Typescript
==================

What are the differences between these two signatures?

```typescript
/**
 * Changes the name of a person.
 *
 * @throws {TypeError} if the input types are invalid.
 * @throws {Error} if the name is empty.
 */
function changeName(person: Person, name: String) {}
```

<!-- alignment: center -->
**vs.**

```typescript
/**
 * Changes the name of a person.
 *
 * @throws {TypeError} if the input types are invalid.
 * @throws {Error} if the name is empty.
 */
export function changeName(person: Person, name: String): Person {}
```

<!-- end_slide -->

Seeing Sharply
==============

This stuff can be done in C# as well!

```csharp
/**
 * <summary>
 * Blah blah
 *
 * <param name="app"></param>
 * </summary>
 */ 
internal static IEndpointRouteBuilder RegisterUserEndpoints(this IEndpointRouteBuilder app) {}
```

<!-- end_slide -->

Rigorous Rust
=============

Talk about rust stuff here.

````rust
/// Determines a delivery route for a set of packages considering
/// distance, time constraints, and delivery priorities.
///
/// # Examples
///
/// ```
/// let test_package = Package {
///     Sku: 123,
///     Name: "Test Package",
///     Weight: 12.as_g()
/// };
/// let packages = vec![Package::new()];
/// let options = DeliveryOptions::default()
///     .with_algorithm(Algorithm::DistanceFirst);
/// let route = get_delivery_route(&packages, &options)?;
///
/// assert!(route.total_distance() < 100.0);
/// ```
///
/// # Errors
///
/// Returns `RouteError::InvalidPackageData` if any package is
/// missing required coordinates or timeframes.
///
/// Returns `RouteError::NoViableRoute` if no viable route can
/// be calculated with the given constraints.
pub fn get_delivery_route(
    packages: &[Package],
    options: &DeliveryOptions
) -> Result<Route, RouteError> {}
````

<!-- end_slide -->

<!-- jump_to_middle -->

This is a BIG deal!
===================

<!-- end_slide -->

Summary
=======

We benefit from having more information in our function signatures. We benefit doubly when we can leverage our code contracts to keep our domain, documentation, and implementation in tight synchronisation.

<!-- incremental_lists: true -->

1. Meaningful Names
2. Types
3. Errors
4. Documentation Comments
5. Memory Information
6. Possible Performance Characteristics
7. General Side-Effects

<!-- end_slide -->

Where To?
=========

Here are a few resources for you to consider based on your needs:

## Javascript

- JSDoc

## Typescript

- TSDoc (msft)
- Strict compiler mode with errors for cheating

## C#

- C# is strongly typed, but we need to leverage do comments more
- C# does in fact have doc gen that nobody uses

## Python

- Type hinting with a linter like Ruff
- Doc gen?

## Rust

- Rust's function signatures are inherently information-dense
- Cargo has built-in tooling for generating documentation from source code

## Go

Conclusion
==========

Function signatures and documentation comments are contracts that tell both program and programmer how to interact with a piece of code. They can help reduce runtime errors, communicate design intent, raise awareness of possible code paths, and even integrate with tools to produce actual, factual documentation.

Next time you implement a module of code, pay some mind to how much information you can pack into your function signatures - maybe you'll realise you've been making assumptions you weren't aware of.
