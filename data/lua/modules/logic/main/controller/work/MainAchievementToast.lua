module("modules.logic.main.controller.work.MainAchievementToast", package.seeall)

slot0 = class("MainAchievementToast", BaseWork)

function slot0.onStart(slot0, slot1)
	AchievementToastController.instance:dispatchEvent(AchievementEvent.LoginShowToast)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
