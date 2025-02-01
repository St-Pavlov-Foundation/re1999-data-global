module("modules.logic.toughbattle.view.ToughBattleEnemyInfoViewContainer", package.seeall)

slot0 = class("ToughBattleEnemyInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ToughBattleEnemyInfoView.New()
	}
end

return slot0
