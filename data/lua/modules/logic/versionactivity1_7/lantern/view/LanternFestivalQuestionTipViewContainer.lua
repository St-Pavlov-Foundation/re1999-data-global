module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalQuestionTipViewContainer", package.seeall)

slot0 = class("LanternFestivalQuestionTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LanternFestivalQuestionTipView.New()
	}
end

return slot0
