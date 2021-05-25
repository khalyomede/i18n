module i18n

pub fn (translations Translations) get_choice(name string, count int, placeholders map[string]string) string {
	return translations.get_choice_lang(name, count, translations.default_lang, placeholders)
}
