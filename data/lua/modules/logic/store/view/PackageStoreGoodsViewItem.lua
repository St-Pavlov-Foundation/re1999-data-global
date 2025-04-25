module("modules.logic.store.view.PackageStoreGoodsViewItem", package.seeall)

slot0 = class("PackageStoreGoodsViewItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1
	slot0._gogoods = gohelper.findChild(slot0.viewGO, "go_goods")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "go_goods/#go_icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot4 = slot1[3]
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(tonumber(slot1[1]), slot1[2], true)

	if not slot0._itemIcon then
		slot0._itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0._goicon)
	end

	slot0._itemIcon:setMOValue(slot2, slot3, slot4, nil, true)
	slot0._itemIcon:hideExpEquipState()
	slot0._itemIcon:isShowName(false)

	if slot0._itemIcon:isEquipIcon() then
		slot0._itemIcon:isShowEquipAndItemCount(true)
	end

	slot0._itemIcon:setCountFontSize(36)
	slot0._itemIcon:hideEquipLvAndBreak(true)
	slot0._itemIcon:showEquipRefineContainer(false)
	slot0._itemIcon:setScale(0.7)
	slot0._itemIcon:SetCountLocalY(43.6)
	slot0._itemIcon:SetCountBgHeight(25)
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.onDestroyView(slot0)
	slot0:__onDispose()
end

return slot0
