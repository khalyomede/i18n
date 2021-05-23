# i18n

Translation and pluralization functions for V.

## Summary

- [About](#about)
- [Features](#features)
- [Installation](#installation)
- [Examples](#examples)
- [Advices](#advices)
- [Test](#test)

## About

I created this package to be able to translate texts.

## Features

- Can define translations for differents languages
- Supports pluralizing texts

## Installation

```bash
v install khalyomede.i18n
```

## Examples

- [1. Translate a text](#1-translate-a-text)
- [2. Translate a text in a specific lang](#2-translate-a-text-in-a-specific-lang)
- [3. Use placeholders in translated texts](#3-use-placeholders-in-translated-texts)
- [4. Define pluralized texts](#4-define-pluralized-texts)
- [5. Translate a pluralized text in a specific lang](#5-translate-a-pluralized-text-in-a-specific-lang)

### 1. Translate a text

In this example, we will translate a simple text in French.

```v
import khalyomede.i18n.src.i18n { Translations }

fn main() {
  translations := Translations{
    default_lang: "fr",
    translations: {
      "Hello world": {
        "en": "Hello world",
        "fr": "Bonjour le monde",
        "es": "Hola mundo"
      }
    }
  }

  assert translation.get("Hello world", map{}) == "Bonjour le monde"
}
```

As you can see, it uses the "default_lang" by default to know which lang to find.

### 2. Translate a text in a specific lang

In this example, we will overpass the default_lang configuration, and print a text in a given lang.

```v
import khalyomede.i18n.src.i18n { Translations }

fn main() {
  translations := Translations{
    default_lang: "en",
    translations: {
      "Hello world": {
        "en": "Hello world",
        "fr": "Bonjour le monde",
        "es": "Hola mundo",
      }
    }
  }

  assert translations.get_lang("Hello world", "es", map{}) == "Hello mundo"
}
```

### 3. Use placeholders in translated texts

In this example, we will use a special syntax to define fillable spots in our translated texts.

```v
import khalyomede.i18n.src.i18n { Translations }

fn main() {
  translations := Translations{
    default_lang: "en",
    translations: {
      "Hello, :name!": {
        "en": "Hello, :name!",
        "fr": "Bonjour, :name!",
        "es": "Hola, :name!"
      }
    }
  }

  assert translations.get("Hello, :name!", { "name": "John" }) == "Hello, John!"
}
```

### 4. Define pluralized texts

In this example, we will define texts that have differents translations depending the number of items.

```v
import khalyomede.i18n.src.i18n { Translations }

fn main() {
  translations := Translations{
    default_lang: "en",
    translations: {
      "You have :count messages": {
        "en": "{0,1} You have :count message | You have :count messages",
        "fr": "{0,1} Vous avez :count message | Vous avez :count messages",
        "es": "{0,1} Tiene :count mensaje | Tiene :count mensajes",
      }
    }
  }

  assert translations.get_choice("You have :count messages", 14, map{}) == "You have 14 messages"
}
```

You are free to define how many variants you which:

```v
"{0,1} You have :count message | {2,9} You have :count messages | You have some messages"
```

Or you can even use a single digit:

```v
"{0} You have no message | {1} You have :count message | You have :count messages"
```

And even define an infinite max range:

```v
"{0} You have no message | {1,*} You have some messages"
```

### 5. Translate a pluralized text in a specific lang

In this example, we will overpass the default_lang configuration to return a pluralized text in a given lang.

```v
import khalyomede.i18n.src.i18n

fn main() {
  translations := Translations{
    default_lang: "en",
    translations: {
      "You have :count messages": {
        "en": "{0,1} You have :count message | You have :count messages",
        "fr": "{0,1} Vous avez :count message | Vous avez :count messages",
        "es": "{0,1} Tiene :count mensaje | Tiene :count mensajes",
      }
    }
  }

  assert translations.get_choice_lang("You have :count messages", 3, "fr", map{}) == "Vous avez 3 messages"
}
```

## Advices

- Make sure your translation keys are capable of delivering a meaningful translation. In fact, this will help if an error happens and the library cannot find the correct translation, to still offer a human readable translation to display. Avoid keys like "home_index_title" and so on.
- Always put a default choice using either "| My default translation" or using the star count "| {2,*} My default translation" for pluralized translation. This will help using it as a default when the count do not matches.
- If you think you can have negative values in the count for pluralized translations, you can use negative values: `"{-1,1} You have a mark of :count point | You have a mark of :count points"`.
- You noticed that in the [examples](#examples) above we use the same text for both the key and the "en" translation. I advice you to keep it like this, so that one day if you don't want to change all the keys, but just the translation text, you can do it (avoid to rely on the key fallback as much as possible).

## Test

```bash
v test src/test
```
