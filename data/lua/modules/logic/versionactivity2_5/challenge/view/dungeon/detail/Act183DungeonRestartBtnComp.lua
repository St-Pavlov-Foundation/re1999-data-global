module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRestartBtnComp", package.seeall)

local var_0_0 = class("Act183DungeonRestartBtnComp", Act183DungeonBaseComp)
local var_0_1 = {
	785,
	-425,
	340,
	104
}
local var_0_2 = {
	697,
	-425,
	560,
	104
}

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._btnrestart = gohelper.getClickWithDefaultAudio(arg_1_0.go)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnrestart:RemoveClickListener()
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)

	arg_4_0._isCanRestart = arg_4_0._groupEpisodeMo:isEpisodeCanRestart(arg_4_0._episodeId)
end

function var_0_0._btnrestartOnClick(arg_5_0)
	local var_5_0 = arg_5_0.mgr:getFuncValue(Act183DungeonSelectBadgeComp, "getReadyUseBadgeNum")
	local var_5_1 = arg_5_0.mgr:getFuncValue(Act183DungeonRewardRuleComp, "getSelectConditionMap")

	Act183HeroGroupController.instance:enterFight(arg_5_0._episodeId, var_5_0, var_5_1)
end

function var_0_0.checkIsVisible(arg_6_0)
	return arg_6_0._isCanRestart
end

function var_0_0.show(arg_7_0)
	var_0_0.super.show(arg_7_0)
	arg_7_0:_setPosition()
end

function var_0_0._setPosition(arg_8_0)
	local var_8_0 = arg_8_0.mgr:isCompVisible(Act183DungeonRepressBtnComp) and var_0_1 or var_0_2

	recthelper.setSize(arg_8_0._btnrestart.transform, var_8_0[3], var_8_0[4])
	recthelper.setAnchor(arg_8_0._btnrestart.transform, var_8_0[1], var_8_0[2])
end

function var_0_0.onDestroy(arg_9_0)
	var_0_0.super.onDestroy(arg_9_0)
end

return var_0_0
