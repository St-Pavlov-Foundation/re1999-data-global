module("modules.logic.fightresistancetip.view.FightResistanceTipViewContainer", package.seeall)

slot0 = class("FightResistanceTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FightResistanceTipView.New())

	return slot1
end

return slot0
