module test

import i18n { Translations }

fn test_get_translation() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"Hello world": {
				"en": "Hello world",
				"fr": "Bonjour le monde",
			}
		}
	}

	assert translations.get("Hello world", { "": "" }) == "Hello world"
}

fn test_get_returns_french_translations_when_default_lang_is_french() {
	translations := Translations{
		default_lang: "fr",
		translations: {
			"Hello world": {
				"en": "Hello world",
				"fr": "Bonjour le monde"
			}
		}
	}

	assert translations.get("Hello world", { "": "" }) == "Bonjour le monde"
}

fn test_fallbacks_to_key_when_translation_in_default_lang_not_found() {
	translations := Translations{
		default_lang: "fr",
		translations: {
			"Hello world": {
				"en": "Hello world",
			}
		}
	}

	assert translations.get("Hello world", { "": "" }) == "Hello world"
}

fn test_get_with_placeholders() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"Welcome, :name!": {
				"en": "Welcome, :name!"
			}
		}
	}

	assert translations.get("Welcome, :name!", {"name": "John"}) == "Welcome, John!"
}

fn test_get_can_change_lang_in_middle_of_program() {
	mut translations := Translations{
		default_lang: "en",
		translations: {
			"Welcome, :name!": {
				"en": "Welcome, :name!",
				"fr": "Bienvenue, :name!"
			}
		}
	}

	assert translations.get("Welcome, :name!", { "name": "John" }) == "Welcome, John!"

	translations.default_lang = "fr"

	assert translations.get("Welcome, :name!", { "name": "John" }) == "Bienvenue, John!"
}
