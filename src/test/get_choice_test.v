module test

import i18n { Translations }

fn test_get_choice_returns_single_count_translation() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | You have :count messages"
			}
		}
	}

	assert translations.get_choice("You have :count messages", 1, map{}) == "You have 1 message"
}

fn test_get_choice_returns_range_count_translation() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | {2,3} You have :count messages | You have some messages"
			}
		}
	}

	assert translations.get_choice("You have :count messages", 3, map{}) == "You have 3 messages"
}

fn test_get_choice_returns_last_fallback_choice_if_no_matching_count() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | {2,3} You have :count messages | You have some messages"
			}
		}
	}

	assert translations.get_choice("You have :count messages", 9, map{}) == "You have some messages"
}

fn test_get_choice_returns_fallback_translation_if_no_lang_found() {
	translations := Translations{
		default_lang: "fr",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | You have some messages"
			}
		}
	}

	assert translations.get_choice("You have :count messages", 2, map{}) == "You have 2 messages"
}

fn test_get_choice_returns_count_range_with_star_translation() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | {2,*} You have some messages (:count)"
			}
		}
	}

	assert translations.get_choice("You have :count messages", 99, map{}) == "You have some messages (99)"
}
