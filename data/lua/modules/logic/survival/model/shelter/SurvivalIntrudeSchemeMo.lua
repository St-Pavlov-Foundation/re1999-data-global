-- chunkname: @modules/logic/survival/model/shelter/SurvivalIntrudeSchemeMo.lua

module("modules.logic.survival.model.shelter.SurvivalIntrudeSchemeMo", package.seeall)

local SurvivalIntrudeSchemeMo = pureTable("SurvivalIntrudeSchemeMo")

function SurvivalIntrudeSchemeMo:setData(survivalIntrudeScheme, point)
	self.survivalIntrudeScheme = survivalIntrudeScheme
	self.point = point
	self.intrudeSchemeCfg = lua_survival_shelter_intrude_scheme.configDict[self.survivalIntrudeScheme.id]
end

function SurvivalIntrudeSchemeMo:getDisplayIcon()
	local path = self.intrudeSchemeCfg.icon

	if self.survivalIntrudeScheme.repress then
		path = "survival_new_bossbuff1_0"
	end

	return path
end

return SurvivalIntrudeSchemeMo
