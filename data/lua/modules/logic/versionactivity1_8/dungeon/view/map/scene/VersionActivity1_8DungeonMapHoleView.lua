module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapHoleView", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapHoleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_2_0.loadSceneFinish, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, arg_2_0.onMapPosChanged, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnAddOneElement, arg_2_0.onAddOneElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRemoveElement, arg_2_0.onRemoveElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRecycleAllElement, arg_2_0.onRecycleAllElement, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, arg_2_0.refreshHoles, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_3_0.loadSceneFinish, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, arg_3_0.onMapPosChanged, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnAddOneElement, arg_3_0.onAddOneElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRemoveElement, arg_3_0.onRemoveElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnRecycleAllElement, arg_3_0.onRecycleAllElement, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, arg_3_0.refreshHoles, arg_3_0)
end

function var_0_0._onScreenResize(arg_4_0)
	arg_4_0:initCameraParam()
end

function var_0_0.loadSceneFinish(arg_5_0, arg_5_1)
	if gohelper.isNil(arg_5_1.mapSceneGo) then
		return
	end

	arg_5_0.loadSceneDone = true
	arg_5_0.sceneGo = arg_5_1.mapSceneGo
	arg_5_0.sceneTrans = arg_5_0.sceneGo.transform

	local var_5_0 = gohelper.findChild(arg_5_0.sceneGo, "Obj-Plant/FogOfWar/mask")

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
	local var_6_4 = VersionActivity1_8DungeonEnum.DungeonMapCameraSize / var_6_3
	local var_6_5 = var_6_2[1] * var_6_1 * var_6_4
	local var_6_6 = var_6_2[3] * var_6_1 * var_6_4
	local var_6_7 = math.abs(var_6_6.x - var_6_5.x) / 2
	local var_6_8 = math.abs(var_6_6.y - var_6_5.y) / 2

	arg_6_0.validMinDistanceX = var_6_7 + VersionActivity1_8DungeonEnum.HoleHalfWidth
	arg_6_0.validMinDistanceY = var_6_8 + VersionActivity1_8DungeonEnum.HoleHalfHeight
end

function var_0_0.onMapPosChanged(arg_7_0)
	arg_7_0.sceneWorldPosX, arg_7_0.sceneWorldPosY = transformhelper.getPos(arg_7_0.sceneTrans)

	tabletool.clear(arg_7_0.validElementIdList)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.beVerifyElementIdList) do
		if arg_7_0:isElementValid(iter_7_1) then
			table.insert(arg_7_0.validElementIdList, iter_7_1)
		end
	end

	arg_7_0:refreshHoles()
end

function var_0_0.onAddOneElement(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getElementId()
	local var_8_1 = Activity157Model.instance:getActId()
	local var_8_2 = Activity157Config.instance:getMissionIdByElementId(var_8_1, var_8_0)

	arg_8_0:addElementHole(var_8_2, var_8_0)
end

function var_0_0.addElementHole(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = false

	if arg_9_1 then
		local var_9_1 = Activity157Model.instance:getActId()
		local var_9_2 = Activity157Config.instance:getMissionGroup(var_9_1, arg_9_1)

		var_9_0 = Activity157Model.instance:isFinishMission(var_9_2, arg_9_1)
	else
		var_9_0 = DungeonMapModel.instance:elementIsFinished(arg_9_2)
	end

	if var_9_0 then
		return
	end

	table.insert(arg_9_0.beVerifyElementIdList, arg_9_2)

	if arg_9_0:isElementValid(arg_9_2) then
		table.insert(arg_9_0.validElementIdList, arg_9_2)
	end

	arg_9_0:refreshHoles()
end

function var_0_0.onRemoveElement(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_1:getElementId()

	arg_10_0:removeElementHole(var_10_0)
end

function var_0_0.removeElementHole(arg_11_0, arg_11_1)
	tabletool.removeValue(arg_11_0.beVerifyElementIdList, arg_11_1)

	local var_11_0 = tabletool.indexOf(arg_11_0.validElementIdList, arg_11_1)

	if var_11_0 then
		table.remove(arg_11_0.validElementIdList, var_11_0)
		arg_11_0:playHoleCloseAnimByElementId(arg_11_1)
	end
end

function var_0_0.onRecycleAllElement(arg_12_0)
	tabletool.clear(arg_12_0.beVerifyElementIdList)
	tabletool.clear(arg_12_0.validElementIdList)
	arg_12_0:refreshHoles()
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0.loadSceneDone = false
	arg_13_0.tempVector = Vector3.zero
	arg_13_0.tempVector4 = Vector4.zero
	arg_13_0.beVerifyElementIdList = {}
	arg_13_0.validElementIdList = {}
	arg_13_0.elementPosDict = {}
	arg_13_0.shaderParamList = arg_13_0:getUserDataTb_()

	for iter_13_0 = 1, VersionActivity1_8DungeonEnum.MaxHoleNum do
		table.insert(arg_13_0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. iter_13_0))
	end
end

function var_0_0.isElementValid(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.elementPosDict[arg_14_1]

	if not var_14_0 then
		local var_14_1 = lua_chapter_map_element.configDict[arg_14_1]

		var_14_0 = string.splitToNumber(var_14_1.pos, "#")
		arg_14_0.elementPosDict[arg_14_1] = var_14_0
	end

	return (arg_14_0:checkPosIsValid(var_14_0[1], var_14_0[2]))
end

function var_0_0.checkPosIsValid(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1 + arg_15_0.sceneWorldPosX
	local var_15_1 = arg_15_2 + arg_15_0.sceneWorldPosY
	local var_15_2 = math.sqrt((arg_15_0.mainCameraPosX - var_15_0)^2)
	local var_15_3 = math.sqrt((arg_15_0.mainCameraPosY - var_15_1)^2)

	if var_15_2 <= arg_15_0.validMinDistanceX and var_15_3 <= arg_15_0.validMinDistanceY then
		return true
	end

	return false
end

function var_0_0.refreshHoles(arg_16_0)
	if not arg_16_0.loadSceneDone or gohelper.isNil(arg_16_0.shader) then
		return
	end

	for iter_16_0 = 1, VersionActivity1_8DungeonEnum.MaxHoleNum do
		local var_16_0 = arg_16_0.validElementIdList[iter_16_0]
		local var_16_1 = false
		local var_16_2 = Activity157Model.instance:getActId()
		local var_16_3 = Activity157Config.instance:getMissionIdByElementId(var_16_2, var_16_0)

		if var_16_3 then
			var_16_1 = Activity157Config.instance:isSideMission(var_16_2, var_16_3)
		end

		local var_16_4 = false

		if var_16_1 then
			var_16_4 = Activity157Model.instance:isInProgressOtherMissionGroupByElementId(var_16_0)
		end

		if var_16_0 and not var_16_4 then
			local var_16_5 = arg_16_0.elementPosDict[var_16_0]

			arg_16_0.tempVector4:Set(var_16_5[1] + arg_16_0.sceneWorldPosX, var_16_5[2] + arg_16_0.sceneWorldPosY)
		else
			arg_16_0.tempVector4:Set(VersionActivity1_8DungeonEnum.OutSideAreaPos.X, VersionActivity1_8DungeonEnum.OutSideAreaPos.Y)
		end

		arg_16_0.shader:SetVector(arg_16_0.shaderParamList[iter_16_0], arg_16_0.tempVector4)
	end
end

function var_0_0.playHoleCloseAnimByElementId(arg_17_0, arg_17_1)
	local var_17_0 = tabletool.indexOf(arg_17_0.validElementIdList, arg_17_1)

	if not var_17_0 or var_17_0 > VersionActivity1_8DungeonEnum.MaxHoleNum then
		arg_17_0:refreshHoles()

		return
	end

	arg_17_0:playHoleCloseAnim(var_17_0)
end

function var_0_0.playHoleCloseAnim(arg_18_0, arg_18_1)
	arg_18_0.param = arg_18_0.shaderParamList[arg_18_1]

	if not arg_18_0.param then
		arg_18_0:refreshHoles()

		return
	end

	UIBlockMgr.instance:startBlock("playHoleAnim")

	arg_18_0.startVector4 = arg_18_0.shader:GetVector(arg_18_0.param)
	arg_18_0.tweenId = ZProj.TweenHelper.DOTweenFloat(VersionActivity1_8DungeonEnum.HoleAnimMinZ, VersionActivity1_8DungeonEnum.HoleAnimMaxZ, VersionActivity1_8DungeonEnum.HoleAnimDuration, arg_18_0.frameCallback, arg_18_0.doneCallback, arg_18_0)
end

function var_0_0.frameCallback(arg_19_0, arg_19_1)
	arg_19_0.tempVector4:Set(arg_19_0.startVector4.x, arg_19_0.startVector4.y, arg_19_1)
	arg_19_0.shader:SetVector(arg_19_0.param, arg_19_0.tempVector4)
end

function var_0_0.doneCallback(arg_20_0)
	arg_20_0.tempVector4:Set(arg_20_0.startVector4.x, arg_20_0.startVector4.y, VersionActivity1_8DungeonEnum.HoleAnimMaxZ)
	arg_20_0.shader:SetVector(arg_20_0.param, arg_20_0.tempVector4)
	arg_20_0:refreshHoles()
	UIBlockMgr.instance:endBlock("playHoleAnim")
end

function var_0_0.onClose(arg_21_0)
	return
end

return var_0_0
