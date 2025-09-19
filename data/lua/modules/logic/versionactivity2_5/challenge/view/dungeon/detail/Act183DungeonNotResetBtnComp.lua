module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonNotResetBtnComp", package.seeall)

local var_0_0 = class("Act183DungeonNotResetBtnComp", Act183DungeonBaseComp)

function var_0_0.updateInfo(arg_1_0, arg_1_1)
	var_0_0.super.updateInfo(arg_1_0, arg_1_1)

	arg_1_0._isSimulate = arg_1_0._episodeMo:isSimulate()
end

function var_0_0.checkIsVisible(arg_2_0)
	return arg_2_0._isSimulate and arg_2_0._episodeType ~= Act183Enum.EpisodeType.Boss
end

return var_0_0
