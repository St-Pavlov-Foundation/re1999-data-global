module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapHoleView", package.seeall)

slot0 = class("VersionActivity1_8DungeonMapHoleView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0, LuaEventSystem.Low)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnAddOneElement, slot0.onAddOneElement, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRecycleAllElement, slot0.onRecycleAllElement, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, slot0.refreshHoles, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnAddOneElement, slot0.onAddOneElement, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRecycleAllElement, slot0.onRecycleAllElement, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, slot0.refreshHoles, slot0)
end

function slot0._onScreenResize(slot0)
	slot0:initCameraParam()
end

function slot0.loadSceneFinish(slot0, slot1)
	if gohelper.isNil(slot1.mapSceneGo) then
		return
	end

	slot0.loadSceneDone = true
	slot0.sceneGo = slot1.mapSceneGo
	slot0.sceneTrans = slot0.sceneGo.transform

	if not gohelper.findChild(slot0.sceneGo, "Obj-Plant/FogOfWar/mask") then
		logError("not found shader mask go, " .. slot0.sceneGo.name)

		return
	end

	slot0.shader = slot2:GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial

	slot0:initCameraParam()
	slot0:refreshHoles()
end

function slot0.initCameraParam(slot0)
	slot2 = GameUtil.getAdapterScale()
	slot3 = ViewMgr.instance:getUILayer(UILayerName.Hud).transform:GetWorldCorners()
	slot0.mainCamera = CameraMgr.instance:getMainCamera()
	slot0.mainCameraPosX, slot0.mainCameraPosY = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())
	slot5 = VersionActivity1_8DungeonEnum.DungeonMapCameraSize / slot0.mainCamera.orthographicSize
	slot6 = slot3[1] * slot2 * slot5
	slot7 = slot3[3] * slot2 * slot5
	slot0.validMinDistanceX = math.abs(slot7.x - slot6.x) / 2 + VersionActivity1_8DungeonEnum.HoleHalfWidth
	slot0.validMinDistanceY = math.abs(slot7.y - slot6.y) / 2 + VersionActivity1_8DungeonEnum.HoleHalfHeight
end

function slot0.onMapPosChanged(slot0)
	slot0.sceneWorldPosX, slot0.sceneWorldPosY = transformhelper.getPos(slot0.sceneTrans)

	tabletool.clear(slot0.validElementIdList)

	for slot4, slot5 in ipairs(slot0.beVerifyElementIdList) do
		if slot0:isElementValid(slot5) then
			table.insert(slot0.validElementIdList, slot5)
		end
	end

	slot0:refreshHoles()
end

function slot0.onAddOneElement(slot0, slot1)
	slot2 = slot1:getElementId()

	slot0:addElementHole(Activity157Config.instance:getMissionIdByElementId(Activity157Model.instance:getActId(), slot2), slot2)
end

function slot0.addElementHole(slot0, slot1, slot2)
	slot3 = false

	if (not slot1 or Activity157Model.instance:isFinishMission(Activity157Config.instance:getMissionGroup(Activity157Model.instance:getActId(), slot1), slot1)) and DungeonMapModel.instance:elementIsFinished(slot2) then
		return
	end

	table.insert(slot0.beVerifyElementIdList, slot2)

	if slot0:isElementValid(slot2) then
		table.insert(slot0.validElementIdList, slot2)
	end

	slot0:refreshHoles()
end

function slot0.onRemoveElement(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:removeElementHole(slot1:getElementId())
end

function slot0.removeElementHole(slot0, slot1)
	tabletool.removeValue(slot0.beVerifyElementIdList, slot1)

	if tabletool.indexOf(slot0.validElementIdList, slot1) then
		table.remove(slot0.validElementIdList, slot2)
		slot0:playHoleCloseAnimByElementId(slot1)
	end
end

function slot0.onRecycleAllElement(slot0)
	tabletool.clear(slot0.beVerifyElementIdList)
	tabletool.clear(slot0.validElementIdList)
	slot0:refreshHoles()
end

function slot0._editableInitView(slot0)
	slot0.loadSceneDone = false
	slot0.tempVector = Vector3.zero
	slot0.tempVector4 = Vector4.zero
	slot0.beVerifyElementIdList = {}
	slot0.validElementIdList = {}
	slot0.elementPosDict = {}
	slot0.shaderParamList = slot0:getUserDataTb_()

	for slot4 = 1, VersionActivity1_8DungeonEnum.MaxHoleNum do
		table.insert(slot0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. slot4))
	end
end

function slot0.isElementValid(slot0, slot1)
	if not slot0.elementPosDict[slot1] then
		slot0.elementPosDict[slot1] = string.splitToNumber(lua_chapter_map_element.configDict[slot1].pos, "#")
	end

	return slot0:checkPosIsValid(slot2[1], slot2[2])
end

function slot0.checkPosIsValid(slot0, slot1, slot2)
	if math.sqrt((slot0.mainCameraPosX - (slot1 + slot0.sceneWorldPosX))^2) <= slot0.validMinDistanceX and math.sqrt((slot0.mainCameraPosY - (slot2 + slot0.sceneWorldPosY))^2) <= slot0.validMinDistanceY then
		return true
	end

	return false
end

function slot0.refreshHoles(slot0)
	if not slot0.loadSceneDone or gohelper.isNil(slot0.shader) then
		return
	end

	for slot4 = 1, VersionActivity1_8DungeonEnum.MaxHoleNum do
		slot6 = false

		if Activity157Config.instance:getMissionIdByElementId(Activity157Model.instance:getActId(), slot0.validElementIdList[slot4]) then
			slot6 = Activity157Config.instance:isSideMission(slot7, slot8)
		end

		slot9 = false

		if slot6 then
			slot9 = Activity157Model.instance:isInProgressOtherMissionGroupByElementId(slot5)
		end

		if slot5 and not slot9 then
			slot10 = slot0.elementPosDict[slot5]

			slot0.tempVector4:Set(slot10[1] + slot0.sceneWorldPosX, slot10[2] + slot0.sceneWorldPosY)
		else
			slot0.tempVector4:Set(VersionActivity1_8DungeonEnum.OutSideAreaPos.X, VersionActivity1_8DungeonEnum.OutSideAreaPos.Y)
		end

		slot0.shader:SetVector(slot0.shaderParamList[slot4], slot0.tempVector4)
	end
end

function slot0.playHoleCloseAnimByElementId(slot0, slot1)
	if not tabletool.indexOf(slot0.validElementIdList, slot1) or VersionActivity1_8DungeonEnum.MaxHoleNum < slot2 then
		slot0:refreshHoles()

		return
	end

	slot0:playHoleCloseAnim(slot2)
end

function slot0.playHoleCloseAnim(slot0, slot1)
	slot0.param = slot0.shaderParamList[slot1]

	if not slot0.param then
		slot0:refreshHoles()

		return
	end

	UIBlockMgr.instance:startBlock("playHoleAnim")

	slot0.startVector4 = slot0.shader:GetVector(slot0.param)
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(VersionActivity1_8DungeonEnum.HoleAnimMinZ, VersionActivity1_8DungeonEnum.HoleAnimMaxZ, VersionActivity1_8DungeonEnum.HoleAnimDuration, slot0.frameCallback, slot0.doneCallback, slot0)
end

function slot0.frameCallback(slot0, slot1)
	slot0.tempVector4:Set(slot0.startVector4.x, slot0.startVector4.y, slot1)
	slot0.shader:SetVector(slot0.param, slot0.tempVector4)
end

function slot0.doneCallback(slot0)
	slot0.tempVector4:Set(slot0.startVector4.x, slot0.startVector4.y, VersionActivity1_8DungeonEnum.HoleAnimMaxZ)
	slot0.shader:SetVector(slot0.param, slot0.tempVector4)
	slot0:refreshHoles()
	UIBlockMgr.instance:endBlock("playHoleAnim")
end

function slot0.onClose(slot0)
end

return slot0
