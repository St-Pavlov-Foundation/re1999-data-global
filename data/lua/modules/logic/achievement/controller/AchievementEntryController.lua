module("modules.logic.achievement.controller.AchievementEntryController", package.seeall)

slot0 = class("AchievementEntryController", BaseController)

function slot0.onOpenView(slot0)
	AchievementEntryModel.instance:initData()
end

function slot0.onCloseView(slot0)
end

function slot0.updateAchievementState(slot0)
	AchievementEntryModel.instance:initData()
end

slot0.instance = slot0.New()

return slot0
