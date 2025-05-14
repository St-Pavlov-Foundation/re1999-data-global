module("modules.logic.versionactivity2_2.enter.view.VersionActivity2_2EnterBgmView", package.seeall)

local var_0_0 = class("VersionActivity2_2EnterBgmView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_2_0.onSelectActId, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_3_0.onSelectActId, arg_3_0, LuaEventSystem.Low)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:initActHandle()
end

function var_0_0.initActHandle(arg_5_0)
	if not arg_5_0.actHandleDict then
		arg_5_0.actHandleDict = {
			[BossRushConfig.instance:getActivityId()] = arg_5_0._bossrushBgmHandle,
			[VersionActivity2_2Enum.ActivityId.Lopera] = arg_5_0._loperaBgmHandle
		}
	end
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.activitySettingList or {}
	local var_6_1 = var_6_0[VersionActivityEnterHelper.getTabIndex(var_6_0, arg_6_0.viewParam.jumpActId)]
	local var_6_2 = VersionActivityEnterHelper.getActId(var_6_1)

	arg_6_0._isFirstOpenMainAct = var_6_2 == VersionActivity2_2Enum.ActivityId.Dungeon

	arg_6_0:modifyBgm(var_6_2)

	arg_6_0._isFirstOpenMainAct = false
end

function var_0_0.onSelectActId(arg_7_0, arg_7_1)
	arg_7_0:modifyBgm(arg_7_1)
end

function var_0_0.modifyBgm(arg_8_0, arg_8_1)
	arg_8_0._isMainAct = arg_8_1 == VersionActivity2_2Enum.ActivityId.Dungeon

	local var_8_0 = 0

	if arg_8_0._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity2_2Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		arg_8_0.playingActId = nil
		arg_8_0.bgmId = nil

		if arg_8_0._isFirstOpenMainAct then
			arg_8_0._isFirstOpenMainAct = false
			var_8_0 = 3.5

			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Enter.play_ui_jinye_open)
		else
			var_8_0 = 1

			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Enter.play_ui_jinye_unfold)
		end
	end

	arg_8_0._actId = arg_8_1

	TaskDispatcher.cancelTask(arg_8_0._doModifyBgm, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._doModifyBgm, arg_8_0, var_8_0)
end

function var_0_0._doModifyBgm(arg_9_0)
	(arg_9_0.actHandleDict[arg_9_0._actId] or arg_9_0.defaultBgmHandle)(arg_9_0, arg_9_0._actId)
end

function var_0_0.defaultBgmHandle(arg_10_0, arg_10_1)
	if arg_10_0.playingActId == arg_10_1 then
		return
	end

	arg_10_0.playingActId = arg_10_1

	local var_10_0 = ActivityConfig.instance:getActivityEnterViewBgm(arg_10_1)

	if var_10_0 == 0 then
		logError("actId : " .. tostring(arg_10_1) .. " 没有配置背景音乐")

		var_10_0 = AudioEnum.Bgm.Act2_0DungeonBgm
	end

	if not arg_10_0._isMainAct and var_10_0 == arg_10_0.bgmId then
		return
	end

	arg_10_0.bgmId = var_10_0

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_2Main)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_2Main, var_10_0)
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._doModifyBgm, arg_11_0)
end

function var_0_0._bossrushBgmHandle(arg_12_0, arg_12_1)
	arg_12_0.playingActId = arg_12_1

	local var_12_0 = ActivityConfig.instance:getActivityEnterViewBgm(arg_12_1)

	arg_12_0.bgmId = var_12_0

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_2Main, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_2Main, var_12_0)
end

function var_0_0._loperaBgmHandle(arg_13_0, arg_13_1)
	arg_13_0.playingActId = arg_13_1

	local var_13_0 = ActivityConfig.instance:getActivityEnterViewBgm(arg_13_1)

	arg_13_0.bgmId = var_13_0

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_2Main, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_2Main, var_13_0)
end

function var_0_0._reactivityBgmHandle(arg_14_0, arg_14_1)
	arg_14_0.playingActId = arg_14_1

	local var_14_0 = ActivityConfig.instance:getActivityEnterViewBgm(arg_14_1)

	arg_14_0.bgmId = var_14_0

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_2Main, "music_vocal_filter", "original")
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_2Main, var_14_0)
end

return var_0_0
