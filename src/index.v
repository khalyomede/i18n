import i18n { Translations }

fn main() {
	translations := Translations{
		default_lang: "en",
		translations: {
			"You have :count messages": {
				"en": "{1} You have :count message | You have :count messages",
				"fr": "{1} Vous avez :count message | Vous avez :count messages"
			}
		}
	}

	println(translations.get_choice_lang("Vous avez :count messages", 1, "fr", { "": "" }))
}
