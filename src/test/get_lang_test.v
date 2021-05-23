module test

import i18n { Translations }

fn test_get_lang_returns_correct_french_translation() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"Hello world": {
				"en": "Hello world",
				"fr": "Bonjour le monde",
			}
		}
	}

	assert translations.get_lang("Hello world", "fr", map{}) == "Bonjour le monde"
}

fn test_get_lang_returns_key_name_when_lang_not_found() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"Hello world": {
				"en": "Hello world",
			}
		}
	}

	assert translations.get_lang("Hello world", "fr", map{}) == "Hello world"
}
