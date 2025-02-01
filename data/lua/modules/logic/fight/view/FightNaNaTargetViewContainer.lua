module("modules.logic.fight.view.FightNaNaTargetViewContainer", package.seeall)

slot0 = class("FightNaNaTargetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FightNaNaTargetView.New())

	return slot1
end

return slot0
