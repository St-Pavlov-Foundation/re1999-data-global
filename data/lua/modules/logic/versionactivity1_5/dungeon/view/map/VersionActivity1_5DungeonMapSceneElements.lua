module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapSceneElements", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapSceneElements", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._elementCompDict = {}
	slot0._elementCompPoolDict = {}
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gofullscreen)

	slot0._click:AddClickDownListener(slot0.onClickDown, slot0)
	slot0._click:AddClickUpListener(slot0.onClickUp, slot0)

	slot0.goTimeParentTr = gohelper.findChildComponent(slot0.viewGO, "#go_maptime", typeof(UnityEngine.RectTransform))
	slot0.goTimeContainer = slot0.goTimeParentTr.gameObject
	slot0.goTimeItem = gohelper.findChild(slot0.viewGO, "#go_maptime/#go_timeitem")

	gohelper.setActive(slot0.goTimeItem, false)
	gohelper.setActive(slot0.goTimeContainer, true)

	slot0.hadEverySecondTask = false
	slot0.elementTimeItemDict = {}
	slot0.timeItemPool = {}
	slot0.tempPos = Vector3.New(0, 0, 0)

	slot0:customAddEvent()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clearElements()
	slot0._click:RemoveClickDownListener()
	slot0._click:RemoveClickUpListener()
end

function slot0.customAddEvent(slot0)
	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, slot0.onGamepadKeyDown, slot0)
	end

	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnBeginDragMap, slot0.onBeginDragMap, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, slot0.onCreateMapRootGoDone, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnAddElements, slot0.onAddElements, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, slot0.showElements, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, slot0.onDisposeOldMap, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, slot0.onDisposeScene, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, slot0.onChangeMap, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, slot0.onHideInteractUI, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, slot0.onAddDispatchInfo, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, slot0.onRemoveDispatchInfo, slot0)
end

function slot0.onGamepadKeyDown(slot0, slot1)
	if slot1 == GamepadEnum.KeyCode.A then
		slot2 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())

		for slot8 = 0, UnityEngine.Physics2D.RaycastAll(slot2.origin, slot2.direction).Length - 1 do
			if MonoHelper.getLuaComFromGo(slot3[slot8].transform.parent.gameObject, VersionActivity1_5DungeonMapElement) then
				slot10:_onClickDown()

				return
			end
		end
	end
end

function slot0.setMouseElementDown(slot0, slot1)
	slot0.mouseDownElement = slot1
end

function slot0.onBeginDragMap(slot0)
	slot0._clickDown = false
end

function slot0.onClickDown(slot0)
	slot0._clickDown = true
end

function slot0.onClickUp(slot0)
	slot1 = slot0.mouseDownElement
	slot0.mouseDownElement = nil

	if not slot0._clickDown then
		return
	end

	if not slot1 then
		return
	end

	if DungeonMapModel.instance:elementIsFinished(slot1:getElementId()) then
		return
	end

	if not slot1:isValid() then
		return
	end

	slot1:onClick()
end

function slot0.onClickElement(slot0, slot1)
	slot0:hideTimeContainer()
	slot0:hideAllElements()
end

function slot0.onHideInteractUI(slot0)
	slot0:showTimeContainer()
	slot0:showAllElements()
end

function slot0.onCreateMapRootGoDone(slot0, slot1)
	if slot0.elementPoolRoot then
		return
	end

	slot0.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(slot1, slot0.elementPoolRoot)
	gohelper.setActive(slot0.elementPoolRoot, false)
	transformhelper.setLocalPos(slot0.elementPoolRoot.transform, 0, 0, 0)
end

function slot0.loadSceneFinish(slot0, slot1)
	slot0._mapCfg = slot1.mapConfig
	slot0._sceneGo = slot1.mapSceneGo
	slot0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(slot0._sceneGo, slot0._elementRoot)
end

function slot0.onDisposeScene(slot0)
	slot0:clearElements()
end

function slot0.onDisposeOldMap(slot0, slot1)
	slot0:recycleAllElements()

	slot0._elementRoot = nil
end

function slot0.hideAllElements(slot0)
	for slot4, slot5 in pairs(slot0._elementCompDict) do
		slot5:hideElement()
	end
end

function slot0.showAllElements(slot0)
	for slot4, slot5 in pairs(slot0._elementCompDict) do
		slot5:showElement()
	end
end

function slot0.clearElements(slot0)
	if slot0._elementCompDict then
		for slot4, slot5 in pairs(slot0._elementCompDict) do
			slot5:onDestroy()
		end
	end

	if slot0._elementCompPoolDict then
		for slot4, slot5 in pairs(slot0._elementCompPoolDict) do
			slot5:onDestroy()
		end
	end

	slot0._elementRoot = nil

	tabletool.clear(slot0._elementCompDict)
	tabletool.clear(slot0._elementCompPoolDict)
end

function slot0.recycleAllElements(slot0)
	if slot0._elementCompDict then
		for slot4, slot5 in pairs(slot0._elementCompDict) do
			slot0._elementCompPoolDict[slot5:getElementId()] = slot5

			gohelper.addChild(slot0.elementPoolRoot, slot5._go)
		end

		tabletool.clear(slot0._elementCompDict)
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnRecycleAllElement)
end

function slot0.showElements(slot0)
	if slot0.activityDungeonMo:isHardMode() then
		slot0:recycleAllElements()

		return
	end

	slot1, slot2 = VersionActivity1_5DungeonModel.instance:getElementCoList(slot0._mapCfg.id)

	for slot6, slot7 in ipairs(slot1) do
		slot0:_addElement(slot7)
	end

	for slot6, slot7 in ipairs(slot2) do
		slot0:_addElement(slot7)
	end
end

function slot0._addElement(slot0, slot1)
	if slot0._elementCompDict[slot1.id] then
		return
	end

	if slot0._elementCompPoolDict[slot1.id] then
		slot0._elementCompPoolDict[slot1.id] = nil

		gohelper.addChild(slot0._elementRoot, slot2._go)
		slot2:updatePos()
		slot2:refreshDispatchRemainTime()
	else
		slot3 = UnityEngine.GameObject.New(tostring(slot1.id))

		gohelper.addChild(slot0._elementRoot, slot3)

		slot2 = MonoHelper.addLuaComOnceToGo(slot3, VersionActivity1_5DungeonMapElement, {
			slot1,
			slot0
		})
	end

	slot0._elementCompDict[slot1.id] = slot2

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnAddOneElement, slot2)
end

function slot0._removeElement(slot0, slot1)
	slot2 = slot0._elementCompDict[slot1]

	slot2:setFinish()

	slot0._elementCompDict[slot1] = nil
	slot0._elementCompPoolDict[slot1] = slot2

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnRemoveElement, slot2)
end

function slot0._addElementById(slot0, slot1)
	slot0:_addElement(lua_chapter_map_element.configDict[slot1])
end

function slot0.onRemoveElement(slot0, slot1)
	if not slot0._showRewardView then
		slot0:_removeElement(slot1)
	else
		slot0._needRemoveElementId = slot1
	end
end

function slot0.onAddElements(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if VersionActivity1_5DungeonConfig.instance:checkElementBelongMapId(DungeonConfig.instance:getChapterMapElement(slot6), slot0._mapCfg.id) then
			slot0:_addElement(slot7)
		end
	end
end

function slot0.getElementComp(slot0, slot1)
	return slot0._elementCompDict[slot1]
end

function slot0.beginShowRewardView(slot0)
	slot0._showRewardView = true
end

function slot0.endShowRewardView(slot0)
	slot0._showRewardView = false

	if slot0._needRemoveElementId then
		slot0:_removeElement(slot0._needRemoveElementId)

		slot0._needRemoveElementId = nil
	end
end

function slot0.addTimeItem(slot0, slot1)
	if not VersionActivity1_5DungeonModel.instance:getDispatchMo(tonumber(slot1:getConfig().param)) or slot3:isFinish() then
		return
	end

	slot4 = slot0:getTimeItem()
	slot4.txttime.text = slot3:getRemainTimeStr()
	slot4.elementComp = slot1
	slot4.dispatchMo = slot3

	gohelper.setActive(slot4.go, true)

	slot0.elementTimeItemDict[slot2] = slot4

	slot0:setElementTimePos(slot4)

	if not slot0.hadEverySecondTask then
		TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)

		slot0.hadEverySecondTask = true
	end
end

function slot0.addTimeItemByDispatchId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._elementCompDict) do
		if slot6:isDispatch() and tonumber(slot6:getConfig().param) == slot1 then
			slot0:addTimeItem(slot6)

			return
		end
	end
end

function slot0.getTimeItem(slot0)
	if #slot0.timeItemPool ~= 0 then
		return table.remove(slot0.timeItemPool)
	end

	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0.goTimeItem)
	slot1.rectTr = slot1.go:GetComponent(typeof(UnityEngine.RectTransform))
	slot1.txttime = gohelper.findChildText(slot1.go, "#txt_time")

	return slot1
end

function slot0.recycleTimeItem(slot0, slot1)
	slot1.elementComp = nil
	slot1.dispatchMo = nil

	gohelper.setActive(slot1.go, false)
	table.insert(slot0.timeItemPool, slot1)
end

function slot0.everySecondCall(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.elementTimeItemDict) do
		if not slot6.dispatchMo or slot7:isFinish() then
			table.insert(slot1, slot5)
		else
			slot6.txttime.text = slot7:getRemainTimeStr()
		end
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0.elementTimeItemDict[slot6]

		slot7.elementComp:onDispatchFinish()
		slot0:recycleTimeItem(slot7)

		slot0.elementTimeItemDict[slot6] = nil
	end

	if tabletool.len(slot0.elementTimeItemDict) == 0 then
		slot0.hadEverySecondTask = false

		TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	end
end

function slot0.setElementTimePos(slot0, slot1)
	slot2 = recthelper.worldPosToAnchorPos(slot0:getElementPos(slot1.elementComp:getElementPos()), slot0.goTimeParentTr)

	recthelper.setAnchor(slot1.rectTr, slot2.x, slot2.y)
end

function slot0.onMapPosChanged(slot0)
	slot0:refreshAllElementTimePos()
end

function slot0.refreshAllElementTimePos(slot0)
	for slot4, slot5 in pairs(slot0.elementTimeItemDict) do
		slot0:setElementTimePos(slot5)
	end
end

function slot0.getElementPos(slot0, slot1, slot2, slot3)
	slot0.tempPos:Set(slot1, slot2 + VersionActivity1_5DungeonEnum.ElementTimeOffsetY, slot3)

	return slot0.tempPos
end

function slot0.onChangeMap(slot0)
	for slot4, slot5 in pairs(slot0.elementTimeItemDict) do
		slot0:recycleTimeItem(slot5)
	end

	slot0.elementTimeItemDict = {}
	slot0.hadEverySecondTask = false

	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.hideTimeContainer(slot0)
	gohelper.setActive(slot0.goTimeContainer, false)
end

function slot0.showTimeContainer(slot0)
	gohelper.setActive(slot0.goTimeContainer, true)
	slot0:refreshAllElementTimePos()
end

function slot0.onAddDispatchInfo(slot0, slot1)
	if slot0.elementTimeItemDict[slot1] then
		return
	end

	slot0:addTimeItemByDispatchId(slot1)
end

function slot0.onRemoveDispatchInfo(slot0, slot1)
	if not slot0.elementTimeItemDict[slot1] then
		return
	end

	slot0:recycleTimeItem(slot0.elementTimeItemDict[slot1])

	slot0.elementTimeItemDict[slot1] = nil
end

return slot0
