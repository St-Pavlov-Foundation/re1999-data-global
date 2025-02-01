module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultViewContainer", package.seeall)

slot0 = class("V1a6_BossRush_ResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_BossRush_ResultView.New()
	}
end

return slot0
