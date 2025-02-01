module("modules.logic.login.controller.work.LogoutVoicePackageDonwloadWork", package.seeall)

slot0 = class("LogoutVoicePackageDonwloadWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	if slot1.isVoicePackageDonwload then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
		SettingsVoicePackageController.instance:initData(slot0.onVoicePackageLoadDone, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0.onVoicePackageLoadDone(slot0)
	slot0:onDone(true)
end

return slot0
