module("modules.logic.rouge.map.controller.RougeMapHelper", package.seeall)

local var_0_0 = class("RougeMapHelper")

function var_0_0.blockEsc()
	return
end

var_0_0.StandardRate = 1.7777777777777777

function var_0_0.getMiddleLayerCameraSize()
	local var_2_0 = UnityEngine.Screen.width / UnityEngine.Screen.height
	local var_2_1 = RougeMapModel.instance:getMapSize()

	if var_2_0 >= var_0_0.StandardRate then
		return var_2_1.y / 2
	end

	return var_2_1.y * var_0_0.StandardRate / var_2_0 / 2
end

function var_0_0.getNormalLayerCameraSize()
	local var_3_0 = UnityEngine.Screen.width
	local var_3_1 = UnityEngine.Screen.height
	local var_3_2 = var_3_0 / var_3_1
	local var_3_3 = RougeMapModel.instance:getMapSize().y / 2

	if var_3_2 >= var_0_0.StandardRate then
		return var_3_3
	end

	return var_3_3 * (var_3_1 * var_0_0.StandardRate / var_3_0)
end

function var_0_0.getUIRoot()
	if UnityEngine.Screen.width / UnityEngine.Screen.height >= var_0_0.StandardRate then
		return ViewMgr.instance:getUIRoot()
	end

	return ViewMgr.instance:getUILayer(UILayerName.PopUpTop)
end

function var_0_0.getScenePos(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1.z = arg_5_2

	local var_5_0 = arg_5_0:ScreenToWorldPoint(arg_5_1)

	var_5_0.x = var_0_0.retain2decimals(var_5_0.x)
	var_5_0.y = var_0_0.retain2decimals(var_5_0.y)
	var_5_0.z = var_0_0.retain2decimals(var_5_0.z)

	return var_5_0
end

function var_0_0.retain2decimals(arg_6_0)
	return arg_6_0 - arg_6_0 % 0.01
end

function var_0_0.getEpisodePosX(arg_7_0)
	local var_7_0 = (arg_7_0 - 1) * RougeMapModel.instance:getMapEpisodeIntervalX()

	return RougeMapModel.instance:getMapStartOffsetX() + var_7_0
end

function var_0_0.getNodeLocalPos(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.randomX()
	local var_8_1 = RougeMapEnum.NodeLocalPosY[arg_8_1][arg_8_0] + RougeMapEnum.NodeGlobalOffsetY
	local var_8_2 = RougeMapModel.instance:getMapSize().y

	return var_8_0, -var_8_1 * var_8_2, 0
end

function var_0_0.randomX()
	local var_9_0 = (RougeMapEnum.NodeLocalPosXRange * 2 + 1) * 100

	return math.random(100, var_9_0) * 0.01 - (RougeMapEnum.NodeLocalPosXRange + 1)
end

function var_0_0.getNodeContainerPos(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return var_0_0.getEpisodePosX(arg_10_0) + arg_10_1, arg_10_2, arg_10_3
end

function var_0_0.getWorldPos(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_11_0, arg_11_1, arg_11_2)

	return var_11_0.x, var_11_0.y, var_11_0.z
end

function var_0_0.getOffsetZ(arg_12_0)
	if math.abs(arg_12_0) > 100 then
		logWarn("abs Y > 100")
	end

	arg_12_0 = arg_12_0 - 100

	return arg_12_0 * 0.001
end

var_0_0.MapType2Cls = {
	[RougeMapEnum.MapType.Edit] = RougeMiddleLayerEditMap,
	[RougeMapEnum.MapType.Normal] = RougeLayerMap,
	[RougeMapEnum.MapType.Middle] = RougeMiddleLayerMap,
	[RougeMapEnum.MapType.PathSelect] = RougePathSelectMap
}

function var_0_0.createMapComp(arg_13_0)
	local var_13_0 = var_0_0.MapType2Cls[arg_13_0]

	if not var_13_0 then
		logError("not found map cls .. " .. tostring(arg_13_0))

		var_13_0 = var_0_0.MapType2Cls[RougeMapEnum.MapType.Normal]
	end

	return (var_13_0.New())
end

function var_0_0.getScenePath(arg_14_0)
	return string.format(RougeMapEnum.ScenePrefabFormat, arg_14_0)
end

function var_0_0.addMapOtherRes(arg_15_0, arg_15_1)
	if arg_15_0 == RougeMapEnum.MapType.Edit then
		arg_15_1:addPath(RougeMapEnum.RedNodeResPath)
		arg_15_1:addPath(RougeMapEnum.GreenNodeResPath)
		arg_15_1:addPath(RougeMapEnum.LineResPath)
		arg_15_1:addPath(RougeMapEnum.MiddleLayerLeavePath)
	elseif arg_15_0 == RougeMapEnum.MapType.Normal then
		arg_15_1:addPath(RougeMapEnum.LinePrefabRes)

		for iter_15_0, iter_15_1 in pairs(RougeMapEnum.LineIconRes) do
			arg_15_1:addPath(iter_15_1)
		end

		for iter_15_2, iter_15_3 in pairs(RougeMapEnum.IconPath) do
			arg_15_1:addPath(var_0_0.getScenePath(iter_15_3))
		end

		for iter_15_4, iter_15_5 in pairs(RougeMapEnum.NodeBgPath) do
			for iter_15_6, iter_15_7 in pairs(iter_15_5) do
				arg_15_1:addPath(var_0_0.getScenePath(iter_15_7))
			end
		end

		arg_15_1:addPath(var_0_0.getScenePath(RougeMapEnum.StartNodeBgPath))
	elseif arg_15_0 == RougeMapEnum.MapType.Middle then
		arg_15_1:addPath(RougeMapEnum.MiddleLayerLeavePath)
		arg_15_1:addPath(RougeMapEnum.PieceBossEffect)

		local var_15_0 = RougeMapModel.instance:getMiddleLayerCo().dayOrNight
		local var_15_1 = var_0_0.getPieceResPath(RougeMapEnum.ActorPiecePath, var_15_0)

		arg_15_1:addPath(var_15_1)

		local var_15_2 = RougeMapModel.instance:getPieceList()

		for iter_15_8, iter_15_9 in ipairs(var_15_2) do
			local var_15_3 = iter_15_9:getPieceCo().pieceRes

			if not string.nilorempty(var_15_3) then
				local var_15_4 = var_0_0.getPieceResPath(var_15_3, var_15_0)

				arg_15_1:addPath(var_15_4)
			end
		end

		for iter_15_10, iter_15_11 in pairs(RougeMapEnum.PieceIconRes) do
			arg_15_1:addPath(iter_15_11)
		end

		for iter_15_12, iter_15_13 in pairs(RougeMapEnum.PieceIconBgRes) do
			arg_15_1:addPath(iter_15_13)
		end
	elseif arg_15_0 == RougeMapEnum.MapType.PathSelect then
		-- block empty
	end
end

function var_0_0.getMapResPath(arg_16_0)
	if arg_16_0 == RougeMapEnum.MapType.Edit then
		local var_16_0 = RougeMapEditModel.instance.middleLayerId

		return RougeMapConfig.instance:getMiddleMapResPath(var_16_0)
	elseif arg_16_0 == RougeMapEnum.MapType.Middle then
		local var_16_1 = RougeMapModel.instance:getMiddleLayerId()

		return RougeMapConfig.instance:getMiddleMapResPath(var_16_1)
	elseif arg_16_0 == RougeMapEnum.MapType.Normal then
		return RougeMapModel.instance:getLayerCo().mapRes
	elseif arg_16_0 == RougeMapEnum.MapType.PathSelect then
		return RougeMapModel.instance:getPathSelectCo().mapRes
	end
end

function var_0_0.getPieceResPath(arg_17_0, arg_17_1)
	local var_17_0 = RougeMapEnum.DayOrNightSuffix[arg_17_1]

	return string.format("scenes/v1a9_m_s16_dilao_room/scene_prefab/chess/%s_%s.prefab", arg_17_0, var_17_0)
end

function var_0_0.formatLineParam(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0 == RougeMapEnum.MiddleLayerPointType.Pieces or arg_18_0 == RougeMapEnum.MiddleLayerPointType.Leave then
		return arg_18_0, arg_18_1, arg_18_2, arg_18_3
	end

	return arg_18_2, arg_18_3, arg_18_0, arg_18_1
end

function var_0_0.backToMainScene()
	RougeMapModel.instance:clearInteractive()
	RougePopController.instance:clearAllPopView()
	ViewMgr.instance:closeAllPopupViews(nil, true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal)
	MainController.instance:enterMainScene(true, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, var_0_0._onEnterMainSceneDone)
end

function var_0_0._onEnterMainSceneDone()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.RougeMainView)

	local var_20_0 = FlowSequence.New()

	var_20_0:addWork(OpenViewWork.New({
		openFunction = DungeonController.openDungeonView,
		openFunctionObj = DungeonController.instance,
		waitOpenViewName = ViewName.DungeonView
	}))
	var_20_0:addWork(OpenViewWork.New({
		openFunction = RougeController.openRougeMainView,
		openFunctionObj = RougeController.instance,
		waitOpenViewName = ViewName.RougeMainView
	}))
	var_20_0:start()
end

function var_0_0.getEpisodeIndex(arg_21_0)
	return arg_21_0 + 1
end

function var_0_0.loadItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	for iter_22_0, iter_22_1 in ipairs(arg_22_2) do
		local var_22_0 = arg_22_3[iter_22_0]

		if not var_22_0 then
			var_22_0 = arg_22_1.New()

			local var_22_1 = gohelper.cloneInPlace(arg_22_0)

			var_22_0:init(var_22_1)
			table.insert(arg_22_3, var_22_0)
		end

		var_22_0:show()
		var_22_0:update(iter_22_0, iter_22_1)
	end

	for iter_22_2 = #arg_22_2 + 1, #arg_22_3 do
		arg_22_3[iter_22_2]:hide()
	end
end

function var_0_0.loadItemWithCustomUpdateFunc(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	for iter_23_0, iter_23_1 in ipairs(arg_23_2) do
		local var_23_0 = arg_23_3[iter_23_0]

		if not var_23_0 then
			var_23_0 = arg_23_1.New()

			local var_23_1 = gohelper.cloneInPlace(arg_23_0)

			var_23_0:init(var_23_1)
			table.insert(arg_23_3, var_23_0)
		end

		var_23_0:show()
		arg_23_4(arg_23_5, var_23_0, iter_23_0, iter_23_1)
	end

	for iter_23_2 = #arg_23_2 + 1, #arg_23_3 do
		arg_23_3[iter_23_2]:hide()
	end
end

function var_0_0.loadGoItem(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = 1, arg_24_1 do
		local var_24_0

		if arg_24_2 then
			var_24_0 = arg_24_2[iter_24_0]

			if not var_24_0 then
				var_24_0 = gohelper.cloneInPlace(arg_24_0)

				table.insert(arg_24_2, var_24_0)
			end
		else
			var_24_0 = gohelper.cloneInPlace(arg_24_0)
		end

		gohelper.setActive(var_24_0, true)
	end

	if arg_24_2 then
		for iter_24_1 = arg_24_1 + 1, #arg_24_2 do
			gohelper.setActive(arg_24_2[iter_24_1], false)
		end
	end
end

function var_0_0.destroyItemList(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0) do
		iter_25_1:destroy()
	end
end

function var_0_0.getLineType(arg_26_0, arg_26_1)
	local var_26_0 = RougeMapEnum.StatusLineMap[arg_26_0][arg_26_1]

	if var_26_0 == RougeMapEnum.LineType.None then
		logError(string.format("Impossible situation .. curStatus : %s   ---   preStatus : %s", arg_26_0, arg_26_1))

		return RougeMapEnum.LineType.CantArrive
	end

	return var_26_0
end

function var_0_0.getMiddleLayerPathListLen(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.pathPointPos
	local var_27_1 = 0

	for iter_27_0 = 2, #arg_27_1 do
		local var_27_2 = var_27_0[arg_27_1[iter_27_0 - 1]]
		local var_27_3 = var_27_0[arg_27_1[iter_27_0]]
		local var_27_4 = Vector2.Distance(var_27_2, var_27_3)

		var_27_1 = var_27_1 + var_27_4

		table.insert(arg_27_2, var_27_4)
	end

	for iter_27_1, iter_27_2 in ipairs(arg_27_2) do
		arg_27_2[iter_27_1] = iter_27_2 / var_27_1 + (arg_27_2[iter_27_1 - 1] or 0)
	end

	arg_27_2[#arg_27_2] = 1

	return var_27_1
end

function var_0_0.getAngle(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_2 - arg_28_0
	local var_28_1 = arg_28_3 - arg_28_1
	local var_28_2 = var_28_0 > 0 and 1 or -1
	local var_28_3 = var_28_1 > 0 and 1 or -1

	if var_28_0 == 0 then
		if var_28_1 == 0 then
			return 0
		else
			return var_28_3 > 0 and 90 or 270
		end
	end

	if var_28_1 == 0 then
		if var_28_0 == 0 then
			return 0
		else
			return var_28_2 > 0 and 0 or 180
		end
	end

	local var_28_4 = math.abs(var_28_1) / math.abs(var_28_0)
	local var_28_5 = math.atan(var_28_4) * 180 / math.pi

	if var_28_2 > 0 then
		if var_28_3 > 0 then
			return var_28_5
		else
			return 360 - var_28_5
		end
	else
		return 180 - var_28_3 * var_28_5
	end
end

function var_0_0.getPieceDir(arg_29_0)
	if arg_29_0 >= 0 and arg_29_0 <= 90 then
		return RougeMapEnum.PieceDir.Top
	elseif arg_29_0 >= 90 and arg_29_0 <= 180 then
		return RougeMapEnum.PieceDir.Left
	elseif arg_29_0 >= 180 and arg_29_0 <= 270 then
		return RougeMapEnum.PieceDir.Bottom
	elseif arg_29_0 >= 270 and arg_29_0 <= 360 then
		return RougeMapEnum.PieceDir.Right
	end

	return RougeMapEnum.PieceDir.Bottom
end

function var_0_0.getActorDir(arg_30_0, arg_30_1)
	if arg_30_1 >= 0 and arg_30_1 <= 22.5 then
		return RougeMapEnum.ActorDir.RightTop
	elseif arg_30_1 >= 22.5 and arg_30_1 <= 67.5 then
		return RougeMapEnum.ActorDir.Top
	elseif arg_30_1 >= 67.5 and arg_30_1 <= 112.5 then
		return RougeMapEnum.ActorDir.LeftTop
	elseif arg_30_1 >= 112.5 and arg_30_1 <= 157.5 then
		return RougeMapEnum.ActorDir.Left
	elseif arg_30_1 >= 157.5 and arg_30_1 <= 202.5 then
		return RougeMapEnum.ActorDir.LeftBottom
	elseif arg_30_1 >= 202.5 and arg_30_1 <= 247.5 then
		return RougeMapEnum.ActorDir.Bottom
	elseif arg_30_1 >= 247.5 and arg_30_1 <= 292.5 then
		return RougeMapEnum.ActorDir.RightBottom
	elseif arg_30_1 >= 292.5 and arg_30_1 <= 337.5 then
		return RougeMapEnum.ActorDir.Right
	elseif arg_30_1 >= 337.5 and arg_30_1 <= 360 then
		return RougeMapEnum.ActorDir.RightTop
	end

	return RougeMapEnum.ActorDir.Bottom
end

function var_0_0.isEntrustPiece(arg_31_0)
	return arg_31_0 == RougeMapEnum.PieceEntrustType.Normal or arg_31_0 == RougeMapEnum.PieceEntrustType.Hard
end

function var_0_0.isRestPiece(arg_32_0)
	return arg_32_0 == RougeMapEnum.PieceEntrustType.Rest
end

function var_0_0.isFightEvent(arg_33_0)
	if not arg_33_0 then
		return false
	end

	return arg_33_0 == RougeMapEnum.EventType.NormalFight or arg_33_0 == RougeMapEnum.EventType.HardFight or arg_33_0 == RougeMapEnum.EventType.EliteFight or arg_33_0 == RougeMapEnum.EventType.BossFight
end

function var_0_0.isChoiceEvent(arg_34_0)
	if not arg_34_0 then
		return false
	end

	return arg_34_0 == RougeMapEnum.EventType.Reward or arg_34_0 == RougeMapEnum.EventType.Choice or arg_34_0 == RougeMapEnum.EventType.Rest
end

function var_0_0.isStoreEvent(arg_35_0)
	if not arg_35_0 then
		return false
	end

	return arg_35_0 == RougeMapEnum.EventType.Store
end

function var_0_0.getPos(arg_36_0)
	local var_36_0 = string.splitToNumber(arg_36_0, "#")

	return var_36_0[1], var_36_0[2]
end

function var_0_0.filterUnActivePieceChoice(arg_37_0)
	for iter_37_0 = #arg_37_0, 1, -1 do
		local var_37_0 = arg_37_0[iter_37_0]
		local var_37_1 = lua_rouge_piece_select.configDict[var_37_0]

		if not RougeMapUnlockHelper.checkIsUnlock(var_37_1.activeType, var_37_1.activeParam) then
			table.remove(arg_37_0, iter_37_0)
		end
	end
end

function var_0_0.getChangeMapEnum(arg_38_0, arg_38_1)
	if arg_38_0 == RougeMapEnum.MapType.Normal and arg_38_1 == RougeMapEnum.MapType.Middle then
		return RougeMapEnum.ChangeMapEnum.NormalToMiddle
	elseif arg_38_0 == RougeMapEnum.MapType.Middle and arg_38_1 == RougeMapEnum.MapType.PathSelect then
		return RougeMapEnum.ChangeMapEnum.MiddleToPathSelect
	elseif arg_38_0 == RougeMapEnum.MapType.PathSelect and arg_38_1 == RougeMapEnum.MapType.Normal then
		return RougeMapEnum.ChangeMapEnum.PathSelectToNormal
	end
end

function var_0_0.getLifeChangeStatus(arg_39_0, arg_39_1)
	if arg_39_0 == arg_39_1 then
		return RougeMapEnum.LifeChangeStatus.Idle
	end

	if arg_39_0 < arg_39_1 then
		return RougeMapEnum.LifeChangeStatus.Add
	end

	return RougeMapEnum.LifeChangeStatus.Reduce
end

function var_0_0.checkNeedFilterUnique(arg_40_0)
	return arg_40_0 == RougeMapEnum.InteractType.LossAndCopy or arg_40_0 == RougeMapEnum.InteractType.LossNotUniqueCollection or arg_40_0 == RougeMapEnum.InteractType.StorageCollection
end

function var_0_0.getEndId()
	local var_41_0 = RougeMapModel.instance:getCurPieceMo()
	local var_41_1 = var_41_0 and var_41_0.selectId
	local var_41_2 = var_41_1 and lua_rouge_piece_select.configDict[var_41_1]

	if not var_41_2 then
		return
	end

	local var_41_3 = string.splitToNumber(var_41_2.triggerParam, "#")

	return var_41_3 and var_41_3[2]
end

var_0_0.CommonIgnoreViewDict = {
	[ViewName.RougeMapView] = true,
	[ViewName.RougeMapTipView] = true,
	[ViewName.ToastView] = true,
	[ViewName.ToastTopView] = true,
	[ViewName.WaterMarkView] = true,
	[ViewName.GuideView] = true
}

function var_0_0.checkMapViewOnTop(arg_42_0)
	local var_42_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if not var_0_0.CommonIgnoreViewDict[iter_42_1] then
			if arg_42_0 then
				logNormal("cur top view : " .. tostring(iter_42_1))
			end

			return false
		end
	end

	return true
end

function var_0_0.clearMapData()
	RougeMapController.instance:clear()
	RougeMapModel.instance:clear()
	RougeMapTipPopController.instance:clear()
	RougeMapVoiceTriggerController.instance:clear()
	RougePopController.instance:clearAllPopView()
end

return var_0_0
