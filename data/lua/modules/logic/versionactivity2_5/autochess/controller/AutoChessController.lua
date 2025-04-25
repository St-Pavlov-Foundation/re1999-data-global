module("modules.logic.versionactivity2_5.autochess.controller.AutoChessController", package.seeall)

slot0 = class("AutoChessController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.cachePopupViewList = {}
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(uv0.instance, AutoChessEvent.StartFight, slot0.onStartFight, slot0)
	slot0:addEventCb(uv0.instance, AutoChessEvent.SkipFight, slot0.recordSkipFight, slot0)
end

function slot0.openMainView(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessMainView)
end

function slot0.openLeaderView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AutoChessLeaderView, slot1)
end

function slot0.openGameView(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessGameView)
end

function slot0.openMallView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AutoChessMallView, slot1)

	slot0.startBuyTime = ServerTime.now()
end

function slot0.openResultView(slot0)
	ViewMgr.instance:openView(ViewName.AutoChessResultView)
end

function slot0.openCardInfoView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AutoChessMallInfoView, slot1)
end

function slot0.openLeaderNextView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AutoChessLeaderNextView, slot1)
end

function slot0.startGame(slot0, slot1, slot2)
	slot4 = Activity182Model.instance:getActMo().gameMoDic[slot1]

	if slot1 == AutoChessEnum.ModuleId.PVE then
		if slot4.episodeId == slot2 then
			AutoChessRpc.instance:sendAutoChessEnterSceneRequest(slot1, slot2, slot4.selectMasterId)
		else
			slot0.tempEpisodeId = slot2

			if slot4.episodeId == 0 then
				slot0:startPveGame(0, 0)
			else
				GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessChangeEpisode, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, slot0._yesCallback, nil, , slot0)
			end
		end
	elseif slot4.episodeId == 0 then
		if #slot4.masterIdBox == 0 then
			slot0.tempEpisodeId = slot2

			Activity182Rpc.instance:sendGetAct182RandomMasterRequest(Activity182Model.instance:getCurActId())
		else
			slot0:openLeaderView({
				episodeId = slot2
			})
		end
	else
		AutoChessRpc.instance:sendAutoChessEnterSceneRequest(slot1, slot2, slot4.selectMasterId)
	end
end

function slot0._yesCallback(slot0)
	AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE, slot0.startPveGame, slot0)
end

function slot0.startPveGame(slot0, slot1, slot2)
	if slot2 == 0 then
		slot0:openLeaderNextView({
			moduleId = AutoChessEnum.ModuleId.PVE,
			episodeId = slot0.tempEpisodeId,
			leaderId = lua_auto_chess_episode.configDict[slot0.tempEpisodeId].masterId
		})
	end

	slot0.tempEpisodeId = nil
end

function slot0.enterGame(slot0, slot1)
	AutoChessModel.instance:setEpisodeId(slot1)
	slot0:openGameView()
	slot0:openMallView({
		firstOpen = true
	})

	slot0.startGameTime = ServerTime.now()
end

function slot0.exitGame(slot0)
	slot0:statExitGame()

	AutoChessModel.instance.episodeId = nil

	ViewMgr.instance:closeView(ViewName.AutoChessMallView)
	ViewMgr.instance:closeView(ViewName.AutoChessGameView)
	Activity182Rpc.instance:sendGetAct182InfoRequest(Activity182Model.instance:getCurActId())
end

function slot0.onResultViewClose(slot0)
	if AutoChessModel.instance.settleData then
		if slot1.moduleId == AutoChessEnum.ModuleId.PVE then
			if slot1.isFirstPass then
				ViewMgr.instance:openView(ViewName.AutoChessPveFirstSettleView)
			else
				ViewMgr.instance:openView(ViewName.AutoChessPveSettleView)
			end
		else
			ViewMgr.instance:openView(ViewName.AutoChessPvpSettleView)
		end

		AutoChessModel.instance.resultData = nil
	else
		slot0:openMallView()
		slot0:dispatchEvent(AutoChessEvent.NextRound)
	end
end

function slot0.onSettleViewClose(slot0)
	AutoChessModel.instance.settleData = nil

	if ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		slot0:exitGame()
	end
end

function slot0.checkRankUp(slot0)
	if Activity182Model.instance:getActMo() and slot1.isRankUp then
		ViewMgr.instance:openView(ViewName.AutoChessRankUpView)
	end
end

function slot0.onSettleViewClose(slot0)
	AutoChessModel.instance.settleData = nil

	if ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		slot0:exitGame()
	end
end

function slot0.isClickDisable(slot0, slot1)
	return not slot0:isOperationEnable(slot1)
end

function slot0.isDragDisable(slot0, slot1, slot2, slot3)
	return not slot0:isOperationEnable(slot1, slot2, slot3)
end

function slot0.isRowIndexEnable(slot0, slot1)
	if tonumber(GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessSetPlaceIndex)) == nil or slot2 == 0 then
		return true
	end

	if slot2 == slot1 == false then
		if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessToast) then
			slot4 = GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessToast)
			slot5 = tonumber(slot4)

			if slot4 ~= nil and slot5 ~= nil then
				GameFacade.showToast(slot5)
			else
				logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
				slot0:showGuideToast()
			end
		else
			logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
			slot0:showGuideToast()
		end
	end

	return slot3
end

function slot0.isOperationEnable(slot0, slot1, slot2, slot3)
	if slot1 == nil then
		logNormal(string.format("当前是否允许操作：%s", not GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessBanAllOper)))
	else
		if slot2 ~= nil then
			slot2 = tostring(slot2)
			slot6 = tostring(GuideModel.instance:getFlagValue(slot1))

			logNormal(string.format("当前 操作id:%s 参数：%s 是否允许操作：%s", slot1, slot2, GuideModel.instance:isFlagEnable(slot1) and slot6 ~= nil and slot6 == slot2))
		else
			logNormal(string.format("当前 操作id: %s 是否允许操作：%s", slot1, slot5))
		end

		slot4 = slot4 or slot5
	end

	if slot4 == false then
		if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessToast) then
			slot5 = GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessToast)
			slot6 = tonumber(slot5)

			if slot5 ~= nil and slot6 ~= nil then
				GameFacade.showToast(slot6)
			else
				logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
				slot0:showGuideToast()
			end
		else
			slot0:showGuideToast()
		end
	end

	return slot4
end

function slot0.showGuideToast(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessEnableDragFreeChess) then
		GameFacade.showToast(ToastEnum.AutoChessDragFree)
	elseif GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessEnableExchangeEXP) then
		GameFacade.showToast(ToastEnum.AutoChessExchangeExp)
	elseif GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessEnableSale) then
		GameFacade.showToast(ToastEnum.AutoChessExchangeExp)
	else
		logError("未指定任何操作")
	end
end

function slot0.isEnableSale(slot0)
	if not (GuideModel.instance:isStepFinish(25405, 13) or GuideModel.instance:isGuideFinish(25406)) then
		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.AutoChessEnableSale) then
			return true
		end
	else
		return true
	end

	GameFacade.showToast(ToastEnum.AutoChessSaleLock)

	return false
end

function slot0.isEnableRefresh(slot0)
	if not GuideModel.instance:isStepFinish(25409, 3) then
		GameFacade.showToast(ToastEnum.AutoChessRefreshLock)

		return false
	end

	return true
end

function slot0.setGuideEventFlag(slot0, slot1)
	slot0._curRpcType = slot1
end

function slot0.checkGuideEventFlag(slot0)
	if slot0._curRpcType and slot0._curRpcType == AutoChessEnum.BuildType.Sell then
		slot0:dispatchEvent(AutoChessEvent.ZSaleChess)
	end
end

function slot0.onStartFight(slot0)
	slot1 = AutoChessModel.instance:getChessMo()

	StatController.instance:track(StatEnum.EventName.AutoChessFightStart, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = slot1.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = tonumber(slot1.svrFight.mySideMaster.hp),
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0.startBuyTime
	})

	slot0.startFightTime = ServerTime.now()
end

function slot0.recordSkipFight(slot0)
	slot0.skipFight = true
end

function slot0.statExitGame(slot0)
	slot1 = AutoChessModel.instance:getChessMo()

	StatController.instance:track(StatEnum.EventName.AutoChessSceneExit, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = slot1.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = tonumber(slot1.svrFight.mySideMaster.hp),
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0.startGameTime
	})
end

function slot0.statFightEnd(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.AutoChessFightEnd, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = AutoChessModel.instance:getChessMo().sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = slot1,
		[StatEnum.EventProperties.SkipFight] = slot0.skipFight,
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0.startFightTime
	})

	slot0.skipFight = nil
end

function slot0.addPopupView(slot0, slot1, slot2)
	table.insert(slot0.cachePopupViewList, 1, {
		viewName = slot1,
		param = slot2
	})
end

function slot0.popupRewardView(slot0)
	for slot4, slot5 in ipairs(slot0.cachePopupViewList) do
		if slot5.viewName == ViewName.CommonPropView then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, slot5.viewName, slot5.param)
		else
			PopupController.instance:addPopupView(PopupEnum.PriorityType.GainSkinView, slot5.viewName, slot5.param)
		end
	end

	tabletool.clear(slot0.cachePopupViewList)
end

slot0.instance = slot0.New()

return slot0
