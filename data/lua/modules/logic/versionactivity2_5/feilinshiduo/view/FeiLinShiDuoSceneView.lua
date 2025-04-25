module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoSceneView", package.seeall)

slot0 = class("FeiLinShiDuoSceneView", BaseView)

function slot0.onInitView(slot0)
	slot0._goscene = gohelper.findChild(slot0.viewGO, "bg/#go_scene")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0.refreshSceneBorder, slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
end

function slot0.removeEvents(slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0.refreshSceneBorder, slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
end

function slot0._editableInitView(slot0)
	slot0.elementGOMap = slot0:getUserDataTb_()
	slot0.boxCompMap = slot0:getUserDataTb_()
	slot0.boxCompList = slot0:getUserDataTb_()
	slot0.optionCompMap = slot0:getUserDataTb_()
	slot0.jumpAnimMap = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
	slot0:initMapConfig()
	slot0:initScene()
	slot0:initMapElement()
	TaskDispatcher.runRepeat(slot0.onTick, slot0, 0)
end

function slot0.initMapConfig(slot0)
	FeiLinShiDuoGameModel.instance:setGameConfig(slot0.viewParam.gameConfig)
	FeiLinShiDuoGameModel.instance:initConfigData(slot0.viewParam.mapId or FeiLinShiDuoEnum.TestMapId)
end

function slot0.initScene(slot0)
	slot0.mapConfigData = FeiLinShiDuoGameModel.instance:getMapConfigData()
	slot0.sceneGO = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goscene)
	slot0.playerGO = gohelper.create2d(gohelper.findChild(slot0.sceneGO, "Player"), "PlayerGO")

	transformhelper.setLocalScale(slot0.playerGO.transform, FeiLinShiDuoEnum.PlayerScale, FeiLinShiDuoEnum.PlayerScale, FeiLinShiDuoEnum.PlayerScale)

	slot0.playerGOComp = MonoHelper.addLuaComOnceToGo(slot0.playerGO, FeiLinShiDuoPlayerComp)
	slot0.playerAnimComp = MonoHelper.addLuaComOnceToGo(slot0.playerGO, FeiLinShiDuoPlayerAnimComp)

	slot0.playerGOComp:setScene(slot0.sceneGO, slot0)

	slot0.sceneScale = slot0.mapConfigData.gameConfig.sceneScale or FeiLinShiDuoEnum.SceneDefaultScale

	transformhelper.setLocalScale(slot0._goscene.transform, slot0.sceneScale, slot0.sceneScale, slot0.sceneScale)

	slot0.screenWidth = gohelper.getUIScreenWidth()
	slot0.screenHeight = UnityEngine.Screen.height
end

function slot0.initMapElement(slot0)
	slot0:createMapElement()
	slot0:initSceneBorder()
	slot0:initSceneAndPlayerPos()
end

function slot0.resetData(slot0)
	TaskDispatcher.cancelTask(slot0.onTick, slot0)
	slot0:destroyAllElement()
	slot0:initMapConfig()
	slot0:initMapElement()
	TaskDispatcher.runRepeat(slot0.onTick, slot0, 0)
end

function slot0.updateCamera(slot0)
end

function slot0.onTick(slot0)
	if FeiLinShiDuoGameModel.instance:getIsPlayerInColorChanging() then
		return
	end

	slot0.playerGOComp:onTick()

	for slot4, slot5 in pairs(slot0.boxCompMap) do
		slot5:onTick()
	end

	for slot4, slot5 in pairs(slot0.optionCompMap) do
		slot5:onTick()
	end
end

function slot0.createMapElement(slot0)
	slot1 = FeiLinShiDuoGameModel.instance:getBlindnessModeState()

	for slot6, slot7 in pairs(FeiLinShiDuoGameModel.instance:getElementList()) do
		slot8 = UnityEngine.GameObject.New(FeiLinShiDuoEnum.ParentName[slot7.type] .. "_" .. slot7.id)
		slot9 = gohelper.onceAddComponent(slot8, gohelper.Type_RectTransform)

		transformhelper.setLocalScale(slot9, 1, 1, 1)
		slot8.transform:SetParent(gohelper.findChild(slot0.sceneGO, FeiLinShiDuoEnum.GroupName[slot7.type]).transform)

		slot15 = 1

		transformhelper.setLocalScale(slot8.transform, 1, 1, slot15)

		slot14 = slot7.pos[2]

		recthelper.setAnchor(slot9, slot7.pos[1], slot14)

		slot9.pivot = Vector2(0, 0)
		slot0.elementGOMap[slot7.id] = {
			elementGO = slot8,
			subGOList = {}
		}

		for slot14, slot15 in ipairs(slot7.subGOPosList) do
			slot16 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[FeiLinShiDuoEnum.ItemName[slot7.type]], slot8)

			slot16.transform:SetParent(slot8.transform, false)
			recthelper.setAnchor(slot16.transform, tonumber(slot15[1]), tonumber(slot15[2]))

			slot21 = slot7.scale[2]

			transformhelper.setLocalScale(gohelper.findChild(slot16, "scale").transform, slot7.scale[1], slot21, 1)

			for slot21 = 0, 4 do
				if gohelper.findChild(slot16, "scale/type" .. slot21) then
					if slot7.color == FeiLinShiDuoEnum.ColorType.Red then
						gohelper.setActive(slot22, slot21 == FeiLinShiDuoEnum.ColorType.Red and not slot1 or slot21 == FeiLinShiDuoEnum.ColorType.Yellow and slot1)
					else
						gohelper.setActive(slot22, slot7.color == slot21)
					end
				end
			end

			table.insert(slot0.elementGOMap[slot7.id].subGOList, slot16)
		end

		if slot7.type == FeiLinShiDuoEnum.ObjectType.Box then
			slot11 = MonoHelper.addLuaComOnceToGo(slot8, FeiLinShiDuoBoxComp)

			slot11:initData(slot7, slot0)

			slot0.boxCompMap[slot7.id] = slot11

			table.insert(slot0.boxCompList, slot7)
		end

		if slot7.type == FeiLinShiDuoEnum.ObjectType.Option then
			slot11 = MonoHelper.addLuaComOnceToGo(slot8, FeiLinShiDuoOptionComp)

			slot11:initData(slot7, slot0)

			slot0.optionCompMap[slot7.id] = slot11
		end

		if slot7.type == FeiLinShiDuoEnum.ObjectType.Jump then
			if not slot0.jumpAnimMap[slot7.id] then
				slot0.jumpAnimMap[slot7.id] = {}
			end

			for slot14, slot15 in pairs(slot0.elementGOMap[slot7.id].subGOList) do
				for slot19 = 0, 4 do
					slot0.jumpAnimMap[slot7.id][slot19] = gohelper.findChild(slot15, "scale/type" .. slot19):GetComponent(gohelper.Type_Animator)
				end
			end
		end
	end
end

function slot0.initSceneBorder(slot0)
	slot0.leftBorderX = 0
	slot0.rightBorderX = 0
	slot0.topBorderY = 0
	slot0.bottomBorderY = 0
	slot3 = slot1[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}

	for slot8, slot9 in pairs(FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.Wall] or {}) do
		table.insert({}, slot9)
	end

	for slot8, slot9 in pairs(slot3) do
		table.insert(slot4, slot9)
	end

	for slot8, slot9 in pairs(slot4) do
		for slot13, slot14 in ipairs(slot9.subGOPosList) do
			slot15 = slot9.pos[1] + tonumber(slot14[1])
			slot16 = slot9.pos[2] + tonumber(slot14[2])

			if slot0.leftBorderX == 0 and slot0.rightBorderX == 0 and slot0.topBorderY == 0 and slot0.bottomBorderY == 0 then
				slot0.leftBorderX = slot15
				slot0.rightBorderX = slot15
				slot0.topBorderY = slot16
				slot0.bottomBorderY = slot16
			end

			if slot15 <= slot0.leftBorderX then
				slot0.leftBorderX = slot15
			end

			if slot0.rightBorderX <= slot15 then
				slot0.rightBorderX = slot15
			end

			if slot0.topBorderY <= slot16 then
				slot0.topBorderY = slot16
			end

			if slot16 <= slot0.bottomBorderY then
				slot0.bottomBorderY = slot16
			end
		end
	end

	slot0.rightBorderX = slot0.rightBorderX + FeiLinShiDuoEnum.SlotWidth
	slot0.topBorderY = slot0.topBorderY + FeiLinShiDuoEnum.SlotWidth

	slot0:refreshSceneBorder()
end

function slot0.refreshSceneBorder(slot0)
	slot0.screenWidth = gohelper.getUIScreenWidth()
	slot0.halfScreenWidth = slot0.screenWidth / 2
	slot0.halfScreenHeight = 540
	slot0.sceneLeftPosX = -(slot0.halfScreenWidth + slot0.leftBorderX * slot0.sceneScale) / slot0.sceneScale
	slot0.sceneRightPosX = (slot0.halfScreenWidth - slot0.rightBorderX * slot0.sceneScale) / slot0.sceneScale
	slot0.sceneTopPosY = (slot0.halfScreenHeight - slot0.topBorderY * slot0.sceneScale) / slot0.sceneScale
	slot0.sceneBottomPosY = -(slot0.halfScreenHeight + slot0.bottomBorderY * slot0.sceneScale) / slot0.sceneScale
	slot0.itemLeftBorderX = slot0.leftBorderX
	slot0.itemRightBorderX = slot0.rightBorderX
end

function slot0.fixSceneBorder(slot0, slot1, slot2)
	if Mathf.Abs(slot0.itemLeftBorderX - slot0.itemRightBorderX) * slot0.sceneScale <= slot0.screenWidth then
		return -(slot0.itemLeftBorderX + Mathf.Abs(slot0.itemLeftBorderX - slot0.itemRightBorderX) / 2), Mathf.Min(slot2, slot0.sceneBottomPosY)
	end

	return Mathf.Clamp(slot1, slot0.sceneRightPosX, slot0.sceneLeftPosX), Mathf.Min(slot2, slot0.sceneBottomPosY)
end

function slot0.initSceneAndPlayerPos(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.Start]) do
		slot1 = slot7.pos
	end

	slot3, slot4 = slot0:fixSceneBorder(-slot1[1], -slot1[2])

	transformhelper.setLocalPosXY(slot0.sceneGO.transform, slot3, slot4)
	transformhelper.setLocalPosXY(slot0.playerGO.transform, slot1[1] + FeiLinShiDuoEnum.HalfSlotWidth, slot1[2])
end

function slot0.changeSceneColor(slot0)
	for slot6, slot7 in pairs(FeiLinShiDuoGameModel.instance:getInterElementMap()) do
		gohelper.setActive(slot0.elementGOMap[slot7.id].elementGO, FeiLinShiDuoGameModel.instance:getElementShowStateMap()[slot7.id])
	end

	for slot6, slot7 in pairs(slot0.boxCompMap) do
		if slot7:getShowState() and not slot7:checkBoxInPlane() then
			slot7:checkBoxFall(true)
		end
	end

	if slot0.playerGOComp then
		slot0.playerGOComp:checkPlayerFall(true)
		slot0.playerGOComp:checkClimbStairs()
	end
end

function slot0.refreshBlindnessMode(slot0)
	slot1 = FeiLinShiDuoGameModel.instance:getBlindnessModeState()

	for slot6, slot7 in pairs(FeiLinShiDuoGameModel.instance:getInterElementMap()) do
		for slot11, slot12 in pairs(slot0.elementGOMap[slot7.id].subGOList) do
			if slot7.color == FeiLinShiDuoEnum.ColorType.Red then
				slot14 = gohelper.findChild(slot12, "scale/type" .. 4)

				if gohelper.findChild(slot12, "scale/type" .. 1) then
					gohelper.setActive(slot13, not slot1)
				end

				if slot14 then
					gohelper.setActive(slot14, slot1)
				end
			end
		end
	end
end

function slot0.getSceneGO(slot0)
	return slot0.sceneGO
end

function slot0.getBoxComp(slot0, slot1)
	return slot0.boxCompMap[slot1]
end

function slot0.getAllBoxComp(slot0)
	return slot0.boxCompMap
end

function slot0.getAllBoxCompList(slot0)
	return slot0.boxCompList
end

function slot0.getPlayerAnimComp(slot0)
	return slot0.playerAnimComp
end

function slot0.getPlayerGO(slot0)
	return slot0.playerGO
end

function slot0.getPlayerComp(slot0)
	return slot0.playerGOComp
end

function slot0.getElementGOMap(slot0)
	return slot0.elementGOMap
end

function slot0.getGameUIView(slot0)
	return slot0.viewContainer:getGameView()
end

function slot0.getJumpAnim(slot0, slot1)
	return slot0.jumpAnimMap[slot1.id] and slot0.jumpAnimMap[slot1.id][slot1.color]
end

function slot0.getCurGuideCheckData(slot0)
	for slot4, slot5 in ipairs(FeiLinShiDuoEnum.GuideDataList) do
		if slot0.viewParam.mapId == slot5.mapId and not GuideModel.instance:isGuideFinish(slot5.guideId) then
			return slot5
		end
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.onTick, slot0)
end

function slot0.destroyAllElement(slot0)
	for slot5, slot6 in pairs(FeiLinShiDuoGameModel.instance:getElementList()) do
		gohelper.destroy(slot0.elementGOMap[slot6.id].elementGO)
	end

	slot0.elementGOMap = slot0:getUserDataTb_()
	slot0.boxCompMap = slot0:getUserDataTb_()
	slot0.boxCompList = slot0:getUserDataTb_()
	slot0.optionCompMap = slot0:getUserDataTb_()
	slot0.jumpAnimMap = slot0:getUserDataTb_()
end

function slot0.onDestroyView(slot0)
end

return slot0
