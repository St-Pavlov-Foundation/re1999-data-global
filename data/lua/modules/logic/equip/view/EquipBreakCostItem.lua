module("modules.logic.equip.view.EquipBreakCostItem", package.seeall)

slot0 = class("EquipBreakCostItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._icon = gohelper.findChild(slot0.viewGO, "icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._item = IconMgr.instance:getCommonItemIcon(slot0._icon)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._item:setMOValue(slot0._mo.type, slot0._mo.id, slot0._mo.quantity)

	if slot0._mo.quantity <= ItemModel.instance:getItemQuantity(slot0._mo.type, slot0._mo.id) then
		slot0._item:getCount().text = tostring(GameUtil.numberDisplay(slot3)) .. "/" .. tostring(GameUtil.numberDisplay(slot0._mo.quantity))
	else
		slot2.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(slot3)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(slot0._mo.quantity))
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
