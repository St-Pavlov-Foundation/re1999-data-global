module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapSceneElements", package.seeall)

slot0 = class("VersionActivity1_8DungeonMapSceneElements", BaseView)
slot1 = 0.5
slot2 = 0.5

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gofullscreen)
	slot0.goTimeParentTr = gohelper.findChildComponent(slot0.viewGO, "#go_maptime", typeof(UnityEngine.RectTransform))
	slot0.goTimeContainer = slot0.goTimeParentTr.gameObject
	slot0.goTimeItem = gohelper.findChild(slot0.viewGO, "#go_maptime/#go_timeitem")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, slot0.onGamepadKeyDown, slot0)
	end

	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnBeginDragMap, slot0.onBeginDragMap, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, slot0.onCreateMapRootGoDone, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideClickElement, slot0.manualClickElement, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, slot0._updateElementArrow, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, slot0.showElements, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, slot0.onDisposeOldMap, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, slot0.onDisposeScene, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, slot0.onChangeMap, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, slot0.onHideInteractUI, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, slot0.onChangeInProgressMissionGroup, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0._onRepairComponent, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, slot0.onAddDispatchInfo, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, slot0.onRemoveDispatchInfo, slot0)
	slot0._click:AddClickUpListener(slot0.onClickUp, slot0)
	slot0._click:AddClickDownListener(slot0.onClickDown, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(GamepadController.instance, GamepadEvent.KeyDown, slot0.onGamepadKeyDown, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnBeginDragMap, slot0.onBeginDragMap, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, slot0.onCreateMapRootGoDone, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.GuideClickElement, slot0.manualClickElement, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, slot0._updateElementArrow, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, slot0.showElements, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, slot0.onDisposeOldMap, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, slot0.onDisposeScene, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, slot0.onChangeMap, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, slot0.onHideInteractUI, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, slot0.onChangeInProgressMissionGroup, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0._onRepairComponent, slot0)
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, slot0.onAddDispatchInfo, slot0)
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, slot0.onRemoveDispatchInfo, slot0)
	slot0._click:RemoveClickUpListener()
	slot0._click:RemoveClickDownListener()
end

function slot0.onGamepadKeyDown(slot0, slot1)
	if slot1 ~= GamepadEnum.KeyCode.A then
		return
	end

	slot3 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())

	for slot9 = 0, UnityEngine.Physics2D.RaycastAll(slot3.origin, slot3.direction).Length - 1 do
		if MonoHelper.getLuaComFromGo(slot4[slot9].transform.parent.gameObject, VersionActivity1_8DungeonMapElement) then
			slot11:_onClickDown()
		end
	end
end

function slot0.onBeginDragMap(slot0)
	slot0._clickDown = false
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

function slot0.beginShowRewardView(slot0)
	slot0._showRewardView = true
end

function slot0.endShowRewardView(slot0)
	slot0._showRewardView = false

	if slot0._needRemoveElementId then
		slot0:_removeElement(slot0._needRemoveElementId)
		TaskDispatcher.runDelay(slot0.showNewElements, slot0, DungeonEnum.ShowNewElementsTimeAfterShowReward)

		slot0._needRemoveElementId = nil
	else
		slot0:showNewElements()
	end
end

function slot0.showNewElements(slot0)
	if not DungeonMapModel.instance:getNewElements() then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if VersionActivity1_8DungeonConfig.instance:checkElementBelongMapId(DungeonConfig.instance:getChapterMapElement(slot7), slot0._mapCfg.id) and slot8.showCamera == 1 then
			slot2[#slot2 + 1] = slot7
		end
	end

	if #slot2 <= 0 then
		return
	end

	slot0:_showElementAnim(slot2)
	DungeonMapModel.instance:clearNewElements()
end

function slot0.onRemoveElement(slot0, slot1)
	if not slot0._showRewardView then
		slot0:_removeElement(slot1)
		slot0:showNewElements()
	else
		slot0._needRemoveElementId = slot1
	end

	if slot0._arrowList[slot1] then
		slot2.arrowClick:RemoveClickListener()

		slot0._arrowList[slot1] = nil

		gohelper.destroy(slot2.go)
	end
end

function slot0.manualClickElement(slot0, slot1)
	if not slot0:getElementComp(tonumber(slot1)) then
		return
	end

	if not slot2:isValid() then
		return
	end

	slot2:onClick()
end

function slot0._updateElementArrow(slot0)
	for slot4, slot5 in pairs(slot0._elementCompDict) do
		slot0:_updateArrow(slot5)
	end
end

function slot0.showElements(slot0)
	if slot0.activityDungeonMo:isHardMode() then
		slot0:recycleAllElements()

		return
	end

	slot1 = {}
	slot2 = {}
	slot3 = DungeonMapModel.instance:getNewElements()
	slot4 = VersionActivity1_8DungeonModel.instance:isNotShowNewElement()

	for slot9, slot10 in ipairs(VersionActivity1_8DungeonModel.instance:getElementCoList(slot0._mapCfg.id)) do
		if slot3 and tabletool.indexOf(slot3, slot10.id) and slot10.showCamera == 1 then
			if not slot4 then
				table.insert(slot1, slot10.id)
			end
		else
			table.insert(slot2, slot10)
		end
	end

	slot0:_showElementAnim(slot1, slot2)

	if slot4 then
		VersionActivity1_8DungeonModel.instance:setIsNotShowNewElement(false)
	else
		DungeonMapModel.instance:clearNewElements()
	end

	if slot0._initClickElementId then
		slot0:manualClickElement(slot0._initClickElementId)

		slot0._initClickElementId = nil
	end
end

function slot0._showElementAnim(slot0, slot1, slot2)
	if not slot1 or #slot1 <= 0 then
		uv0._addAnimElementDone({
			slot0,
			slot2
		})

		return
	end

	slot0:_stopShowSequence()

	slot0._showSequence = FlowSequence.New()
	slot6 = TimerWork.New

	slot0._showSequence:addWork(slot6(uv1))
	table.sort(slot1)

	for slot6, slot7 in ipairs(slot1) do
		slot0._showSequence:addWork(FunctionWork.New(uv0._doFocusElement, {
			slot0,
			slot7
		}))
		slot0._showSequence:addWork(TimerWork.New(uv2))
		slot0._showSequence:addWork(FunctionWork.New(uv0._doAddElement, {
			slot0,
			slot7
		}))
		slot0._showSequence:addWork(TimerWork.New(uv1))
	end

	slot0._showSequence:addWork(FunctionWork.New(uv0._addAnimElementDone, {
		slot0,
		slot2
	}))
	slot0._showSequence:registerDoneListener(slot0._stopShowSequence, slot0)
	slot0._showSequence:start()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.FocusNewElement)
end

function slot0._doFocusElement(slot0)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, slot0[2], true)
end

function slot0._doAddElement(slot0)
	slot1 = slot0[1]
	slot2 = slot0[2]

	slot1:_addElementById(slot2)

	if not slot1._elementCompDict[slot2] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementappear)
end

function slot0._addAnimElementDone(slot0)
	slot1 = slot0[1]

	if not slot0[2] or #slot2 <= 0 then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		slot1:_addElement(slot7)
	end
end

function slot0._stopShowSequence(slot0)
	if slot0._showSequence then
		slot0._showSequence:unregisterDoneListener(slot0._stopShowSequence, slot0)
		slot0._showSequence:destroy()

		slot0._showSequence = nil

		UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.FocusNewElement)
	end
end

function slot0.loadSceneFinish(slot0, slot1)
	slot0._mapCfg = slot1.mapConfig
	slot0._sceneGo = slot1.mapSceneGo
	slot0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(slot0._sceneGo, slot0._elementRoot)
end

function slot0.onDisposeOldMap(slot0, slot1)
	slot0:recycleAllElements()

	slot0._elementRoot = nil

	for slot5, slot6 in pairs(slot0._arrowList) do
		slot6.arrowClick:RemoveClickListener()
		gohelper.destroy(slot6.go)
	end

	slot0._arrowList = slot0:getUserDataTb_()

	slot0:_stopShowSequence()

	slot0._needRemoveElementId = nil
	slot0._waitCloseFactoryView = false
end

function slot0.onDisposeScene(slot0)
	slot0:clearElements()
	slot0:_stopShowSequence()

	slot0._needRemoveElementId = nil
	slot0._waitCloseFactoryView = false
end

function slot0.onChangeMap(slot0)
	for slot4, slot5 in pairs(slot0.elementTimeItemDict) do
		slot0:recycleTimeItem(slot5)
	end

	slot0.elementTimeItemDict = {}
	slot0.hadEverySecondTask = false

	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	slot0:_stopShowSequence()

	slot0._needRemoveElementId = nil
	slot0._waitCloseFactoryView = false
end

function slot0._onCloseView(slot0)
	if slot0._waitCloseFactoryView then
		if not ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView) and not ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView) then
			slot0:showNewElements()

			slot0._waitCloseFactoryView = false
		end
	end
end

function slot0.onMapPosChanged(slot0)
	slot0:refreshAllElementTimePos()
end

function slot0.onClickElement(slot0, slot1)
	slot0:hideTimeContainer()
	slot0:hideAllElements()
end

function slot0.hideTimeContainer(slot0)
	gohelper.setActive(slot0.goTimeContainer, false)
end

function slot0.onHideInteractUI(slot0)
	slot0:showTimeContainer()
	slot0:showAllElements()
end

function slot0.showTimeContainer(slot0)
	gohelper.setActive(slot0.goTimeContainer, true)
	slot0:refreshAllElementTimePos()
end

function slot0.onChangeInProgressMissionGroup(slot0)
	slot0:_updateElementArrow()
end

function slot0._onRepairComponent(slot0, slot1)
	if not slot1 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView) or ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView) then
		slot0._waitCloseFactoryView = true
	else
		slot0:showNewElements()
	end
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

function slot0.onClickUp(slot0)
	slot1 = slot0.mouseDownElement
	slot0.mouseDownElement = nil

	if not slot0._clickDown or not slot1 then
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

function slot0.onClickDown(slot0)
	slot0._clickDown = true
end

function slot0._editableInitView(slot0)
	slot0._elementCompDict = {}
	slot0._elementCompPoolDict = {}
	slot0._arrowList = {}
	slot0.hadEverySecondTask = false
	slot0.elementTimeItemDict = {}
	slot0.timeItemPool = {}
	slot0.tempPos = Vector3.New(0, 0, 0)

	gohelper.setActive(slot0.goTimeItem, false)
	gohelper.setActive(slot0.goTimeContainer, true)
end

function slot0.onOpen(slot0)
end

function slot0.setInitClickElement(slot0, slot1)
	slot0._initClickElementId = slot1
end

function slot0.setMouseElementDown(slot0, slot1)
	slot0.mouseDownElement = slot1
end

function slot0.getElementComp(slot0, slot1)
	return slot0._elementCompDict[slot1]
end

function slot0.hideAllElements(slot0)
	for slot4, slot5 in pairs(slot0._elementCompDict) do
		slot5:hideElement()
	end

	gohelper.setActive(slot0._goarrow, false)
end

function slot0.showAllElements(slot0)
	for slot4, slot5 in pairs(slot0._elementCompDict) do
		slot5:showElement()
	end

	gohelper.setActive(slot0._goarrow, true)
end

function slot0._addElementById(slot0, slot1)
	slot0:_addElement(lua_chapter_map_element.configDict[slot1])
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

		slot2 = MonoHelper.addLuaComOnceToGo(slot3, VersionActivity1_8DungeonMapElement, {
			slot1,
			slot0
		})
	end

	slot0._elementCompDict[slot1.id] = slot2

	if slot2:isConfigShowArrow() then
		slot5 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._goarrow)
		slot6 = gohelper.findChild(slot5, "mesh")
		slot7, slot8, slot9 = transformhelper.getLocalRotation(slot6.transform)
		slot10 = gohelper.getClick(gohelper.findChild(slot5, "click"))

		slot10:AddClickListener(slot0._arrowClick, slot0, slot1.id)

		slot11 = slot0:getUserDataTb_()
		slot11.go = slot5
		slot11.rotationTrans = slot6.transform
		slot11.initRotation = {
			slot7,
			slot8,
			slot9
		}
		slot11.arrowClick = slot10
		slot0._arrowList[slot1.id] = slot11

		slot0:_updateArrow(slot2)
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnAddOneElement, slot2)
end

function slot0._arrowClick(slot0, slot1)
	slot0.mouseDownElement = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, slot1)
end

function slot0._updateArrow(slot0, slot1)
	if not slot0._arrowList[slot1:getElementId()] then
		return
	end

	if not slot1:showArrow() then
		gohelper.setActive(slot2.go, false)

		return
	end

	slot6 = CameraMgr.instance:getMainCamera():WorldToViewportPoint(slot1._transform.position)
	slot8 = slot6.y
	slot9 = slot6.x >= 0 and slot7 <= 1 and slot8 >= 0 and slot8 <= 1

	gohelper.setActive(slot2.go, not slot9)

	if slot9 then
		return
	end

	recthelper.setAnchor(slot2.go.transform, recthelper.getWidth(slot0._goarrow.transform) * (math.max(0.02, math.min(slot7, 0.98)) - 0.5), recthelper.getHeight(slot0._goarrow.transform) * (math.max(0.035, math.min(slot8, 0.965)) - 0.5))

	slot14 = slot2.initRotation

	if slot7 >= 0 and slot7 <= 1 then
		if slot8 < 0 then
			transformhelper.setLocalRotation(slot2.rotationTrans, slot14[1], slot14[2], 180)

			return
		elseif slot8 > 1 then
			transformhelper.setLocalRotation(slot2.rotationTrans, slot14[1], slot14[2], 0)

			return
		end
	end

	if slot8 >= 0 and slot8 <= 1 then
		if slot7 < 0 then
			transformhelper.setLocalRotation(slot2.rotationTrans, slot14[1], slot14[2], 270)

			return
		elseif slot7 > 1 then
			transformhelper.setLocalRotation(slot2.rotationTrans, slot14[1], slot14[2], 90)

			return
		end
	end

	transformhelper.setLocalRotation(slot2.rotationTrans, slot14[1], slot14[2], 90 - Mathf.Atan2(slot8, slot7) * Mathf.Rad2Deg)
end

function slot0._removeElement(slot0, slot1)
	slot0._elementCompDict[slot1] = nil

	if slot0._elementCompDict[slot1] then
		slot2:setFinish()

		slot0._elementCompPoolDict[slot1] = slot2
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnRemoveElement, slot2)
end

function slot0.recycleAllElements(slot0)
	if slot0._elementCompDict then
		for slot4, slot5 in pairs(slot0._elementCompDict) do
			slot0._elementCompPoolDict[slot5:getElementId()] = slot5

			gohelper.addChild(slot0.elementPoolRoot, slot5._go)
		end

		tabletool.clear(slot0._elementCompDict)
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnRecycleAllElement)
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

function slot0.addTimeItemByDispatchId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._elementCompDict) do
		if slot6:isDispatch() and tonumber(slot6:getConfig().param) == slot1 then
			slot0:addTimeItem(slot6)

			return
		end
	end
end

function slot0.addTimeItem(slot0, slot1)
	if not DispatchModel.instance:getDispatchMo(slot1:getElementId(), tonumber(slot1:getConfig().param)) or slot4:isFinish() then
		return
	end

	slot5 = slot0:getTimeItem()
	slot5.txttime.text = slot4:getRemainTimeStr()
	slot5.elementComp = slot1
	slot5.dispatchMo = slot4

	gohelper.setActive(slot5.go, true)

	slot0.elementTimeItemDict[slot3] = slot5

	slot0:setElementTimePos(slot5)

	if not slot0.hadEverySecondTask then
		TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)

		slot0.hadEverySecondTask = true
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

function slot0.refreshAllElementTimePos(slot0)
	for slot4, slot5 in pairs(slot0.elementTimeItemDict) do
		slot0:setElementTimePos(slot5)
	end
end

function slot0.setElementTimePos(slot0, slot1)
	slot2, slot3, slot4 = slot1.elementComp:getElementPos()
	slot6 = recthelper.worldPosToAnchorPos(slot0:getElementTimePos(slot2, slot3, slot4), slot0.goTimeParentTr)

	recthelper.setAnchor(slot1.rectTr, slot6.x, slot6.y)
end

function slot0.getElementTimePos(slot0, slot1, slot2, slot3)
	slot0.tempPos:Set(slot1, slot2 + VersionActivity1_8DungeonEnum.ElementTimeOffsetY, slot3)

	return slot0.tempPos
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clearElements()
	DungeonMapModel.instance:clearNewElements()
	slot0:_stopShowSequence()
	TaskDispatcher.cancelTask(slot0.showNewElements, slot0)
end

return slot0
