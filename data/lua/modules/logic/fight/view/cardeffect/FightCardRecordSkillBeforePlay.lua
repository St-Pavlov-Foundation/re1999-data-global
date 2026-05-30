-- chunkname: @modules/logic/fight/view/cardeffect/FightCardRecordSkillBeforePlay.lua

module("modules.logic.fight.view.cardeffect.FightCardRecordSkillBeforePlay", package.seeall)

local FightCardRecordSkillBeforePlay = class("FightCardRecordSkillBeforePlay", BaseWork)

function FightCardRecordSkillBeforePlay:onStart(context)
	self.context.canEnterLorentzRecordSkill = false

	if FightDataHelper.stateMgr:getIsAuto() or FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AutoCardPlaying) then
		self:handleAuto()

		return self:onDone(true)
	end

	if FightDataHelper.stateMgr.isReplay then
		self:handleReplay()

		return self:onDone(true)
	end

	self:handleNormal()

	return self:onDone(true)
end

function FightCardRecordSkillBeforePlay:handleAuto()
	self:setExistRecordCard()
end

function FightCardRecordSkillBeforePlay:handleReplay()
	self:setExistRecordCard()
end

function FightCardRecordSkillBeforePlay:handleNormal()
	if not self:checkCanRecord() then
		return
	end

	local beginRoundOp = self.context and self.context.fightBeginRoundOp
	local skillId = beginRoundOp and beginRoundOp.skillId
	local skillCo = skillId and lua_skill.configDict[skillId]

	if not skillCo then
		return
	end

	local targetId = FightEnum.BehaviourId.BufferflyRecordSkill

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")
			local behaviourId = array and array[1]

			if behaviourId == targetId then
				self.context.canEnterLorentzRecordSkill = true

				FightDataHelper.operationDataMgr:setLorenzRecordSkillDepend(beginRoundOp)

				return
			end
		end
	end
end

function FightCardRecordSkillBeforePlay:setExistRecordCard()
	local beginRoundOp = self.context and self.context.fightBeginRoundOp
	local cardParam1 = beginRoundOp and beginRoundOp.cardParam1

	if not string.nilorempty(cardParam1) then
		local array = FightStrUtil.instance:getSplitCache(beginRoundOp.cardParam1, "#")
		local skillId = array and array[1]
		local skillId, entityUid = skillId, array and array[2]

		beginRoundOp:setCardParam1(skillId, entityUid)
		FightDataHelper.operationDataMgr:setLorenzRecordSkillDepend(beginRoundOp)
		FightDataHelper.operationDataMgr:setLorenzRecordSkillId(skillId)
	end
end

function FightCardRecordSkillBeforePlay:checkCanRecord()
	local cardList = self.context and self.context.cards

	if not cardList then
		return
	end

	local len = #cardList

	if len < 1 then
		return
	end

	local beginRoundOp = self.context and self.context.fightBeginRoundOp
	local entityId = beginRoundOp and beginRoundOp.cardInfoMO and beginRoundOp.cardInfoMO.uid

	if not entityId then
		return
	end

	local operateMgr = FightDataHelper.operationDataMgr

	for _, cardInfo in ipairs(cardList) do
		if operateMgr:canRecordCard(cardInfo, entityId) then
			return true
		end
	end
end

function FightCardRecordSkillBeforePlay:clearWork()
	return
end

return FightCardRecordSkillBeforePlay
