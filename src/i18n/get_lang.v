module i18n

pub fn (translations Translations) get_lang(name string, lang string, placeholders map[string]string) string {
	mut translation := translations.translations[name][lang] or {
		eprintln("i18n: no translation found for key \"$name\" with lang \"$lang\"")

		name
	}

	for key, value in placeholders {
		if key == "" {
			continue
		}

		mut placeholder_key := key

		if !key.starts_with(":") {
			placeholder_key = ':$placeholder_key'
		}

		translation = translation.replace(placeholder_key, value)
	}

	return translation
}
