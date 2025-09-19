module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonStartBtnComp", package.seeall)

local var_0_0 = class("Act183DungeonStartBtnComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._btnstart = gohelper.getClickWithDefaultAudio(arg_1_0.go)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
end

function var_0_0._btnstartOnClick(arg_4_0)
	if arg_4_0._episodeType == Act183Enum.EpisodeType.Boss and arg_4_0._groupEpisodeMo:isAnySubEpisodeNotFinished() then
		local var_4_0 = arg_4_0._groupType == Act183Enum.GroupType.Daily and MessageBoxIdDefine.Act183FightDailyBossEpisode or MessageBoxIdDefine.Act183FightMainBossEpisode

		GameFacade.showMessageBox(var_4_0, MsgBoxEnum.BoxType.Yes_No, arg_4_0.enterBossFightIfSubNotFinish, nil, nil, arg_4_0)

		return
	end

	arg_4_0:enterFight()
end

function var_0_0.enterFight(arg_5_0)
	local var_5_0 = arg_5_0.mgr:getFuncValue(Act183DungeonSelectBadgeComp, "getReadyUseBadgeNum")
	local var_5_1 = arg_5_0.mgr:getFuncValue(Act183DungeonRewardRuleComp, "getSelectConditionMap")

	Act183HeroGroupController.instance:enterFight(arg_5_0._episodeId, var_5_0, var_5_1)
end

function var_0_0.enterBossFightIfSubNotFinish(arg_6_0)
	arg_6_0:addEventCb(Act183Controller.instance, Act183Event.OnPlayEffectDoneIfSubUnfinish, arg_6_0._onPlayEffectDoneIfSubUnfinish, arg_6_0)
	Act183Controller.instance:dispatchEvent(Act183Event.FightBossIfSubUnfinish, arg_6_0._episodeId)
end

function var_0_0._onPlayEffectDoneIfSubUnfinish(arg_7_0, arg_7_1)
	if arg_7_0._episodeId ~= arg_7_1 then
		return
	end

	arg_7_0:enterFight()
	arg_7_0:removeEventCb(Act183Controller.instance, Act183Event.OnPlayEffectDoneIfSubUnfinish, arg_7_0._onPlayEffectDoneIfSubUnfinish, arg_7_0)
end

function var_0_0.checkIsVisible(arg_8_0)
	return arg_8_0._status == Act183Enum.EpisodeStatus.Unlocked
end

function var_0_0.show(arg_9_0)
	var_0_0.super.show(arg_9_0)
end

function var_0_0.onDestroy(arg_10_0)
	var_0_0.super.onDestroy(arg_10_0)
end

return var_0_0
