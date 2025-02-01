module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_EnterViewContainer", package.seeall)

slot0 = class("V1a6_BossRush_EnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_BossRush_EnterView.New()
	}
end

return slot0
