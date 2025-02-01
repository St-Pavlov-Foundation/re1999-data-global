module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterFightSubEntity", package.seeall)

slot0 = class("WaitGuideActionEnterFightSubEntity", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, slot0._onRoundStart, slot0, LuaEventSystem.High)
end

function slot0._onRoundStart(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Distribute or slot1 == FightEnum.Stage.Card then
		if not FightEntityModel.instance:getMySideList() or #slot2 < 3 then
			return
		end

		if not FightEntityModel.instance:getSubModel(FightEnum.EntitySide.MySide):getList() or #slot3 == 0 then
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
