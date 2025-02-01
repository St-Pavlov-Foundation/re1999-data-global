module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultPanelContainer", package.seeall)

slot0 = class("V1a6_BossRush_ResultPanelContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {
		V1a6_BossRush_ResultPanel.New()
	}

	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		table.insert(slot1, FightGMRecordView.New())
	end

	return slot1
end

return slot0
