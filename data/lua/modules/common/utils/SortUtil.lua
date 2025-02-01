module("modules.common.utils.SortUtil", package.seeall)

return {
	keyLower = function (slot0)
		return function (slot0, slot1)
			return slot0[uv0] < slot1[uv0]
		end
	end,
	keyUpper = function (slot0)
		return function (slot0, slot1)
			return slot1[uv0] < slot0[uv0]
		end
	end,
	tableKeyLower = function (slot0)
		return function (slot0, slot1)
			for slot5, slot6 in ipairs(uv0) do
				if slot0[slot6] ~= slot1[slot6] then
					return slot0[slot6] < slot1[slot6]
				end
			end

			return false
		end
	end,
	tableKeyUpper = function (slot0)
		return function (slot0, slot1)
			for slot5, slot6 in ipairs(uv0) do
				if slot0[slot6] ~= slot1[slot6] then
					return slot1[slot6] < slot0[slot6]
				end
			end

			return false
		end
	end
}
