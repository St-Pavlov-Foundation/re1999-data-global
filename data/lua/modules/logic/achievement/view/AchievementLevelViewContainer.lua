module("modules.logic.achievement.view.AchievementLevelViewContainer", package.seeall)

slot0 = class("AchievementLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		AchievementLevelView.New()
	}
end

return slot0
