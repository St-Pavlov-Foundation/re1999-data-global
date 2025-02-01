module("modules.configs.excel2json.lua_block", package.seeall)

slot1 = {
	prefabPath = 2,
	mainRes = 4,
	category = 5,
	resourceIds = 3,
	defineId = 1
}
slot2 = {
	"defineId"
}
slot3 = {}
slot4 = {
	"blockType",
	"waterType"
}

return {
	onLoad = function (slot0)
		uv0.confgData = slot0
		uv0.configList, uv0.configDict = uv0.json_parse(slot0)
		uv0.propertyList, uv0.propertyDict = uv0.json_property(slot0, uv1)
	end,
	json_parse = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(slot0) do
			table.insert(slot1, slot7)

			if slot7.category == cjson.null then
				slot7.category = nil
			end

			slot7.resIdCountDict = {}

			for slot12, slot13 in ipairs(slot7.resourceIds) do
				slot8[slot13] = (slot8[slot13] or 0) + 1
			end
		end

		return slot1, {
			[slot7.defineId] = slot7
		}
	end,
	json_property = function (slot0, slot1)
		for slot7, slot8 in ipairs(slot1) do
			for slot14, slot15 in ipairs(slot0) do
				if slot15[slot8] and not slot10[slot16] then
					slot10[slot16] = slot16

					table.insert(slot9, slot16)
				end
			end

			logNormal(string.format("lua_block.json_property [%s]:%s,", slot8, table.concat(slot9, ",")))
		end

		return {
			[slot8] = {}
		}, {
			[slot8] = {}
		}
	end
}
