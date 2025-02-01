module("modules.logic.fight.view.FightSuccBonusItem", package.seeall)

slot0 = class("FightSuccBonusItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._itemIcon = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot1, "itemIcon"))
	slot0._tagGO = gohelper.findChild(slot1, "tag")
	slot0._imgFirstGO = gohelper.findChild(slot1, "tag/imgFirst")
	slot0._imgNormalGO = gohelper.findChild(slot1, "tag/imgNormal")
	slot0._imgHardGO = gohelper.findChild(slot1, "tag/imgHard")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._itemIcon:onUpdateMO(slot1)
	slot0._itemIcon:setCantJump(true)
end

return slot0
