-- chunkname: @modules/logic/fight/system/work/FightWorkTowerScoreChangeWork.lua

module("modules.logic.fight.system.work.FightWorkTowerScoreChangeWork", package.seeall)

local FightWorkTowerScoreChangeWork = class("FightWorkTowerScoreChangeWork", FightEffectBase)

function FightWorkTowerScoreChangeWork:beforePlayEffectData()
	self.indicatorId = FightEnum.IndicatorId.PaTaScore

	local data = FightDataHelper.fieldMgr.indicatorDict[self.indicatorId]

	self._beforeScore = data and data.num or 0
end

function FightWorkTowerScoreChangeWork:onStart()
	local data = FightDataHelper.fieldMgr.indicatorDict[self.indicatorId]

	self._curScore = data and data.num or 0

	self:com_sendFightEvent(FightEvent.OnIndicatorChange, self.indicatorId)
	self:com_sendFightEvent(FightEvent.OnAssistBossScoreChange, self._beforeScore, self._curScore)
	self:onDone(true)
end

return FightWorkTowerScoreChangeWork
