module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterBgmView", package.seeall)

local var_0_0 = class("VersionActivity1_7EnterBgmView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_4_0.onSelectActId, arg_4_0, LuaEventSystem.Low)
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = VersionActivityEnterHelper.getTabIndex(arg_5_0.viewParam.activityIdList, arg_5_0.viewParam.jumpActId)
	local var_5_1 = VersionActivityEnterHelper.getActId(arg_5_0.viewParam.activityIdList[var_5_0])

	arg_5_0._isFirstOpenMainAct = var_5_1 == VersionActivity1_7Enum.ActivityId.Dungeon

	arg_5_0:modifyBgm(var_5_1)

	arg_5_0._isFirstOpenMainAct = false
end

function var_0_0.onSelectActId(arg_6_0, arg_6_1)
	arg_6_0:modifyBgm(arg_6_1)
end

function var_0_0.initActHandle(arg_7_0)
	if not arg_7_0.actHandleDict then
		arg_7_0.actHandleDict = {
			[VersionActivity1_7Enum.ActivityId.BossRush] = arg_7_0.playBossRushBgm
		}
	end
end

function var_0_0.modifyBgm(arg_8_0, arg_8_1)
	arg_8_0._isMainAct = arg_8_1 == VersionActivity1_7Enum.ActivityId.Dungeon

	local var_8_0 = 0

	if arg_8_0._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_7Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		if arg_8_0._isFirstOpenMainAct then
			arg_8_0._isFirstOpenMainAct = false
			var_8_0 = 3.5

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Enter.play_ui_jinye_open)
		else
			var_8_0 = 1

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_7Enter.play_ui_jinye_unfold)
		end
	end

	arg_8_0._actId = arg_8_1

	TaskDispatcher.cancelTask(arg_8_0._delayModifyBgm, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._delayModifyBgm, arg_8_0, var_8_0)
end

function var_0_0._delayModifyBgm(arg_9_0)
	arg_9_0:_doModifyBgm(arg_9_0._actId)
end

function var_0_0._doModifyBgm(arg_10_0, arg_10_1)
	arg_10_0:initActHandle()
	;(arg_10_0.actHandleDict[arg_10_1] or arg_10_0.defaultBgmHandle)(arg_10_0, arg_10_1)
end

function var_0_0.defaultBgmHandle(arg_11_0, arg_11_1)
	if arg_11_0.playingActId == arg_11_1 then
		return
	end

	arg_11_0.playingActId = arg_11_1

	local var_11_0 = ActivityConfig.instance:getActivityEnterViewBgm(arg_11_1)

	if var_11_0 == 0 then
		logError("actId : " .. tostring(arg_11_1) .. " 没有配置背景音乐")

		var_11_0 = AudioEnum.Bgm.Act1_7DungeonBgm
	end

	if var_11_0 == arg_11_0.bgmId and not arg_11_0._isMainAct then
		return
	end

	arg_11_0.bgmId = var_11_0

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_7Main, var_11_0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function var_0_0.playBossRushBgm(arg_12_0, arg_12_1)
	arg_12_0.playingActId = arg_12_1

	local var_12_0 = ActivityConfig.instance:getActivityEnterViewBgm(arg_12_1)

	arg_12_0.bgmId = var_12_0

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_7Main, var_12_0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm, nil, nil, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._delayModifyBgm, arg_13_0)
end

return var_0_0
