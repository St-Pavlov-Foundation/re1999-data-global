module("modules.logic.battlepass.view.BpBuyBonusItem", package.seeall)

slot0 = class("BpBuyBonusItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0.go)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1

	slot0._itemIcon:setMOValue(slot0.mo[1], slot0.mo[2], slot0.mo[3], nil, true)
	slot0._itemIcon:isShowCount(slot0.mo[1] ~= MaterialEnum.MaterialType.Hero)
	slot0._itemIcon:setCountFontSize(40)
	slot0._itemIcon:setScale(0.8)
	slot0._itemIcon:showStackableNum2()
	slot0._itemIcon:setHideLvAndBreakFlag(true)
	slot0._itemIcon:hideEquipLvAndBreak(true)
end

function slot0.onDestroyView(slot0)
	if slot0._itemIcon then
		slot0._itemIcon:onDestroy()
	end

	slot0._itemIcon = nil
end

return slot0
