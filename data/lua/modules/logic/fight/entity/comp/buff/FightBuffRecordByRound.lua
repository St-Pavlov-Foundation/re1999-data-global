-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffRecordByRound.lua

module("modules.logic.fight.entity.comp.buff.FightBuffRecordByRound", package.seeall)

local FightBuffRecordByRound = class("FightBuffRecordByRound")

function FightBuffRecordByRound:onBuffStart(entity, buffMo)
	self.entity = entity

	FightController.instance:registerCallback(FightEvent.ALF_AddRecordCardData, self.onUpdateRecordCard, self)
	self:onUpdateRecordCard(buffMo)
end

function FightBuffRecordByRound:onUpdateRecordCard(buffMo)
	local actParam = buffMo and buffMo.actCommonParams or ""
	local list = FightStrUtil.instance:getSplitToNumberCache(actParam, "#")
	local alfCustomComp = self.entity.heroCustomComp and self.entity.heroCustomComp:getCustomComp()

	if alfCustomComp then
		alfCustomComp:setCacheRecordSkillList(list)
	end

	FightController.instance:dispatchEvent(FightEvent.ALF_AddRecordCardUI)
end

function FightBuffRecordByRound:onBuffEnd()
	self:clear()
end

function FightBuffRecordByRound:clear()
	FightController.instance:unregisterCallback(FightEvent.ALF_AddRecordCardData, self.onUpdateRecordCard, self)
end

function FightBuffRecordByRound:dispose()
	self:clear()
end

return FightBuffRecordByRound
