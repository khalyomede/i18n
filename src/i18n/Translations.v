module i18n

pub struct Translations {
	translations map[string]map[string]string
	pub mut:
		default_lang string [required]
}
