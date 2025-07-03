module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonResetBtnComp", package.seeall)

local var_0_0 = class("Act183DungeonResetBtnComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._btnresetepisode = gohelper.getClickWithDefaultAudio(arg_1_0.go)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnresetepisode:AddClickListener(arg_2_0._btnresetepisodeOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnresetepisode:RemoveClickListener()
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)

	arg_4_0._isCanReset = arg_4_0._groupEpisodeMo:isEpisodeCanReset(arg_4_0._episodeId)
end

function var_0_0._btnresetepisodeOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act183ResetEpisode, MsgBoxEnum.BoxType.Yes_No, arg_5_0._startResetEpisode, nil, nil, arg_5_0)
end

function var_0_0._startResetEpisode(arg_6_0)
	Act183Controller.instance:resetEpisode(arg_6_0._activityId, arg_6_0._episodeId)
end

function var_0_0.checkIsVisible(arg_7_0)
	return arg_7_0._isCanReset
end

function var_0_0.show(arg_8_0)
	var_0_0.super.show(arg_8_0)
end

function var_0_0.onDestroy(arg_9_0)
	var_0_0.super.onDestroy(arg_9_0)
end

return var_0_0
