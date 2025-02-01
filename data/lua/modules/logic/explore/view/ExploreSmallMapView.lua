module("modules.logic.explore.view.ExploreSmallMapView", package.seeall)

slot0 = class("ExploreSmallMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnsmallmap = gohelper.findChildButtonWithAudio(slot0.viewGO, "topright/minimap/#btn_smallmap")
	slot0._keytips = gohelper.findChild(slot0._btnsmallmap.gameObject, "#go_pcbtn1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, slot0.applyRolePos, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, slot0.applyRolePos, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.AreaShow, slot0._areaShowChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.UnitOutlineChange, slot0.outlineChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.MapRotate, slot0.applyRolePos, slot0)
	slot0._btnsmallmap:AddClickListener(slot0._openSmallMap, slot0)
end

function slot0.removeEvents(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, slot0.applyRolePos, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, slot0.applyRolePos, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.AreaShow, slot0._areaShowChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitOutlineChange, slot0.outlineChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.MapRotate, slot0.applyRolePos, slot0)
	slot0._btnsmallmap:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._mapItems = {}
	slot0._mapItemsNoUse = {}
	slot1 = gohelper.findChild(slot0.viewGO, "topright/minimap/mask").transform
	slot0._maskHalfWidth = recthelper.getWidth(slot1) / 2
	slot0._maskHalfHeight = recthelper.getHeight(slot1) / 2
	slot0._container = gohelper.findChild(slot0.viewGO, "topright/minimap/mask/container").transform
	slot0._mapItem = gohelper.findChild(slot0.viewGO, "topright/minimap/mask/container/#go_mapitem")
	slot0._itemWidth = recthelper.getWidth(slot0._mapItem.transform)
	slot0._itemHeight = recthelper.getHeight(slot0._mapItem.transform)
	slot2 = ExploreMapModel.instance.mapBound
	slot0._offsetX = slot2.x
	slot0._offsetY = slot2.z
	slot0._mapWidth = (slot2.y - slot2.x + 1) * slot0._itemWidth
	slot0._mapHeight = (slot2.w - slot2.z + 1) * slot0._itemHeight

	recthelper.setWidth(slot0._container, slot0._mapWidth)
	recthelper.setHeight(slot0._container, slot0._mapHeight)
	slot0:applyRolePos()
	slot0:showKeyTips()
end

function slot0._openSmallMap(slot0)
	ViewMgr.instance:openView(ViewName.ExploreMapView)
end

function slot0.outlineChange(slot0, slot1)
	if slot0._mapItems[slot1] then
		slot0._mapItems[slot1]:updateOutLineIcon()
	end
end

function slot0._areaShowChange(slot0)
	slot0._fromX = nil

	slot0:applyRolePos()
end

function slot0.applyRolePos(slot0, slot1)
	if not slot1 then
		slot0._hero = slot0._hero or ExploreController.instance:getMap():getHero()

		if not slot0._hero then
			return
		end

		slot1 = slot0._hero:getPos()
	end

	slot5 = -(-slot0._offsetX + slot1.x) * slot0._itemWidth
	slot6 = -(-slot0._offsetY + slot1.z) * slot0._itemWidth
	slot7 = math.floor((-slot5 - slot0._maskHalfWidth) / slot0._itemWidth)
	slot8 = math.ceil((-slot5 + slot0._maskHalfWidth) / slot0._itemWidth)
	slot9 = math.floor((-slot6 - slot0._maskHalfHeight) / slot0._itemHeight)
	slot10 = math.ceil((-slot6 + slot0._maskHalfHeight) / slot0._itemHeight)

	if ExploreMapModel.instance.nowMapRotate ~= 0 then
		slot5 = slot6 * math.sin(-slot4 * Mathf.Deg2Rad) + slot5 * math.cos(-slot4 * Mathf.Deg2Rad)
		slot6 = slot6 * math.cos(-slot4 * Mathf.Deg2Rad) + slot5 * math.sin(slot4 * Mathf.Deg2Rad)
	end

	transformhelper.setLocalPosXY(slot0._container, slot5, slot6)
	transformhelper.setLocalRotation(slot0._container, 0, 0, slot4)
	slot0:showMapItem(slot7 + slot0._offsetX, slot9 + slot0._offsetY, slot8 + slot0._offsetX, slot10 + slot0._offsetY)
end

function slot0.showMapItem(slot0, slot1, slot2, slot3, slot4)
	if slot0._fromX == slot1 and slot0._fromY == slot2 and slot0._toX == slot3 and slot0._toY == slot4 then
		for slot8, slot9 in pairs(slot0._mapItems) do
			slot9:updateRotate()
		end

		return
	end

	slot0._toY = slot4
	slot0._toX = slot3
	slot0._fromY = slot2
	slot0._fromX = slot1

	for slot8, slot9 in pairs(slot0._mapItems) do
		slot9:markUse(false)
	end

	slot5 = {}
	slot6 = {}

	for slot10 = slot1, slot3 do
		for slot14 = slot2, slot4 do
			if ExploreMapModel.instance:getNodeIsShow(ExploreHelper.getKeyXY(slot10, slot14)) then
				if slot0._mapItems[slot15] then
					slot0._mapItems[slot15]:markUse(true)

					slot0._mapItems[slot15]._mo.rotate = true

					slot0._mapItems[slot15]:updateRotate()
				else
					slot17 = ExploreHelper.getKeyXY(slot10 - 1, slot14)
					slot5[slot15] = {
						left = not ExploreMapModel.instance:getNodeIsShow(slot17),
						right = not ExploreMapModel.instance:getNodeIsShow(ExploreHelper.getKeyXY(slot10 + 1, slot14)),
						top = not ExploreMapModel.instance:getNodeIsShow(ExploreHelper.getKeyXY(slot10, slot14 + 1)),
						bottom = not ExploreMapModel.instance:getNodeIsShow(ExploreHelper.getKeyXY(slot10, slot14 - 1)),
						key = slot15,
						posY = (slot14 - slot0._offsetY) * slot0._itemHeight,
						posX = (slot10 - slot0._offsetX) * slot0._itemWidth,
						rotate = true
					}

					if slot0._mapItems[slot17] then
						slot0._mapItems[slot17]._mo.right = false
						slot6[slot17] = true
					end

					if slot0._mapItems[slot18] then
						slot0._mapItems[slot18]._mo.left = false
						slot6[slot18] = true
					end

					if slot0._mapItems[slot19] then
						slot0._mapItems[slot19]._mo.bottom = false
						slot6[slot19] = true
					end

					if slot0._mapItems[slot20] then
						slot0._mapItems[slot20]._mo.top = false
						slot6[slot20] = true
					end
				end
			end
		end
	end

	for slot10, slot11 in pairs(slot0._mapItems) do
		if not slot11:getIsUse() then
			table.insert(slot0._mapItemsNoUse, slot11)

			slot0._mapItems[slot10] = nil
			slot6[slot10] = nil
		end
	end

	slot7 = #slot0._mapItemsNoUse

	for slot11, slot12 in pairs(slot5) do
		if slot7 > 0 then
			slot0._mapItems[slot11] = slot0._mapItemsNoUse[slot7]
			slot0._mapItemsNoUse[slot7] = nil
			slot7 = slot7 - 1

			slot0._mapItems[slot11]:markUse()
			slot0._mapItems[slot11]:updateMo(slot12)
			slot0._mapItems[slot11]:updateRotate()
		else
			slot13 = gohelper.cloneInPlace(slot0._mapItem)

			gohelper.setActive(slot13, true)

			slot0._mapItems[slot11] = MonoHelper.addNoUpdateLuaComOnceToGo(slot13, ExploreMapItem, slot12)
		end
	end

	for slot11 in pairs(slot6) do
		slot0._mapItems[slot11]:updateMo(slot0._mapItems[slot11]._mo)
		slot0._mapItems[slot11]:updateRotate()
	end

	for slot11 = 1, slot7 do
		slot0._mapItemsNoUse[slot11]:setActive(false)
	end
end

function slot0.showKeyTips(slot0)
	PCInputController.instance:showkeyTips(slot0._keytips, PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.map)
end

return slot0
