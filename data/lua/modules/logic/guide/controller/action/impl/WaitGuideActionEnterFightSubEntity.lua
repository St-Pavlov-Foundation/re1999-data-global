module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterFightSubEntity", package.seeall)

slot0 = class("WaitGuideActionEnterFightSubEntity", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, slot0._onRoundStart, slot0, LuaEventSystem.High)
end

function slot0._onRoundStart(slot0)
	slot1 = FightModel.instance:getCurStage()

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Distribute1Card) or slot1 == FightEnum.Stage.Distribute or slot1 == FightEnum.Stage.Card then
		if not FightDataHelper.entityMgr:getMyNormalList() or #slot3 < 3 then
			return
		end

		if not FightDataHelper.entityMgr:getMySubList() or #slot4 == 0 then
			return
		end

		if GuideModel.instance:getDoingGuideId() then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightDoingEnterPassedEpisode) then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightLeadRoleSkillGuide) then
			return
		end

		slot0:clearWork()
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, slot0._onRoundStart, slot0)
end

return slot0
