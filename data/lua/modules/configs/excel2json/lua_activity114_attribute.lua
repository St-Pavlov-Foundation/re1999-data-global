module("modules.configs.excel2json.lua_activity114_attribute", package.seeall)

slot1 = {
	attrName = 4,
	educationAttentionConsts = 6,
	attributeNum = 5,
	id = 2,
	activityId = 1,
	attribute = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	attrName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
