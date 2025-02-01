module("modules.logic.fightresistancetip.controller.FightResistanceTipController", package.seeall)

slot0 = class("FightResistanceTipController")

function slot0.openFightResistanceTipView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.FightResistanceTipView, {
		resistanceDict = slot1,
		screenPos = slot2
	})
end

slot0.instance = slot0.New()

return slot0
