module("modules.logic.bossrush.view.V1a4_BossRush_ResultViewContainer", package.seeall)

slot0 = class("V1a4_BossRush_ResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a4_BossRush_ResultView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
