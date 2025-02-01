module("modules.logic.fight.controller.replay.FightReplayWorkClothSkill", package.seeall)

slot0 = class("FightReplayWorkClothSkill", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.clothSkillOp = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)

	if slot0.clothSkillOp.type == FightEnum.ClothSkillType.HeroUpgrade then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, slot0._failDone, slot0)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillDone, slot0)
		FightRpc.instance:sendUseClothSkillRequest(slot0.clothSkillOp.skillId, slot0.clothSkillOp.fromId, slot0.clothSkillOp.toId, FightEnum.ClothSkillType.HeroUpgrade)

		return
	elseif slot0.clothSkillOp.type == FightEnum.ClothSkillType.Contract then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, slot0._failDone, slot0)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillDone, slot0)
		FightRpc.instance:sendUseClothSkillRequest(slot0.clothSkillOp.skillId, slot0.clothSkillOp.fromId, slot0.clothSkillOp.toId, FightEnum.ClothSkillType.Contract)

		return
	end

	if lua_skill.configDict[slot0.clothSkillOp.skillId] then
		if not string.nilorempty(slot1.behavior1) then
			slot4 = string.splitToNumber(slot2, "#")[1] and lua_skill_behavior.configDict[slot3]

			if slot4 and slot4.type then
				slot0:_playBehavior(slot5)
			else
				logError("主角技能行为类型不存在：" .. slot0.clothSkillOp.skillId .. " behavior=" .. slot2)
				slot0:onDone(true)
			end
		else
			logError("主角技能行为不存在：" .. slot0.clothSkillOp.skillId)
			slot0:onDone(true)
		end
	else
		logError("主角技能不存在：" .. slot0.clothSkillOp.skillId)
		slot0:onDone(true)
	end
end

function slot0._playBehavior(slot0, slot1)
	if slot1 == "AddUniversalCard" then
		FightController.instance:registerCallback(FightEvent.OnUniversalAppear, slot0._onUniversalAppear, slot0)
	elseif slot1 == "RedealCardKeepStar" then
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onRedealCardDone, slot0)
	elseif slot1 == "SubHeroChange" then
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onChangeSubDone, slot0)
	elseif slot1 == "ExtraMoveCard" then
		FightController.instance:registerCallback(FightEvent.OnEffectExtraMoveAct, slot0._onEffectExtraMoveAct, slot0)
	else
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillDone, slot0)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, slot0._failDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.SimulateClickClothSkillIcon, slot0.clothSkillOp)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._onChangeSubDone(slot0)
	TaskDispatcher.runDelay(slot0._done, slot0, 0.1)
end

function slot0._onRedealCardDone(slot0)
	TaskDispatcher.runDelay(slot0._done, slot0, 0.1)
end

function slot0._onUniversalAppear(slot0)
	TaskDispatcher.runDelay(slot0._done, slot0, 0.1)
end

function slot0._onEffectExtraMoveAct(slot0)
	TaskDispatcher.runDelay(slot0._done, slot0, 0.1)
end

function slot0._onClothSkillDone(slot0)
	TaskDispatcher.runDelay(slot0._done, slot0, 0.1)
end

function slot0._done(slot0)
	slot0:onDone(true)
end

function slot0._failDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnUniversalAppear, slot0._onUniversalAppear, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._done, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onChangeSubDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnEffectExtraMoveAct, slot0._onEffectExtraMoveAct, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, slot0._failDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onRedealCardDone, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0._done, slot0)
end

return slot0
