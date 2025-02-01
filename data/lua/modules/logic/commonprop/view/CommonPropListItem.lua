module("modules.logic.commonprop.view.CommonPropListItem", package.seeall)

slot0 = class("CommonPropListItem", CommonPropItemIcon)
slot0.hasOpen = false

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
end

function slot0.setMOValue(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0._isEquip = tonumber(slot1) == MaterialEnum.MaterialType.Equip
	slot0._type = slot1
	slot0._id = slot2
	slot0._quantity = slot3
	slot0._uid = slot4
	slot0._isGold = slot6
	slot0._roomBuildingLevel = slot7

	if uv0.hasOpen then
		slot0:_playInEffect()
	else
		TaskDispatcher.runDelay(slot0._playInEffect, slot0, 0.06 * slot0._index)
	end

	gohelper.setActive(slot0._nameTxt.gameObject, uv0.hasOpen and slot0._isEquip)
	gohelper.setActive(slot0._goequip, uv0.hasOpen and slot0._isEquip)
	gohelper.setActive(slot0._goitem, uv0.hasOpen and not slot0._isEquip)
end

function slot0._playInEffect(slot0)
	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(slot0._type, slot0._id)
	slot3 = slot1.rare

	if not slot1.rare and (slot0._type == MaterialEnum.MaterialType.PlayerCloth or slot0._type == MaterialEnum.MaterialType.Antique) then
		slot3 = 5
	end

	for slot7, slot8 in ipairs(slot0._rareInGos) do
		if slot7 == slot3 then
			gohelper.setActive(slot8, true)

			if not uv0.hasOpen then
				if slot0._index <= 10 then
					gohelper.setActive(slot8, true)
					slot8:GetComponent(typeof(UnityEngine.Animation)):Play()
				else
					gohelper.setActive(slot8, false)
				end

				TaskDispatcher.runDelay(slot0._setItem, slot0, 0.5)
			else
				gohelper.setActive(slot8, false)
				slot0:_setItem()
			end
		else
			gohelper.setActive(slot8, false)
		end
	end

	slot0:showHighQualityEffect(slot0._type, slot1, slot3)
end

function slot0._setItem(slot0)
	gohelper.setActive(slot0._nameTxt.gameObject, slot0._isEquip)
	gohelper.setActive(slot0._goequip, slot0._isEquip)
	gohelper.setActive(slot0._goitem, not slot0._isEquip)
	gohelper.setActive(slot0._gogold, slot0._isGold)

	if slot0._index == 10 then
		uv0.hasOpen = true
	end

	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(slot0._type, slot0._id)

	if slot0._isEquip then
		if not slot0._equipIcon then
			slot0._equipIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip, 1)

			slot0._equipIcon:addClick()
		end

		slot0._equipIcon:setMOValue(slot0._type, slot0._id, slot0._quantity, slot0._uid)
		slot0._equipIcon:setCantJump(true)
		slot0._equipIcon:isShowRefineLv(true)
		slot0._equipIcon:playEquipAnim(UIAnimationName.Open)

		slot0._nameTxt.text = slot1.name
	else
		slot0._itemIcon = slot0._itemIcon or IconMgr.instance:getCommonItemIcon(slot0._goitem)

		slot0._itemIcon:setMOValue(slot0._type, slot0._id, slot0._quantity, slot0._uid, true)
		slot0._itemIcon:refreshDeadline(true)
		slot0._itemIcon:showName()
		slot0._itemIcon:playAnimation()
		slot0._itemIcon:setCantJump(true)

		slot3 = nil

		if slot0._type == MaterialEnum.MaterialType.Building and slot0._roomBuildingLevel and slot0._roomBuildingLevel > 0 then
			slot3 = RoomConfig.instance:getLevelGroupConfig(slot0._id, slot0._roomBuildingLevel) and ResUrl.getRoomBuildingPropIcon(slot4.icon)
		end

		slot0._itemIcon:setSpecificIcon(slot3)
		slot0._itemIcon:setRoomBuildingLevel(slot0._roomBuildingLevel)
	end

	if slot0.callback then
		slot0:callback()
	end
end

function slot0.hideName(slot0)
	if slot0._isEquip then
		slot0._nameTxt.text = ""
	elseif slot0._itemIcon then
		slot0._itemIcon:isShowName()
	end
end

function slot0.onDestroy(slot0)
	slot0.callback = nil

	TaskDispatcher.cancelTask(slot0._playInEffect, slot0)
	TaskDispatcher.cancelTask(slot0._setItem, slot0)
end

return slot0
