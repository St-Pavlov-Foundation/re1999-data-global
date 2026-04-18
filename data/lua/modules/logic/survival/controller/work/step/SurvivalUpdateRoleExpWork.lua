-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdateRoleExpWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdateRoleExpWork", package.seeall)

local SurvivalUpdateRoleExpWork = class("SurvivalUpdateRoleExpWork", SurvivalStepBaseWork)

function SurvivalUpdateRoleExpWork:onStart()
	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local exp = self._stepMo.paramInt[1] or 0

	survivalShelterRoleMo:setExp(exp)
	survivalShelterRoleMo:setExpCache(exp)
	self:onDone(true)
end

return SurvivalUpdateRoleExpWork
