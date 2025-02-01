module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapHoleView", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapHoleView", BaseView)

function slot0.onInitView(slot0)
	slot0._godispatcharea = gohelper.findChild(slot0.viewGO, "#go_dispatcharea")
	slot0._goareaitem = gohelper.findChild(slot0.viewGO, "#go_dispatcharea/#go_areaitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._godispatcharea, true)
	gohelper.setActive(slot0._goareaitem, false)

	slot0.loadSceneDone = false
	slot0.transform = slot0._godispatcharea:GetComponent(gohelper.Type_RectTransform)
	slot0.tempVector = Vector3.zero
	slot0.tempVector4 = Vector4.zero
	slot0.areaItemDict = {}
	slot0.areaItemPool = {}
	slot0.exploreElementIdList = {}
	slot0.subHeroElementIdList = {}
	slot0.validElementIdList = {}
	slot0.validExploreIdList = {}
	slot0.elementPosDict = {}
	slot0.shaderParamList = slot0:getUserDataTb_()

	for slot4 = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		table.insert(slot0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. slot4))
	end

	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0, LuaEventSystem.Low)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.loadSceneFinish, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnAddOneElement, slot0.onAddOneElement, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRecycleAllElement, slot0.onRecycleAllElement, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, slot0.hideAreaUI, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, slot0.showAreaUI, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.TweenMapPosDone, slot0.tweenMapPosDone, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, slot0.onDispatchFinish, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.FocusElement, slot0.onFocusElement, slot0)
end

function slot0.loadSceneFinish(slot0, slot1)
	if gohelper.isNil(slot1.mapSceneGo) then
		return
	end

	slot0.loadSceneDone = true
	slot0.sceneGo = slot1.mapSceneGo
	slot0.sceneTrans = slot0.sceneGo.transform

	if not gohelper.findChild(slot0.sceneGo, "Obj-Plant/FogOfWar/m_s14_hddt_mask") then
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
	slot5 = VersionActivity1_5DungeonEnum.DungeonMapCameraSize / slot0.mainCamera.orthographicSize
	slot6 = slot3[1] * slot2 * slot5
	slot7 = slot3[3] * slot2 * slot5
	slot0.validMinDistanceX = math.abs(slot7.x - slot6.x) / 2 + VersionActivity1_5DungeonEnum.HoleHalfWidth
	slot0.validMinDistanceY = math.abs(slot7.y - slot6.y) / 2 + VersionActivity1_5DungeonEnum.HoleHalfHeight
end

function slot0.onMapPosChanged(slot0)
	slot0.sceneWorldPosX, slot0.sceneWorldPosY = transformhelper.getPos(slot0.sceneTrans)

	tabletool.clear(slot0.validElementIdList)
	tabletool.clear(slot0.validExploreIdList)

	for slot4, slot5 in ipairs(slot0.exploreElementIdList) do
		slot0:refreshAreaItem(slot5)
	end

	for slot4, slot5 in ipairs(slot0.subHeroElementIdList) do
		if slot0:subHeroTaskElementIsValid(slot5) then
			table.insert(slot0.validElementIdList, slot5)
		end
	end

	slot0:refreshHoles()
end

function slot0.onAddOneElement(slot0, slot1)
	if VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(slot1:getElementId()) then
		slot0:addExploreHole(slot3, slot2)

		return
	end

	if VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(slot2) then
		slot0:addSubHeroTaskHole(slot4, slot2)

		return
	end
end

function slot0.addExploreHole(slot0, slot1, slot2)
	if VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(slot1) == VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward then
		return
	end

	table.insert(slot0.exploreElementIdList, slot2)
	slot0:refreshAreaItem(slot2)
	slot0:refreshHoles()
end

function slot0.addSubHeroTaskHole(slot0, slot1, slot2)
	if VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(slot1) == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.GainedReward then
		return
	end

	table.insert(slot0.subHeroElementIdList, slot2)

	if slot0:subHeroTaskElementIsValid(slot2) then
		table.insert(slot0.validElementIdList, slot2)
	end

	slot0:refreshHoles()
end

function slot0.onRemoveElement(slot0, slot1)
	if VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(slot1:getElementId()) then
		slot0:removeExploreElement(slot3, slot2)

		return
	end

	if VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(slot2) then
		slot0:removeSubHeroTaskElement(slot4, slot2)

		return
	end
end

function slot0.removeExploreElement(slot0, slot1, slot2)
	tabletool.removeValue(slot0.exploreElementIdList, slot2)
	table.remove(slot0.validExploreIdList, slot1.id)

	if tabletool.indexOf(slot0.validElementIdList, slot2) then
		table.remove(slot0.validElementIdList, slot3)
		slot0:playHoleCloseAnimByElementId(slot2)
		slot0:playAreaItemCloseAnim(slot1.id)
	else
		slot0:recycleAreaItemById(slot1.id)
	end
end

function slot0.removeSubHeroTaskElement(slot0, slot1, slot2)
	tabletool.removeValue(slot0.subHeroElementIdList, slot2)

	if tabletool.indexOf(slot0.validElementIdList, slot2) then
		table.remove(slot0.validElementIdList, slot3)
		slot0:playHoleCloseAnimByElementId(slot2)
	end
end

function slot0.onRecycleAllElement(slot0)
	for slot4, slot5 in pairs(slot0.areaItemDict) do
		slot0:recycleAreaItem(slot5)
	end

	tabletool.clear(slot0.exploreElementIdList)
	tabletool.clear(slot0.subHeroElementIdList)
	tabletool.clear(slot0.areaItemDict)
	tabletool.clear(slot0.validElementIdList)
	tabletool.clear(slot0.validExploreIdList)
	slot0:refreshHoles()
end

function slot0.refreshAreaItem(slot0, slot1)
	if not slot0.areaItemDict[VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(slot1).id] then
		slot0.areaItemDict[slot2.id] = slot0:createAreaItem(slot2)
	end

	if not slot0:checkPosIsValid(slot2.areaPosX, slot2.areaPosY) then
		gohelper.setActive(slot3.go, false)

		return
	end

	table.insert(slot0.validExploreIdList, slot2.id)
	table.insert(slot0.validElementIdList, slot1)

	if not slot0.elementPosDict[slot1] then
		slot0.elementPosDict[slot1] = {
			slot2.areaPosX,
			slot2.areaPosY
		}
	end

	gohelper.setActive(slot3.go, true)
	gohelper.setActive(slot3.goFight, slot2.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight)
	gohelper.setActive(slot3.goDispatch, slot2.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch)
	slot0:refreshExplorePoint(slot3, slot2)
	slot0.tempVector:Set(slot2.areaPosX + slot0.sceneWorldPosX, slot2.areaPosY + slot0.sceneWorldPosY)

	slot4 = recthelper.worldPosToAnchorPos(slot0.tempVector, slot0.transform)

	recthelper.setAnchor(slot3.rectTr, slot4.x, slot4.y + VersionActivity1_5DungeonEnum.AreaItemOffsetY)
end

function slot0.refreshExplorePoint(slot0, slot1, slot2)
	slot3 = slot2.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch

	gohelper.setActive(slot1.goPoint, slot3)

	if slot3 then
		slot4 = slot2.elementList
		slot5 = #slot4
		slot7 = slot0:getPointItem(slot1, 1)

		if not VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(slot4[1]) then
			gohelper.setActive(slot7.goRunning, false)
			gohelper.setActive(slot7.goFinish, false)
		elseif slot8:isRunning() then
			gohelper.setActive(slot7.goRunning, true)
			gohelper.setActive(slot7.goFinish, false)
		elseif slot8:isFinish() then
			gohelper.setActive(slot7.goRunning, false)
			gohelper.setActive(slot7.goFinish, true)
		end

		for slot12 = 2, slot5 do
			slot7 = slot0:getPointItem(slot1, slot12)

			if DungeonMapModel.instance:elementIsFinished(slot4[slot12]) then
				gohelper.setActive(slot7.goRunning, false)
				gohelper.setActive(slot7.goFinish, true)
			else
				gohelper.setActive(slot7.goRunning, false)
				gohelper.setActive(slot7.goFinish, false)
			end
		end

		for slot12 = slot5 + 1, #slot1.pointList do
			gohelper.setActive(slot1.pointList[slot12].go, false)
		end
	end
end

function slot0.subHeroTaskElementIsValid(slot0, slot1)
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

function slot0.checkViewPortPosIsValid(slot0, slot1)
	if slot1.x < 0 or slot1.x > 1 or slot1.y < 0 or slot1.y > 1 then
		return false
	end

	return true
end

function slot0.refreshHoles(slot0)
	if not slot0.loadSceneDone then
		return
	end

	if gohelper.isNil(slot0.shader) then
		return
	end

	for slot4 = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		if slot0.validElementIdList[slot4] then
			slot6 = slot0.elementPosDict[slot5]

			slot0.tempVector4:Set(slot6[1] + slot0.sceneWorldPosX, slot6[2] + slot0.sceneWorldPosY)
		else
			slot0.tempVector4:Set(VersionActivity1_5DungeonEnum.OutSideAreaPos.X, VersionActivity1_5DungeonEnum.OutSideAreaPos.Y)
		end

		slot0.shader:SetVector(slot0.shaderParamList[slot4], slot0.tempVector4)
	end

	if SLFramework.FrameworkSettings.IsEditor and VersionActivity1_5DungeonEnum.MaxHoleNum < #slot0.validElementIdList then
		logError("同时挖洞个数大于5个了，多余直接丢弃, " .. table.concat(slot0.validElementIdList, ";"))
	end
end

function slot0.createAreaItem(slot0)
	if #slot0.areaItemPool > 0 then
		return table.remove(slot0.areaItemPool)
	end

	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goareaitem)
	slot1.rectTr = slot1.go:GetComponent(gohelper.Type_RectTransform)
	slot1.goFight = gohelper.findChild(slot1.go, "#go_tip/fight")
	slot1.goDispatch = gohelper.findChild(slot1.go, "#go_tip/dispatch")
	slot1.goPoint = gohelper.findChild(slot1.go, "#go_tip/progresspoint")
	slot1.goPointItem = gohelper.findChild(slot1.go, "#go_tip/progresspoint/staritem")
	slot1.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot1.go)

	gohelper.setActive(slot1.goPointItem, false)

	slot1.pointList = {}

	return slot1
end

function slot0.getPointItem(slot0, slot1, slot2)
	if slot1.pointList[slot2] then
		gohelper.setActive(slot3.go, true)

		return slot3
	end

	slot3 = slot0:getUserDataTb_()
	slot3.go = gohelper.cloneInPlace(slot1.goPointItem, slot2)
	slot3.goRunning = gohelper.findChild(slot3.go, "running")
	slot3.goFinish = gohelper.findChild(slot3.go, "finish")
	slot1.pointList[slot2] = slot3

	gohelper.setActive(slot3.go, true)

	return slot3
end

function slot0.recycleAreaItem(slot0, slot1)
	gohelper.setActive(slot1.go, false)
	table.insert(slot0.areaItemPool, slot1)
end

function slot0.recycleAreaItemById(slot0, slot1)
	if slot0.areaItemDict[slot1] then
		slot0:recycleAreaItem(slot2)

		slot0.areaItemDict[slot1] = nil
	end
end

function slot0._onScreenResize(slot0)
	slot0:initCameraParam()
end

function slot0.hideAreaUI(slot0)
	slot0.needHideArea = true
end

function slot0.showAreaUI(slot0)
	slot0.needHideArea = false

	for slot4, slot5 in ipairs(slot0.validExploreIdList) do
		gohelper.setActive(slot0.areaItemDict[slot5].go, true)
	end
end

function slot0.checkNeedPlayShowAnimAudio(slot0)
	if slot0.needPlayShowAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

		slot0.needPlayShowAudio = false
	end
end

function slot0.tweenMapPosDone(slot0)
	if not slot0.needHideArea then
		slot0:checkNeedPlayShowAnimAudio()

		return
	end

	slot0.hideItemCount = 0

	for slot4, slot5 in ipairs(slot0.validExploreIdList) do
		slot0.areaItemDict[slot5].animatorPlayer:Play("hide", slot0.onHideAnimDone, slot0)

		slot0.hideItemCount = slot0.hideItemCount + 1
	end
end

function slot0.onHideAnimDone(slot0)
	slot0.hideItemCount = slot0.hideItemCount - 1

	if slot0.hideItemCount == 0 then
		for slot4, slot5 in ipairs(slot0.validExploreIdList) do
			gohelper.setActive(slot0.areaItemDict[slot5].go, false)
		end
	end
end

function slot0.playHoleCloseAnimByElementId(slot0, slot1)
	if not tabletool.indexOf(slot0.validElementIdList, slot1) then
		slot0:refreshHoles()

		return
	end

	if VersionActivity1_5DungeonEnum.MaxHoleNum < slot2 then
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
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(VersionActivity1_5DungeonEnum.HoleAnimMinZ, VersionActivity1_5DungeonEnum.HoleAnimMaxZ, VersionActivity1_5DungeonEnum.HoleAnimDuration, slot0.frameCallback, slot0.doneCallback, slot0)
end

function slot0.frameCallback(slot0, slot1)
	slot0.tempVector4:Set(slot0.startVector4.x, slot0.startVector4.y, slot1)
	slot0.shader:SetVector(slot0.param, slot0.tempVector4)
end

function slot0.doneCallback(slot0)
	slot0.tempVector4:Set(slot0.startVector4.x, slot0.startVector4.y, VersionActivity1_5DungeonEnum.HoleAnimMaxZ)
	slot0.shader:SetVector(slot0.param, slot0.tempVector4)
	slot0:refreshHoles()
	UIBlockMgr.instance:endBlock("playHoleAnim")
end

function slot0.playAreaItemCloseAnim(slot0, slot1)
	if slot0.areaItemDict[slot1] then
		UIBlockMgr.instance:startBlock("playAreaAnim")

		slot0.playingExploreId = slot1

		slot2.animatorPlayer:Play("close", slot0.onCloseAnimDone, slot0)
	end
end

function slot0.onCloseAnimDone(slot0)
	slot0:recycleAreaItemById(slot0.playingExploreId)

	slot0.playingExploreId = nil

	slot0:onMapPosChanged()
	UIBlockMgr.instance:endBlock("playAreaAnim")
end

function slot0.onDispatchFinish(slot0)
	for slot4, slot5 in ipairs(slot0.validExploreIdList) do
		slot0:refreshExplorePoint(slot0.areaItemDict[slot5], VersionActivity1_5DungeonConfig.instance:getExploreTask(slot5))
	end
end

function slot0.onFocusElement(slot0, slot1)
	if tabletool.indexOf(slot0.validElementIdList, slot1) then
		slot0.needPlayShowAudio = false

		return
	end

	slot0.needPlayShowAudio = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(slot1) ~= nil
end

function slot0.onClose(slot0)
end

return slot0
