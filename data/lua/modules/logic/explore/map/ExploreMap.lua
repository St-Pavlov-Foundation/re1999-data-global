module("modules.logic.explore.map.ExploreMap", package.seeall)

slot0 = class("ExploreMap")

function slot0.ctor(slot0)
	slot0._loader = nil
	slot0._mapGo = nil
	slot0._clickEffectContainer = nil
	slot0._clickEffectLoader = nil
	slot0._initDone = false
	slot0._needLoadedCount = 0
	slot0._needUnitLoadedCount = 0
end

function slot0.isInitDone(slot0)
	return slot0._initDone
end

function slot0.getAllUnit(slot0)
	return slot0._unitDic
end

function slot0.getUnit(slot0, slot1, slot2)
	if slot0._unitDic[slot1] then
		return slot0._unitDic[slot1]
	elseif slot2 ~= true then
		logError("unit not find in map:" .. slot1)
	end
end

function slot0.getUnitByPos(slot0, slot1)
	slot3 = {}

	if slot0._unitPosDic[ExploreHelper.getKey(slot1)] then
		for slot7, slot8 in ipairs(slot0._unitPosDic[slot2]) do
			if ExploreModel.instance:isUseItemOrUnit(slot8.id) == false then
				table.insert(slot3, slot8)
			end
		end
	end

	return slot3
end

function slot0.getUnitByType(slot0, slot1)
	for slot5, slot6 in pairs(slot0._unitDic) do
		if slot6:getUnitType() == slot1 then
			return slot6
		end
	end
end

function slot0.getUnitsByType(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._unitDic) do
		if slot7:getUnitType() == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getUnitsByTypeDict(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._unitDic) do
		if slot1[slot7:getUnitType()] then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getHeroPos(slot0)
	if slot0._hero then
		return slot0._hero.nodePos
	end
end

function slot0.getHero(slot0)
	return slot0._hero
end

function slot0.loadMap(slot0)
	ExploreMapTriggerController.instance:registerMap(slot0)

	slot0._root = GameSceneMgr.instance:getScene(SceneType.Explore):getSceneContainerGO()
	slot0._mapId = ExploreModel.instance:getMapId()
	slot0._episodeCo = DungeonConfig.instance:getEpisodeCO(ExploreConfig.instance:getEpisodeId(slot0._mapId))
	slot0._mapPrefabPath = ExploreConstValue.MapPrefab
	slot0._mapConfigPath = string.format(ExploreConstValue.MapConfigPath, ExploreModel.instance:getMapId())
	slot0._meshPath = string.format(ExploreConstValue.MapNavMeshPath, ExploreModel.instance:getMapId())
	slot3 = MultiAbLoader.New()
	slot0._loader = slot3

	slot3:addPath(slot0._mapPrefabPath)
	slot3:addPath(ExploreConstValue.EntryCameraCtrlPath)
	slot3:addPath(slot0._meshPath)
	slot3:startLoad(slot0._loadedFinish, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnClickMap, slot0._onClickMap, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnClickUnit, slot0._onClickUnit, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, slot0._onCharacterPosChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, slot0._onCharacterPosChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterStartMove, slot0._onCharacterStartMove, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, slot0._onCharacterNodeChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.MoveHeroToPos, slot0.moveTo, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, slot0._onHeroMoveEnd, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitNodeChange, slot0._onUnitNodeChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitStatusChange, slot0._onUnitStatusChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitStatus2Change, slot0.OnUnitStatus2Change, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.UpdateMoveDir, slot0.UpdateMoveDir, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.CounterChange, slot0.CounterChange, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.CounterInitDone, slot0.CounterInitDone, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroFirstAnimEnd, slot0.beginCameraAnim, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
end

function slot0.unloadMap(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnClickMap, slot0._onClickMap, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnClickUnit, slot0._onClickUnit, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, slot0._onCharacterPosChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, slot0._onCharacterPosChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterStartMove, slot0._onCharacterStartMove, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, slot0._onCharacterNodeChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.MoveHeroToPos, slot0.moveTo, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, slot0._onHeroMoveEnd, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitNodeChange, slot0._onUnitNodeChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitStatusChange, slot0._onUnitStatusChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitStatus2Change, slot0.OnUnitStatus2Change, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UpdateMoveDir, slot0.UpdateMoveDir, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.CounterChange, slot0.CounterChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.CounterInitDone, slot0.CounterInitDone, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjLoadedCb, slot0.onSceneObjLoadedDone, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroFirstAnimEnd, slot0.beginCameraAnim, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
	slot0:destroy()
	gohelper.destroy(slot0._mapGo)
	slot0._loader:dispose()
end

function slot0.setCameraPos(slot0, slot1)
	slot0._cameraComponent:setCameraPos(slot1)

	if slot0._preloadComp then
		slot0._preloadComp:updateCameraPos(slot1)
	end
end

function slot0.clearUnUseObj(slot0)
	if slot0._preloadComp then
		slot0._preloadComp:clearUnUseObj()
	end

	ResDispose.unloadTrue()
end

function slot0.addUnitNeedLoadedNum(slot0, slot1)
	slot0._needUnitLoadedCount = slot0._needUnitLoadedCount + slot1

	if slot0._waitAllObjLoaded and slot0._needLoadedCount <= 0 and slot0._needUnitLoadedCount <= 0 then
		slot0._waitAllObjLoaded = false

		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
	end
end

function slot0.markWaitAllSceneObj(slot0)
	if not slot0._preloadComp then
		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)

		return
	end

	slot0._waitAllObjLoaded = true
	slot0._needLoadedCount = slot0._preloadComp:calcNeedLoadedSceneObj()

	if slot0._needLoadedCount > 0 then
		ExploreController.instance:registerCallback(ExploreEvent.SceneObjLoadedCb, slot0.onSceneObjLoadedDone, slot0)
	elseif slot0._needUnitLoadedCount <= 0 then
		slot0._waitAllObjLoaded = false

		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
	end
end

function slot0.onSceneObjLoadedDone(slot0)
	slot0._needLoadedCount = slot0._needLoadedCount - 1

	if slot0._needLoadedCount <= 0 then
		ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjLoadedCb, slot0.onSceneObjLoadedDone, slot0)

		if slot0._needUnitLoadedCount <= 0 then
			slot0._waitAllObjLoaded = false

			ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
		end
	end
end

function slot0.showGrid(slot0)
	for slot4, slot5 in pairs(slot0._walkableList) do
		slot6 = ExploreGrid.New(slot0:getContainRootByAreaId(slot5.areaId).node)

		slot6:setName(slot5.walkableKey)
		slot6:setPosByNode(slot5.pos)
	end
end

function slot0.GetTilemapMousePos(slot0, slot1, slot2)
	slot5, slot6 = UnityEngine.Physics.Raycast(slot0._cameraComponent:getCamera():ScreenPointToRay(slot1), nil, Mathf.Infinity, slot2 and ExploreHelper.getNavigateMask() or ExploreHelper.getSceneMask())

	if slot5 then
		slot8 = slot6.point

		return tolua.getpeer(slot6.collider), ExploreHelper.posToTile(slot8), slot8
	end
end

function slot0.getHitTriggerTrans(slot0, slot1)
	slot3, slot4 = UnityEngine.Physics.Raycast(slot0._cameraComponent:getCamera():ScreenPointToRay(GamepadController.instance:getMousePosition()), nil, Mathf.Infinity, slot1 or ExploreHelper.getTriggerMask())

	if slot3 then
		return slot4.transform
	end
end

function slot0.getSceneY(slot0, slot1)
	slot1.y = 10
	slot3, slot4 = UnityEngine.Physics.Raycast(slot1, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())
	slot1.y = slot1.y

	if slot3 then
		return slot4.point.y
	else
		return slot2
	end
end

function slot0.UpdateMoveDir(slot0, slot1)
	if slot1 and slot0:getNowStatus() ~= ExploreEnum.MapStatus.Normal then
		return
	end

	if slot0._hero then
		slot0._hero:setMoveDir(slot1)
	end
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == ViewName.LoadingView and GameSceneMgr.instance:getCurSceneType() == SceneType.Explore then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)

		if ExploreModel.instance.isFirstEnterMap ~= ExploreEnum.EnterMode.Battle then
			ViewMgr.instance:openView(ViewName.ExploreEnterView)
		elseif slot0._hero then
			slot0._hero:onRoleFirstEnter()
		end
	end
end

function slot0.CounterChange(slot0, slot1, slot2)
	if slot0:getUnit(slot1, true) then
		slot3:onUpdateCount(slot2)
	end
end

function slot0.CounterInitDone(slot0)
	for slot4, slot5 in pairs(slot0._unitDic) do
		slot5:onUpdateCount(ExploreCounterModel.instance:getCount(slot4), ExploreCounterModel.instance:getTotalCount(slot4))
	end
end

function slot0.moveTo(slot0, slot1, slot2, slot3)
	if slot1 ~= nil then
		for slot8, slot9 in ipairs(slot0:getUnitByPos(slot1)) do
			if slot9.mo.triggerByClick ~= false and (not slot9.clickComp or slot9.clickComp.enable) then
				slot0:_onClickUnit(slot9.mo)

				return true
			end
		end

		slot0._hero:moveTo(slot1, slot2, slot3)
	end
end

function slot0._showClickEffect(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.Explore.ClickFloor)
	gohelper.setActive(slot0._clickEffectContainer, false)
	gohelper.setActive(slot0._clickEffectContainer, true)

	slot2 = ExploreHelper.tileToPos(slot1)
	slot2.y = slot0:getSceneY(slot2)
	slot0._clickEffectContainer.transform.position = slot2
end

function slot0.startFindPath(slot0, slot1, slot2, slot3)
	slot0._route = slot0._route or ExploreAStarFindRoute.New()

	for slot10, slot11 in pairs(slot0._walkableList) do
		if slot11:isWalkable(slot0._walkableList[ExploreHelper.getKeyXY(slot1.x, slot1.y)].height) then
			-- Nothing
		end
	end

	slot7, slot8 = slot0._route:startFindPath({
		[slot10] = slot11.walkableKey
	}, slot1, slot2, slot3)

	if #slot7 <= 0 then
		slot7, slot8 = slot0._route:startFindPath(slot6, slot1, slot8, slot3)
	end

	if ExploreHelper.getCornerNum(slot7, slot1) > 1 then
		slot10 = slot0._route:startFindPath(slot6, slot2, slot1, slot3)

		if #slot10 > 0 and ExploreHelper.getCornerNum(slot10, slot2) < slot9 then
			for slot15 = #slot10, 2, -1 do
				table.insert({
					slot2
				}, slot10[slot15])
			end
		end
	end

	return slot7
end

function slot0._onHeroMoveEnd(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getUnitByPos(slot1)) do
		if slot7:isEnable() then
			slot7:onRoleStay()
		end
	end
end

function slot0._onCharacterStartMove(slot0, slot1, slot2)
	ExploreMapModel.instance:setNodeLight(slot1)
end

function slot0._onUnitNodeChange(slot0, slot1, slot2, slot3)
	if slot3 then
		slot4 = slot1.mo

		for slot8 = slot4.offsetSize[1], slot4.offsetSize[3] do
			for slot12 = slot4.offsetSize[2], slot4.offsetSize[4] do
				if slot0._unitPosDic[ExploreHelper.getKeyXY(slot3.x + slot8, slot3.y + slot12)] ~= nil then
					tabletool.removeValue(slot0._unitPosDic[slot13], slot1)
				end
			end
		end

		if slot2 then
			for slot8 = slot4.offsetSize[1], slot4.offsetSize[3] do
				for slot12 = slot4.offsetSize[2], slot4.offsetSize[4] do
					if slot0._unitPosDic[ExploreHelper.getKeyXY(slot2.x + slot8, slot2.y + slot12)] == nil then
						slot0._unitPosDic[slot13] = {}
					end

					table.insert(slot0._unitPosDic[slot13], slot1)
				end
			end
		end
	end

	slot4 = {}
	slot5 = {}

	if slot2 then
		slot5 = slot0:getUnitByPos(slot2)
	end

	if slot3 then
		slot9 = slot3

		for slot9, slot10 in ipairs(slot0:getUnitByPos(slot9)) do
			if slot1 ~= slot10 and slot10:isEnable() and tabletool.indexOf(slot5, slot10) == nil then
				slot10:onRoleLeave(slot2 or slot3, slot3, slot1)
			end
		end
	end

	for slot9, slot10 in ipairs(slot5) do
		if slot1 ~= slot10 and slot10:isEnable() and tabletool.indexOf(slot4, slot10) == nil then
			slot10:onRoleEnter(slot2, slot3, slot1)
		end
	end

	slot0:checkUnitNear(slot2, slot1)
end

function slot0.checkAllRuneTrigger(slot0)
	for slot4, slot5 in pairs(slot0._unitDic) do
		if slot5:getUnitType() == ExploreEnum.ItemType.Rune then
			slot5:checkShowIcon()
		end
	end
end

function slot0.checkUnitNear(slot0, slot1, slot2)
	if slot0._nearIdList and slot1 and slot2 then
		slot3 = ExploreHelper.getDistance(slot1, slot0._hero.nodePos) == 1
		slot4 = false
		slot5 = nil

		for slot9, slot10 in pairs(slot0._nearIdList) do
			if slot10 == slot2.id then
				slot4 = true
				slot5 = slot9

				break
			end
		end

		if slot3 ~= slot4 then
			if slot4 then
				table.remove(slot0._nearIdList, slot5)
				slot2:onRoleFar()
			else
				table.insert(slot0._nearIdList, slot2.id)
				slot2:onRoleNear()
			end
		end
	end
end

function slot0._onUnitStatusChange(slot0, slot1, slot2)
	if not slot0._initDone then
		return
	end

	if slot0:getUnit(slot1, true) then
		slot3:onStatusChange(slot2)
	end
end

function slot0.OnUnitStatus2Change(slot0, slot1, slot2, slot3)
	if not slot0._initDone then
		return
	end

	if slot0:getUnit(slot1, true) then
		slot4:onStatus2Change(slot2, slot3)
	end
end

function slot0._onCharacterNodeChange(slot0, slot1, slot2, slot3)
	if slot2 and slot0._hero:getHeroStatus() ~= ExploreAnimEnum.RoleAnimStatus.Glide and slot0:getNowStatus() ~= ExploreEnum.MapStatus.MoveUnit then
		ExploreModel.instance:setStepPause(false)
	end

	slot4 = {}
	slot5 = slot0:getUnitByPos(slot1)

	if slot2 then
		slot9 = slot2

		for slot9, slot10 in ipairs(slot0:getUnitByPos(slot9)) do
			if slot10:isEnable() and tabletool.indexOf(slot5, slot10) == nil then
				slot10:onRoleLeave(slot1, slot2, slot0._hero)
			end
		end
	end

	for slot9, slot10 in ipairs(slot5) do
		if slot10:isEnable() and tabletool.indexOf(slot4, slot10) == nil then
			slot10:onRoleEnter(slot1, slot2, slot0._hero)
		end
	end

	ExploreMapModel.instance:setNodeLight(slot1)

	if slot2 and slot0._hero:getHeroStatus() ~= ExploreAnimEnum.RoleAnimStatus.Glide and slot0:getNowStatus() ~= ExploreEnum.MapStatus.MoveUnit then
		ExploreRpc.instance:sendExploreMoveRequest(slot1.x, slot1.y)
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChangeCameraCO, ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot1)) and slot6.cameraId)

	if slot6 and ExploreMapModel.instance:getMapAreaMO(slot6.areaId) then
		ExploreMapModel.instance:setIsShowResetBtn(slot7.isCanReset)
	end

	slot0._nearIdList = slot0._nearIdList or {}
	slot7 = {}

	for slot11 = 0, 270, 90 do
		slot12 = ExploreHelper.dirToXY(slot11)

		if slot0._unitPosDic[ExploreHelper.getKeyXY(slot1.x + slot12.x, slot1.y + slot12.y)] then
			for slot18, slot19 in pairs(slot14) do
				slot7[slot19.id] = true
			end
		end
	end

	for slot11 = #slot0._nearIdList, 1, -1 do
		if slot7[slot0._nearIdList[slot11]] then
			slot7[slot12] = nil
		else
			if slot0:getUnit(slot12, true) then
				slot13:onRoleFar()
			end

			table.remove(slot0._nearIdList, slot11)
		end
	end

	for slot11 in pairs(slot7) do
		table.insert(slot0._nearIdList, slot11)

		if slot0:getUnit(slot11, true) then
			slot12:onRoleNear()
		end
	end
end

function slot0._onCharacterPosChange(slot0, slot1)
	slot0:setCameraPos(slot1)
end

function slot0._onClickUnit(slot0, slot1)
	slot0._hero:moveToTar(slot1)
end

function slot0.setMapStatus(slot0, slot1, slot2)
	if slot0._compDict[slot0._nowStatus] then
		if not slot0._compDict[slot0._nowStatus]:canSwitchStatus(slot1) then
			return false
		end

		slot0._compDict[slot0._nowStatus]:onStatusEnd()
	end

	slot0._nowStatus = slot1

	if slot0._compDict[slot0._nowStatus] then
		slot0._compDict[slot0._nowStatus]:onStatusStart(slot2)
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.MapStatusChange, slot1)

	return true
end

function slot0._onClickMap(slot0, slot1)
	if slot0._compDict[slot0._nowStatus] then
		return slot0._compDict[slot0._nowStatus]:onMapClick(slot1)
	end

	if not slot0._mapGo or not slot0._mapGo.activeInHierarchy then
		return
	end

	slot2, slot3 = slot0:GetTilemapMousePos(slot1)
	slot4 = false

	if slot2 and slot2:click() then
		-- Nothing
	elseif slot2 == nil then
		slot4 = slot0:moveTo(slot3)
	else
		slot2, slot6 = slot0:GetTilemapMousePos(slot1, true)

		if slot6 then
			slot4 = slot0:moveTo(slot3)
		else
			slot2, slot6 = slot0:GetTilemapMousePos(slot1)
			slot4 = slot0:moveTo(slot6)
		end
	end

	slot5 = false

	if slot3 then
		slot5 = ExploreMapModel.instance:getNodeCanWalk(ExploreHelper.getKey(slot3))
	end

	if ExploreModel.instance:isHeroInControl() and slot3 and not slot2 and not slot4 and slot5 then
		slot0:_showClickEffect(slot3)
	end
end

function slot0.adjustSpineLookRotation(slot0, slot1)
	if slot1 and not gohelper.isNil(slot1.go) then
		slot1:setRotate(slot0._cameraComponent:getRotation())
	end
end

function slot0._loadedFinish(slot0, slot1)
	if slot0._episodeCo and slot0._episodeCo.bgmevent > 0 then
		-- Nothing
	end

	slot4 = gohelper.clone(slot0._loader:getAssetItem(slot0._mapPrefabPath):GetResource(slot0._mapPrefabPath), slot0._root)
	slot0._mapGo = slot4
	slot5 = gohelper.create3d(slot4, "NavMesh")

	if slot0._loader:getAssetItem(slot0._meshPath) and slot6.IsLoadSuccess then
		gohelper.onceAddComponent(slot5, typeof(UnityEngine.MeshCollider)).sharedMesh = slot6:GetResource()

		gohelper.setLayer(slot5, UnityLayer.Scene)
	end

	ExploreConfig.instance:loadExploreConfig(ExploreModel.instance.mapId)
	ExploreMapModel.instance:initMapData(ExploreConfig.instance:getMapConfig(), ExploreModel.instance.mapId)
	slot4:SetActive(false)
	slot0:_initMap()

	if slot0._preloadComp == nil then
		ExploreController.instance:dispatchEvent(ExploreEvent.InitMapDone)
	end
end

function slot0.getLoader(slot0)
	return slot0._loader
end

function slot0.getNowStatus(slot0)
	return slot0._nowStatus
end

function slot0.getCompByType(slot0, slot1)
	if not slot0._compDict then
		return
	end

	return slot0._compDict[slot1]
end

function slot0.getCatchComp(slot0)
	return slot0._catchComponent
end

function slot0._initMap(slot0)
	if not slot0._mapGo then
		return
	end

	slot0._mapGo:SetActive(true)

	slot0._cameraComponent = MonoHelper.addLuaComOnceToGo(slot0._mapGo, ExploreCamera)
	slot4 = slot0

	slot0._cameraComponent:setMap(slot4)

	slot0._nowStatus = ExploreEnum.MapStatus.Normal
	slot0._compDict = {
		[ExploreEnum.MapStatus.UseItem] = MonoHelper.addLuaComOnceToGo(slot0._mapGo, ExploreMapUseItemComp),
		[ExploreEnum.MapStatus.MoveUnit] = MonoHelper.addLuaComOnceToGo(slot0._mapGo, ExploreMapUnitMoveComp)
	}
	slot5 = slot0._mapGo
	slot0._compDict[ExploreEnum.MapStatus.RotateUnit] = MonoHelper.addLuaComOnceToGo(slot5, ExploreMapUnitRotateComp)

	for slot4, slot5 in pairs(slot0._compDict) do
		slot5:setMap(slot0)
		slot5:setMapStatus(slot4)
	end

	slot0._preloadComp = MonoHelper.addLuaComOnceToGo(slot0._mapGo, ExploreMapScenePreloadComp)

	if slot0._preloadComp.hasInit == false then
		slot0._preloadComp = nil
	end

	slot0._catchComponent = MonoHelper.addLuaComOnceToGo(slot0._mapGo, ExploreMapUnitCatchComp)
	slot0._fovComponent = MonoHelper.addLuaComOnceToGo(slot0._mapGo, ExploreMapFOVComp)
	slot0._unitRoot = gohelper.findChild(slot0._mapGo, "unit")

	slot0:_buildNode()
	slot0:_buildUnit()
	slot0:_initCharacter()
	slot0:_initClickEffect()

	if slot0._preloadComp == nil then
		slot0:showGrid()
	end

	slot0._fovComponent:setMap(slot0)

	slot4 = slot0

	slot0._catchComponent:setMap(slot4)
	ExploreCounterModel.instance:reCalcCount()

	for slot4, slot5 in pairs(slot0._unitDic) do
		slot5:onMapInit()
	end

	slot0._initDone = true

	ExploreController.instance:getMapLight():initLight()
	ExploreController.instance:getMapWhirl():init(slot0._mapGo)
	ExploreController.instance:getMapPipe():init()
	slot0._cameraComponent:initHeroPos()
end

function slot0.beginCameraAnim(slot0)
	for slot4, slot5 in pairs(slot0._unitDic) do
		slot5:onHeroInitDone()
	end
end

function slot0.getUnitRoot(slot0)
	return slot0._unitRoot
end

function slot0.getContainRootByAreaId(slot0, slot1)
	if type(slot1) ~= "number" then
		slot1 = 0
	end

	if not slot0._areaRoots then
		slot0._areaRoots = {}
	end

	if not slot0._areaRoots[slot1] then
		slot0._areaRoots[slot1] = {
			go = gohelper.create3d(slot0._mapGo, "area_" .. slot1)
		}
		slot0._areaRoots[slot1].unit = gohelper.create3d(slot0._areaRoots[slot1].go, "unit")
		slot0._areaRoots[slot1].sceneObj = gohelper.create3d(slot0._areaRoots[slot1].go, "sceneObj")
		slot0._areaRoots[slot1].node = gohelper.create3d(slot0._areaRoots[slot1].go, "node")

		if ExploreMapModel.instance:getMapAreaMO(slot1) and not slot2.visible then
			gohelper.setActive(slot0._areaRoots[slot1].go, false)
		end
	end

	return slot0._areaRoots[slot1]
end

function slot0._buildNode(slot0)
	slot0._walkableList = {}

	for slot5, slot6 in pairs(ExploreMapModel.instance:getNodeDic()) do
		slot0._walkableList[slot6.walkableKey] = slot6
	end
end

function slot0._buildUnit(slot0)
	slot0._unitDic = {}
	slot0._hideUnitDic = {}
	slot0._unitPosDic = {}

	for slot5, slot6 in pairs(ExploreMapModel.instance:getUnitDic()) do
		slot0:enterUnit(slot6)
	end

	if ExploreModel.instance:getAllInteractInfo() then
		for slot6, slot7 in pairs(slot2) do
			if ExploreMapModel.instance:getUnitMO(slot6) == nil then
				ExploreController.instance:updateUnit(slot7)
			end
		end
	end
end

function slot0.haveNodeXY(slot0, slot1)
	return slot0._walkableList[slot1] and true or false
end

function slot0.enterUnit(slot0, slot1)
	slot2 = slot0._unitDic[slot1.id]

	if not slot1:isEnter() then
		slot0._hideUnitDic[slot1.id] = slot2

		return
	end

	slot3 = nil

	if slot2 == nil then
		if slot0._hideUnitDic[slot1.id] then
			slot2 = slot0._hideUnitDic[slot1.id]
			slot0._hideUnitDic[slot1.id] = nil
		else
			slot4 = slot1:getUnitClass()
			slot5 = slot1.areaId

			if slot1.type == ExploreEnum.ItemType.SceneAudio then
				slot5 = -9999999
			end

			slot2 = slot4.New(slot0:getContainRootByAreaId(slot5).unit)
		end

		slot3 = true
	end

	slot0._unitDic[slot1.id] = slot2

	slot2:setData(slot1)

	if slot3 or not slot2.nodePos then
		for slot8 = slot1.offsetSize[1], slot1.offsetSize[3] do
			for slot12 = slot1.offsetSize[2], slot1.offsetSize[4] do
				if slot0._unitPosDic[ExploreHelper.getKeyXY(slot1.nodePos.x + slot8, slot1.nodePos.y + slot12)] == nil then
					slot0._unitPosDic[slot13] = {}
				end

				if not tabletool.indexOf(slot0._unitPosDic[slot13], slot2) then
					table.insert(slot0._unitPosDic[slot13], slot2)
				end
			end
		end

		if slot0._initDone then
			slot2:setInFOV(true)
			slot2:checkLight()
		end
	end
end

function slot0.removeUnit(slot0, slot1)
	if slot0._unitDic[slot1] then
		slot3 = slot2.mo
		slot0._hideUnitDic[slot3.id] = slot2
		slot0._unitDic[slot3.id] = nil

		for slot7 = slot3.offsetSize[1], slot3.offsetSize[3] do
			for slot11 = slot3.offsetSize[2], slot3.offsetSize[4] do
				if slot0._unitPosDic[ExploreHelper.getKeyXY(slot3.nodePos.x + slot7, slot3.nodePos.y + slot11)] ~= nil then
					for slot16, slot17 in pairs(slot0._unitPosDic[slot12]) do
						if slot17 ~= slot2 then
							slot17:onRoleLeave(slot2.nodePos, slot2.nodePos, slot2)
						end
					end

					tabletool.removeValue(slot0._unitPosDic[slot12], slot2)
				end
			end
		end

		slot2:setExit()
	end
end

function slot0._initCharacter(slot0)
	slot0._hero = ExploreHero.New(gohelper.findChild(slot0._mapGo, "role"))

	slot0._hero:setMap(slot0)
	slot0._hero:onUpdateExploreInfo()
	slot0._hero:setResPath("explore/roles/prefabs/hero.prefab")
end

function slot0._initClickEffect(slot0)
	slot0._clickEffectContainer = UnityEngine.GameObject.New("ClickEffect")

	gohelper.addChild(slot0._mapGo, slot0._clickEffectContainer)

	slot0._clickEffectLoader = PrefabInstantiate.Create(slot0._clickEffectContainer)

	slot0._clickEffectLoader:startLoad(ResUrl.getExploreEffectPath(ExploreConstValue.ClickEffect), function ()
		uv0._effectGo = uv0._clickEffectLoader:getInstGO()

		gohelper.addChild(uv0._clickEffectContainer, uv0._effectGo)
		gohelper.setActive(uv0._clickEffectContainer, false)

		uv0._effectOrderContainer = gohelper.findChildComponent(uv0._effectGo, "root", typeof(ZProj.EffectOrderContainer))
	end)
end

function slot0.destroy(slot0)
	for slot4, slot5 in pairs(slot0._unitDic) do
		slot5:destroy()
	end

	for slot4, slot5 in pairs(slot0._hideUnitDic) do
		slot5:destroy()
	end

	if slot0._hero then
		slot0._hero:destroy()

		slot0._hero = nil
	end

	if slot0._clickEffectLoader then
		slot0._clickEffectLoader:dispose()

		slot0._clickEffectLoader = nil
	end

	gohelper.destroy(slot0._clickEffectContainer)

	slot0._clickEffectContainer = nil
	slot0._unitDic = nil
	slot0._hideUnitDic = nil
	slot0._nowStatus = ExploreEnum.MapStatus.Normal
	slot0._compDict = nil

	ExploreModel.instance:setHeroControl(true)
	ExploreMapTriggerController.instance:unRegisterMap(slot0)
	ExploreMapModel.instance:clear()
	ZProj.ExploreHelper.Clear()
	ViewMgr.instance:closeView(ViewName.ExploreEnterView)
	ExploreHeroCatchUnitFlow.instance:clear()
	ExploreHeroFallAnimFlow.instance:clear()
	ExploreHeroTeleportFlow.instance:clear()
	ExploreHeroResetFlow.instance:clear()
	ExploreMapLightPool.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.Explore.HeroWalkStop)
	AudioMgr.instance:trigger(AudioEnum.Explore.HeroGlideStop)
	AudioMgr.instance:trigger(AudioEnum.Explore.ElevatorStop)
end

return slot0
