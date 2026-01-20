-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerOpenViewCondition.lua

module("modules.logic.guide.controller.trigger.GuideTriggerOpenViewCondition", package.seeall)

local GuideTriggerOpenViewCondition = class("GuideTriggerOpenViewCondition", BaseGuideTrigger)

function GuideTriggerOpenViewCondition:ctor(triggerKey)
	GuideTriggerOpenViewCondition.super.ctor(self, triggerKey)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
end

function GuideTriggerOpenViewCondition:assertGuideSatisfy(param, configParam)
	local paramList = string.split(configParam, "_")
	local viewName = paramList[1]
	local conditionFunc = paramList[2]
	local conditionParam = paramList[3]

	if param ~= viewName then
		return false
	end

	return GuideTriggerOpenViewCondition[conditionFunc](conditionParam)
end

function GuideTriggerOpenViewCondition:_onOpenView(viewName, viewParam)
	self:checkStartGuide(viewName)
end

function GuideTriggerOpenViewCondition.checkInEliminateEpisode(id)
	return EliminateTeamSelectionModel.instance:getSelectedEpisodeId() == tonumber(id)
end

function GuideTriggerOpenViewCondition.checkInWindows(id)
	return BootNativeUtil.isWindows()
end

function GuideTriggerOpenViewCondition.checkTowerMopUpOpen()
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local openLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	return permanentPassLayerNum >= tonumber(openLayerNum)
end

function GuideTriggerOpenViewCondition.checkTowerBossOpen()
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local openLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	return permanentPassLayerNum >= tonumber(openLayerNum)
end

function GuideTriggerOpenViewCondition.checkTowerLimitOpen()
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local openLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)
	local result = permanentPassLayerNum >= tonumber(openLayerNum)

	if result then
		local mo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

		result = mo ~= nil
	end

	local isBossGuideFinish = GuideModel.instance:isGuideFinish(TowerEnum.BossGuideId)

	return result and isBossGuideFinish
end

function GuideTriggerOpenViewCondition.checkTowerPermanentElite()
	return TowerPermanentModel.instance:checkNewLayerIsElite()
end

function GuideTriggerOpenViewCondition.checkMercenaryUnlock()
	local mercenaryUnlockCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryUnlock)
	local isMercenaryUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(mercenaryUnlockCo.value)

	return isMercenaryUnlock
end

return GuideTriggerOpenViewCondition
