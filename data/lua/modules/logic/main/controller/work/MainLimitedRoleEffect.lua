module("modules.logic.main.controller.work.MainLimitedRoleEffect", package.seeall)

slot0 = class("MainLimitedRoleEffect", BaseWork)

function slot0.onStart(slot0, slot1)
	if LimitedRoleController.instance:getNeedPlayLimitedCO() then
		if SettingsModel.instance.limitedRoleMO:isAuto() then
			if slot3:isEveryLogin() or not slot3:getTodayHasPlay() then
				SettingsModel.instance.limitedRoleMO:setTodayHasPlay()
				LimitedRoleController.instance:registerCallback(LimitedRoleController.VideoState, slot0._onVideoState, slot0)
				LimitedRoleController.instance:play(LimitedRoleEnum.Stage.FirstLogin, slot2, slot0._doneCallback, slot0)
			else
				GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
				slot0:onDone(true)
			end
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
			slot0:onDone(true)
		end
	else
		GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
		slot0:onDone(true)
	end
end

function slot0._doneCallback(slot0)
	if SDKMgr.instance:isEmulator() then
		PlayerPrefsHelper.save()
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	slot0:onDone(true)
end

function slot0._onVideoState(slot0, slot1)
	if slot1 == AvProEnum.PlayerStatus.Started then
		LimitedRoleController.instance:unregisterCallback(LimitedRoleController.VideoState, slot0._onVideoState, slot0)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	end
end

function slot0.clearWork(slot0)
	LimitedRoleController.instance:stop()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
	LimitedRoleController.instance:unregisterCallback(LimitedRoleController.VideoState, slot0._onVideoState, slot0)
end

return slot0
