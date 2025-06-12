---
title: What's in a Function Signature?
sub_title: The Power of Code Contracts
author: mmibbetson
---

Code Contracts
==============

**Code Contracts** tell programs and programmers how different parts of the codebase can and should interact. They create rules for how the parts of our systems can come together to form a greater whole.

<!-- newlines: 2 -->

Code contracts are present in many forms in our code bases, but the primary ones are:

<!-- incremental_lists: true -->

1. Function Signatures
2. Data Types

<!-- newlines: 2 -->

We will be focusing almost entirely on the first of these.

<!-- end_slide -->

The Dotted Line
===============

A function signature defines the input and output of a function. It can include:

<!-- incremental_lists: true -->

- Parameters
- Returns
- Types
- Errors
- Access

<!-- newlines: 2 -->

Most languages meet this definition with some combination of these features; some languages have additional features as well.

<!-- end_slide -->

Jarring Javascript
==================

Let's start with an extremely minimalist function signature:

<!-- newlines: 2 -->

```javascript
function c(p, n) {}
```

<!-- newlines: 2 -->

What do we know about this function from its signature?

<!-- incremental_lists: true -->

- It's a function
- It has two arguments
- ...
- That's it?

<!-- end_slide -->

Okay, let's get a little bit more descriptive:

<!-- newlines: 2 -->

```javascript
function changeName(person, name) {}
```

<!-- newlines: 2 -->

What do we know about this function from its signature?

<!-- incremental_lists: true -->

- It's a function
- It has two arguments
- It changes the name of a person (probably)

<!-- end_slide -->

Documentation comments can immensely improve code understanding.

<!-- newlines: 2 -->

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

<!-- newlines: 2 -->

What do we know about this function from its signature?

<!-- incremental_lists: true -->

- It's a function
- It has two arguments, an `Object` and a `String`
- It can throw errors, specifically a `TypeError` or `Error`
- It changes the name of a person

<!-- newlines: 2 -->

But how rigidly enforced is our code contract?

<!-- end_slide -->

The Fine Print
==============

We want our contracts to be:

<!-- incremental_lists: true -->

- Explicit
- Exhaustive
- Enforcible

<!-- newlines: 2 -->

Documentation comments are explicit to the programmer, but not to the program.
They are only as exhaustive as the author.
They are not enforcible unless you have the right tools.

<!-- newlines: 2 -->

Generally, we want to _move the details out of the fine print and into the bold print_, i.e. we want to make as much of our contract verifiable by the tooling we have, or the language itself.

<!-- end_slide -->

Typical Typescript
==================

For starters, we can move type information into a gradual or static type system with run time or compile time type checking. In Javascript, this usually means adopting Typescript:

<!-- newlines: 2 -->

```typescript
/**
 * Changes the name of a person.
 *
 * @throws {TypeError} if the input types are invalid.
 * @throws {Error} if the name is empty.
 */
function changeName(person: Person, name: String) {}
```

<!-- newlines: 2 -->

What do we know about this function from its signature?

<!-- incremental_lists: true -->

- It's a function
- It has two arguments, an `Person` and a `String`
- It can throw errors, specifically a `TypeError` or `Error`
- It changes the name of a person

We "knew" these things before, but now our guarantees are much stronger (although you can fudge Typescript types, it can be configured to be very strict on its enforcement of typing).

<!-- newlines: 2 -->

> Note: Dynamic typing is useful and underrated, and static types are not the only means of enforcing contracts.

<!-- end_slide -->

Surfacing New Information
=========================

Can you spot the difference between these two signatures?

<!-- newlines: 2 -->

```typescript
/**
 * Changes the name of a person.
 *
 * @throws {TypeError} if the input types are invalid.
 * @throws {Error} if the name is empty.
 */
function changeName(person: Person, name: String) {}
```

<!-- newlines: 2 -->

<!-- alignment: center -->

**vs.**

<!-- newlines: 2 -->

```typescript
/**
 * Changes the name of a person.
 *
 * @throws {TypeError} if the input types are invalid.
 * @throws {Error} if the name is empty.
 */
export function changeName(person: Person, name: String): Person {}
```

<!-- newlines: 2 -->

There are various tools in our languages to communicate intent through our code contracts. Often, we are oblivious to how much can be said when we're not made aware of our options.

<!-- end_slide -->

Seeing Sharply
==============

C# has built-in support for code documentation and document generation from source code. It helps that it's a statically typed, compiled language as well.

<!-- newlines: 2 -->

```csharp
/// <summary>
/// Extension method to register the endpoints related to the <c>User</c> feature.
/// Can be chained with other registration extension methods.
/// </summary>
/// <param name="app">The route builder onto which the endpoints will be registered.</param>
/// <returns>The same <see cref="IEndpointRouteBuilder"/> instance for method chaining.</returns>
/// <exception cref="InvalidOperationException">
/// Thrown when an invalid endpoint registration method is used.
/// </exception> 
internal static IEndpointRouteBuilder RegisterUserEndpoints(this IEndpointRouteBuilder app) {}
```

<!-- end_slide -->

Rigorous Rust
=============

Beyond the scope of this talk, Rust allows you to get runnable tests, memory information, thread-safety information, and exhaustive error types, and more into your function signatures.

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
pub(crate) fn get_delivery_route(
    packages: &[Package],
    options: &DeliveryOptions
) -> Result<Route, RouteError> {}
````

<!-- end_slide -->

<!-- jump_to_middle -->

Programming is about _language_
===============================

<!-- end_slide -->

Summary
=======

We benefit from having more information in our function signatures. We benefit doubly when we can leverage our code contracts to keep our domain, documentation, and implementation in accord. We can use function signatures to communicate the following:

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

Tooling goes far beyond type checking and documentation; we should always be leveraging linters, formatters, and other static analysis tools as well, but code contracts help reduce errors, communicate design intent, raise awareness of possible code paths, and integrate with our tools to produce actual, factual documentation.

<!-- alignment: right -->

<!-- newlines: 2 -->

Our day-to-day tools support this:

- Javascript with [JSDoc](https://jsdoc.app/)
- Typescript with [TSDoc](https://tsdoc.org/)
- C# with [Docfx](https://dotnet.github.io/docfx/)
- Python with [pdoc](https://pdoc.dev/)

<!-- alignment: left -->

<!-- newlines: 2 -->

Next time you implement a module of code, pay some mind to how much information you can pack into your function signatures - maybe you'll realise you've been making assumptions you weren't aware of.

**Explicit, exhaustive, enforcible code contracts** are the bedrock of a good codebase.
