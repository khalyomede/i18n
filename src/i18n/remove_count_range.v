module i18n

import regex

fn remove_count_range(translation string) string {
	query := r"^\{\d+,{0,1}(\d|\*)*\}"

	mut re := regex.regex_opt(query) or {
		// Todo: Raise a compilation error once supported
		eprintln(err)

		return translation
	}

	updated_translation := re.replace(translation, "").trim(" ")

	return updated_translation
}
