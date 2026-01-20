-- chunkname: @modules/configs/excel2json/lua_store_decorate.lua

module("modules.configs.excel2json.lua_store_decorate", package.seeall)

local lua_store_decorate = {}
local fields = {
	productType = 3,
	video = 11,
	smalllmg = 8,
	decorateskinOffset = 17,
	biglmg = 9,
	typeName = 5,
	maxbuycountType = 7,
	decorateskinl2dOffset = 18,
	originalCost1 = 14,
	subType = 4,
	tag1 = 13,
	storeld = 2,
	showskinId = 20,
	buylmg = 10,
	offTag = 16,
	tag2 = 21,
	rare = 6,
	effectbiglmg = 19,
	originalCost2 = 15,
	onlineTag = 12,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tag1 = 2,
	typeName = 1
}

function lua_store_decorate.onLoad(json)
	lua_store_decorate.configList, lua_store_decorate.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_decorate
