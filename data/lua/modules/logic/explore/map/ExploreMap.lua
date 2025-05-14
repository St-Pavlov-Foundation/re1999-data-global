module("modules.logic.explore.map.ExploreMap", package.seeall)

local var_0_0 = class("ExploreMap")

function var_0_0.ctor(arg_1_0)
	arg_1_0._loader = nil
	arg_1_0._mapGo = nil
	arg_1_0._clickEffectContainer = nil
	arg_1_0._clickEffectLoader = nil
	arg_1_0._initDone = false
	arg_1_0._needLoadedCount = 0
	arg_1_0._needUnitLoadedCount = 0
end

function var_0_0.isInitDone(arg_2_0)
	return arg_2_0._initDone
end

function var_0_0.getAllUnit(arg_3_0)
	return arg_3_0._unitDic
end

function var_0_0.getUnit(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._unitDic[arg_4_1] then
		return arg_4_0._unitDic[arg_4_1]
	elseif arg_4_2 ~= true then
		logError("unit not find in map:" .. arg_4_1)
	end
end

function var_0_0.getUnitByPos(arg_5_0, arg_5_1)
	local var_5_0 = ExploreHelper.getKey(arg_5_1)
	local var_5_1 = {}

	if arg_5_0._unitPosDic[var_5_0] then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._unitPosDic[var_5_0]) do
			if ExploreModel.instance:isUseItemOrUnit(iter_5_1.id) == false then
				table.insert(var_5_1, iter_5_1)
			end
		end
	end

	return var_5_1
end

function var_0_0.getUnitByType(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._unitDic) do
		if iter_6_1:getUnitType() == arg_6_1 then
			return iter_6_1
		end
	end
end

function var_0_0.getUnitsByType(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._unitDic) do
		if iter_7_1:getUnitType() == arg_7_1 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_0.getUnitsByTypeDict(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0._unitDic) do
		if arg_8_1[iter_8_1:getUnitType()] then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.getHeroPos(arg_9_0)
	if arg_9_0._hero then
		return arg_9_0._hero.nodePos
	end
end

function var_0_0.getHero(arg_10_0)
	return arg_10_0._hero
end

function var_0_0.loadMap(arg_11_0)
	ExploreMapTriggerController.instance:registerMap(arg_11_0)

	arg_11_0._root = GameSceneMgr.instance:getScene(SceneType.Explore):getSceneContainerGO()
	arg_11_0._mapId = ExploreModel.instance:getMapId()

	local var_11_0 = ExploreConfig.instance:getEpisodeId(arg_11_0._mapId)

	arg_11_0._episodeCo = DungeonConfig.instance:getEpisodeCO(var_11_0)
	arg_11_0._mapPrefabPath = ExploreConstValue.MapPrefab
	arg_11_0._mapConfigPath = string.format(ExploreConstValue.MapConfigPath, ExploreModel.instance:getMapId())
	arg_11_0._meshPath = string.format(ExploreConstValue.MapNavMeshPath, ExploreModel.instance:getMapId())

	local var_11_1 = MultiAbLoader.New()

	arg_11_0._loader = var_11_1

	var_11_1:addPath(arg_11_0._mapPrefabPath)
	var_11_1:addPath(ExploreConstValue.EntryCameraCtrlPath)
	var_11_1:addPath(arg_11_0._meshPath)
	var_11_1:startLoad(arg_11_0._loadedFinish, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnClickMap, arg_11_0._onClickMap, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnClickUnit, arg_11_0._onClickUnit, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, arg_11_0._onCharacterPosChange, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, arg_11_0._onCharacterPosChange, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterStartMove, arg_11_0._onCharacterStartMove, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, arg_11_0._onCharacterNodeChange, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.MoveHeroToPos, arg_11_0.moveTo, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, arg_11_0._onHeroMoveEnd, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitNodeChange, arg_11_0._onUnitNodeChange, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitStatusChange, arg_11_0._onUnitStatusChange, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnUnitStatus2Change, arg_11_0.OnUnitStatus2Change, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.UpdateMoveDir, arg_11_0.UpdateMoveDir, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.CounterChange, arg_11_0.CounterChange, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.CounterInitDone, arg_11_0.CounterInitDone, arg_11_0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroFirstAnimEnd, arg_11_0.beginCameraAnim, arg_11_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_11_0._onViewClose, arg_11_0)
end

function var_0_0.unloadMap(arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnClickMap, arg_12_0._onClickMap, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnClickUnit, arg_12_0._onClickUnit, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, arg_12_0._onCharacterPosChange, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, arg_12_0._onCharacterPosChange, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterStartMove, arg_12_0._onCharacterStartMove, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, arg_12_0._onCharacterNodeChange, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.MoveHeroToPos, arg_12_0.moveTo, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, arg_12_0._onHeroMoveEnd, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitNodeChange, arg_12_0._onUnitNodeChange, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitStatusChange, arg_12_0._onUnitStatusChange, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnUnitStatus2Change, arg_12_0.OnUnitStatus2Change, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UpdateMoveDir, arg_12_0.UpdateMoveDir, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.CounterChange, arg_12_0.CounterChange, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.CounterInitDone, arg_12_0.CounterInitDone, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjLoadedCb, arg_12_0.onSceneObjLoadedDone, arg_12_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroFirstAnimEnd, arg_12_0.beginCameraAnim, arg_12_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_12_0._onViewClose, arg_12_0)
	arg_12_0:destroy()
	gohelper.destroy(arg_12_0._mapGo)
	arg_12_0._loader:dispose()
end

function var_0_0.setCameraPos(arg_13_0, arg_13_1)
	arg_13_0._cameraComponent:setCameraPos(arg_13_1)

	if arg_13_0._preloadComp then
		arg_13_0._preloadComp:updateCameraPos(arg_13_1)
	end
end

function var_0_0.clearUnUseObj(arg_14_0)
	if arg_14_0._preloadComp then
		arg_14_0._preloadComp:clearUnUseObj()
	end

	ResDispose.unloadTrue()
end

function var_0_0.addUnitNeedLoadedNum(arg_15_0, arg_15_1)
	arg_15_0._needUnitLoadedCount = arg_15_0._needUnitLoadedCount + arg_15_1

	if arg_15_0._waitAllObjLoaded and arg_15_0._needLoadedCount <= 0 and arg_15_0._needUnitLoadedCount <= 0 then
		arg_15_0._waitAllObjLoaded = false

		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
	end
end

function var_0_0.markWaitAllSceneObj(arg_16_0)
	if not arg_16_0._preloadComp then
		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)

		return
	end

	arg_16_0._waitAllObjLoaded = true
	arg_16_0._needLoadedCount = arg_16_0._preloadComp:calcNeedLoadedSceneObj()

	if arg_16_0._needLoadedCount > 0 then
		ExploreController.instance:registerCallback(ExploreEvent.SceneObjLoadedCb, arg_16_0.onSceneObjLoadedDone, arg_16_0)
	elseif arg_16_0._needUnitLoadedCount <= 0 then
		arg_16_0._waitAllObjLoaded = false

		ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
	end
end

function var_0_0.onSceneObjLoadedDone(arg_17_0)
	arg_17_0._needLoadedCount = arg_17_0._needLoadedCount - 1

	if arg_17_0._needLoadedCount <= 0 then
		ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjLoadedCb, arg_17_0.onSceneObjLoadedDone, arg_17_0)

		if arg_17_0._needUnitLoadedCount <= 0 then
			arg_17_0._waitAllObjLoaded = false

			ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjAllLoadedDone)
		end
	end
end

function var_0_0.showGrid(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0._walkableList) do
		local var_18_0 = ExploreGrid.New(arg_18_0:getContainRootByAreaId(iter_18_1.areaId).node)

		var_18_0:setName(iter_18_1.walkableKey)
		var_18_0:setPosByNode(iter_18_1.pos)
	end
end

function var_0_0.GetTilemapMousePos(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._cameraComponent:getCamera():ScreenPointToRay(arg_19_1)
	local var_19_1 = arg_19_2 and ExploreHelper.getNavigateMask() or ExploreHelper.getSceneMask()
	local var_19_2, var_19_3 = UnityEngine.Physics.Raycast(var_19_0, nil, Mathf.Infinity, var_19_1)

	if var_19_2 then
		local var_19_4 = tolua.getpeer(var_19_3.collider)
		local var_19_5 = var_19_3.point

		return var_19_4, ExploreHelper.posToTile(var_19_5), var_19_5
	end
end

function var_0_0.getHitTriggerTrans(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._cameraComponent:getCamera():ScreenPointToRay(GamepadController.instance:getMousePosition())

	arg_20_1 = arg_20_1 or ExploreHelper.getTriggerMask()

	local var_20_1, var_20_2 = UnityEngine.Physics.Raycast(var_20_0, nil, Mathf.Infinity, arg_20_1)

	if var_20_1 then
		return var_20_2.transform
	end
end

function var_0_0.getSceneY(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.y

	arg_21_1.y = 10

	local var_21_1, var_21_2 = UnityEngine.Physics.Raycast(arg_21_1, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

	arg_21_1.y = var_21_0

	if var_21_1 then
		return var_21_2.point.y
	else
		return var_21_0
	end
end

function var_0_0.UpdateMoveDir(arg_22_0, arg_22_1)
	if arg_22_1 and arg_22_0:getNowStatus() ~= ExploreEnum.MapStatus.Normal then
		return
	end

	if arg_22_0._hero then
		arg_22_0._hero:setMoveDir(arg_22_1)
	end
end

function var_0_0._onViewClose(arg_23_0, arg_23_1)
	if arg_23_1 == ViewName.LoadingView and GameSceneMgr.instance:getCurSceneType() == SceneType.Explore then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_23_0._onViewClose, arg_23_0)

		if ExploreModel.instance.isFirstEnterMap ~= ExploreEnum.EnterMode.Battle then
			ViewMgr.instance:openView(ViewName.ExploreEnterView)
		elseif arg_23_0._hero then
			arg_23_0._hero:onRoleFirstEnter()
		end
	end
end

function var_0_0.CounterChange(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:getUnit(arg_24_1, true)

	if var_24_0 then
		var_24_0:onUpdateCount(arg_24_2)
	end
end

function var_0_0.CounterInitDone(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._unitDic) do
		iter_25_1:onUpdateCount(ExploreCounterModel.instance:getCount(iter_25_0), ExploreCounterModel.instance:getTotalCount(iter_25_0))
	end
end

function var_0_0.moveTo(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_1 == nil then
		-- block empty
	else
		local var_26_0 = arg_26_0:getUnitByPos(arg_26_1)

		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			if iter_26_1.mo.triggerByClick ~= false and (not iter_26_1.clickComp or iter_26_1.clickComp.enable) then
				arg_26_0:_onClickUnit(iter_26_1.mo)

				return true
			end
		end

		arg_26_0._hero:moveTo(arg_26_1, arg_26_2, arg_26_3)
	end
end

function var_0_0._showClickEffect(arg_27_0, arg_27_1)
	AudioMgr.instance:trigger(AudioEnum.Explore.ClickFloor)
	gohelper.setActive(arg_27_0._clickEffectContainer, false)
	gohelper.setActive(arg_27_0._clickEffectContainer, true)

	local var_27_0 = ExploreHelper.tileToPos(arg_27_1)

	var_27_0.y = arg_27_0:getSceneY(var_27_0)
	arg_27_0._clickEffectContainer.transform.position = var_27_0
end

function var_0_0.startFindPath(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0._route = arg_28_0._route or ExploreAStarFindRoute.New()

	local var_28_0 = ExploreHelper.getKeyXY(arg_28_1.x, arg_28_1.y)
	local var_28_1 = arg_28_0._walkableList[var_28_0].height
	local var_28_2 = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0._walkableList) do
		if iter_28_1:isWalkable(var_28_1) then
			var_28_2[iter_28_0] = iter_28_1.walkableKey
		end
	end

	local var_28_3, var_28_4 = arg_28_0._route:startFindPath(var_28_2, arg_28_1, arg_28_2, arg_28_3)

	if #var_28_3 <= 0 then
		arg_28_2 = var_28_4

		local var_28_5

		var_28_3, var_28_5 = arg_28_0._route:startFindPath(var_28_2, arg_28_1, arg_28_2, arg_28_3)
	end

	local var_28_6 = ExploreHelper.getCornerNum(var_28_3, arg_28_1)

	if var_28_6 > 1 then
		local var_28_7 = arg_28_0._route:startFindPath(var_28_2, arg_28_2, arg_28_1, arg_28_3)
		local var_28_8 = ExploreHelper.getCornerNum(var_28_7, arg_28_2)

		if #var_28_7 > 0 and var_28_8 < var_28_6 then
			var_28_3 = {
				arg_28_2
			}

			for iter_28_2 = #var_28_7, 2, -1 do
				table.insert(var_28_3, var_28_7[iter_28_2])
			end
		end
	end

	return var_28_3
end

function var_0_0._onHeroMoveEnd(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getUnitByPos(arg_29_1)

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		if iter_29_1:isEnable() then
			iter_29_1:onRoleStay()
		end
	end
end

function var_0_0._onCharacterStartMove(arg_30_0, arg_30_1, arg_30_2)
	ExploreMapModel.instance:setNodeLight(arg_30_1)
end

function var_0_0._onUnitNodeChange(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_3 then
		local var_31_0 = arg_31_1.mo

		for iter_31_0 = var_31_0.offsetSize[1], var_31_0.offsetSize[3] do
			for iter_31_1 = var_31_0.offsetSize[2], var_31_0.offsetSize[4] do
				local var_31_1 = ExploreHelper.getKeyXY(arg_31_3.x + iter_31_0, arg_31_3.y + iter_31_1)

				if arg_31_0._unitPosDic[var_31_1] ~= nil then
					tabletool.removeValue(arg_31_0._unitPosDic[var_31_1], arg_31_1)
				end
			end
		end

		if arg_31_2 then
			for iter_31_2 = var_31_0.offsetSize[1], var_31_0.offsetSize[3] do
				for iter_31_3 = var_31_0.offsetSize[2], var_31_0.offsetSize[4] do
					local var_31_2 = ExploreHelper.getKeyXY(arg_31_2.x + iter_31_2, arg_31_2.y + iter_31_3)

					if arg_31_0._unitPosDic[var_31_2] == nil then
						arg_31_0._unitPosDic[var_31_2] = {}
					end

					table.insert(arg_31_0._unitPosDic[var_31_2], arg_31_1)
				end
			end
		end
	end

	local var_31_3 = {}
	local var_31_4 = {}

	if arg_31_2 then
		var_31_4 = arg_31_0:getUnitByPos(arg_31_2)
	end

	if arg_31_3 then
		var_31_3 = arg_31_0:getUnitByPos(arg_31_3)

		for iter_31_4, iter_31_5 in ipairs(var_31_3) do
			if arg_31_1 ~= iter_31_5 and iter_31_5:isEnable() and tabletool.indexOf(var_31_4, iter_31_5) == nil then
				iter_31_5:onRoleLeave(arg_31_2 or arg_31_3, arg_31_3, arg_31_1)
			end
		end
	end

	for iter_31_6, iter_31_7 in ipairs(var_31_4) do
		if arg_31_1 ~= iter_31_7 and iter_31_7:isEnable() and tabletool.indexOf(var_31_3, iter_31_7) == nil then
			iter_31_7:onRoleEnter(arg_31_2, arg_31_3, arg_31_1)
		end
	end

	arg_31_0:checkUnitNear(arg_31_2, arg_31_1)
end

function var_0_0.checkAllRuneTrigger(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0._unitDic) do
		if iter_32_1:getUnitType() == ExploreEnum.ItemType.Rune then
			iter_32_1:checkShowIcon()
		end
	end
end

function var_0_0.checkUnitNear(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0._nearIdList and arg_33_1 and arg_33_2 then
		local var_33_0 = ExploreHelper.getDistance(arg_33_1, arg_33_0._hero.nodePos) == 1
		local var_33_1 = false
		local var_33_2

		for iter_33_0, iter_33_1 in pairs(arg_33_0._nearIdList) do
			if iter_33_1 == arg_33_2.id then
				var_33_1 = true
				var_33_2 = iter_33_0

				break
			end
		end

		if var_33_0 ~= var_33_1 then
			if var_33_1 then
				table.remove(arg_33_0._nearIdList, var_33_2)
				arg_33_2:onRoleFar()
			else
				table.insert(arg_33_0._nearIdList, arg_33_2.id)
				arg_33_2:onRoleNear()
			end
		end
	end
end

function var_0_0._onUnitStatusChange(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_0._initDone then
		return
	end

	local var_34_0 = arg_34_0:getUnit(arg_34_1, true)

	if var_34_0 then
		var_34_0:onStatusChange(arg_34_2)
	end
end

function var_0_0.OnUnitStatus2Change(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if not arg_35_0._initDone then
		return
	end

	local var_35_0 = arg_35_0:getUnit(arg_35_1, true)

	if var_35_0 then
		var_35_0:onStatus2Change(arg_35_2, arg_35_3)
	end
end

function var_0_0._onCharacterNodeChange(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_2 and arg_36_0._hero:getHeroStatus() ~= ExploreAnimEnum.RoleAnimStatus.Glide and arg_36_0:getNowStatus() ~= ExploreEnum.MapStatus.MoveUnit then
		ExploreModel.instance:setStepPause(false)
	end

	local var_36_0 = {}
	local var_36_1 = arg_36_0:getUnitByPos(arg_36_1)

	if arg_36_2 then
		var_36_0 = arg_36_0:getUnitByPos(arg_36_2)

		for iter_36_0, iter_36_1 in ipairs(var_36_0) do
			if iter_36_1:isEnable() and tabletool.indexOf(var_36_1, iter_36_1) == nil then
				iter_36_1:onRoleLeave(arg_36_1, arg_36_2, arg_36_0._hero)
			end
		end
	end

	for iter_36_2, iter_36_3 in ipairs(var_36_1) do
		if iter_36_3:isEnable() and tabletool.indexOf(var_36_0, iter_36_3) == nil then
			iter_36_3:onRoleEnter(arg_36_1, arg_36_2, arg_36_0._hero)
		end
	end

	ExploreMapModel.instance:setNodeLight(arg_36_1)

	if arg_36_2 and arg_36_0._hero:getHeroStatus() ~= ExploreAnimEnum.RoleAnimStatus.Glide and arg_36_0:getNowStatus() ~= ExploreEnum.MapStatus.MoveUnit then
		ExploreRpc.instance:sendExploreMoveRequest(arg_36_1.x, arg_36_1.y)
	end

	local var_36_2 = ExploreMapModel.instance:getNode(ExploreHelper.getKey(arg_36_1))

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChangeCameraCO, var_36_2 and var_36_2.cameraId)

	if var_36_2 then
		local var_36_3 = ExploreMapModel.instance:getMapAreaMO(var_36_2.areaId)

		if var_36_3 then
			ExploreMapModel.instance:setIsShowResetBtn(var_36_3.isCanReset)
		end
	end

	arg_36_0._nearIdList = arg_36_0._nearIdList or {}

	local var_36_4 = {}

	for iter_36_4 = 0, 270, 90 do
		local var_36_5 = ExploreHelper.dirToXY(iter_36_4)
		local var_36_6 = ExploreHelper.getKeyXY(arg_36_1.x + var_36_5.x, arg_36_1.y + var_36_5.y)
		local var_36_7 = arg_36_0._unitPosDic[var_36_6]

		if var_36_7 then
			for iter_36_5, iter_36_6 in pairs(var_36_7) do
				var_36_4[iter_36_6.id] = true
			end
		end
	end

	for iter_36_7 = #arg_36_0._nearIdList, 1, -1 do
		local var_36_8 = arg_36_0._nearIdList[iter_36_7]

		if var_36_4[var_36_8] then
			var_36_4[var_36_8] = nil
		else
			local var_36_9 = arg_36_0:getUnit(var_36_8, true)

			if var_36_9 then
				var_36_9:onRoleFar()
			end

			table.remove(arg_36_0._nearIdList, iter_36_7)
		end
	end

	for iter_36_8 in pairs(var_36_4) do
		table.insert(arg_36_0._nearIdList, iter_36_8)

		local var_36_10 = arg_36_0:getUnit(iter_36_8, true)

		if var_36_10 then
			var_36_10:onRoleNear()
		end
	end
end

function var_0_0._onCharacterPosChange(arg_37_0, arg_37_1)
	arg_37_0:setCameraPos(arg_37_1)
end

function var_0_0._onClickUnit(arg_38_0, arg_38_1)
	arg_38_0._hero:moveToTar(arg_38_1)
end

function var_0_0.setMapStatus(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0._compDict[arg_39_0._nowStatus] then
		if not arg_39_0._compDict[arg_39_0._nowStatus]:canSwitchStatus(arg_39_1) then
			return false
		end

		arg_39_0._compDict[arg_39_0._nowStatus]:onStatusEnd()
	end

	arg_39_0._nowStatus = arg_39_1

	if arg_39_0._compDict[arg_39_0._nowStatus] then
		arg_39_0._compDict[arg_39_0._nowStatus]:onStatusStart(arg_39_2)
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.MapStatusChange, arg_39_1)

	return true
end

function var_0_0._onClickMap(arg_40_0, arg_40_1)
	if arg_40_0._compDict[arg_40_0._nowStatus] then
		return arg_40_0._compDict[arg_40_0._nowStatus]:onMapClick(arg_40_1)
	end

	if not arg_40_0._mapGo or not arg_40_0._mapGo.activeInHierarchy then
		return
	end

	local var_40_0, var_40_1 = arg_40_0:GetTilemapMousePos(arg_40_1)
	local var_40_2 = false

	if var_40_0 and var_40_0:click() then
		-- block empty
	elseif var_40_0 == nil then
		var_40_2 = arg_40_0:moveTo(var_40_1)
	else
		var_40_0, var_40_1 = arg_40_0:GetTilemapMousePos(arg_40_1, true)

		if var_40_1 then
			var_40_2 = arg_40_0:moveTo(var_40_1)
		else
			var_40_0, var_40_1 = arg_40_0:GetTilemapMousePos(arg_40_1)
			var_40_2 = arg_40_0:moveTo(var_40_1)
		end
	end

	local var_40_3 = false

	if var_40_1 then
		local var_40_4 = ExploreHelper.getKey(var_40_1)

		var_40_3 = ExploreMapModel.instance:getNodeCanWalk(var_40_4)
	end

	if ExploreModel.instance:isHeroInControl() and var_40_1 and not var_40_0 and not var_40_2 and var_40_3 then
		arg_40_0:_showClickEffect(var_40_1)
	end
end

function var_0_0.adjustSpineLookRotation(arg_41_0, arg_41_1)
	if arg_41_1 and not gohelper.isNil(arg_41_1.go) then
		arg_41_1:setRotate(arg_41_0._cameraComponent:getRotation())
	end
end

function var_0_0._loadedFinish(arg_42_0, arg_42_1)
	if arg_42_0._episodeCo and arg_42_0._episodeCo.bgmevent > 0 then
		-- block empty
	end

	local var_42_0 = arg_42_0._loader:getAssetItem(arg_42_0._mapPrefabPath):GetResource(arg_42_0._mapPrefabPath)
	local var_42_1 = gohelper.clone(var_42_0, arg_42_0._root)

	arg_42_0._mapGo = var_42_1

	local var_42_2 = gohelper.create3d(var_42_1, "NavMesh")
	local var_42_3 = arg_42_0._loader:getAssetItem(arg_42_0._meshPath)

	if var_42_3 and var_42_3.IsLoadSuccess then
		gohelper.onceAddComponent(var_42_2, typeof(UnityEngine.MeshCollider)).sharedMesh = var_42_3:GetResource()

		gohelper.setLayer(var_42_2, UnityLayer.Scene)
	end

	ExploreConfig.instance:loadExploreConfig(ExploreModel.instance.mapId)
	ExploreMapModel.instance:initMapData(ExploreConfig.instance:getMapConfig(), ExploreModel.instance.mapId)
	var_42_1:SetActive(false)
	arg_42_0:_initMap()

	if arg_42_0._preloadComp == nil then
		ExploreController.instance:dispatchEvent(ExploreEvent.InitMapDone)
	end
end

function var_0_0.getLoader(arg_43_0)
	return arg_43_0._loader
end

function var_0_0.getNowStatus(arg_44_0)
	return arg_44_0._nowStatus
end

function var_0_0.getCompByType(arg_45_0, arg_45_1)
	if not arg_45_0._compDict then
		return
	end

	return arg_45_0._compDict[arg_45_1]
end

function var_0_0.getCatchComp(arg_46_0)
	return arg_46_0._catchComponent
end

function var_0_0._initMap(arg_47_0)
	if not arg_47_0._mapGo then
		return
	end

	arg_47_0._mapGo:SetActive(true)

	arg_47_0._cameraComponent = MonoHelper.addLuaComOnceToGo(arg_47_0._mapGo, ExploreCamera)

	arg_47_0._cameraComponent:setMap(arg_47_0)

	arg_47_0._nowStatus = ExploreEnum.MapStatus.Normal
	arg_47_0._compDict = {}
	arg_47_0._compDict[ExploreEnum.MapStatus.UseItem] = MonoHelper.addLuaComOnceToGo(arg_47_0._mapGo, ExploreMapUseItemComp)
	arg_47_0._compDict[ExploreEnum.MapStatus.MoveUnit] = MonoHelper.addLuaComOnceToGo(arg_47_0._mapGo, ExploreMapUnitMoveComp)
	arg_47_0._compDict[ExploreEnum.MapStatus.RotateUnit] = MonoHelper.addLuaComOnceToGo(arg_47_0._mapGo, ExploreMapUnitRotateComp)

	for iter_47_0, iter_47_1 in pairs(arg_47_0._compDict) do
		iter_47_1:setMap(arg_47_0)
		iter_47_1:setMapStatus(iter_47_0)
	end

	arg_47_0._preloadComp = MonoHelper.addLuaComOnceToGo(arg_47_0._mapGo, ExploreMapScenePreloadComp)

	if arg_47_0._preloadComp.hasInit == false then
		arg_47_0._preloadComp = nil
	end

	arg_47_0._catchComponent = MonoHelper.addLuaComOnceToGo(arg_47_0._mapGo, ExploreMapUnitCatchComp)
	arg_47_0._fovComponent = MonoHelper.addLuaComOnceToGo(arg_47_0._mapGo, ExploreMapFOVComp)
	arg_47_0._unitRoot = gohelper.findChild(arg_47_0._mapGo, "unit")

	arg_47_0:_buildNode()
	arg_47_0:_buildUnit()
	arg_47_0:_initCharacter()
	arg_47_0:_initClickEffect()

	if arg_47_0._preloadComp == nil then
		arg_47_0:showGrid()
	end

	arg_47_0._fovComponent:setMap(arg_47_0)
	arg_47_0._catchComponent:setMap(arg_47_0)
	ExploreCounterModel.instance:reCalcCount()

	for iter_47_2, iter_47_3 in pairs(arg_47_0._unitDic) do
		iter_47_3:onMapInit()
	end

	arg_47_0._initDone = true

	ExploreController.instance:getMapLight():initLight()
	ExploreController.instance:getMapWhirl():init(arg_47_0._mapGo)
	ExploreController.instance:getMapPipe():init()
	arg_47_0._cameraComponent:initHeroPos()
end

function var_0_0.beginCameraAnim(arg_48_0)
	for iter_48_0, iter_48_1 in pairs(arg_48_0._unitDic) do
		iter_48_1:onHeroInitDone()
	end
end

function var_0_0.getUnitRoot(arg_49_0)
	return arg_49_0._unitRoot
end

function var_0_0.getContainRootByAreaId(arg_50_0, arg_50_1)
	if type(arg_50_1) ~= "number" then
		arg_50_1 = 0
	end

	if not arg_50_0._areaRoots then
		arg_50_0._areaRoots = {}
	end

	if not arg_50_0._areaRoots[arg_50_1] then
		arg_50_0._areaRoots[arg_50_1] = {}
		arg_50_0._areaRoots[arg_50_1].go = gohelper.create3d(arg_50_0._mapGo, "area_" .. arg_50_1)
		arg_50_0._areaRoots[arg_50_1].unit = gohelper.create3d(arg_50_0._areaRoots[arg_50_1].go, "unit")
		arg_50_0._areaRoots[arg_50_1].sceneObj = gohelper.create3d(arg_50_0._areaRoots[arg_50_1].go, "sceneObj")
		arg_50_0._areaRoots[arg_50_1].node = gohelper.create3d(arg_50_0._areaRoots[arg_50_1].go, "node")

		local var_50_0 = ExploreMapModel.instance:getMapAreaMO(arg_50_1)

		if var_50_0 and not var_50_0.visible then
			gohelper.setActive(arg_50_0._areaRoots[arg_50_1].go, false)
		end
	end

	return arg_50_0._areaRoots[arg_50_1]
end

function var_0_0._buildNode(arg_51_0)
	arg_51_0._walkableList = {}

	local var_51_0 = ExploreMapModel.instance:getNodeDic()

	for iter_51_0, iter_51_1 in pairs(var_51_0) do
		arg_51_0._walkableList[iter_51_1.walkableKey] = iter_51_1
	end
end

function var_0_0._buildUnit(arg_52_0)
	arg_52_0._unitDic = {}
	arg_52_0._hideUnitDic = {}
	arg_52_0._unitPosDic = {}

	local var_52_0 = ExploreMapModel.instance:getUnitDic()

	for iter_52_0, iter_52_1 in pairs(var_52_0) do
		arg_52_0:enterUnit(iter_52_1)
	end

	local var_52_1 = ExploreModel.instance:getAllInteractInfo()

	if var_52_1 then
		for iter_52_2, iter_52_3 in pairs(var_52_1) do
			if ExploreMapModel.instance:getUnitMO(iter_52_2) == nil then
				ExploreController.instance:updateUnit(iter_52_3)
			end
		end
	end
end

function var_0_0.haveNodeXY(arg_53_0, arg_53_1)
	return arg_53_0._walkableList[arg_53_1] and true or false
end

function var_0_0.enterUnit(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0._unitDic[arg_54_1.id]

	if not arg_54_1:isEnter() then
		arg_54_0._hideUnitDic[arg_54_1.id] = var_54_0

		return
	end

	local var_54_1

	if var_54_0 == nil then
		if arg_54_0._hideUnitDic[arg_54_1.id] then
			var_54_0 = arg_54_0._hideUnitDic[arg_54_1.id]
			arg_54_0._hideUnitDic[arg_54_1.id] = nil
		else
			local var_54_2 = arg_54_1:getUnitClass()
			local var_54_3 = arg_54_1.areaId

			if arg_54_1.type == ExploreEnum.ItemType.SceneAudio then
				var_54_3 = -9999999
			end

			var_54_0 = var_54_2.New(arg_54_0:getContainRootByAreaId(var_54_3).unit)
		end

		var_54_1 = true or var_54_1
	end

	arg_54_0._unitDic[arg_54_1.id] = var_54_0

	local var_54_4 = var_54_0.nodePos

	var_54_0:setData(arg_54_1)

	if var_54_1 or not var_54_4 then
		for iter_54_0 = arg_54_1.offsetSize[1], arg_54_1.offsetSize[3] do
			for iter_54_1 = arg_54_1.offsetSize[2], arg_54_1.offsetSize[4] do
				local var_54_5 = ExploreHelper.getKeyXY(arg_54_1.nodePos.x + iter_54_0, arg_54_1.nodePos.y + iter_54_1)

				if arg_54_0._unitPosDic[var_54_5] == nil then
					arg_54_0._unitPosDic[var_54_5] = {}
				end

				if not tabletool.indexOf(arg_54_0._unitPosDic[var_54_5], var_54_0) then
					table.insert(arg_54_0._unitPosDic[var_54_5], var_54_0)
				end
			end
		end

		if arg_54_0._initDone then
			var_54_0:setInFOV(true)
			var_54_0:checkLight()
		end
	end
end

function var_0_0.removeUnit(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0._unitDic[arg_55_1]

	if var_55_0 then
		local var_55_1 = var_55_0.mo

		arg_55_0._hideUnitDic[var_55_1.id] = var_55_0
		arg_55_0._unitDic[var_55_1.id] = nil

		for iter_55_0 = var_55_1.offsetSize[1], var_55_1.offsetSize[3] do
			for iter_55_1 = var_55_1.offsetSize[2], var_55_1.offsetSize[4] do
				local var_55_2 = ExploreHelper.getKeyXY(var_55_1.nodePos.x + iter_55_0, var_55_1.nodePos.y + iter_55_1)

				if arg_55_0._unitPosDic[var_55_2] ~= nil then
					for iter_55_2, iter_55_3 in pairs(arg_55_0._unitPosDic[var_55_2]) do
						if iter_55_3 ~= var_55_0 then
							iter_55_3:onRoleLeave(var_55_0.nodePos, var_55_0.nodePos, var_55_0)
						end
					end

					tabletool.removeValue(arg_55_0._unitPosDic[var_55_2], var_55_0)
				end
			end
		end

		var_55_0:setExit()
	end
end

function var_0_0._initCharacter(arg_56_0)
	local var_56_0 = gohelper.findChild(arg_56_0._mapGo, "role")

	arg_56_0._hero = ExploreHero.New(var_56_0)

	arg_56_0._hero:setMap(arg_56_0)
	arg_56_0._hero:onUpdateExploreInfo()
	arg_56_0._hero:setResPath("explore/roles/prefabs/hero.prefab")
end

function var_0_0._initClickEffect(arg_57_0)
	arg_57_0._clickEffectContainer = UnityEngine.GameObject.New("ClickEffect")

	gohelper.addChild(arg_57_0._mapGo, arg_57_0._clickEffectContainer)

	arg_57_0._clickEffectLoader = PrefabInstantiate.Create(arg_57_0._clickEffectContainer)

	arg_57_0._clickEffectLoader:startLoad(ResUrl.getExploreEffectPath(ExploreConstValue.ClickEffect), function()
		arg_57_0._effectGo = arg_57_0._clickEffectLoader:getInstGO()

		gohelper.addChild(arg_57_0._clickEffectContainer, arg_57_0._effectGo)
		gohelper.setActive(arg_57_0._clickEffectContainer, false)

		arg_57_0._effectOrderContainer = gohelper.findChildComponent(arg_57_0._effectGo, "root", typeof(ZProj.EffectOrderContainer))
	end)
end

function var_0_0.destroy(arg_59_0)
	for iter_59_0, iter_59_1 in pairs(arg_59_0._unitDic) do
		iter_59_1:destroy()
	end

	for iter_59_2, iter_59_3 in pairs(arg_59_0._hideUnitDic) do
		iter_59_3:destroy()
	end

	if arg_59_0._hero then
		arg_59_0._hero:destroy()

		arg_59_0._hero = nil
	end

	if arg_59_0._clickEffectLoader then
		arg_59_0._clickEffectLoader:dispose()

		arg_59_0._clickEffectLoader = nil
	end

	gohelper.destroy(arg_59_0._clickEffectContainer)

	arg_59_0._clickEffectContainer = nil
	arg_59_0._unitDic = nil
	arg_59_0._hideUnitDic = nil
	arg_59_0._nowStatus = ExploreEnum.MapStatus.Normal
	arg_59_0._compDict = nil

	ExploreModel.instance:setHeroControl(true)
	ExploreMapTriggerController.instance:unRegisterMap(arg_59_0)
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

return var_0_0
