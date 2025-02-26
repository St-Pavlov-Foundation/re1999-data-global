module("modules.logic.versionactivity2_3.dungeon.view.map.scene.VersionActivity2_3DungeonMapSceneElements", package.seeall)

slot0 = class("VersionActivity2_3DungeonMapSceneElements", BaseView)
slot1 = 0.5
slot2 = 0.5

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gofullscreen)
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
	slot0:addEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnHideInteractUI, slot0.onHideInteractUI, slot0)
	slot0._click:AddClickUpListener(slot0.onClickUp, slot0)
	slot0._click:AddClickDownListener(slot0.onClickDown, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.showNewElements, slot0)
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
	slot0:removeEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:removeEventCb(VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnHideInteractUI, slot0.onHideInteractUI, slot0)
	slot0._click:RemoveClickUpListener()
	slot0._click:RemoveClickDownListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.showNewElements, slot0)
end

function slot0._editableInitView(slot0)
	slot0._elementCompDict = {}
	slot0._elementCompPoolDict = {}
	slot0._arrowList = {}
	slot0.hadEverySecondTask = false
	slot0.tempPos = Vector3.New(0, 0, 0)
end

function slot0.onOpen(slot0)
end

function slot0.onGamepadKeyDown(slot0, slot1)
	if slot1 ~= GamepadEnum.KeyCode.A then
		return
	end

	slot3 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())

	for slot9 = 0, UnityEngine.Physics2D.RaycastAll(slot3.origin, slot3.direction).Length - 1 do
		if MonoHelper.getLuaComFromGo(slot4[slot9].transform.parent.gameObject, VersionActivity2_3DungeonMapElement) then
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

function slot0.loadSceneFinish(slot0, slot1)
	slot0._mapCfg = slot1.mapConfig
	slot0._sceneGo = slot1.mapSceneGo
	slot0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(slot0._sceneGo, slot0._elementRoot)
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

function slot0.setMouseElementDown(slot0, slot1)
	slot0.mouseDownElement = slot1
end

function slot0.getElementComp(slot0, slot1)
	return slot0._elementCompDict[slot1]
end

function slot0.onClickElement(slot0, slot1)
	slot0:hideAllElements()
end

function slot0.hideAllElements(slot0)
	for slot4, slot5 in pairs(slot0._elementCompDict) do
		slot5:hideElement()
	end

	gohelper.setActive(slot0._goarrow, false)
end

function slot0.onHideInteractUI(slot0)
	slot0:showAllElements()
end

function slot0.showAllElements(slot0)
	for slot4, slot5 in pairs(slot0._elementCompDict) do
		slot5:showElement()
	end

	gohelper.setActive(slot0._goarrow, true)
end

function slot0._updateElementArrow(slot0)
	for slot4, slot5 in pairs(slot0._elementCompDict) do
		slot0:_updateArrow(slot5)
	end
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

function slot0._removeElement(slot0, slot1)
	slot0._elementCompDict[slot1] = nil

	if slot0._elementCompDict[slot1] then
		slot2:setFinish()

		slot0._elementCompPoolDict[slot1] = slot2
	end

	VersionActivity2_3DungeonController.instance:dispatchEvent(VersionActivity2_3DungeonEvent.OnRemoveElement, slot2)
end

function slot0.showNewElements(slot0)
	if not DungeonMapModel.instance:getNewElements() then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if VersionActivity2_3DungeonConfig.instance:checkElementBelongMapId(DungeonConfig.instance:getChapterMapElement(slot7), slot0._mapCfg.id) and slot8.showCamera == 1 then
			slot2[#slot2 + 1] = slot7
		end
	end

	if #slot2 <= 0 then
		return
	end

	slot0:_showElementAnim(slot2)
	DungeonMapModel.instance:clearNewElements()
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
	slot6 = uv1

	slot0._showSequence:addWork(TimerWork.New(slot6))
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
	UIBlockMgr.instance:startBlock(VersionActivity2_3DungeonEnum.BlockKey.FocusNewElement)
end

function slot0._doFocusElement(slot0)
	VersionActivity2_3DungeonController.instance:dispatchEvent(VersionActivity2_3DungeonEvent.FocusElement, slot0[2], true)
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
	else
		slot3 = UnityEngine.GameObject.New(tostring(slot1.id))

		gohelper.addChild(slot0._elementRoot, slot3)

		slot2 = MonoHelper.addLuaComOnceToGo(slot3, VersionActivity2_3DungeonMapElement, {
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

	VersionActivity2_3DungeonController.instance:dispatchEvent(VersionActivity2_3DungeonEvent.OnAddOneElement, slot2)
end

function slot0.showElements(slot0)
	if not slot0._mapCfg then
		return
	end

	if slot0.activityDungeonMo:isHardMode() then
		slot0:recycleAllElements()

		for slot4, slot5 in pairs(slot0._arrowList) do
			slot5.arrowClick:RemoveClickListener()
			gohelper.destroy(slot5.go)
		end

		slot0._arrowList = slot0:getUserDataTb_()

		return
	end

	slot1 = {}
	slot2 = {}
	slot3 = DungeonMapModel.instance:getNewElements()

	for slot8, slot9 in ipairs(VersionActivity2_3DungeonModel.instance:getElementCoList(slot0._mapCfg.id)) do
		if slot3 and tabletool.indexOf(slot3, slot9.id) and slot9.showCamera == 1 then
			table.insert(slot1, slot9.id)
		else
			table.insert(slot2, slot9)
		end
	end

	slot0:_showElementAnim(slot1, slot2)
	DungeonMapModel.instance:clearNewElements()

	if slot0._initClickElementId then
		slot0:manualClickElement(slot0._initClickElementId)

		slot0._initClickElementId = nil
	end
end

function slot0.recycleAllElements(slot0)
	if slot0._elementCompDict then
		for slot4, slot5 in pairs(slot0._elementCompDict) do
			slot0._elementCompPoolDict[slot5:getElementId()] = slot5

			gohelper.addChild(slot0.elementPoolRoot, slot5._go)
		end

		tabletool.clear(slot0._elementCompDict)
	end

	VersionActivity2_3DungeonController.instance:dispatchEvent(VersionActivity2_3DungeonEvent.OnRecycleAllElement)
end

function slot0._arrowClick(slot0, slot1)
	slot0.mouseDownElement = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	VersionActivity2_3DungeonController.instance:dispatchEvent(VersionActivity2_3DungeonEvent.FocusElement, slot1)
end

function slot0._updateArrow(slot0, slot1)
	if not slot0._arrowList[slot1:getElementId()] then
		return
	end

	if not slot1:isConfigShowArrow() then
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

function slot0.setInitClickElement(slot0, slot1)
	slot0._initClickElementId = slot1
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

function slot0.onChangeMap(slot0)
	slot0.hadEverySecondTask = false

	slot0:_stopShowSequence()

	slot0._needRemoveElementId = nil
end

function slot0._stopShowSequence(slot0)
	if slot0._showSequence then
		slot0._showSequence:unregisterDoneListener(slot0._stopShowSequence, slot0)
		slot0._showSequence:destroy()

		slot0._showSequence = nil

		UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.FocusNewElement)
	end
end

function slot0.onDisposeScene(slot0)
	slot0:clearElements()
	slot0:_stopShowSequence()

	slot0._needRemoveElementId = nil
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
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clearElements()
	DungeonMapModel.instance:clearNewElements()
	slot0:_stopShowSequence()
	TaskDispatcher.cancelTask(slot0.showNewElements, slot0)
	slot0:onDisposeOldMap()
end

return slot0
