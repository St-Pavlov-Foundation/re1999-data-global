module("modules.logic.versionactivity2_5.autochess.controller.AutoChessController", package.seeall)

local var_0_0 = class("AutoChessController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.cachePopupViewList = {}
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:addEventCb(var_0_0.instance, AutoChessEvent.StartFight, arg_3_0.onStartFight, arg_3_0)
	arg_3_0:addEventCb(var_0_0.instance, AutoChessEvent.SkipFight, arg_3_0.recordSkipFight, arg_3_0)
end

function var_0_0.openMainView(arg_4_0)
	ViewMgr.instance:openView(ViewName.AutoChessMainView)
end

function var_0_0.openLeaderView(arg_5_0, arg_5_1)
	ViewMgr.instance:openView(ViewName.AutoChessLeaderView, arg_5_1)
end

function var_0_0.openGameView(arg_6_0)
	ViewMgr.instance:openView(ViewName.AutoChessGameView)
end

function var_0_0.openMallView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.AutoChessMallView, arg_7_1)

	arg_7_0.startBuyTime = ServerTime.now()
end

function var_0_0.openResultView(arg_8_0)
	ViewMgr.instance:openView(ViewName.AutoChessResultView)
end

function var_0_0.openCardInfoView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.AutoChessMallInfoView, arg_9_1)
end

function var_0_0.openLeaderNextView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.AutoChessLeaderNextView, arg_10_1)
end

function var_0_0.startGame(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = Activity182Model.instance:getActMo().gameMoDic[arg_11_1]

	if arg_11_1 == AutoChessEnum.ModuleId.PVE then
		if var_11_0.episodeId == arg_11_2 then
			AutoChessRpc.instance:sendAutoChessEnterSceneRequest(arg_11_1, arg_11_2, var_11_0.selectMasterId)
		else
			arg_11_0.tempEpisodeId = arg_11_2

			if var_11_0.episodeId == 0 then
				arg_11_0:startPveGame(0, 0)
			else
				GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessChangeEpisode, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, arg_11_0._yesCallback, nil, nil, arg_11_0)
			end
		end
	elseif var_11_0.episodeId == 0 then
		if #var_11_0.masterIdBox == 0 then
			local var_11_1 = Activity182Model.instance:getCurActId()

			arg_11_0.tempEpisodeId = arg_11_2

			Activity182Rpc.instance:sendGetAct182RandomMasterRequest(var_11_1)
		else
			arg_11_0:openLeaderView({
				episodeId = arg_11_2
			})
		end
	else
		AutoChessRpc.instance:sendAutoChessEnterSceneRequest(arg_11_1, arg_11_2, var_11_0.selectMasterId)
	end
end

function var_0_0._yesCallback(arg_12_0)
	AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE, arg_12_0.startPveGame, arg_12_0)
end

function var_0_0.startPveGame(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == 0 then
		local var_13_0 = {
			moduleId = AutoChessEnum.ModuleId.PVE,
			episodeId = arg_13_0.tempEpisodeId,
			leaderId = lua_auto_chess_episode.configDict[arg_13_0.tempEpisodeId].masterId
		}

		arg_13_0:openLeaderNextView(var_13_0)
	end

	arg_13_0.tempEpisodeId = nil
end

function var_0_0.enterGame(arg_14_0, arg_14_1)
	AutoChessModel.instance:setEpisodeId(arg_14_1)
	arg_14_0:openGameView()
	arg_14_0:openMallView({
		firstOpen = true
	})

	arg_14_0.startGameTime = ServerTime.now()
end

function var_0_0.exitGame(arg_15_0)
	arg_15_0:statExitGame()

	AutoChessModel.instance.episodeId = nil

	ViewMgr.instance:closeView(ViewName.AutoChessMallView)
	ViewMgr.instance:closeView(ViewName.AutoChessGameView)

	local var_15_0 = Activity182Model.instance:getCurActId()

	Activity182Rpc.instance:sendGetAct182InfoRequest(var_15_0)
end

function var_0_0.onResultViewClose(arg_16_0)
	local var_16_0 = AutoChessModel.instance.settleData

	if var_16_0 then
		if var_16_0.moduleId == AutoChessEnum.ModuleId.PVE then
			if var_16_0.isFirstPass then
				ViewMgr.instance:openView(ViewName.AutoChessPveFirstSettleView)
			else
				ViewMgr.instance:openView(ViewName.AutoChessPveSettleView)
			end
		else
			ViewMgr.instance:openView(ViewName.AutoChessPvpSettleView)
		end

		AutoChessModel.instance.resultData = nil
	else
		arg_16_0:openMallView()
		arg_16_0:dispatchEvent(AutoChessEvent.NextRound)
	end
end

function var_0_0.onSettleViewClose(arg_17_0)
	AutoChessModel.instance.settleData = nil

	if ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		arg_17_0:exitGame()
	end
end

function var_0_0.checkRankUp(arg_18_0)
	local var_18_0 = Activity182Model.instance:getActMo()

	if var_18_0 and var_18_0.isRankUp then
		ViewMgr.instance:openView(ViewName.AutoChessRankUpView)
	end
end

function var_0_0.onSettleViewClose(arg_19_0)
	AutoChessModel.instance.settleData = nil

	if ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		arg_19_0:exitGame()
	end
end

function var_0_0.isClickDisable(arg_20_0, arg_20_1)
	return not arg_20_0:isOperationEnable(arg_20_1)
end

function var_0_0.isDragDisable(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	return not arg_21_0:isOperationEnable(arg_21_1, arg_21_2, arg_21_3)
end

function var_0_0.isRowIndexEnable(arg_22_0, arg_22_1)
	local var_22_0 = tonumber(GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessSetPlaceIndex))

	if var_22_0 == nil or var_22_0 == 0 then
		return true
	end

	local var_22_1 = var_22_0 == arg_22_1

	if var_22_1 == false then
		if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessToast) then
			local var_22_2 = GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessToast)
			local var_22_3 = tonumber(var_22_2)

			if var_22_2 ~= nil and var_22_3 ~= nil then
				GameFacade.showToast(var_22_3)
			else
				logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
				arg_22_0:showGuideToast()
			end
		else
			logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
			arg_22_0:showGuideToast()
		end
	end

	return var_22_1
end

function var_0_0.isOperationEnable(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = not GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessBanAllOper)

	if arg_23_1 == nil then
		logNormal(string.format("当前是否允许操作：%s", var_23_0))
	else
		local var_23_1 = GuideModel.instance:isFlagEnable(arg_23_1)

		if arg_23_2 ~= nil then
			arg_23_2 = tostring(arg_23_2)

			local var_23_2 = tostring(GuideModel.instance:getFlagValue(arg_23_1))

			var_23_1 = var_23_1 and var_23_2 ~= nil and var_23_2 == arg_23_2

			logNormal(string.format("当前 操作id:%s 参数：%s 是否允许操作：%s", arg_23_1, arg_23_2, var_23_1))
		else
			logNormal(string.format("当前 操作id: %s 是否允许操作：%s", arg_23_1, var_23_1))
		end

		var_23_0 = var_23_0 or var_23_1
	end

	if var_23_0 == false then
		if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessToast) then
			local var_23_3 = GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessToast)
			local var_23_4 = tonumber(var_23_3)

			if var_23_3 ~= nil and var_23_4 ~= nil then
				GameFacade.showToast(var_23_4)
			else
				logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
				arg_23_0:showGuideToast()
			end
		else
			arg_23_0:showGuideToast()
		end
	end

	return var_23_0
end

function var_0_0.showGuideToast(arg_24_0)
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

function var_0_0.isEnableSale(arg_25_0)
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

function var_0_0.isEnableRefresh(arg_26_0)
	if not GuideModel.instance:isStepFinish(25409, 3) then
		GameFacade.showToast(ToastEnum.AutoChessRefreshLock)

		return false
	end

	return true
end

function var_0_0.setGuideEventFlag(arg_27_0, arg_27_1)
	arg_27_0._curRpcType = arg_27_1
end

function var_0_0.checkGuideEventFlag(arg_28_0)
	if arg_28_0._curRpcType and arg_28_0._curRpcType == AutoChessEnum.BuildType.Sell then
		arg_28_0:dispatchEvent(AutoChessEvent.ZSaleChess)
	end
end

function var_0_0.onStartFight(arg_29_0)
	local var_29_0 = AutoChessModel.instance:getChessMo()
	local var_29_1 = ServerTime.now() - arg_29_0.startBuyTime

	StatController.instance:track(StatEnum.EventName.AutoChessFightStart, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = var_29_0.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = tonumber(var_29_0.svrFight.mySideMaster.hp),
		[StatEnum.EventProperties.UseTime] = var_29_1
	})

	arg_29_0.startFightTime = ServerTime.now()
end

function var_0_0.recordSkipFight(arg_30_0)
	arg_30_0.skipFight = true
end

function var_0_0.statExitGame(arg_31_0)
	local var_31_0 = AutoChessModel.instance:getChessMo()
	local var_31_1 = ServerTime.now() - arg_31_0.startGameTime

	StatController.instance:track(StatEnum.EventName.AutoChessSceneExit, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = var_31_0.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = tonumber(var_31_0.svrFight.mySideMaster.hp),
		[StatEnum.EventProperties.UseTime] = var_31_1
	})
end

function var_0_0.statFightEnd(arg_32_0, arg_32_1)
	local var_32_0 = AutoChessModel.instance:getChessMo()
	local var_32_1 = ServerTime.now() - arg_32_0.startFightTime

	StatController.instance:track(StatEnum.EventName.AutoChessFightEnd, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = var_32_0.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = arg_32_1,
		[StatEnum.EventProperties.SkipFight] = arg_32_0.skipFight,
		[StatEnum.EventProperties.UseTime] = var_32_1
	})

	arg_32_0.skipFight = nil
end

function var_0_0.addPopupView(arg_33_0, arg_33_1, arg_33_2)
	table.insert(arg_33_0.cachePopupViewList, 1, {
		viewName = arg_33_1,
		param = arg_33_2
	})
end

function var_0_0.popupRewardView(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0.cachePopupViewList) do
		if iter_34_1.viewName == ViewName.CommonPropView then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, iter_34_1.viewName, iter_34_1.param)
		else
			PopupController.instance:addPopupView(PopupEnum.PriorityType.GainSkinView, iter_34_1.viewName, iter_34_1.param)
		end
	end

	tabletool.clear(arg_34_0.cachePopupViewList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
