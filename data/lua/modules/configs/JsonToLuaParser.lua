module("modules.configs.JsonToLuaParser", package.seeall)

return {
	parse = function (slot0, slot1, slot2, slot3)
		slot4 = {}

		for slot10, slot11 in ipairs(slot0) do
			slot12 = slot11.name

			setmetatable(slot11, {
				__index = function (slot0, slot1)
					slot3 = rawget(slot0, uv0[slot1])

					if uv1 and uv1[slot1] then
						return lang(slot3)
					end

					return slot3
				end,
				__newindex = function (slot0, slot1, slot2)
					logError("Can't modify config field: " .. slot1)
				end
			})

			for slot17, slot18 in ipairs(slot2) do
				if slot17 == #slot2 then
					slot4[slot11[slot18]] = slot11
				else
					if not slot13[slot19] then
						slot13[slot19] = {}
					end

					slot13 = slot13[slot19]
				end
			end
		end

		return slot5, slot4
	end
}
