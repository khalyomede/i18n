module i18n

import regex

fn matches_count(translation string, count int) bool {
	query := r"^\{(\d+),{0,1}([\d\*]*)\}"
	mut re := regex.regex_opt(query) or {
		// Todo: raise a compilation error once supported
		eprintln(err)

		return false
	}

	values := re.find_all_str(translation)

	if values.len > 0 {
		numbers := values[0].replace("{", "").replace("}", "").split(",")

		if numbers.len == 1 {
			// This is a single digit "count range" ({n})
			number := numbers[0].int()

			return number == count
		} else {
			// This (should) be a 2 digits "count range" ({x,y})
			min := numbers[0].int()
			max := numbers[1]

			if max != "*" && max.int() < min {
				// Todo: raise a compile time error when supported
				eprintln('i18n: max should be greater than min (max was $max, min was $min)')
			}

			return min <= count && (max == "*" || count <= max.int())
		}
	} else {
		// Always fallback to parts without "count ranges" ({x,y})
		return true
	}
}
