module("modules.configs.excel2json.lua_block_package_data", package.seeall)

slot1 = {
	packageId = 3,
	blockId = 2,
	mainRes = 5,
	defineId = 1,
	order = 4
}
slot2 = {
	"blockId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict, uv0.packageDict = uv0.json_parse(slot0)
	end,
	json_parse = function (slot0)
		slot1 = {}
		slot2 = {}
		slot3 = {}

		for slot7, slot8 in ipairs(slot0) do
			if not slot3[slot8.id] then
				slot3[slot8.id] = {}
			end

			for slot13, slot14 in ipairs(slot8.infos) do
				slot14.packageId = slot8.id
				slot14.packageOrder = slot13

				table.insert(slot1, slot14)

				slot2[slot14.blockId] = slot14

				table.insert(slot3[slot8.id], slot14)
			end
		end

		return slot1, slot2, slot3
	end
}
