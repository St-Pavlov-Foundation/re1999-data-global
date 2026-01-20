-- chunkname: @modules/configs/excel2json/lua_block_init.lua

module("modules.configs.excel2json.lua_block_init", package.seeall)

local lua_block_init = {}
local fields = {
	packageId = 3,
	blockId = 2,
	mainRes = 5,
	defineId = 1,
	order = 4
}
local primaryKey = {
	"blockId"
}
local mlStringKey = {}

function lua_block_init.onLoad(json)
	lua_block_init.configList, lua_block_init.configDict, lua_block_init.poscfgDict = lua_block_init.json_parse(json)
end

function lua_block_init.json_parse(json)
	local configList = {}
	local configDict = {}
	local poscfgDict = {}

	if json.infos then
		for i, info in ipairs(json.infos) do
			local config = {}

			config.blockId = info.blockId
			config.defineId = info.defineId
			config.mainRes = info.mainRes
			config.packageId = -1
			config.order = -1

			table.insert(configList, config)

			configDict[config.blockId] = config

			if not poscfgDict[info.x] then
				poscfgDict[info.x] = {}
			end

			poscfgDict[info.x][info.y] = info
		end
	end

	return configList, configDict, poscfgDict
end

return lua_block_init
