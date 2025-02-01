module("modules.configs.excel2json.lua_block_resource_style", package.seeall)

slot1 = {
	c3tc = 11,
	name = 3,
	c4tb = 14,
	c5ta = 16,
	c4ta = 13,
	c2ta = 6,
	c3ta = 9,
	path = 4,
	c6ta = 17,
	c3tb = 10,
	c2tb = 7,
	resourceId = 2,
	c3td = 12,
	c1ta = 5,
	id = 1,
	c4tc = 15,
	c2tc = 8
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
