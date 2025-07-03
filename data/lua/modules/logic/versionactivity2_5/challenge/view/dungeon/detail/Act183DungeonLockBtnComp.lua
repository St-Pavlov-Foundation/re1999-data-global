module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonLockBtnComp", package.seeall)

local var_0_0 = class("Act183DungeonLockBtnComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.checkIsVisible(arg_4_0)
	return arg_4_0._status == Act183Enum.EpisodeStatus.Locked
end

function var_0_0.show(arg_5_0)
	var_0_0.super.show(arg_5_0)
end

function var_0_0.onDestroy(arg_6_0)
	var_0_0.super.onDestroy(arg_6_0)
end

return var_0_0
