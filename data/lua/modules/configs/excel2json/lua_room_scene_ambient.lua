module("modules.configs.excel2json.lua_room_scene_ambient", package.seeall)

slot1 = {}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.confgData = slot0
		uv0.configList, uv0.configDict = uv0.json_parse(slot0)
	end,
	json_parse = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(slot0) do
			table.insert(slot1, slot7)
		end

		return slot1, {
			[slot7.id] = slot7
		}
	end
}
