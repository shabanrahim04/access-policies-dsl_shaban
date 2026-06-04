# Access Policies DSL (Xtext)

A domain-specific language (DSL) for defining **role-based access control (RBAC)** policies, built using **Eclipse Xtext** and **Xtend**, and compiled into executable Java authorization logic.

This project demonstrates how formal language design can be used to replace fragile, hard-coded security logic with a structured, declarative policy language.

---

## Overview

In traditional systems, access control logic is embedded directly into application code, leading to:

* Poor maintainability
* Hidden security rules
* High risk of inconsistency
* Difficult auditability

This DSL solves these problems by introducing a **declarative policy language** that separates security rules from application logic. You define policies in a `.rbac` file, and the system compiles them into a Java class that evaluates access decisions at runtime.

---

## Project Structure & Organization

This project follows a dual-structure: the **Eclipse/Xtext standard structure** (required for the framework) and a **Task-based logical organization** used during development.

### Logical Layout (Development Tasks)

```text
access-policies-dsl_shaban/
│
├── Task 1 - Grammar/              -> maps to: gse.xtext.assignment/src/.../AccessPolicies.xtext
├── Task 2 - Logic/                -> maps to: gse.xtext.assignment/src/.../generator/AccessPoliciesGenerator.xtend
├── Task 3 - Validation/           -> maps to: gse.xtext.assignment/src/.../validation/AccessPoliciesValidator.xtend
├── Task 4 - Examples/             -> maps to: example/example.rbac
└── Task 5 - Generated Output/     -> maps to: gse.xtext.assignment/src-gen/SecurityEvaluator.java

```

### Eclipse/Xtext Standard Structure

```text
gse.xtext.assignment/
├── src/
│   └── gse/xtext/assignment/
│       ├── AccessPolicies.xtext       # Grammar Definition
│       ├── generator/                 # Xtend Code Generator
│       └── validation/                # Semantic Validator
└── src-gen/                           # Auto-generated code & final SecurityEvaluator.java

```

---

## Language Syntax & Concepts

The DSL models four fundamental concepts: **Actors**, **Assets**, **Operations**, and **Policies**. It supports actor inheritance, scoped rules, and strong cross-referencing (e.g., `[Actor]`, `[Asset]`) to ensure IDE-level type safety.

### Example Definition

```rbac
actor Admin
actor User inherits Admin

asset File
operation Read

policy AccessControl {
    scope Admin {
        allow Read on File
    }
}

```

---

## Build Requirements

* **JDK:** Java 17+
* **IDE:** Eclipse IDE (Latest recommended)
* **Required Plugins:** Xtext SDK and Xtend support (available via Eclipse Marketplace)

---

## How to Run

1. **Import:** Import the project into Eclipse as an existing workspace project.
2. **Setup:** Ensure Xtext dependencies are resolved.
3. **Workflow:** Right-click the `.mwe2` file in the project and select **Run As -> MWE2 Workflow**.
4. **Compile:** Create or edit your `.rbac` files in the `example` folder.
5. **Output:** The generator will automatically produce `SecurityEvaluator.java` inside the `src-gen` directory of your project.

---

## Design Highlights

1. **Declarative Security Model:** Security rules are expressed as readable policy definitions.
2. **Meta-Model Integration:** Uses Xtext cross-referencing to provide IDE features like auto-completion and broken-reference detection.
3. **Dispatch-based Generation:** Employs Xtend's `dispatch` polymorphism for modular code generation.
4. **Deterministic Evaluation:** Policies compile into a high-performance `isAllowed` method with safe, default-deny fallbacks.

---

## Limitations (Assignment Scope)

* **Deny rules:** Currently ignored in the generated `isAllowed` logic (allow-only priority).
* **Policy Lifecycle:** Supports compile-time generation only (no dynamic runtime reloading).

---

## License

Academic / Educational Use Only.

---

## Author

Generated as part of an Xtext DSL engineering assignment focused on language design, model-driven development, and code generation principles.
