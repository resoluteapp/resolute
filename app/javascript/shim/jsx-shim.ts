export function jsxCreateElement(
	tag: string,
	attrs: Record<string, string | EventListenerOrEventListenerObject>,
	...children: string[]
): Element {
	const element = document.createElement(tag);

	for (const i in attrs) {
		if (typeof attrs[i] === "string") {
			element.setAttribute(i, attrs[i] as string);
		} else if (typeof attrs[i] === "function") {
			element.addEventListener(
				i.substring(2).toLowerCase(),
				attrs[i] as EventListenerOrEventListenerObject
			);
		}
	}

	for (const child of children) {
		element.append(child);
	}

	return element;
}
