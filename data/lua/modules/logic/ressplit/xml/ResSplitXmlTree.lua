module("modules.logic.ressplit.xml.ResSplitXmlTree", package.seeall)

slot1 = function ()
	slot0 = {
		root = {},
		options = {
			noreduce = {
				SoundBank = true,
				Event = true,
				File = true
			}
		}
	}
	slot0._stack = {
		slot0.root
	}

	return slot0
end()

function slot1.new(slot0)
	slot1 = uv0()
	slot1.__index = slot0

	setmetatable(slot1, slot0)

	return slot1
end

function slot1.reduce(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot1) do
		if type(slot8) == "table" then
			slot0:reduce(slot8, slot7, slot1)
		end
	end

	if #slot1 == 1 and not slot0.options.noreduce[slot2] and slot1._attr == nil then
		slot3[slot2] = slot1[1]
	end
end

function slot2(slot0)
	if #slot0 == 0 then
		slot1 = {}

		table.insert(slot1, slot0)

		return slot1
	end

	return slot0
end

function slot1.starttag(slot0, slot1)
	if slot0.parseAttributes == true then
		-- Nothing
	end

	if slot0._stack[#slot0._stack][slot1.name] then
		slot4 = uv0(slot3[slot1.name])

		table.insert(slot4, slot2)

		slot3[slot1.name] = slot4
	else
		slot3[slot1.name] = {
			slot2
		}
	end

	table.insert(slot0._stack, {
		_attr = slot1.attrs
	})
end

function slot1.endtag(slot0, slot1, slot2)
	if not slot0._stack[#slot0._stack - 1][slot1.name] then
		error("XML Error - Unmatched Tag [" .. slot2 .. ":" .. slot1.name .. "]\n")
	end

	if slot3 == slot0.root then
		slot0:reduce(slot3, nil, )
	end

	table.remove(slot0._stack)
end

function slot1.text(slot0, slot1)
	table.insert(slot0._stack[#slot0._stack], slot1)
end

slot1.cdata = slot1.text
slot1.__index = slot1

return slot1
