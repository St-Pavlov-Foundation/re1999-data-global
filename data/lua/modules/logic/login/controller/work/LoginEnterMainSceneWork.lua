module("modules.logic.login.controller.work.LoginEnterMainSceneWork", package.seeall)

slot0 = class("LoginEnterMainSceneWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	transformhelper.setLocalPos(CameraMgr.instance:getCameraRootGO().transform, 0, 0, 0)
	MainController.instance:enterMainScene()
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._enterSceneFinish, slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 20)
end

function slot0._enterSceneFinish(slot0, slot1, slot2)
	if slot1 == SceneType.Main then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			if LimitedRoleController.instance:getNeedPlayLimitedCO() and SettingsModel.instance.limitedRoleMO:isAuto() then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetManualClose)
				slot0:onDone(true)
			else
				ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
			end
		else
			slot0:onDone(true)
		end
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.LoadingView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	logError("登录流程，进入主场景超时了！")
	TimeDispatcher.instance:startTick()
	LoginController.instance:dispatchEvent(LoginEvent.OnLoginEnterMainScene)

	LoginController.instance.enteredGame = true

	slot0:onDone(false)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._enterSceneFinish, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
