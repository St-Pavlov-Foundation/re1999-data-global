﻿module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonStartBtnComp", package.seeall)

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
	local var_4_0 = arg_4_0.mgr:getFuncValue(Act183DungeonSelectBadgeComp, "getReadyUseBadgeNum")
	local var_4_1 = arg_4_0.mgr:getFuncValue(Act183DungeonRewardRuleComp, "getSelectConditionMap")

	Act183HeroGroupController.instance:enterFight(arg_4_0._episodeId, var_4_0, var_4_1)
end

function var_0_0.checkIsVisible(arg_5_0)
	return arg_5_0._status == Act183Enum.EpisodeStatus.Unlocked
end

function var_0_0.show(arg_6_0)
	var_0_0.super.show(arg_6_0)
end

function var_0_0.onDestroy(arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)
end

return var_0_0
