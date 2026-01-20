-- chunkname: @modules/logic/fight/model/data/FightTempDataMgr.lua

module("modules.logic.fight.model.data.FightTempDataMgr", package.seeall)

local FightTempDataMgr = FightDataClass("FightTempDataMgr", FightDataMgrBase)

function FightTempDataMgr:onConstructor()
	self.hasNextWave = false
	self.combineCount = 0
	self.aiJiAoQteCount = 0
	self.aiJiAoQteEndlessLoop = 0
	self.aiJiAoFakeHpOffset = {}
	self.aiJiAoSelectTargetView = nil
	self.playAiJiAoPreTimeline = nil
	self.buffDurationDic = {}
	self.douQuQuDice = nil
end

function FightTempDataMgr:onCancelOperation()
	self.combineCount = 0
end

function FightTempDataMgr:onStageChanged()
	self.combineCount = 0
end

function FightTempDataMgr:setAutoSelectedCrystal(selected)
	self.autoSelectedCrystal = true
end

function FightTempDataMgr:isAutoSelectedCrystal()
	return self.autoSelectedCrystal
end

return FightTempDataMgr
