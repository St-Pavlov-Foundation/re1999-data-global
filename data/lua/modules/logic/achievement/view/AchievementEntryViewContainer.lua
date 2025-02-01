module("modules.logic.achievement.view.AchievementEntryViewContainer", package.seeall)

slot0 = class("AchievementEntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		AchievementEntryView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, slot0.closeCallback)

		return {
			slot0.navigateView
		}
	end
end

function slot0.closeCallback(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_close)
end

return slot0
