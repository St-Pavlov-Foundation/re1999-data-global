module("modules.logic.main.controller.work.MainLimitedRoleEffect", package.seeall)

local var_0_0 = class("MainLimitedRoleEffect", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = LimitedRoleController.instance:getNeedPlayLimitedCO()

	if var_1_0 then
		local var_1_1 = SettingsModel.instance.limitedRoleMO

		if var_1_1:isAuto() then
			if var_1_1:isEveryLogin() or not var_1_1:getTodayHasPlay() then
				SettingsModel.instance.limitedRoleMO:setTodayHasPlay()
				LimitedRoleController.instance:registerCallback(LimitedRoleController.VideoState, arg_1_0._onVideoState, arg_1_0)
				LimitedRoleController.instance:play(LimitedRoleEnum.Stage.FirstLogin, var_1_0, arg_1_0._doneCallback, arg_1_0)
			else
				GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
				arg_1_0:onDone(true)
			end
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
			arg_1_0:onDone(true)
		end
	else
		GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
		arg_1_0:onDone(true)
	end
end

function var_0_0._doneCallback(arg_2_0)
	if SDKMgr.instance:isEmulator() then
		PlayerPrefsHelper.save()
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	arg_2_0:onDone(true)
end

function var_0_0._onVideoState(arg_3_0, arg_3_1)
	if arg_3_1 == AvProEnum.PlayerStatus.Started then
		LimitedRoleController.instance:unregisterCallback(LimitedRoleController.VideoState, arg_3_0._onVideoState, arg_3_0)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	end
end

function var_0_0.clearWork(arg_4_0)
	LimitedRoleController.instance:stop()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	LimitedRoleController.instance:unregisterCallback(LimitedRoleController.VideoState, arg_4_0._onVideoState, arg_4_0)
end

return var_0_0
