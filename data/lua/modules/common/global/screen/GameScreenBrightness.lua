module("modules.common.global.screen.GameScreenBrightness", package.seeall)

local var_0_0 = class("GameScreenBrightness")

function var_0_0.ctor(arg_1_0)
	if BootNativeUtil.isAndroid() or BootNativeUtil.isIOS() then
		arg_1_0:_setScreenLightingOff(false)
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
		StoryController.instance:registerCallback(StoryEvent.RefreshStep, arg_1_0._onRefreshState, arg_1_0)
		StoryController.instance:registerCallback(StoryEvent.Auto, arg_1_0._refreshAutoState, arg_1_0)
		StoryController.instance:registerCallback(StoryEvent.Finish, arg_1_0._onStoryFinished, arg_1_0)
		StoryController.instance:registerCallback(StoryEvent.Log, arg_1_0._refreshAutoState, arg_1_0)
		SettingsController.instance:registerCallback(SettingsEvent.OnChangeEnergyMode, arg_1_0._onChangeEnergyMode, arg_1_0)
	end
end

function var_0_0._onChangeEnergyMode(arg_2_0)
	local var_2_0 = GameSceneMgr.instance:getCurSceneType()

	arg_2_0:_setScreenLightingOff(var_2_0 == SceneType.Fight)
end

function var_0_0._onEnterOneSceneFinish(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:_setScreenLightingOff(arg_3_1 == SceneType.Fight)
end

function var_0_0._onRefreshState(arg_4_0, arg_4_1)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	if #arg_4_1.branches > 0 then
		arg_4_0:_setScreenLightingOff(true)

		return
	end

	arg_4_0._stepCo = StoryStepModel.instance:getStepListById(arg_4_1.stepId)

	arg_4_0:_refreshAutoState()
end

function var_0_0._refreshAutoState(arg_5_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	if StoryModel.instance:isStoryAuto() then
		arg_5_0:_setScreenLightingOff(true)

		return
	end

	local var_5_0 = false

	if arg_5_0._stepCo then
		local var_5_1 = StoryModel.instance:isLimitNoInteractLock(arg_5_0._stepCo)

		if arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.None or arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog or arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or var_5_1 then
			var_5_0 = true
		end
	end

	arg_5_0:_setScreenLightingOff(var_5_0)
end

function var_0_0._onStoryFinished(arg_6_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	arg_6_0:_setScreenLightingOff(false)
end

function var_0_0._setScreenLightingOff(arg_7_0, arg_7_1)
	if SettingsModel.instance:getEnergyMode() == 0 then
		SDKMgr.instance:setScreenLightingOff(true)
	else
		SDKMgr.instance:setScreenLightingOff(arg_7_1)
	end
end

return var_0_0
