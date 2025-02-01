module("modules.logic.ressplit.xml.ResSplitXml2lua", package.seeall)

function slot1(slot0, slot1)
	if slot0 == nil then
		return
	end

	for slot6, slot7 in pairs(slot0) do
		if type(slot7) == "table" then
			print(string.rep(" ", (slot1 or 1) * 2) .. slot6)
			uv0(slot7, slot1 + 1)
		else
			print(slot2 .. slot6 .. "=" .. slot7)
		end
	end
end

function slot2(slot0)
	for slot5, slot6 in pairs(slot0 or {}) do
		slot1 = "" .. " " .. slot5 .. "=" .. "\"" .. slot6 .. "\""
	end

	return slot1
end

function slot3(slot0)
	if type(slot0) == "table" then
		for slot4, slot5 in pairs(slot0) do
			return slot4
		end

		return nil
	end

	return slot0
end

function slot4(slot0, slot1, slot2, slot3)
	slot4 = string.rep(" ", slot3 * 2)
	slot5 = ""

	table.insert(slot0, slot4 .. "<" .. slot1 .. "" .. ">" .. (type(slot2) == "table" and "\n" .. (#slot2 == 1 and slot4 .. tostring(slot2[1]) or uv1.toXml(slot2, slot1, slot3 + 1)) .. "\n" .. slot4 or tostring(slot2)) .. "</" .. slot1 .. ">")
end

return {
	_VERSION = "1.5-2",
	parser = function (slot0)
		if slot0 == uv0 then
			error("You must call ResSplitXml2lua.parse(handler) instead of ResSplitXml2lua:parse(handler)")
		end

		return ResSplitXmlParser.new(slot0, {
			expandEntities = 1,
			stripWS = 1,
			errorHandler = function (slot0, slot1)
				error(string.format("%s [char=%d]\n", slot0 or "Parse Error", slot1))
			end
		})
	end,
	printable = function (slot0)
		uv0(slot0)
	end,
	toString = function (slot0)
		slot1 = ""
		slot2 = ""

		if type(slot0) ~= "table" then
			return slot0
		end

		for slot6, slot7 in pairs(slot0) do
			if type(slot7) == "table" then
				slot7 = uv0.toString(slot7)
			end

			slot2 = slot2 .. slot1 .. string.format("%s=%s", slot6, slot7)
			slot1 = ","
		end

		return "{" .. slot2 .. "}"
	end,
	loadFile = function (slot0)
		slot1, slot2 = io.open(slot0, "r")

		if slot1 then
			slot1:close()

			return slot1:read("*a")
		end

		error(slot2)
	end,
	toXml = function (slot0, slot1, slot2)
		slot2 = slot2 or 1
		slot3 = slot2
		slot1 = slot1 or ""

		for slot8, slot9 in pairs(slot0) do
			if type(slot9) == "table" then
				if type(slot8) == "number" then
					uv0(slot1 ~= "" and slot2 == 1 and {
						"<" .. slot1 .. ">"
					} or {}, slot1, slot9, slot2)
				elseif type(uv1(slot9)) == "number" then
					uv0(slot4, slot8, slot9, slot2 + 1)
				else
					uv0(slot4, slot8, slot9, slot2)
				end
			else
				if type(slot8) == "number" then
					slot8 = slot1
				end

				uv0(slot4, slot8, slot9, slot2)
			end
		end

		if slot1 ~= "" and slot3 == 1 then
			table.insert(slot4, "</" .. slot1 .. ">\n")
		end

		return table.concat(slot4, "\n")
	end
}
