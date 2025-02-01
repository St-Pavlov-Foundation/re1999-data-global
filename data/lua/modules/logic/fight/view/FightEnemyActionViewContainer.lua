module("modules.logic.fight.view.FightEnemyActionViewContainer", package.seeall)

slot0 = class("FightEnemyActionViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FightEnemyActionView.New())

	return slot1
end

return slot0
