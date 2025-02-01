module("modules.logic.achievement.view.AchievementGroupPreViewContainer", package.seeall)

slot0 = class("AchievementGroupPreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		AchievementGroupPreView.New()
	}
end

return slot0
