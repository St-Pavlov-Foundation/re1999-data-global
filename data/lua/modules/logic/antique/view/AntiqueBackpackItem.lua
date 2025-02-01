module("modules.logic.antique.view.AntiqueBackpackItem", package.seeall)

slot0 = class("AntiqueBackpackItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot1)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._itemIcon:setMOValue(MaterialEnum.MaterialType.Antique, slot1.id, 1)
	slot0._itemIcon:isShowCount(false)
	slot0._itemIcon:isShowName(true)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._showItem, slot0)
end

return slot0
