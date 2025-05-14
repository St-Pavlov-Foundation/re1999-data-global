module("modules.logic.login.controller.work.LoginEnterMainSceneWork", package.seeall)

local var_0_0 = class("LoginEnterMainSceneWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = CameraMgr.instance:getCameraRootGO()

	transformhelper.setLocalPos(var_2_0.transform, 0, 0, 0)
	MainController.instance:enterMainScene()
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_2_0._enterSceneFinish, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 20)
end

function var_0_0._enterSceneFinish(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == SceneType.Main then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			local var_3_0 = SettingsModel.instance.limitedRoleMO

			if LimitedRoleController.instance:getNeedPlayLimitedCO() and var_3_0:isAuto() then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetManualClose)
				arg_3_0:onDone(true)
			else
				ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
			end
		else
			arg_3_0:onDone(true)
		end
	end
end

function var_0_0._onCloseViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.LoadingView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
		arg_4_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_5_0)
	logError("登录流程，进入主场景超时了！")
	TimeDispatcher.instance:startTick()
	LoginController.instance:dispatchEvent(LoginEvent.OnLoginEnterMainScene)

	LoginController.instance.enteredGame = true

	arg_5_0:onDone(false)
end

function var_0_0.clearWork(arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_6_0._onCloseViewFinish, arg_6_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_6_0._enterSceneFinish, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
end

return var_0_0
