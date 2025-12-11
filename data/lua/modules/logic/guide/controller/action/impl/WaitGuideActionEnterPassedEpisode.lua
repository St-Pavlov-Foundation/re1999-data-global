module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterPassedEpisode", package.seeall)

local var_0_0 = class("WaitGuideActionEnterPassedEpisode", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, arg_1_0._onRoundStart, arg_1_0)
end

function var_0_0._onRoundStart(arg_2_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard) or FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local var_2_0 = FightModel.instance:getFightParam()

		if not DungeonModel.instance:hasPassLevel(var_2_0.episodeId) then
			return
		end

		if GuideModel.instance:getDoingGuideId() then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightDoingSubEntity) then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightLeadRoleSkillGuide) then
			return
		end

		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, arg_3_0._onRoundStart, arg_3_0)
end

return var_0_0
