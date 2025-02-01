module("modules.logic.rouge.map.controller.RougeMapHelper", package.seeall)

slot0 = class("RougeMapHelper")

function slot0.blockEsc()
end

slot0.StandardRate = 1.7777777777777777

function slot0.getMiddleLayerCameraSize()
	slot3 = RougeMapModel.instance:getMapSize()

	if uv0.StandardRate <= UnityEngine.Screen.width / UnityEngine.Screen.height then
		return slot3.y / 2
	end

	return slot3.y * uv0.StandardRate / slot2 / 2
end

function slot0.getNormalLayerCameraSize()
	slot4 = RougeMapModel.instance:getMapSize().y / 2

	if uv0.StandardRate <= UnityEngine.Screen.width / UnityEngine.Screen.height then
		return slot4
	end

	return slot4 * slot1 * uv0.StandardRate / slot0
end

function slot0.getUIRoot()
	if uv0.StandardRate <= UnityEngine.Screen.width / UnityEngine.Screen.height then
		return ViewMgr.instance:getUIRoot()
	end

	return ViewMgr.instance:getUILayer(UILayerName.PopUpTop)
end

function slot0.getScenePos(slot0, slot1, slot2)
	slot1.z = slot2
	slot3 = slot0:ScreenToWorldPoint(slot1)
	slot3.x = uv0.retain2decimals(slot3.x)
	slot3.y = uv0.retain2decimals(slot3.y)
	slot3.z = uv0.retain2decimals(slot3.z)

	return slot3
end

function slot0.retain2decimals(slot0)
	return slot0 - slot0 % 0.01
end

function slot0.getEpisodePosX(slot0)
	return RougeMapEnum.MapStartOffsetX + (slot0 - 1) * RougeMapModel.instance:getMapEpisodeIntervalX()
end

function slot0.getNodeLocalPos(slot0, slot1)
	return uv0.randomX(), -(RougeMapEnum.NodeLocalPosY[slot1][slot0] + RougeMapEnum.NodeGlobalOffsetY) * RougeMapModel.instance:getMapSize().y, 0
end

function slot0.randomX()
	return math.random(100, (RougeMapEnum.NodeLocalPosXRange * 2 + 1) * 100) * 0.01 - (RougeMapEnum.NodeLocalPosXRange + 1)
end

function slot0.getNodeContainerPos(slot0, slot1, slot2, slot3)
	return uv0.getEpisodePosX(slot0) + slot1, slot2, slot3
end

function slot0.getWorldPos(slot0, slot1, slot2)
	slot3 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot0, slot1, slot2)

	return slot3.x, slot3.y, slot3.z
end

function slot0.getOffsetZ(slot0)
	if math.abs(slot0) > 100 then
		logWarn("abs Y > 100")
	end

	return (slot0 - 100) * 0.001
end

slot0.MapType2Cls = {
	[RougeMapEnum.MapType.Edit] = RougeMiddleLayerEditMap,
	[RougeMapEnum.MapType.Normal] = RougeLayerMap,
	[RougeMapEnum.MapType.Middle] = RougeMiddleLayerMap,
	[RougeMapEnum.MapType.PathSelect] = RougePathSelectMap
}

function slot0.createMapComp(slot0)
	if not uv0.MapType2Cls[slot0] then
		logError("not found map cls .. " .. tostring(slot0))

		slot1 = uv0.MapType2Cls[RougeMapEnum.MapType.Normal]
	end

	return slot1.New()
end

function slot0.getScenePath(slot0)
	return string.format(RougeMapEnum.ScenePrefabFormat, slot0)
end

function slot0.addMapOtherRes(slot0, slot1)
	if slot0 == RougeMapEnum.MapType.Edit then
		slot1:addPath(RougeMapEnum.RedNodeResPath)
		slot1:addPath(RougeMapEnum.GreenNodeResPath)
		slot1:addPath(RougeMapEnum.LineResPath)
		slot1:addPath(RougeMapEnum.MiddleLayerLeavePath)
	elseif slot0 == RougeMapEnum.MapType.Normal then
		slot1:addPath(RougeMapEnum.LinePrefabRes)

		for slot5, slot6 in pairs(RougeMapEnum.LineIconRes) do
			slot1:addPath(slot6)
		end

		for slot5, slot6 in pairs(RougeMapEnum.IconPath) do
			slot1:addPath(uv0.getScenePath(slot6))
		end

		for slot5, slot6 in pairs(RougeMapEnum.NodeBgPath) do
			for slot10, slot11 in pairs(slot6) do
				slot1:addPath(uv0.getScenePath(slot11))
			end
		end

		slot1:addPath(uv0.getScenePath(RougeMapEnum.StartNodeBgPath))
	elseif slot0 == RougeMapEnum.MapType.Middle then
		slot1:addPath(RougeMapEnum.MiddleLayerLeavePath)
		slot1:addPath(RougeMapEnum.PieceBossEffect)
		slot1:addPath(uv0.getPieceResPath(RougeMapEnum.ActorPiecePath, RougeMapModel.instance:getMiddleLayerCo().dayOrNight))

		for slot9, slot10 in ipairs(RougeMapModel.instance:getPieceList()) do
			if not string.nilorempty(slot10:getPieceCo().pieceRes) then
				slot1:addPath(uv0.getPieceResPath(slot12, slot3))
			end
		end

		for slot9, slot10 in pairs(RougeMapEnum.PieceIconRes) do
			slot1:addPath(slot10)
		end

		for slot9, slot10 in pairs(RougeMapEnum.PieceIconBgRes) do
			slot1:addPath(slot10)
		end
	elseif slot0 == RougeMapEnum.MapType.PathSelect then
		-- Nothing
	end
end

function slot0.getMapResPath(slot0)
	if slot0 == RougeMapEnum.MapType.Edit then
		return RougeMapConfig.instance:getMiddleMapResPath(RougeMapEditModel.instance.middleLayerId)
	elseif slot0 == RougeMapEnum.MapType.Middle then
		return RougeMapConfig.instance:getMiddleMapResPath(RougeMapModel.instance:getMiddleLayerId())
	elseif slot0 == RougeMapEnum.MapType.Normal then
		return RougeMapModel.instance:getLayerCo().mapRes
	elseif slot0 == RougeMapEnum.MapType.PathSelect then
		return RougeMapModel.instance:getPathSelectCo().mapRes
	end
end

function slot0.getPieceResPath(slot0, slot1)
	return string.format("scenes/v1a9_m_s16_dilao_room/scene_prefab/chess/%s_%s.prefab", slot0, RougeMapEnum.DayOrNightSuffix[slot1])
end

function slot0.formatLineParam(slot0, slot1, slot2, slot3)
	if slot0 == RougeMapEnum.MiddleLayerPointType.Pieces or slot0 == RougeMapEnum.MiddleLayerPointType.Leave then
		return slot0, slot1, slot2, slot3
	end

	return slot2, slot3, slot0, slot1
end

function slot0.backToMainScene()
	RougeMapModel.instance:clearInteractive()
	RougePopController.instance:clearAllPopView()
	ViewMgr.instance:closeAllPopupViews(nil, true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal)
	MainController.instance:enterMainScene(true, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, uv0._onEnterMainSceneDone)
end

function slot0._onEnterMainSceneDone()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.RougeMainView)

	slot0 = FlowSequence.New()

	slot0:addWork(OpenViewWork.New({
		openFunction = DungeonController.openDungeonView,
		openFunctionObj = DungeonController.instance,
		waitOpenViewName = ViewName.DungeonView
	}))
	slot0:addWork(OpenViewWork.New({
		openFunction = RougeController.openRougeMainView,
		openFunctionObj = RougeController.instance,
		waitOpenViewName = ViewName.RougeMainView
	}))
	slot0:start()
end

function slot0.getEpisodeIndex(slot0)
	return slot0 + 1
end

function slot0.loadItem(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot2) do
		if not slot3[slot7] then
			slot9 = slot1.New()

			slot9:init(gohelper.cloneInPlace(slot0))
			table.insert(slot3, slot9)
		end

		slot9:show()
		slot9:update(slot7, slot8)
	end

	for slot7 = #slot2 + 1, #slot3 do
		slot3[slot7]:hide()
	end
end

function slot0.loadItemWithCustomUpdateFunc(slot0, slot1, slot2, slot3, slot4, slot5)
	for slot9, slot10 in ipairs(slot2) do
		if not slot3[slot9] then
			slot11 = slot1.New()

			slot11:init(gohelper.cloneInPlace(slot0))
			table.insert(slot3, slot11)
		end

		slot11:show()
		slot4(slot5, slot11, slot9, slot10)
	end

	for slot9 = #slot2 + 1, #slot3 do
		slot3[slot9]:hide()
	end
end

function slot0.loadGoItem(slot0, slot1, slot2)
	for slot6 = 1, slot1 do
		slot7 = nil

		if slot2 then
			if not slot2[slot6] then
				table.insert(slot2, gohelper.cloneInPlace(slot0))
			end
		else
			slot7 = gohelper.cloneInPlace(slot0)
		end

		gohelper.setActive(slot7, true)
	end

	if slot2 then
		for slot6 = slot1 + 1, #slot2 do
			gohelper.setActive(slot2[slot6], false)
		end
	end
end

function slot0.destroyItemList(slot0)
	for slot4, slot5 in pairs(slot0) do
		slot5:destroy()
	end
end

function slot0.getLineType(slot0, slot1)
	if RougeMapEnum.StatusLineMap[slot0][slot1] == RougeMapEnum.LineType.None then
		logError(string.format("Impossible situation .. curStatus : %s   ---   preStatus : %s", slot0, slot1))

		return RougeMapEnum.LineType.CantArrive
	end

	return slot2
end

function slot0.getMiddleLayerPathListLen(slot0, slot1, slot2)
	slot3 = slot0.pathPointPos

	for slot8 = 2, #slot1 do
		slot11 = Vector2.Distance(slot3[slot1[slot8 - 1]], slot3[slot1[slot8]])
		slot4 = 0 + slot11

		table.insert(slot2, slot11)
	end

	for slot8, slot9 in ipairs(slot2) do
		slot2[slot8] = slot9 / slot4 + (slot2[slot8 - 1] or 0)
	end

	slot2[#slot2] = 1

	return slot4
end

function slot0.getAngle(slot0, slot1, slot2, slot3)
	slot6 = slot2 - slot0 > 0 and 1 or -1
	slot7 = slot3 - slot1 > 0 and 1 or -1

	if slot4 == 0 then
		if slot5 == 0 then
			return 0
		else
			return slot7 > 0 and 90 or 270
		end
	end

	if slot5 == 0 then
		if slot4 == 0 then
			return 0
		else
			return slot6 > 0 and 0 or 180
		end
	end

	if slot6 > 0 then
		if slot7 > 0 then
			return math.atan(math.abs(slot5) / math.abs(slot4)) * 180 / math.pi
		else
			return 360 - slot9
		end
	else
		return 180 - slot7 * slot9
	end
end

function slot0.getPieceDir(slot0)
	if slot0 >= 0 and slot0 <= 90 then
		return RougeMapEnum.PieceDir.Top
	elseif slot0 >= 90 and slot0 <= 180 then
		return RougeMapEnum.PieceDir.Left
	elseif slot0 >= 180 and slot0 <= 270 then
		return RougeMapEnum.PieceDir.Bottom
	elseif slot0 >= 270 and slot0 <= 360 then
		return RougeMapEnum.PieceDir.Right
	end

	return RougeMapEnum.PieceDir.Bottom
end

function slot0.getActorDir(slot0, slot1)
	if slot1 >= 0 and slot1 <= 22.5 then
		return RougeMapEnum.ActorDir.RightTop
	elseif slot1 >= 22.5 and slot1 <= 67.5 then
		return RougeMapEnum.ActorDir.Top
	elseif slot1 >= 67.5 and slot1 <= 112.5 then
		return RougeMapEnum.ActorDir.LeftTop
	elseif slot1 >= 112.5 and slot1 <= 157.5 then
		return RougeMapEnum.ActorDir.Left
	elseif slot1 >= 157.5 and slot1 <= 202.5 then
		return RougeMapEnum.ActorDir.LeftBottom
	elseif slot1 >= 202.5 and slot1 <= 247.5 then
		return RougeMapEnum.ActorDir.Bottom
	elseif slot1 >= 247.5 and slot1 <= 292.5 then
		return RougeMapEnum.ActorDir.RightBottom
	elseif slot1 >= 292.5 and slot1 <= 337.5 then
		return RougeMapEnum.ActorDir.Right
	elseif slot1 >= 337.5 and slot1 <= 360 then
		return RougeMapEnum.ActorDir.RightTop
	end

	return RougeMapEnum.ActorDir.Bottom
end

function slot0.isEntrustPiece(slot0)
	return slot0 == RougeMapEnum.PieceEntrustType.Normal or slot0 == RougeMapEnum.PieceEntrustType.Hard
end

function slot0.isRestPiece(slot0)
	return slot0 == RougeMapEnum.PieceEntrustType.Rest
end

function slot0.isFightEvent(slot0)
	if not slot0 then
		return false
	end

	return slot0 == RougeMapEnum.EventType.NormalFight or slot0 == RougeMapEnum.EventType.HardFight or slot0 == RougeMapEnum.EventType.EliteFight or slot0 == RougeMapEnum.EventType.BossFight
end

function slot0.isChoiceEvent(slot0)
	if not slot0 then
		return false
	end

	return slot0 == RougeMapEnum.EventType.Reward or slot0 == RougeMapEnum.EventType.Choice or slot0 == RougeMapEnum.EventType.Rest
end

function slot0.isStoreEvent(slot0)
	if not slot0 then
		return false
	end

	return slot0 == RougeMapEnum.EventType.Store
end

function slot0.getPos(slot0)
	slot1 = string.splitToNumber(slot0, "#")

	return slot1[1], slot1[2]
end

function slot0.filterUnActivePieceChoice(slot0)
	for slot4 = #slot0, 1, -1 do
		slot6 = lua_rouge_piece_select.configDict[slot0[slot4]]

		if not RougeMapUnlockHelper.checkIsUnlock(slot6.activeType, slot6.activeParam) then
			table.remove(slot0, slot4)
		end
	end
end

function slot0.getChangeMapEnum(slot0, slot1)
	if slot0 == RougeMapEnum.MapType.Normal and slot1 == RougeMapEnum.MapType.Middle then
		return RougeMapEnum.ChangeMapEnum.NormalToMiddle
	elseif slot0 == RougeMapEnum.MapType.Middle and slot1 == RougeMapEnum.MapType.PathSelect then
		return RougeMapEnum.ChangeMapEnum.MiddleToPathSelect
	elseif slot0 == RougeMapEnum.MapType.PathSelect and slot1 == RougeMapEnum.MapType.Normal then
		return RougeMapEnum.ChangeMapEnum.PathSelectToNormal
	end
end

function slot0.getLifeChangeStatus(slot0, slot1)
	if slot0 == slot1 then
		return RougeMapEnum.LifeChangeStatus.Idle
	end

	if slot0 < slot1 then
		return RougeMapEnum.LifeChangeStatus.Add
	end

	return RougeMapEnum.LifeChangeStatus.Reduce
end

function slot0.checkNeedFilterUnique(slot0)
	return slot0 == RougeMapEnum.InteractType.LossAndCopy or slot0 == RougeMapEnum.InteractType.LossNotUniqueCollection or slot0 == RougeMapEnum.InteractType.StorageCollection
end

function slot0.getEndId()
	slot1 = RougeMapModel.instance:getCurPieceMo() and slot0.selectId

	if not (slot1 and lua_rouge_piece_select.configDict[slot1]) then
		return
	end

	return string.splitToNumber(slot2.triggerParam, "#") and slot3[2]
end

slot0.CommonIgnoreViewDict = {
	[ViewName.RougeMapView] = true,
	[ViewName.RougeMapTipView] = true,
	[ViewName.ToastView] = true,
	[ViewName.ToastTopView] = true,
	[ViewName.WaterMarkView] = true,
	[ViewName.GuideView] = true
}

function slot0.checkMapViewOnTop(slot0)
	for slot5, slot6 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if not uv0.CommonIgnoreViewDict[slot6] then
			if slot0 then
				logNormal("cur top view : " .. tostring(slot6))
			end

			return false
		end
	end

	return true
end

function slot0.clearMapData()
	RougeMapController.instance:clear()
	RougeMapModel.instance:clear()
	RougeMapTipPopController.instance:clear()
	RougeMapVoiceTriggerController.instance:clear()
	RougePopController.instance:clearAllPopView()
end

return slot0
