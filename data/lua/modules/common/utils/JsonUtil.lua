module("modules.common.utils.JsonUtil", package.seeall)

return {
	emptyArrayPlaceholder = "empty_array_placeholder_202205171648",
	encode = function (slot0)
		uv0._add_placeholder(slot0)

		if not string.nilorempty(cjson.encode(slot0)) then
			slot1 = string.gsub(slot1, "%[\"" .. uv0.emptyArrayPlaceholder .. "\"]", "[]")
		end

		return slot1
	end,
	markAsArray = function (slot0)
		slot1 = getmetatable(slot0) or {}
		slot1.__jsontype = "array"

		setmetatable(slot0, slot1)
	end,
	_is_marked_as_array = function (slot0)
		return getmetatable(slot0) and slot1.__jsontype == "array"
	end,
	_add_placeholder = function (slot0, slot1)
		if not slot0 or not LuaUtil.isTable(slot0) then
			return
		end

		slot2 = true
		(slot1 or {})[slot0] = true

		for slot6, slot7 in pairs(slot0) do
			if not slot1[slot7] and LuaUtil.isTable(slot7) then
				uv0._add_placeholder(slot7, slot1)
			end

			slot2 = false
		end

		if uv0._is_marked_as_array(slot0) and slot2 then
			table.insert(slot0, uv0.emptyArrayPlaceholder)
		end
	end
}
