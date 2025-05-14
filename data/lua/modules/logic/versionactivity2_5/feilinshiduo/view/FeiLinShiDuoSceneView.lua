module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoSceneView", package.seeall)

local var_0_0 = class("FeiLinShiDuoSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscene = gohelper.findChild(arg_1_0.viewGO, "bg/#go_scene")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_2_0.refreshSceneBorder, arg_2_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, arg_2_0.resetData, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_3_0.refreshSceneBorder, arg_3_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, arg_3_0.resetData, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.elementGOMap = arg_4_0:getUserDataTb_()
	arg_4_0.boxCompMap = arg_4_0:getUserDataTb_()
	arg_4_0.boxCompList = arg_4_0:getUserDataTb_()
	arg_4_0.optionCompMap = arg_4_0:getUserDataTb_()
	arg_4_0.jumpAnimMap = arg_4_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:initMapConfig()
	arg_5_0:initScene()
	arg_5_0:initMapElement()
	TaskDispatcher.runRepeat(arg_5_0.onTick, arg_5_0, 0)
end

function var_0_0.initMapConfig(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.mapId or FeiLinShiDuoEnum.TestMapId
	local var_6_1 = arg_6_0.viewParam.gameConfig

	FeiLinShiDuoGameModel.instance:setGameConfig(var_6_1)
	FeiLinShiDuoGameModel.instance:initConfigData(var_6_0)
end

function var_0_0.initScene(arg_7_0)
	arg_7_0.mapConfigData = FeiLinShiDuoGameModel.instance:getMapConfigData()
	arg_7_0.sceneGO = arg_7_0:getResInst(arg_7_0.viewContainer:getSetting().otherRes[1], arg_7_0._goscene)

	local var_7_0 = gohelper.findChild(arg_7_0.sceneGO, "Player")

	arg_7_0.playerGO = gohelper.create2d(var_7_0, "PlayerGO")

	transformhelper.setLocalScale(arg_7_0.playerGO.transform, FeiLinShiDuoEnum.PlayerScale, FeiLinShiDuoEnum.PlayerScale, FeiLinShiDuoEnum.PlayerScale)

	arg_7_0.playerGOComp = MonoHelper.addLuaComOnceToGo(arg_7_0.playerGO, FeiLinShiDuoPlayerComp)
	arg_7_0.playerAnimComp = MonoHelper.addLuaComOnceToGo(arg_7_0.playerGO, FeiLinShiDuoPlayerAnimComp)

	arg_7_0.playerGOComp:setScene(arg_7_0.sceneGO, arg_7_0)

	arg_7_0.sceneScale = arg_7_0.mapConfigData.gameConfig.sceneScale or FeiLinShiDuoEnum.SceneDefaultScale

	transformhelper.setLocalScale(arg_7_0._goscene.transform, arg_7_0.sceneScale, arg_7_0.sceneScale, arg_7_0.sceneScale)

	arg_7_0.screenWidth = gohelper.getUIScreenWidth()
	arg_7_0.screenHeight = UnityEngine.Screen.height
end

function var_0_0.initMapElement(arg_8_0)
	arg_8_0:createMapElement()
	arg_8_0:initSceneBorder()
	arg_8_0:initSceneAndPlayerPos()
end

function var_0_0.resetData(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.onTick, arg_9_0)
	arg_9_0:destroyAllElement()
	arg_9_0:initMapConfig()
	arg_9_0:initMapElement()
	TaskDispatcher.runRepeat(arg_9_0.onTick, arg_9_0, 0)
end

function var_0_0.updateCamera(arg_10_0)
	return
end

function var_0_0.onTick(arg_11_0)
	if FeiLinShiDuoGameModel.instance:getIsPlayerInColorChanging() then
		return
	end

	arg_11_0.playerGOComp:onTick()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.boxCompMap) do
		iter_11_1:onTick()
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0.optionCompMap) do
		iter_11_3:onTick()
	end
end

function var_0_0.createMapElement(arg_12_0)
	local var_12_0 = FeiLinShiDuoGameModel.instance:getBlindnessModeState()
	local var_12_1 = FeiLinShiDuoGameModel.instance:getElementList()

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		local var_12_2 = UnityEngine.GameObject.New(FeiLinShiDuoEnum.ParentName[iter_12_1.type] .. "_" .. iter_12_1.id)
		local var_12_3 = gohelper.onceAddComponent(var_12_2, gohelper.Type_RectTransform)

		transformhelper.setLocalScale(var_12_3, 1, 1, 1)

		local var_12_4 = gohelper.findChild(arg_12_0.sceneGO, FeiLinShiDuoEnum.GroupName[iter_12_1.type])

		var_12_2.transform:SetParent(var_12_4.transform)
		transformhelper.setLocalScale(var_12_2.transform, 1, 1, 1)
		recthelper.setAnchor(var_12_3, iter_12_1.pos[1], iter_12_1.pos[2])

		var_12_3.pivot = Vector2(0, 0)
		arg_12_0.elementGOMap[iter_12_1.id] = {}
		arg_12_0.elementGOMap[iter_12_1.id].elementGO = var_12_2
		arg_12_0.elementGOMap[iter_12_1.id].subGOList = {}

		for iter_12_2, iter_12_3 in ipairs(iter_12_1.subGOPosList) do
			local var_12_5 = arg_12_0:getResInst(arg_12_0.viewContainer:getSetting().otherRes[FeiLinShiDuoEnum.ItemName[iter_12_1.type]], var_12_2)

			var_12_5.transform:SetParent(var_12_2.transform, false)
			recthelper.setAnchor(var_12_5.transform, tonumber(iter_12_3[1]), tonumber(iter_12_3[2]))

			local var_12_6 = gohelper.findChild(var_12_5, "scale").transform

			transformhelper.setLocalScale(var_12_6, iter_12_1.scale[1], iter_12_1.scale[2], 1)

			for iter_12_4 = 0, 4 do
				local var_12_7 = gohelper.findChild(var_12_5, "scale/type" .. iter_12_4)

				if var_12_7 then
					if iter_12_1.color == FeiLinShiDuoEnum.ColorType.Red then
						gohelper.setActive(var_12_7, iter_12_4 == FeiLinShiDuoEnum.ColorType.Red and not var_12_0 or iter_12_4 == FeiLinShiDuoEnum.ColorType.Yellow and var_12_0)
					else
						gohelper.setActive(var_12_7, iter_12_1.color == iter_12_4)
					end
				end
			end

			table.insert(arg_12_0.elementGOMap[iter_12_1.id].subGOList, var_12_5)
		end

		if iter_12_1.type == FeiLinShiDuoEnum.ObjectType.Box then
			local var_12_8 = MonoHelper.addLuaComOnceToGo(var_12_2, FeiLinShiDuoBoxComp)

			var_12_8:initData(iter_12_1, arg_12_0)

			arg_12_0.boxCompMap[iter_12_1.id] = var_12_8

			table.insert(arg_12_0.boxCompList, iter_12_1)
		end

		if iter_12_1.type == FeiLinShiDuoEnum.ObjectType.Option then
			local var_12_9 = MonoHelper.addLuaComOnceToGo(var_12_2, FeiLinShiDuoOptionComp)

			var_12_9:initData(iter_12_1, arg_12_0)

			arg_12_0.optionCompMap[iter_12_1.id] = var_12_9
		end

		if iter_12_1.type == FeiLinShiDuoEnum.ObjectType.Jump then
			if not arg_12_0.jumpAnimMap[iter_12_1.id] then
				arg_12_0.jumpAnimMap[iter_12_1.id] = {}
			end

			for iter_12_5, iter_12_6 in pairs(arg_12_0.elementGOMap[iter_12_1.id].subGOList) do
				for iter_12_7 = 0, 4 do
					local var_12_10 = gohelper.findChild(iter_12_6, "scale/type" .. iter_12_7):GetComponent(gohelper.Type_Animator)

					arg_12_0.jumpAnimMap[iter_12_1.id][iter_12_7] = var_12_10
				end
			end
		end
	end
end

function var_0_0.initSceneBorder(arg_13_0)
	arg_13_0.leftBorderX = 0
	arg_13_0.rightBorderX = 0
	arg_13_0.topBorderY = 0
	arg_13_0.bottomBorderY = 0

	local var_13_0 = FeiLinShiDuoGameModel.instance:getElementMap()
	local var_13_1 = var_13_0[FeiLinShiDuoEnum.ObjectType.Wall] or {}
	local var_13_2 = var_13_0[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}
	local var_13_3 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		table.insert(var_13_3, iter_13_1)
	end

	for iter_13_2, iter_13_3 in pairs(var_13_2) do
		table.insert(var_13_3, iter_13_3)
	end

	for iter_13_4, iter_13_5 in pairs(var_13_3) do
		for iter_13_6, iter_13_7 in ipairs(iter_13_5.subGOPosList) do
			local var_13_4 = iter_13_5.pos[1] + tonumber(iter_13_7[1])
			local var_13_5 = iter_13_5.pos[2] + tonumber(iter_13_7[2])

			if arg_13_0.leftBorderX == 0 and arg_13_0.rightBorderX == 0 and arg_13_0.topBorderY == 0 and arg_13_0.bottomBorderY == 0 then
				arg_13_0.leftBorderX = var_13_4
				arg_13_0.rightBorderX = var_13_4
				arg_13_0.topBorderY = var_13_5
				arg_13_0.bottomBorderY = var_13_5
			end

			if var_13_4 <= arg_13_0.leftBorderX then
				arg_13_0.leftBorderX = var_13_4
			end

			if var_13_4 >= arg_13_0.rightBorderX then
				arg_13_0.rightBorderX = var_13_4
			end

			if var_13_5 >= arg_13_0.topBorderY then
				arg_13_0.topBorderY = var_13_5
			end

			if var_13_5 <= arg_13_0.bottomBorderY then
				arg_13_0.bottomBorderY = var_13_5
			end
		end
	end

	arg_13_0.rightBorderX = arg_13_0.rightBorderX + FeiLinShiDuoEnum.SlotWidth
	arg_13_0.topBorderY = arg_13_0.topBorderY + FeiLinShiDuoEnum.SlotWidth

	arg_13_0:refreshSceneBorder()
end

function var_0_0.refreshSceneBorder(arg_14_0)
	arg_14_0.screenWidth = gohelper.getUIScreenWidth()
	arg_14_0.halfScreenWidth = arg_14_0.screenWidth / 2
	arg_14_0.halfScreenHeight = 540
	arg_14_0.sceneLeftPosX = -(arg_14_0.halfScreenWidth + arg_14_0.leftBorderX * arg_14_0.sceneScale) / arg_14_0.sceneScale
	arg_14_0.sceneRightPosX = (arg_14_0.halfScreenWidth - arg_14_0.rightBorderX * arg_14_0.sceneScale) / arg_14_0.sceneScale
	arg_14_0.sceneTopPosY = (arg_14_0.halfScreenHeight - arg_14_0.topBorderY * arg_14_0.sceneScale) / arg_14_0.sceneScale
	arg_14_0.sceneBottomPosY = -(arg_14_0.halfScreenHeight + arg_14_0.bottomBorderY * arg_14_0.sceneScale) / arg_14_0.sceneScale
	arg_14_0.itemLeftBorderX = arg_14_0.leftBorderX
	arg_14_0.itemRightBorderX = arg_14_0.rightBorderX
end

function var_0_0.fixSceneBorder(arg_15_0, arg_15_1, arg_15_2)
	if Mathf.Abs(arg_15_0.itemLeftBorderX - arg_15_0.itemRightBorderX) * arg_15_0.sceneScale <= arg_15_0.screenWidth then
		local var_15_0 = Mathf.Abs(arg_15_0.itemLeftBorderX - arg_15_0.itemRightBorderX)

		return -(arg_15_0.itemLeftBorderX + var_15_0 / 2), Mathf.Min(arg_15_2, arg_15_0.sceneBottomPosY)
	end

	return Mathf.Clamp(arg_15_1, arg_15_0.sceneRightPosX, arg_15_0.sceneLeftPosX), Mathf.Min(arg_15_2, arg_15_0.sceneBottomPosY)
end

function var_0_0.initSceneAndPlayerPos(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = FeiLinShiDuoGameModel.instance:getElementMap()

	for iter_16_0, iter_16_1 in pairs(var_16_1[FeiLinShiDuoEnum.ObjectType.Start]) do
		var_16_0 = iter_16_1.pos
	end

	local var_16_2, var_16_3 = arg_16_0:fixSceneBorder(-var_16_0[1], -var_16_0[2])

	transformhelper.setLocalPosXY(arg_16_0.sceneGO.transform, var_16_2, var_16_3)
	transformhelper.setLocalPosXY(arg_16_0.playerGO.transform, var_16_0[1] + FeiLinShiDuoEnum.HalfSlotWidth, var_16_0[2])
end

function var_0_0.changeSceneColor(arg_17_0)
	local var_17_0 = FeiLinShiDuoGameModel.instance:getInterElementMap()
	local var_17_1 = FeiLinShiDuoGameModel.instance:getElementShowStateMap()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		gohelper.setActive(arg_17_0.elementGOMap[iter_17_1.id].elementGO, var_17_1[iter_17_1.id])
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0.boxCompMap) do
		if iter_17_3:getShowState() and not iter_17_3:checkBoxInPlane() then
			iter_17_3:checkBoxFall(true)
		end
	end

	if arg_17_0.playerGOComp then
		arg_17_0.playerGOComp:checkPlayerFall(true)
		arg_17_0.playerGOComp:checkClimbStairs()
	end
end

function var_0_0.refreshBlindnessMode(arg_18_0)
	local var_18_0 = FeiLinShiDuoGameModel.instance:getBlindnessModeState()
	local var_18_1 = FeiLinShiDuoGameModel.instance:getInterElementMap()

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		for iter_18_2, iter_18_3 in pairs(arg_18_0.elementGOMap[iter_18_1.id].subGOList) do
			if iter_18_1.color == FeiLinShiDuoEnum.ColorType.Red then
				local var_18_2 = gohelper.findChild(iter_18_3, "scale/type" .. 1)
				local var_18_3 = gohelper.findChild(iter_18_3, "scale/type" .. 4)

				if var_18_2 then
					gohelper.setActive(var_18_2, not var_18_0)
				end

				if var_18_3 then
					gohelper.setActive(var_18_3, var_18_0)
				end
			end
		end
	end
end

function var_0_0.getSceneGO(arg_19_0)
	return arg_19_0.sceneGO
end

function var_0_0.getBoxComp(arg_20_0, arg_20_1)
	return arg_20_0.boxCompMap[arg_20_1]
end

function var_0_0.getAllBoxComp(arg_21_0)
	return arg_21_0.boxCompMap
end

function var_0_0.getAllBoxCompList(arg_22_0)
	return arg_22_0.boxCompList
end

function var_0_0.getPlayerAnimComp(arg_23_0)
	return arg_23_0.playerAnimComp
end

function var_0_0.getPlayerGO(arg_24_0)
	return arg_24_0.playerGO
end

function var_0_0.getPlayerComp(arg_25_0)
	return arg_25_0.playerGOComp
end

function var_0_0.getElementGOMap(arg_26_0)
	return arg_26_0.elementGOMap
end

function var_0_0.getGameUIView(arg_27_0)
	return arg_27_0.viewContainer:getGameView()
end

function var_0_0.getJumpAnim(arg_28_0, arg_28_1)
	return arg_28_0.jumpAnimMap[arg_28_1.id] and arg_28_0.jumpAnimMap[arg_28_1.id][arg_28_1.color]
end

function var_0_0.getCurGuideCheckData(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(FeiLinShiDuoEnum.GuideDataList) do
		if arg_29_0.viewParam.mapId == iter_29_1.mapId and not GuideModel.instance:isGuideFinish(iter_29_1.guideId) then
			return iter_29_1
		end
	end
end

function var_0_0.onClose(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.onTick, arg_30_0)
end

function var_0_0.destroyAllElement(arg_31_0)
	local var_31_0 = FeiLinShiDuoGameModel.instance:getElementList()

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		gohelper.destroy(arg_31_0.elementGOMap[iter_31_1.id].elementGO)
	end

	arg_31_0.elementGOMap = arg_31_0:getUserDataTb_()
	arg_31_0.boxCompMap = arg_31_0:getUserDataTb_()
	arg_31_0.boxCompList = arg_31_0:getUserDataTb_()
	arg_31_0.optionCompMap = arg_31_0:getUserDataTb_()
	arg_31_0.jumpAnimMap = arg_31_0:getUserDataTb_()
end

function var_0_0.onDestroyView(arg_32_0)
	return
end

return var_0_0
