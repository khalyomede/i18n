module test

import i18n { Translations }

fn test_get_choice_lang_returns_single_count_translation_in_french() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | You have :count messages",
				"fr": "{1} Vous avez :count message | Vous avez :count messages"
			}
		}
	}

	assert translations.get_choice_lang("You have :count messages", 1, "fr", { "": "" }) == "Vous avez 1 message"
}

fn test_get_choice_lang_returns_range_count_translation_in_french() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | {2,3} You have :count messages | You have some messages"
				"fr": "{1} Vous avez :count message | {2,3} Vous avez :count messages | Vous avez des messages"
			}
		}
	}

	assert translations.get_choice_lang("You have :count messages", 3, "fr" , { "": "" }) == "Vous avez 3 messages"
}

fn test_get_choice_lang_returns_last_fallback_choice_if_no_matching_count_in_french() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | {2,3} You have :count messages | You have some messages"
				"fr": "{1} Vous avez :count message | {2,3} Vous avez :count messages | Vous avez des messages"
			}
		}
	}

	assert translations.get_choice_lang("You have :count messages", 9, "fr" , { "": "" }) == "Vous avez des messages"
}

fn test_get_choice_lang_returns_fallback_translation_if_no_lang_found_in_spanish() {
	translations := Translations{
		default_lang: "es",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | You have some messages"
				"fr": "{1} Vous avez :count message | Vous avez des messages"
			}
		}
	}

	assert translations.get_choice_lang("You have :count messages", 2, "es" , { "": "" }) == "You have 2 messages"
}

fn test_get_choice_lang_returns_count_range_with_star_translation_in_french() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | {2,*} You have some messages (:count)"
				"fr": "{1} Vous avez :count message | {2,*} Vous avez des messages (:count)"
			}
		}
	}

	assert translations.get_choice_lang("You have :count messages", 99, "fr" , { "": ""}) == "Vous avez des messages (99)"
}
