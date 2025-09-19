module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryLoadingView", package.seeall)

local var_0_0 = class("VersionActivity2_8BossStoryLoadingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosnow = gohelper.findChild(arg_1_0.viewGO, "#go_snow")

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
	arg_4_0:addEventCb(GameSceneMgr.instance, SceneEventName.CanCloseLoading, arg_4_0._onCanCloseLoading, arg_4_0)
end

function var_0_0._onCanCloseLoading(arg_5_0)
	arg_5_0._canClose = true

	arg_5_0:_checkClose()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_showSnowEffect()
	TaskDispatcher.cancelTask(arg_7_0.closeThis, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0.closeThis, arg_7_0, 10)
end

function var_0_0._showSnowEffect(arg_8_0)
	if not arg_8_0._snowGo then
		local var_8_0 = arg_8_0.viewContainer._viewSetting.otherRes[1]

		arg_8_0._snowGo = arg_8_0:getResInst(var_8_0, arg_8_0._gosnow)
	end

	gohelper.setActive(arg_8_0._gosnow, true)

	arg_8_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_8_0._snowGo)

	arg_8_0._animatorPlayer:Play("start", arg_8_0._onStartDone, arg_8_0)
	AudioMgr.instance:trigger(AudioEnum2_8.BossStory.play_ui_fuleyuan_boss_snow)
end

function var_0_0._onStartDone(arg_9_0)
	arg_9_0._startAnimDone = true

	arg_9_0:_checkClose()
end

function var_0_0._checkClose(arg_10_0)
	if arg_10_0._canClose and arg_10_0._startAnimDone then
		TaskDispatcher.cancelTask(arg_10_0.closeThis, arg_10_0)
		TaskDispatcher.runDelay(arg_10_0.closeThis, arg_10_0, 1)
		arg_10_0._animatorPlayer:Play("end", arg_10_0._onEndDone, arg_10_0)
	end
end

function var_0_0._onEndDone(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.closeThis, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
