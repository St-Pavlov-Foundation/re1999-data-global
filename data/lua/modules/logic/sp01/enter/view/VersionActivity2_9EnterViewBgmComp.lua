module("modules.logic.sp01.enter.view.VersionActivity2_9EnterViewBgmComp", package.seeall)

local var_0_0 = class("VersionActivity2_9EnterViewBgmComp", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9EnterController.instance, VersionActivity2_9Event.ManualSwitchBgm, arg_2_0._manualSwitchBgm, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9EnterController.instance, VersionActivity2_9Event.StopBgm, arg_2_0._stopBgm, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._bgmLayer = VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(2, 9)
end

function var_0_0.viewName2BgmHandle(arg_5_0, arg_5_1)
	arg_5_0:_initBgmConfigs()

	local var_5_0 = arg_5_0:viewName2ActId(arg_5_1)
	local var_5_1, var_5_2 = arg_5_0:actId2BgmHandle(var_5_0)

	return var_5_1, var_5_2
end

function var_0_0.viewName2ActId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._viewName2ActId and arg_6_0._viewName2ActId[arg_6_1]

	if not var_6_0 then
		local var_6_1 = arg_6_0._viewName2ActIdHandle and arg_6_0._viewName2ActIdHandle[arg_6_1]

		if var_6_1 then
			var_6_0 = var_6_1(arg_6_0, arg_6_1)
		end
	end

	return var_6_0
end

function var_0_0.actId2BgmHandle(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = ActivityConfig.instance:getActivityEnterViewBgm(arg_7_1)
	local var_7_1 = arg_7_0._actId2BgmHandle and arg_7_0._actId2BgmHandle[arg_7_1]

	if var_7_0 and var_7_0 ~= 0 and not var_7_1 then
		logError(string.format("缺少播放活动背景音乐的方法! actId = %s, bgmId = %s", arg_7_1, var_7_0))
	end

	return var_7_1, var_7_0
end

function var_0_0._initBgmConfigs(arg_8_0)
	if not arg_8_0._viewName2ActId then
		arg_8_0._viewName2ActId = {}
		arg_8_0._viewName2ActId[ViewName.AssassinLoginView] = VersionActivity2_9Enum.ActivityId.Outside
		arg_8_0._viewName2ActId[ViewName.AssassinMapView] = VersionActivity2_9Enum.ActivityId.Outside
		arg_8_0._viewName2ActId[ViewName.V1a4_BossRushMainView] = VersionActivity2_9Enum.ActivityId.BossRush
		arg_8_0._viewName2ActId[ViewName.VersionActivity2_9DungeonMapView] = VersionActivity2_9Enum.ActivityId.Dungeon
	end

	if not arg_8_0._viewName2ActIdHandle then
		arg_8_0._viewName2ActIdHandle = {}
		arg_8_0._viewName2ActIdHandle[ViewName.VersionActivity2_9EnterView] = arg_8_0.getActIdHandle_EnterView
	end

	if not arg_8_0._actId2BgmHandle then
		arg_8_0._actId2BgmHandle = {}
		arg_8_0._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.EnterView] = arg_8_0.playBgm_EnterView
		arg_8_0._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.EnterView2] = arg_8_0.playBgm_EnterView
		arg_8_0._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.BossRush] = arg_8_0.playBgm_BossRush
		arg_8_0._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.Outside] = arg_8_0.playBgm_default
		arg_8_0._actId2BgmHandle[VersionActivity2_9Enum.ActivityId.Dungeon] = arg_8_0.playBgm_default
	end
end

function var_0_0.getActIdHandle_EnterView(arg_9_0)
	local var_9_0 = arg_9_0.viewContainer._views[1].showGroupIndex

	return arg_9_0.viewParam.mainActIdList[var_9_0]
end

function var_0_0.playBgm_EnterView(arg_10_0, arg_10_1)
	AudioBgmManager.instance:modifyAndPlay(arg_10_0._bgmLayer, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	AudioBgmManager.instance:modifyBgmAudioId(arg_10_0._bgmLayer, arg_10_1)
end

function var_0_0.playBgm_BossRush(arg_11_0, arg_11_1)
	AudioBgmManager.instance:setSwitchData(arg_11_0._bgmLayer, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(arg_11_0._bgmLayer, arg_11_1)
end

function var_0_0.playBgm_default(arg_12_0, arg_12_1)
	AudioBgmManager.instance:setSwitchData(arg_12_0._bgmLayer)
	AudioBgmManager.instance:modifyBgmAudioId(arg_12_0._bgmLayer, arg_12_1)
end

function var_0_0._onOpenViewFinish(arg_13_0, arg_13_1)
	arg_13_0:tryModifyBgm()
end

function var_0_0._onCloseViewFinish(arg_14_0, arg_14_1)
	arg_14_0:tryModifyBgm()
end

function var_0_0.tryModifyBgm(arg_15_0)
	local var_15_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_15_0 = var_15_0 and #var_15_0 or 0, 1, -1 do
		local var_15_1 = var_15_0[iter_15_0]
		local var_15_2, var_15_3 = arg_15_0:viewName2BgmHandle(var_15_1)

		if arg_15_0._playingBgmId and arg_15_0._playingBgmId == var_15_3 then
			break
		end

		if var_15_2 and var_15_3 and var_15_3 ~= 0 then
			var_15_2(arg_15_0, var_15_3)

			arg_15_0._playingBgmId = var_15_3

			break
		end
	end
end

function var_0_0._stopBgm(arg_16_0)
	AudioBgmManager.instance:stopBgm(arg_16_0._bgmLayer)
end

function var_0_0._manualSwitchBgm(arg_17_0)
	arg_17_0:tryModifyBgm()
end

return var_0_0
