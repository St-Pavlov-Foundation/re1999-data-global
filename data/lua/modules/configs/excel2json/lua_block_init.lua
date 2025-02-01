module("modules.configs.excel2json.lua_block_init", package.seeall)

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
		uv0.configList, uv0.configDict, uv0.poscfgDict = uv0.json_parse(slot0)
	end,
	json_parse = function (slot0)
		slot1 = {}
		slot2 = {}
		slot3 = {}

		if slot0.infos then
			for slot7, slot8 in ipairs(slot0.infos) do
				slot9 = {
					blockId = slot8.blockId,
					defineId = slot8.defineId,
					mainRes = slot8.mainRes,
					packageId = -1,
					order = -1
				}

				table.insert(slot1, slot9)

				slot2[slot9.blockId] = slot9

				if not slot3[slot8.x] then
					slot3[slot8.x] = {}
				end

				slot3[slot8.x][slot8.y] = slot8
			end
		end

		return slot1, slot2, slot3
	end
}
