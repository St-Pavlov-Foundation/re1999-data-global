-- chunkname: @modules/logic/fight/view/FightNamePowerInfoView.lua

module("modules.logic.fight.view.FightNamePowerInfoView", package.seeall)

local FightNamePowerInfoView = class("FightNamePowerInfoView", FightBaseClass)

function FightNamePowerInfoView:onConstructor(entityId, fightNameObj)
	self.entityId = entityId
	self.fightNameObj = fightNameObj
	self.viewComp = self:addComponent(FightViewComponent)
end

local type2Class = {
	[FightEnum.PowerType.Alert] = FightNamePowerInfoView6,
	[FightEnum.PowerType.ZongMaoBossEnergy] = FightNamePowerInfoView9
}
local type2url = {
	[FightEnum.PowerType.Alert] = "ui/viewres/fight/fightalertview.prefab",
	[FightEnum.PowerType.ZongMaoBossEnergy] = "ui/viewres/fight/fight_bossspecialenergy.prefab"
}

function FightNamePowerInfoView:onLogicEnter()
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)

	if not self.entityData then
		return
	end

	local powerInfoDic = self.entityData._powerInfos

	if powerInfoDic then
		for powerId, powerInfo in pairs(powerInfoDic) do
			local class = type2Class[powerId]

			if class then
				local url = type2url[powerId]
				local parentRoot = self:getParentRoot(powerId)

				self.viewComp:openSubView(class, url, parentRoot, self.entityId, powerInfo)
			end
		end
	end
end

function FightNamePowerInfoView:getParentRoot(powerId)
	if powerId == FightEnum.PowerType.Alert then
		local alertRoot = gohelper.create2d(self.fightNameObj, "alertRoot")

		return alertRoot
	elseif powerId == FightEnum.PowerType.ZongMaoBossEnergy then
		local bossEnergyRoot = gohelper.create2d(self.fightNameObj, "expointContainer")

		return bossEnergyRoot
	end
end

function FightNamePowerInfoView:onDestructor()
	return
end

return FightNamePowerInfoView
