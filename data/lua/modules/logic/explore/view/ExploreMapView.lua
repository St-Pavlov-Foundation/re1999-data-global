module("modules.logic.explore.view.ExploreMapView", package.seeall)

slot0 = class("ExploreMapView", BaseView)
slot1 = 0.5
slot2 = 1.5

function slot0.onInitView(slot0)
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")
	slot0._mapContainer = gohelper.findChild(slot0.viewGO, "container/#go_map").transform
	slot0._mapScrollRect = gohelper.findChild(slot0.viewGO, "container")
	slot0._mapItem = gohelper.findChild(slot0.viewGO, "container/#go_map/mapitems/#go_mapitem")
	slot0._heroItem = gohelper.findChild(slot0.viewGO, "container/#go_map/#go_hero").transform
	slot0._txtmapname = gohelper.findChildTextMesh(slot0.viewGO, "top/#txt_mapname")
	slot0._txtmapnameen = gohelper.findChildTextMesh(slot0.viewGO, "top/#txt_mapname/#txt_mapnameen")
	slot0._slider = gohelper.findChildSlider(slot0.viewGO, "Right/#go_mapSlider")
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "#scroll_category")
	slot0._gocategoryParent = gohelper.findChild(slot0.viewGO, "#scroll_category/Viewport/Content")
	slot0._gocategoryItem = gohelper.findChild(slot0.viewGO, "#scroll_category/Viewport/Content/#go_categoryitem")
	slot0._btnCategory = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_tushi")
	slot0._gocategoryon = gohelper.findChild(slot0.viewGO, "Left/#btn_tushi/icon_on")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose1:AddClickListener(slot0.closeThis, slot0)
	slot0._btnclose2:AddClickListener(slot0.closeThis, slot0)
	slot0._btnCategory:AddClickListener(slot0.showHideCategory, slot0)
	slot0._slider:AddOnValueChanged(slot0.onSliderValueChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, slot0.applyRolePos, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, slot0.applyRolePos, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, slot0.onRoleNodeChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.UnitOutlineChange, slot0.outlineChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose1:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
	slot0._btnCategory:RemoveClickListener()
	slot0._slider:RemoveOnValueChanged()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, slot0.applyRolePos, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, slot0.applyRolePos, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, slot0.onRoleNodeChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitOutlineChange, slot0.outlineChange, slot0)
end

function slot0._editableInitView(slot0)
	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._mapContainer.gameObject)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetScrollWheelCb(slot0.onMouseScrollWheelChange, slot0)

	if BootNativeUtil.isMobilePlayer() then
		TaskDispatcher.runRepeat(slot0._checkMultDrag, slot0, 0, -1)
	end

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._mapContainer.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
end

function slot0.showHideCategory(slot0)
	slot1 = not slot0._gocategory.activeSelf

	gohelper.setActive(slot0._gocategory, slot1)
	gohelper.setActive(slot0._gocategoryon, slot1)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)
	gohelper.setActive(slot0._mapItem, false)

	slot2 = ExploreModel.instance:getMapId() and ExploreConfig.instance:getMapIdConfig(slot1)

	if slot2 and lua_episode.configDict[slot2.episodeId] then
		slot0._txtmapname.text = slot3.name
		slot0._txtmapnameen.text = slot3.name_En
	end

	slot0._mapItems = {}
	slot0._containWidth = recthelper.getWidth(slot0._mapScrollRect.transform)
	slot0._containHeight = recthelper.getHeight(slot0._mapScrollRect.transform)
	slot0._itemWidth = recthelper.getWidth(slot0._mapItem.transform)
	slot0._itemHeight = recthelper.getHeight(slot0._mapItem.transform)
	slot4 = ExploreMapModel.instance.mapBound
	slot0._mapWidth = (slot4.y - slot4.x + 1) * slot0._itemWidth
	slot0._mapHeight = (slot4.w - slot4.z + 1) * slot0._itemHeight

	recthelper.setWidth(slot0._mapContainer, slot0._mapWidth)
	recthelper.setHeight(slot0._mapContainer, slot0._mapHeight)

	slot0._hero = ExploreController.instance:getMap():getHero()
	slot5 = slot0._hero:getPos()
	slot0._offsetX = slot4.x
	slot0._offsetY = slot4.z
	slot6 = (slot5.x - slot0._offsetX - 0.5) * slot0._itemWidth
	slot7 = (slot5.z - slot0._offsetY - 0.5) * slot0._itemHeight

	transformhelper.setLocalPosXY(slot0._heroItem, slot6, slot7)
	transformhelper.setLocalPosXY(slot0._mapContainer, -(slot6 + slot0._itemWidth / 2), -(slot7 + slot0._itemHeight / 2))

	slot0._scale = 1

	slot0._slider:SetValue((1 - uv0) / (uv1 - uv0))
	slot0:calcBound()
	gohelper.setActive(slot0._gocategory, false)
	gohelper.setActive(slot0._gocategoryon, false)

	slot11 = {}

	if string.splitToNumber(slot2 and slot2.signsId or "", "#") then
		for slot15, slot16 in ipairs(slot10) do
			table.insert(slot11, lua_explore_signs.configDict[slot16])
		end
	end

	gohelper.CreateObjList(slot0, slot0.onCategoryItem, slot11, slot0._gocategoryParent, slot0._gocategoryItem)
end

function slot0.onCategoryItem(slot0, slot1, slot2, slot3)
	gohelper.findChildTextMesh(slot1, "#txt_name").text = slot2.desc

	UISpriteSetMgr.instance:setExploreSprite(gohelper.findChildImage(slot1, "#txt_name/icon"), slot2.icon)
end

function slot0.onSliderValueChange(slot0)
	slot0:setScale(uv0 + (uv1 - uv0) * slot0._slider:GetValue(), true)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0.startDragPos = slot2.position
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0.startDragPos = nil
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0.startDragPos then
		return
	end

	if UnityEngine.Input.touchCount >= 2 then
		return
	end

	slot3, slot4 = transformhelper.getLocalPos(slot0._mapContainer)
	slot5 = slot2.position
	slot0.startDragPos = slot5

	transformhelper.setLocalPosXY(slot0._mapContainer, slot3 + slot5.x - slot0.startDragPos.x, slot4 + slot5.y - slot0.startDragPos.y)
	slot0:calcBound()
end

function slot0._checkMultDrag(slot0)
	if UnityEngine.Input.touchCount ~= 2 then
		return
	end

	slot2 = UnityEngine.Input.GetTouch(0)
	slot3 = slot2.position
	slot5 = UnityEngine.Input.GetTouch(1)
	slot6 = slot5.position

	if (slot2.phase == TouchPhase.Moved or slot2.phase == TouchPhase.Stationary) and (slot5.phase == TouchPhase.Moved or slot5.phase == TouchPhase.Stationary) then
		slot8 = slot3 - slot2.deltaPosition
		slot9 = slot6 - slot5.deltaPosition

		if Vector2.Distance(slot3, slot6) < 5 or Vector2.Distance(slot8, slot9) < 5 then
			return
		end

		slot0:setScale((0.005 * (Vector2.Distance(slot3, slot6) - Vector2.Distance(slot8, slot9)) + 1) * slot0._scale)
	end
end

function slot0.onScaleHandler(slot0, slot1)
	slot0.startDragPos = nil

	slot0:setScale(slot0._scale * (1 + (slot1 and 0.1 or -0.1)))
end

function slot0.onMouseScrollWheelChange(slot0, slot1)
	slot0:setScale(slot0._scale * (1 + slot1))
end

function slot0.setScale(slot0, slot1, slot2)
	if Mathf.Clamp(slot1, uv0, uv1) == slot0._scale then
		return
	end

	if not slot2 then
		slot0._slider:SetValue((slot1 - uv0) / (uv1 - uv0))
	end

	slot3, slot4 = transformhelper.getLocalPos(slot0._mapContainer)
	slot0._scale = slot1

	transformhelper.setLocalScale(slot0._mapContainer, slot0._scale, slot0._scale, 1)

	slot8 = slot3 / slot0._scale * slot1
	slot9 = slot4 / slot0._scale * slot1

	transformhelper.setLocalPosXY(slot0._mapContainer, slot8, slot9)

	for slot8, slot9 in pairs(slot0._mapItems) do
		slot9:setScale(1 / slot0._scale)
	end

	slot0:calcBound()
end

function slot0.applyRolePos(slot0)
	if not slot0._hero then
		return
	end

	slot1 = slot0._hero:getPos()

	transformhelper.setLocalPosXY(slot0._heroItem, (slot1.x - slot0._offsetX - 0.5) * slot0._itemWidth, (slot1.z - slot0._offsetY - 0.5) * slot0._itemHeight)
end

function slot0.onRoleNodeChange(slot0)
	slot0._fromX = nil

	slot0:calcBound()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._checkMultDrag, slot0)

	slot0._hero = nil
end

function slot0.calcBound(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._mapContainer)

	slot0:showMapItem(math.floor((-slot1 - slot0._containWidth / 2) / slot0._itemWidth / slot0._scale) + slot0._offsetX, math.floor((-slot2 - slot0._containHeight / 2) / slot0._itemHeight / slot0._scale) + slot0._offsetY, math.ceil((-slot1 + slot0._containWidth / 2) / slot0._itemWidth / slot0._scale) + slot0._offsetX, math.ceil((-slot2 + slot0._containHeight / 2) / slot0._itemHeight / slot0._scale) + slot0._offsetY)
end

function slot0.showMapItem(slot0, slot1, slot2, slot3, slot4)
	if slot0._fromX == slot1 and slot0._fromY == slot2 and slot0._toX == slot3 and slot0._toY == slot4 then
		return
	end

	slot0._toY = slot4
	slot0._toX = slot3
	slot0._fromY = slot2
	slot0._fromX = slot1
	slot5 = {}

	for slot9 = slot1, slot3 do
		for slot13 = slot2, slot4 do
			if not slot0._mapItems[ExploreHelper.getKeyXY(slot9, slot13)] and (ExploreMapModel.instance:getNodeIsShow(slot14) or ExploreMapModel.instance:getNodeIsBound(slot14)) then
				gohelper.setActive(gohelper.cloneInPlace(slot0._mapItem), true)

				slot18 = ExploreHelper.getKeyXY(slot9 + 1, slot13)
				slot19 = ExploreHelper.getKeyXY(slot9, slot13 + 1)
				slot20 = ExploreHelper.getKeyXY(slot9, slot13 - 1)

				if ({
					bound = ExploreMapModel.instance:getNodeBoundType(slot14),
					left = not ExploreMapModel.instance:getNodeIsShow(ExploreHelper.getKeyXY(slot9 - 1, slot13)) and not ExploreMapModel.instance:getNodeIsBound(slot17),
					right = not ExploreMapModel.instance:getNodeIsShow(slot18) and not ExploreMapModel.instance:getNodeIsBound(slot18),
					top = not ExploreMapModel.instance:getNodeIsShow(slot19) and not ExploreMapModel.instance:getNodeIsBound(slot19),
					bottom = not ExploreMapModel.instance:getNodeIsShow(slot20) and not ExploreMapModel.instance:getNodeIsBound(slot20)
				}).bound then
					slot16.left = slot16.left and (slot16.bound == 7 or slot16.bound == 8)
					slot16.right = slot16.right and (slot16.bound == 7 or slot16.bound == 8)
					slot16.top = slot16.top and (slot16.bound == 5 or slot16.bound == 6)
					slot16.bottom = slot16.bottom and (slot16.bound == 5 or slot16.bound == 6)
				end

				slot16.posY = (slot13 - slot0._offsetY) * slot0._itemHeight
				slot16.posX = (slot9 - slot0._offsetX) * slot0._itemWidth
				slot16.key = slot14
				slot0._mapItems[slot14] = MonoHelper.addNoUpdateLuaComOnceToGo(slot15, ExploreMapItem, slot16)

				slot0._mapItems[slot14]:setScale(1 / slot0._scale)

				if slot0._mapItems[slot17] then
					slot0._mapItems[slot17]._mo.right = false
					slot5[slot17] = true
				end

				if slot0._mapItems[slot18] then
					slot0._mapItems[slot18]._mo.left = false
					slot5[slot18] = true
				end

				if slot0._mapItems[slot19] then
					slot0._mapItems[slot19]._mo.bottom = false
					slot5[slot19] = true
				end

				if slot0._mapItems[slot20] then
					slot0._mapItems[slot20]._mo.top = false
					slot5[slot20] = true
				end
			elseif slot0._mapItems[slot14] and slot0._mapItems[slot14]._mo.bound ~= ExploreMapModel.instance:getNodeBoundType(slot14) then
				slot16 = ExploreHelper.getKeyXY(slot9 + 1, slot13)
				slot17 = ExploreHelper.getKeyXY(slot9, slot13 + 1)
				slot18 = ExploreHelper.getKeyXY(slot9, slot13 - 1)
				slot19 = slot0._mapItems[slot14]._mo
				slot19.left = not ExploreMapModel.instance:getNodeIsShow(ExploreHelper.getKeyXY(slot9 - 1, slot13)) and not ExploreMapModel.instance:getNodeIsBound(slot15)
				slot19.right = not ExploreMapModel.instance:getNodeIsShow(slot16) and not ExploreMapModel.instance:getNodeIsBound(slot16)
				slot19.top = not ExploreMapModel.instance:getNodeIsShow(slot17) and not ExploreMapModel.instance:getNodeIsBound(slot17)
				slot19.bottom = not ExploreMapModel.instance:getNodeIsShow(slot18) and not ExploreMapModel.instance:getNodeIsBound(slot18)
				slot19.bound = ExploreMapModel.instance:getNodeBoundType(slot14)

				slot0._mapItems[slot14]:updateMo(slot19)
			end
		end
	end

	for slot9 in pairs(slot5) do
		slot0._mapItems[slot9]:updateMo(slot0._mapItems[slot9]._mo)
	end
end

function slot0.outlineChange(slot0, slot1)
	if slot0._mapItems[slot1] then
		slot0._mapItems[slot1]:updateOutLineIcon()
	end
end

function slot0.onDestroyView(slot0)
	if slot0._touchEventMgr then
		TouchEventMgrHepler.remove(slot0._touchEventMgr)

		slot0._touchEventMgr = nil
	end

	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
end

return slot0
