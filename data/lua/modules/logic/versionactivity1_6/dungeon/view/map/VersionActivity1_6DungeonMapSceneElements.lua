module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapSceneElements", package.seeall)

slot0 = class("VersionActivity1_6DungeonMapSceneElements", BaseView)

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

	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideClickElement, slot0.manualClickElement, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonEvent.OnBeginDragMap, slot0.onBeginDragMap, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, slot0.onCreateMapRootGoDone, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnInitElements, slot0.showElements, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, slot0.onDisposeOldMap, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, slot0.onDisposeScene, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnChangeMap, slot0.onChangeMap, slot0)
end

function slot0.onGamepadKeyDown(slot0, slot1)
	if slot1 == GamepadEnum.KeyCode.A then
		slot2 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())

		for slot8 = 0, UnityEngine.Physics2D.RaycastAll(slot2.origin, slot2.direction).Length - 1 do
			if MonoHelper.getLuaComFromGo(slot3[slot8].transform.parent.gameObject, VersionActivity1_6DungeonMapElement) then
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

function slot0.manualClickElement(slot0, slot1)
	if not slot0:getElementComp(tonumber(slot1)) then
		return
	end

	if not slot2:isValid() then
		return
	end

	slot2:onClick()
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

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnRecycleAllElement)
end

function slot0.showElements(slot0)
	if slot0.activityDungeonMo:isHardMode() then
		slot0:recycleAllElements()

		return
	end

	if slot0._mapCfg and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102) and Activity149Config.instance:getAct149BossMapElementByMapId(slot0._mapCfg.id) then
		for slot7, slot8 in ipairs(VersionActivity1_6DungeonEnum.DungeonBossElementHideObjPaths) do
			gohelper.setActive(gohelper.findChild(slot0._sceneGo, slot8), false)
		end

		slot0:_addElement(slot2)
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
	else
		slot3 = UnityEngine.GameObject.New(tostring(slot1.id))

		gohelper.addChild(slot0._elementRoot, slot3)

		slot2 = MonoHelper.addLuaComOnceToGo(slot3, VersionActivity1_6DungeonMapElement, {
			slot1,
			slot0
		})
	end

	slot0._elementCompDict[slot1.id] = slot2

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnAddOneElement, slot2)
end

function slot0._removeElement(slot0, slot1)
	slot2 = slot0._elementCompDict[slot1]

	slot2:setFinish()

	slot0._elementCompDict[slot1] = nil
	slot0._elementCompPoolDict[slot1] = slot2

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnRemoveElement, slot2)
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

function slot0.onChangeMap(slot0)
end

return slot0
