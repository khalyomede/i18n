module i18n

pub fn (translations Translations) get_choice_lang(name string, count int, lang string, placeholders map[string]string) string {
	mut updated_placeholders := placeholders.clone()

	updated_placeholders["count"] = count.str()

	translation := translations.get_lang(name, lang, updated_placeholders)

	parts := translation.split("|")

	for part in parts {
		if i18n.matches_count(part, count) {
			return i18n.remove_count_range(part)
		}
	}

	return name
}
