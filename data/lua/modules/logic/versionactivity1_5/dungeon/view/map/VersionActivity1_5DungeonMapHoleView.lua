module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapHoleView", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapHoleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godispatcharea = gohelper.findChild(arg_1_0.viewGO, "#go_dispatcharea")
	arg_1_0._goareaitem = gohelper.findChild(arg_1_0.viewGO, "#go_dispatcharea/#go_areaitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._godispatcharea, true)
	gohelper.setActive(arg_4_0._goareaitem, false)

	arg_4_0.loadSceneDone = false
	arg_4_0.transform = arg_4_0._godispatcharea:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.tempVector = Vector3.zero
	arg_4_0.tempVector4 = Vector4.zero
	arg_4_0.areaItemDict = {}
	arg_4_0.areaItemPool = {}
	arg_4_0.exploreElementIdList = {}
	arg_4_0.subHeroElementIdList = {}
	arg_4_0.validElementIdList = {}
	arg_4_0.validExploreIdList = {}
	arg_4_0.elementPosDict = {}
	arg_4_0.shaderParamList = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		table.insert(arg_4_0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. iter_4_0))
	end

	arg_4_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_4_0.loadSceneFinish, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, arg_4_0.onMapPosChanged, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnAddOneElement, arg_4_0.onAddOneElement, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRemoveElement, arg_4_0.onRemoveElement, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRecycleAllElement, arg_4_0.onRecycleAllElement, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, arg_4_0.hideAreaUI, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, arg_4_0.showAreaUI, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.TweenMapPosDone, arg_4_0.tweenMapPosDone, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, arg_4_0.onDispatchFinish, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.FocusElement, arg_4_0.onFocusElement, arg_4_0)
end

function var_0_0.loadSceneFinish(arg_5_0, arg_5_1)
	if gohelper.isNil(arg_5_1.mapSceneGo) then
		return
	end

	arg_5_0.loadSceneDone = true
	arg_5_0.sceneGo = arg_5_1.mapSceneGo
	arg_5_0.sceneTrans = arg_5_0.sceneGo.transform

	local var_5_0 = gohelper.findChild(arg_5_0.sceneGo, "Obj-Plant/FogOfWar/m_s14_hddt_mask")

	if not var_5_0 then
		logError("not found shader mask go, " .. arg_5_0.sceneGo.name)

		return
	end

	arg_5_0.shader = var_5_0:GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial

	arg_5_0:initCameraParam()
	arg_5_0:refreshHoles()
end

function var_0_0.initCameraParam(arg_6_0)
	local var_6_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	local var_6_1 = GameUtil.getAdapterScale()
	local var_6_2 = var_6_0.transform:GetWorldCorners()

	arg_6_0.mainCamera = CameraMgr.instance:getMainCamera()
	arg_6_0.mainCameraPosX, arg_6_0.mainCameraPosY = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())

	local var_6_3 = arg_6_0.mainCamera.orthographicSize
	local var_6_4 = VersionActivity1_5DungeonEnum.DungeonMapCameraSize / var_6_3
	local var_6_5 = var_6_2[1] * var_6_1 * var_6_4
	local var_6_6 = var_6_2[3] * var_6_1 * var_6_4
	local var_6_7 = math.abs(var_6_6.x - var_6_5.x) / 2
	local var_6_8 = math.abs(var_6_6.y - var_6_5.y) / 2

	arg_6_0.validMinDistanceX = var_6_7 + VersionActivity1_5DungeonEnum.HoleHalfWidth
	arg_6_0.validMinDistanceY = var_6_8 + VersionActivity1_5DungeonEnum.HoleHalfHeight
end

function var_0_0.onMapPosChanged(arg_7_0)
	arg_7_0.sceneWorldPosX, arg_7_0.sceneWorldPosY = transformhelper.getPos(arg_7_0.sceneTrans)

	tabletool.clear(arg_7_0.validElementIdList)
	tabletool.clear(arg_7_0.validExploreIdList)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.exploreElementIdList) do
		arg_7_0:refreshAreaItem(iter_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.subHeroElementIdList) do
		if arg_7_0:subHeroTaskElementIsValid(iter_7_3) then
			table.insert(arg_7_0.validElementIdList, iter_7_3)
		end
	end

	arg_7_0:refreshHoles()
end

function var_0_0.onAddOneElement(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getElementId()
	local var_8_1 = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(var_8_0)

	if var_8_1 then
		arg_8_0:addExploreHole(var_8_1, var_8_0)

		return
	end

	local var_8_2 = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(var_8_0)

	if var_8_2 then
		arg_8_0:addSubHeroTaskHole(var_8_2, var_8_0)

		return
	end
end

function var_0_0.addExploreHole(arg_9_0, arg_9_1, arg_9_2)
	if VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(arg_9_1) == VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward then
		return
	end

	table.insert(arg_9_0.exploreElementIdList, arg_9_2)
	arg_9_0:refreshAreaItem(arg_9_2)
	arg_9_0:refreshHoles()
end

function var_0_0.addSubHeroTaskHole(arg_10_0, arg_10_1, arg_10_2)
	if VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(arg_10_1) == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.GainedReward then
		return
	end

	table.insert(arg_10_0.subHeroElementIdList, arg_10_2)

	if arg_10_0:subHeroTaskElementIsValid(arg_10_2) then
		table.insert(arg_10_0.validElementIdList, arg_10_2)
	end

	arg_10_0:refreshHoles()
end

function var_0_0.onRemoveElement(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getElementId()
	local var_11_1 = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(var_11_0)

	if var_11_1 then
		arg_11_0:removeExploreElement(var_11_1, var_11_0)

		return
	end

	local var_11_2 = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(var_11_0)

	if var_11_2 then
		arg_11_0:removeSubHeroTaskElement(var_11_2, var_11_0)

		return
	end
end

function var_0_0.removeExploreElement(arg_12_0, arg_12_1, arg_12_2)
	tabletool.removeValue(arg_12_0.exploreElementIdList, arg_12_2)
	table.remove(arg_12_0.validExploreIdList, arg_12_1.id)

	local var_12_0 = tabletool.indexOf(arg_12_0.validElementIdList, arg_12_2)

	if var_12_0 then
		table.remove(arg_12_0.validElementIdList, var_12_0)
		arg_12_0:playHoleCloseAnimByElementId(arg_12_2)
		arg_12_0:playAreaItemCloseAnim(arg_12_1.id)
	else
		arg_12_0:recycleAreaItemById(arg_12_1.id)
	end
end

function var_0_0.removeSubHeroTaskElement(arg_13_0, arg_13_1, arg_13_2)
	tabletool.removeValue(arg_13_0.subHeroElementIdList, arg_13_2)

	local var_13_0 = tabletool.indexOf(arg_13_0.validElementIdList, arg_13_2)

	if var_13_0 then
		table.remove(arg_13_0.validElementIdList, var_13_0)
		arg_13_0:playHoleCloseAnimByElementId(arg_13_2)
	end
end

function var_0_0.onRecycleAllElement(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.areaItemDict) do
		arg_14_0:recycleAreaItem(iter_14_1)
	end

	tabletool.clear(arg_14_0.exploreElementIdList)
	tabletool.clear(arg_14_0.subHeroElementIdList)
	tabletool.clear(arg_14_0.areaItemDict)
	tabletool.clear(arg_14_0.validElementIdList)
	tabletool.clear(arg_14_0.validExploreIdList)
	arg_14_0:refreshHoles()
end

function var_0_0.refreshAreaItem(arg_15_0, arg_15_1)
	local var_15_0 = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(arg_15_1)
	local var_15_1 = arg_15_0.areaItemDict[var_15_0.id]

	if not var_15_1 then
		var_15_1 = arg_15_0:createAreaItem(var_15_0)
		arg_15_0.areaItemDict[var_15_0.id] = var_15_1
	end

	if not arg_15_0:checkPosIsValid(var_15_0.areaPosX, var_15_0.areaPosY) then
		gohelper.setActive(var_15_1.go, false)

		return
	end

	table.insert(arg_15_0.validExploreIdList, var_15_0.id)
	table.insert(arg_15_0.validElementIdList, arg_15_1)

	if not arg_15_0.elementPosDict[arg_15_1] then
		arg_15_0.elementPosDict[arg_15_1] = {
			var_15_0.areaPosX,
			var_15_0.areaPosY
		}
	end

	gohelper.setActive(var_15_1.go, true)
	gohelper.setActive(var_15_1.goFight, var_15_0.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight)
	gohelper.setActive(var_15_1.goDispatch, var_15_0.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch)
	arg_15_0:refreshExplorePoint(var_15_1, var_15_0)
	arg_15_0.tempVector:Set(var_15_0.areaPosX + arg_15_0.sceneWorldPosX, var_15_0.areaPosY + arg_15_0.sceneWorldPosY)

	local var_15_2 = recthelper.worldPosToAnchorPos(arg_15_0.tempVector, arg_15_0.transform)

	recthelper.setAnchor(var_15_1.rectTr, var_15_2.x, var_15_2.y + VersionActivity1_5DungeonEnum.AreaItemOffsetY)
end

function var_0_0.refreshExplorePoint(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch

	gohelper.setActive(arg_16_1.goPoint, var_16_0)

	if var_16_0 then
		local var_16_1 = arg_16_2.elementList
		local var_16_2 = #var_16_1
		local var_16_3 = var_16_1[1]
		local var_16_4 = arg_16_0:getPointItem(arg_16_1, 1)
		local var_16_5 = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(var_16_3)

		if not var_16_5 then
			gohelper.setActive(var_16_4.goRunning, false)
			gohelper.setActive(var_16_4.goFinish, false)
		elseif var_16_5:isRunning() then
			gohelper.setActive(var_16_4.goRunning, true)
			gohelper.setActive(var_16_4.goFinish, false)
		elseif var_16_5:isFinish() then
			gohelper.setActive(var_16_4.goRunning, false)
			gohelper.setActive(var_16_4.goFinish, true)
		end

		for iter_16_0 = 2, var_16_2 do
			local var_16_6 = var_16_1[iter_16_0]
			local var_16_7 = arg_16_0:getPointItem(arg_16_1, iter_16_0)

			if DungeonMapModel.instance:elementIsFinished(var_16_6) then
				gohelper.setActive(var_16_7.goRunning, false)
				gohelper.setActive(var_16_7.goFinish, true)
			else
				gohelper.setActive(var_16_7.goRunning, false)
				gohelper.setActive(var_16_7.goFinish, false)
			end
		end

		for iter_16_1 = var_16_2 + 1, #arg_16_1.pointList do
			gohelper.setActive(arg_16_1.pointList[iter_16_1].go, false)
		end
	end
end

function var_0_0.subHeroTaskElementIsValid(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.elementPosDict[arg_17_1]

	if not var_17_0 then
		local var_17_1 = lua_chapter_map_element.configDict[arg_17_1]

		var_17_0 = string.splitToNumber(var_17_1.pos, "#")
		arg_17_0.elementPosDict[arg_17_1] = var_17_0
	end

	return arg_17_0:checkPosIsValid(var_17_0[1], var_17_0[2])
end

function var_0_0.checkPosIsValid(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1 + arg_18_0.sceneWorldPosX
	local var_18_1 = arg_18_2 + arg_18_0.sceneWorldPosY
	local var_18_2 = math.sqrt((arg_18_0.mainCameraPosX - var_18_0)^2)
	local var_18_3 = math.sqrt((arg_18_0.mainCameraPosY - var_18_1)^2)

	if var_18_2 <= arg_18_0.validMinDistanceX and var_18_3 <= arg_18_0.validMinDistanceY then
		return true
	end

	return false
end

function var_0_0.checkViewPortPosIsValid(arg_19_0, arg_19_1)
	if arg_19_1.x < 0 or arg_19_1.x > 1 or arg_19_1.y < 0 or arg_19_1.y > 1 then
		return false
	end

	return true
end

function var_0_0.refreshHoles(arg_20_0)
	if not arg_20_0.loadSceneDone then
		return
	end

	if gohelper.isNil(arg_20_0.shader) then
		return
	end

	for iter_20_0 = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		local var_20_0 = arg_20_0.validElementIdList[iter_20_0]

		if var_20_0 then
			local var_20_1 = arg_20_0.elementPosDict[var_20_0]

			arg_20_0.tempVector4:Set(var_20_1[1] + arg_20_0.sceneWorldPosX, var_20_1[2] + arg_20_0.sceneWorldPosY)
		else
			arg_20_0.tempVector4:Set(VersionActivity1_5DungeonEnum.OutSideAreaPos.X, VersionActivity1_5DungeonEnum.OutSideAreaPos.Y)
		end

		arg_20_0.shader:SetVector(arg_20_0.shaderParamList[iter_20_0], arg_20_0.tempVector4)
	end

	if SLFramework.FrameworkSettings.IsEditor and #arg_20_0.validElementIdList > VersionActivity1_5DungeonEnum.MaxHoleNum then
		logError("同时挖洞个数大于5个了，多余直接丢弃, " .. table.concat(arg_20_0.validElementIdList, ";"))
	end
end

function var_0_0.createAreaItem(arg_21_0)
	if #arg_21_0.areaItemPool > 0 then
		return table.remove(arg_21_0.areaItemPool)
	end

	local var_21_0 = arg_21_0:getUserDataTb_()

	var_21_0.go = gohelper.cloneInPlace(arg_21_0._goareaitem)
	var_21_0.rectTr = var_21_0.go:GetComponent(gohelper.Type_RectTransform)
	var_21_0.goFight = gohelper.findChild(var_21_0.go, "#go_tip/fight")
	var_21_0.goDispatch = gohelper.findChild(var_21_0.go, "#go_tip/dispatch")
	var_21_0.goPoint = gohelper.findChild(var_21_0.go, "#go_tip/progresspoint")
	var_21_0.goPointItem = gohelper.findChild(var_21_0.go, "#go_tip/progresspoint/staritem")
	var_21_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(var_21_0.go)

	gohelper.setActive(var_21_0.goPointItem, false)

	var_21_0.pointList = {}

	return var_21_0
end

function var_0_0.getPointItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1.pointList[arg_22_2]

	if var_22_0 then
		gohelper.setActive(var_22_0.go, true)

		return var_22_0
	end

	local var_22_1 = arg_22_0:getUserDataTb_()

	var_22_1.go = gohelper.cloneInPlace(arg_22_1.goPointItem, arg_22_2)
	var_22_1.goRunning = gohelper.findChild(var_22_1.go, "running")
	var_22_1.goFinish = gohelper.findChild(var_22_1.go, "finish")
	arg_22_1.pointList[arg_22_2] = var_22_1

	gohelper.setActive(var_22_1.go, true)

	return var_22_1
end

function var_0_0.recycleAreaItem(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_1.go, false)
	table.insert(arg_23_0.areaItemPool, arg_23_1)
end

function var_0_0.recycleAreaItemById(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.areaItemDict[arg_24_1]

	if var_24_0 then
		arg_24_0:recycleAreaItem(var_24_0)

		arg_24_0.areaItemDict[arg_24_1] = nil
	end
end

function var_0_0._onScreenResize(arg_25_0)
	arg_25_0:initCameraParam()
end

function var_0_0.hideAreaUI(arg_26_0)
	arg_26_0.needHideArea = true
end

function var_0_0.showAreaUI(arg_27_0)
	arg_27_0.needHideArea = false

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.validExploreIdList) do
		local var_27_0 = arg_27_0.areaItemDict[iter_27_1]

		gohelper.setActive(var_27_0.go, true)
	end
end

function var_0_0.checkNeedPlayShowAnimAudio(arg_28_0)
	if arg_28_0.needPlayShowAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

		arg_28_0.needPlayShowAudio = false
	end
end

function var_0_0.tweenMapPosDone(arg_29_0)
	if not arg_29_0.needHideArea then
		arg_29_0:checkNeedPlayShowAnimAudio()

		return
	end

	arg_29_0.hideItemCount = 0

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.validExploreIdList) do
		arg_29_0.areaItemDict[iter_29_1].animatorPlayer:Play("hide", arg_29_0.onHideAnimDone, arg_29_0)

		arg_29_0.hideItemCount = arg_29_0.hideItemCount + 1
	end
end

function var_0_0.onHideAnimDone(arg_30_0)
	arg_30_0.hideItemCount = arg_30_0.hideItemCount - 1

	if arg_30_0.hideItemCount == 0 then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0.validExploreIdList) do
			local var_30_0 = arg_30_0.areaItemDict[iter_30_1]

			gohelper.setActive(var_30_0.go, false)
		end
	end
end

function var_0_0.playHoleCloseAnimByElementId(arg_31_0, arg_31_1)
	local var_31_0 = tabletool.indexOf(arg_31_0.validElementIdList, arg_31_1)

	if not var_31_0 then
		arg_31_0:refreshHoles()

		return
	end

	if var_31_0 > VersionActivity1_5DungeonEnum.MaxHoleNum then
		arg_31_0:refreshHoles()

		return
	end

	arg_31_0:playHoleCloseAnim(var_31_0)
end

function var_0_0.playHoleCloseAnim(arg_32_0, arg_32_1)
	arg_32_0.param = arg_32_0.shaderParamList[arg_32_1]

	if not arg_32_0.param then
		arg_32_0:refreshHoles()

		return
	end

	UIBlockMgr.instance:startBlock("playHoleAnim")

	arg_32_0.startVector4 = arg_32_0.shader:GetVector(arg_32_0.param)
	arg_32_0.tweenId = ZProj.TweenHelper.DOTweenFloat(VersionActivity1_5DungeonEnum.HoleAnimMinZ, VersionActivity1_5DungeonEnum.HoleAnimMaxZ, VersionActivity1_5DungeonEnum.HoleAnimDuration, arg_32_0.frameCallback, arg_32_0.doneCallback, arg_32_0)
end

function var_0_0.frameCallback(arg_33_0, arg_33_1)
	arg_33_0.tempVector4:Set(arg_33_0.startVector4.x, arg_33_0.startVector4.y, arg_33_1)
	arg_33_0.shader:SetVector(arg_33_0.param, arg_33_0.tempVector4)
end

function var_0_0.doneCallback(arg_34_0)
	arg_34_0.tempVector4:Set(arg_34_0.startVector4.x, arg_34_0.startVector4.y, VersionActivity1_5DungeonEnum.HoleAnimMaxZ)
	arg_34_0.shader:SetVector(arg_34_0.param, arg_34_0.tempVector4)
	arg_34_0:refreshHoles()
	UIBlockMgr.instance:endBlock("playHoleAnim")
end

function var_0_0.playAreaItemCloseAnim(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.areaItemDict[arg_35_1]

	if var_35_0 then
		UIBlockMgr.instance:startBlock("playAreaAnim")

		arg_35_0.playingExploreId = arg_35_1

		var_35_0.animatorPlayer:Play("close", arg_35_0.onCloseAnimDone, arg_35_0)
	end
end

function var_0_0.onCloseAnimDone(arg_36_0)
	arg_36_0:recycleAreaItemById(arg_36_0.playingExploreId)

	arg_36_0.playingExploreId = nil

	arg_36_0:onMapPosChanged()
	UIBlockMgr.instance:endBlock("playAreaAnim")
end

function var_0_0.onDispatchFinish(arg_37_0)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0.validExploreIdList) do
		local var_37_0 = VersionActivity1_5DungeonConfig.instance:getExploreTask(iter_37_1)
		local var_37_1 = arg_37_0.areaItemDict[iter_37_1]

		arg_37_0:refreshExplorePoint(var_37_1, var_37_0)
	end
end

function var_0_0.onFocusElement(arg_38_0, arg_38_1)
	if tabletool.indexOf(arg_38_0.validElementIdList, arg_38_1) then
		arg_38_0.needPlayShowAudio = false

		return
	end

	arg_38_0.needPlayShowAudio = VersionActivity1_5DungeonConfig.instance:getExploreTaskByElementId(arg_38_1) ~= nil
end

function var_0_0.onClose(arg_39_0)
	return
end

return var_0_0
