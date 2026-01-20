-- chunkname: @modules/logic/survival/model/shelter/SurvivalMapInfoMo.lua

module("modules.logic.survival.model.shelter.SurvivalMapInfoMo", package.seeall)

local SurvivalMapInfoMo = pureTable("SurvivalMapInfoMo")

function SurvivalMapInfoMo:init(data)
	self.mapId = data.mapId
	self.rainId = data.rainId
	self.disasterId = data.disasterId
	self.taskId = data.taskId

	if self.taskId > 0 then
		self.taskCo = SurvivalConfig.instance:getTaskCo(SurvivalEnum.TaskModule.MapMainTarget, self.taskId)
	end

	self.disasterCo = lua_survival_disaster.configDict[self.disasterId]
	self.rainCo = lua_survival_rain.configDict[self.rainId]

	local groupMapperCo = lua_survival_map_group_mapping.configDict[self.mapId]

	self.groupId = groupMapperCo and groupMapperCo.id or 0
	self.groupCo = lua_survival_map_group.configDict[self.groupId]
	self.mapType = self.groupCo and self.groupCo.type or 0

	local level = self.groupCo and self.groupCo.hardLevel or 1

	if level <= 2 then
		self.level = 1
	elseif level <= 4 then
		self.level = 2
	else
		self.level = 3
	end
end

return SurvivalMapInfoMo
