module("modules.logic.dungeon.view.DungeonMapHoleView", package.seeall)

slot0 = class("DungeonMapHoleView", BaseView)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnElementAdd, slot0._onAddElement, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnElementRemove, slot0._onRemoveElement, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.initCameraParam, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnElementAdd, slot0._onAddElement, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnElementRemove, slot0._onRemoveElement, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.initCameraParam, slot0)
end

function slot0.onOpen(slot0)
	slot0.tempVector4 = Vector4()
	slot0.shaderParamList = {}
	slot0._tweens = {}

	for slot4 = 1, 5 do
		table.insert(slot0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. slot4))
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.setHoleByTween, slot0)
	slot0:clearTween()
end

function slot0.clearTween(slot0)
	for slot4, slot5 in pairs(slot0._tweens) do
		ZProj.TweenHelper.KillById(slot5)
	end
end

function slot0._onAddElement(slot0, slot1)
	if slot0._elementIndex[slot1] and slot0._tweens[slot0._elementIndex[slot1]] then
		ZProj.TweenHelper.KillById(slot0._tweens[slot2], true)

		slot0._tweens[slot2] = nil
	end

	if not slot0._elementIndex or slot0._elementIndex[slot1] or not slot0.defaultSceneWorldPosX then
		return
	end

	if not lua_chapter_map_element.configDict[slot1] then
		return
	end

	if string.nilorempty(slot2.holeSize) then
		return
	end

	slot3 = 1

	while true do
		if not slot0.holdCoList[slot3] then
			slot0._elementIndex[slot1] = slot3
			slot8, slot9, slot10 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)
			slot0.holdCoList[slot3] = {
				(string.splitToNumber(slot2.pos, "#")[1] or 0) + slot0.defaultSceneWorldPosX + (string.splitToNumber(slot2.holeSize, "#")[1] or 0),
				(slot4[2] or 0) + slot0.defaultSceneWorldPosY + slot9 + (slot11[2] or 0),
				0,
				slot1
			}
			slot0._tweens[slot3] = ZProj.TweenHelper.DOTweenFloat(0, slot11[3] or 0, 0.2, slot0.onTweenOpen, slot0.onTweenOpenEnd, slot0, slot3, EaseType.Linear)

			return
		end

		slot3 = slot3 + 1
	end
end

function slot0.onTweenOpen(slot0, slot1, slot2)
	if not slot0.holdCoList[slot2] then
		return
	end

	slot0.holdCoList[slot2][3] = slot1

	slot0:refreshHoles()
end

function slot0.onTweenOpenEnd(slot0, slot1)
	slot0._tweens[slot1] = nil
end

function slot0._onRemoveElement(slot0, slot1)
	if not slot0._elementIndex then
		return
	end

	if not slot0._elementIndex or not slot0._elementIndex[slot1] then
		return
	end

	slot2 = slot0._elementIndex[slot1]
	slot0._tweens[slot2] = ZProj.TweenHelper.DOTweenFloat(slot0.holdCoList[slot2][3], 0, 0.2, slot0.onTweenClose, slot0.onTweenCloseEnd, slot0, slot2, EaseType.Linear)
end

function slot0.onTweenClose(slot0, slot1, slot2)
	if not slot0.holdCoList[slot2] then
		return
	end

	slot0.holdCoList[slot2][3] = slot1

	slot0:refreshHoles()
end

function slot0.onTweenCloseEnd(slot0, slot1)
	slot0._tweens[slot1] = nil
	slot0.holdCoList[slot1] = nil

	for slot5, slot6 in pairs(slot0._elementIndex) do
		if slot6 == slot1 then
			slot0._elementIndex[slot5] = nil

			slot0:refreshHoles()

			break
		end
	end
end

function slot0.loadSceneFinish(slot0, slot1)
	slot0.mapCfg = slot1[1]
	slot0.sceneGo = slot1[2]
	slot0.mapScene = slot1[3]

	TaskDispatcher.cancelTask(slot0.setHoleByTween, slot0)

	if gohelper.isNil(slot0.sceneGo) then
		slot0.loadSceneDone = false

		return
	end

	slot0:clearTween()

	slot2 = lua_chapter_map_hole.configDict[slot0.mapCfg.id] or {}
	slot0.holdCoList = {}
	slot0._elementIndex = {}

	for slot6 = 1, #slot2 do
		table.insert(slot0.holdCoList, string.splitToNumber(slot2[slot6].param, "#"))
	end

	slot0.loadSceneDone = true
	slot0.sceneTrans = slot0.sceneGo.transform

	if not gohelper.findChild(slot0.sceneGo, "Obj-Plant/FogOfWar/mask") then
		return
	end

	slot0.sceneWorldPosX, slot0.sceneWorldPosY = transformhelper.getLocalPos(slot0.sceneTrans)
	slot5 = string.splitToNumber(slot0.mapCfg.initPos, "#")
	slot0.defaultSceneWorldPosY = slot5[2]
	slot0.defaultSceneWorldPosX = slot5[1]
	slot0.mat = slot3:GetComponent(typeof(UnityEngine.MeshRenderer)).material

	slot0:initCameraParam()
	slot0:refreshHoles()
end

function slot0.onMapPosChanged(slot0, slot1, slot2)
	if not slot0.loadSceneDone then
		return
	end

	if slot2 then
		slot0.targetPosY = slot1.y
		slot0.targetPosX = slot1.x

		slot0:setHoleByTween()
		TaskDispatcher.runRepeat(slot0.setHoleByTween, slot0, 0, -1)
	else
		TaskDispatcher.cancelTask(slot0.setHoleByTween, slot0)

		slot0.sceneWorldPosY = slot1.y
		slot0.sceneWorldPosX = slot1.x

		slot0:refreshHoles()
	end
end

function slot0.setHoleByTween(slot0)
	if not slot0.sceneTrans or tolua.isnull(slot0.sceneTrans) then
		TaskDispatcher.cancelTask(slot0.setHoleByTween, slot0)

		return
	end

	slot0.sceneWorldPosX, slot0.sceneWorldPosY = transformhelper.getLocalPos(slot0.sceneTrans)

	if math.abs(slot0.sceneWorldPosX - slot0.targetPosX) < 0.01 and math.abs(slot0.sceneWorldPosY - slot0.targetPosY) < 0.01 then
		slot0.sceneWorldPosY = slot0.targetPosY
		slot0.sceneWorldPosX = slot0.targetPosX

		TaskDispatcher.cancelTask(slot0.setHoleByTween, slot0)
	end

	slot0:refreshHoles()
end

function slot0.initCameraParam(slot0)
	if not slot0.loadSceneDone then
		return
	end

	slot2 = GameUtil.getAdapterScale()
	slot3 = ViewMgr.instance:getUILayer(UILayerName.Hud).transform:GetWorldCorners()
	slot0.mainCamera = CameraMgr.instance:getMainCamera()
	slot0.mainCameraPosX, slot0.mainCameraPosY = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())
	slot5 = 5 / slot0.mainCamera.orthographicSize
	slot6 = slot3[1] * slot2 * slot5
	slot7 = slot3[3] * slot2 * slot5
	slot0._mapHalfWidth = math.abs(slot7.x - slot6.x) / 2
	slot0._mapHalfHeight = math.abs(slot7.y - slot6.y) / 2

	slot0:refreshHoles()
end

function slot0.refreshHoles(slot0)
	if not slot0.loadSceneDone or gohelper.isNil(slot0.mat) then
		return
	end

	slot1 = 1

	for slot5, slot6 in pairs(slot0.holdCoList) do
		if math.sqrt((slot0.mainCameraPosX - (slot6[1] + slot0.sceneWorldPosX - slot0.defaultSceneWorldPosX))^2) <= slot0._mapHalfWidth + math.abs(slot6[3]) and math.sqrt((slot0.mainCameraPosY - (slot6[2] + slot0.sceneWorldPosY - slot0.defaultSceneWorldPosY))^2) <= slot0._mapHalfHeight + slot9 then
			if slot1 > 5 then
				logError("元件太多无法挖孔")

				return
			end

			slot0.tempVector4:Set(slot7, slot8, slot6[3])
			slot0.mat:SetVector(slot0.shaderParamList[slot1], slot0.tempVector4)

			slot1 = slot1 + 1
		end
	end

	for slot5 = slot1, 5 do
		slot0.tempVector4:Set(100, 100, 100)
		slot0.mat:SetVector(slot0.shaderParamList[slot5], slot0.tempVector4)
	end
end

return slot0
