-- chunkname: @modules/logic/roleactivity/model/RoleActivityLevelMo.lua

module("modules.logic.roleactivity.model.RoleActivityLevelMo", package.seeall)

local RoleActivityLevelMo = pureTable("RoleActivityLevelMo")

function RoleActivityLevelMo:init(_config)
	self.config = _config
	self.isUnlock = DungeonModel.instance:isUnlock(_config)

	local dungeonMO = DungeonModel.instance:getEpisodeInfo(_config.id)

	self.star = dungeonMO and dungeonMO.star or 0
end

function RoleActivityLevelMo:update()
	self.isUnlock = DungeonModel.instance:isUnlock(self.config)

	local dungeonMO = DungeonModel.instance:getEpisodeInfo(self.config.id)

	self.star = dungeonMO and dungeonMO.star or 0
end

return RoleActivityLevelMo
