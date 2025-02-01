module("modules.logic.ressplit.xml.ResSplitXmlPrint", package.seeall)

return {
	starttag = function (slot0, slot1, slot2, slot3)
		io.write("Start    : " .. slot1.name .. "\n")

		if slot1.attrs then
			for slot7, slot8 in pairs(slot1.attrs) do
				io.write(string.format(" + %s='%s'\n", slot7, slot8))
			end
		end
	end,
	endtag = function (slot0, slot1, slot2, slot3)
		io.write("End      : " .. slot1.name .. "\n")
	end,
	text = function (slot0, slot1, slot2, slot3)
		io.write("Text     : " .. slot1 .. "\n")
	end,
	cdata = function (slot0, slot1, slot2, slot3)
		io.write("CDATA    : " .. slot1 .. "\n")
	end,
	comment = function (slot0, slot1, slot2, slot3)
		io.write("Comment  : " .. slot1 .. "\n")
	end,
	dtd = function (slot0, slot1, slot2, slot3)
		io.write("DTD      : " .. slot1.name .. "\n")

		if slot1.attrs then
			for slot7, slot8 in pairs(slot1.attrs) do
				io.write(string.format(" + %s='%s'\n", slot7, slot8))
			end
		end
	end,
	pi = function (slot0, slot1, slot2, slot3)
		io.write("PI       : " .. slot1.name .. "\n")

		if slot1.attrs then
			for slot7, slot8 in pairs(slot1.attrs) do
				io.write(string.format(" + %s='%s'\n", slot7, slot8))
			end
		end
	end,
	decl = function (slot0, slot1, slot2, slot3)
		io.write("XML Decl : " .. slot1.name .. "\n")

		if slot1.attrs then
			for slot7, slot8 in pairs(slot1.attrs) do
				io.write(string.format(" + %s='%s'\n", slot7, slot8))
			end
		end
	end
}
