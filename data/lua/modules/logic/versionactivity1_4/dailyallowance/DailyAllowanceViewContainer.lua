module("modules.logic.versionactivity1_4.dailyallowance.DailyAllowanceViewContainer", package.seeall)

slot0 = class("DailyAllowanceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DailyAllowanceView.New()
	}
end

return slot0
