module i18n

pub fn (translations Translations) get(name string, placeholders map[string]string) string {
	return translations.get_lang(name, translations.default_lang, placeholders)
}
