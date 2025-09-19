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

function var_0_0.openFriendBattleView(arg_11_0, arg_11_1)
	ViewMgr.instance:openView(ViewName.AutoChessFriendBattleView, arg_11_1)
end

function var_0_0.openFriendBattleRecordView(arg_12_0)
	ViewMgr.instance:openView(ViewName.AutoChessFriendBattleRecordView)
end

function var_0_0.openFriendListView(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.AutoChessFriendListView, arg_13_1)
end

function var_0_0.openAutoChessHandbook(arg_14_0, arg_14_1)
	ViewMgr.instance:openView(ViewName.AutoChessHandBookView, arg_14_1)
end

function var_0_0.openAutoChessHandbookPreviewView(arg_15_0, arg_15_1)
	ViewMgr.instance:openView(ViewName.AutoChessHandbookPreviewView, arg_15_1)
end

function var_0_0.startGame(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_3.id
	local var_16_1 = Activity182Model.instance:getActMo():getGameMo(arg_16_1, arg_16_2)

	if arg_16_2 == AutoChessEnum.ModuleId.PVE then
		if var_16_1.episodeId == var_16_0 then
			AutoChessRpc.instance:sendAutoChessEnterSceneRequest(arg_16_1, arg_16_2, var_16_0, var_16_1.selectMasterId)
		else
			arg_16_0.tempEpisodeId = var_16_0

			if var_16_1.episodeId == 0 then
				arg_16_0:startPveGame(0, 0)
			else
				GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessChangeEpisode, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, arg_16_0._yesCallback, nil, nil, arg_16_0)
			end
		end
	elseif arg_16_2 == AutoChessEnum.ModuleId.PVP2 then
		if var_16_1.episodeId == 0 then
			local var_16_2 = {
				actId = arg_16_1,
				moduleId = AutoChessEnum.ModuleId.PVP2,
				episodeId = arg_16_3.id,
				leaderId = arg_16_3.masterId
			}

			arg_16_0:openLeaderNextView(var_16_2)
		else
			AutoChessRpc.instance:sendAutoChessEnterSceneRequest(arg_16_1, arg_16_2, var_16_0, var_16_1.selectMasterId)
		end
	elseif var_16_1.episodeId == 0 then
		if #var_16_1.masterIdBox == 0 then
			Activity182Rpc.instance:sendGetAct182RandomMasterRequest(arg_16_1)
		else
			arg_16_0:openLeaderView({
				actId = arg_16_1,
				moduleId = arg_16_2
			})
		end
	else
		AutoChessRpc.instance:sendAutoChessEnterSceneRequest(arg_16_1, arg_16_2, var_16_0, var_16_1.selectMasterId)
	end
end

function var_0_0._yesCallback(arg_17_0)
	AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE, arg_17_0.startPveGame, arg_17_0)
end

function var_0_0.startPveGame(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == 0 then
		local var_18_0 = {
			moduleId = AutoChessEnum.ModuleId.PVE,
			episodeId = arg_18_0.tempEpisodeId,
			leaderId = AutoChessConfig.instance:getEpisodeCO(arg_18_0.tempEpisodeId).masterId
		}

		arg_18_0:openLeaderNextView(var_18_0)
	end

	arg_18_0.tempEpisodeId = nil
end

function var_0_0.enterGame(arg_19_0, arg_19_1, arg_19_2)
	AutoChessModel.instance:setEpisodeId(arg_19_1)
	arg_19_0:openGameView()
	arg_19_0:openMallView({
		firstEnter = arg_19_2
	})

	arg_19_0.startGameTime = ServerTime.now()
end

function var_0_0.exitGame(arg_20_0)
	arg_20_0:statExitGame()
	AutoChessModel.instance:clearData()
	ViewMgr.instance:closeView(ViewName.AutoChessMallView)
	ViewMgr.instance:closeView(ViewName.AutoChessGameView)
	AutoChessGameModel.instance:setUsingLeaderSkill(false)

	local var_20_0 = Activity182Model.instance:getCurActId()

	Activity182Rpc.instance:sendGetAct182InfoRequest(var_20_0)
end

function var_0_0.enterSingleGame(arg_21_0)
	arg_21_0:openGameView()

	arg_21_0.startGameTime = ServerTime.now()
end

function var_0_0.onResultViewClose(arg_22_0)
	AutoChessModel.instance.resultData = nil

	if AutoChessModel.instance.moduleId == AutoChessEnum.ModuleId.Friend then
		arg_22_0:exitGame()

		return
	end

	local var_22_0 = AutoChessModel.instance.settleData

	if var_22_0 then
		if var_22_0.moduleId == AutoChessEnum.ModuleId.PVE then
			if var_22_0.isFirstPass then
				ViewMgr.instance:openView(ViewName.AutoChessPveFirstSettleView)
			else
				ViewMgr.instance:openView(ViewName.AutoChessPveSettleView)
			end
		elseif var_22_0.moduleId == AutoChessEnum.ModuleId.PVP then
			ViewMgr.instance:openView(ViewName.AutoChessPvpSettleView)
		elseif var_22_0.moduleId == AutoChessEnum.ModuleId.PVP2 then
			ViewMgr.instance:openView(ViewName.AutoChessCrazySettleView)
		end
	else
		arg_22_0:openMallView()
		arg_22_0:dispatchEvent(AutoChessEvent.NextRound)
	end
end

function var_0_0.onSettleViewClose(arg_23_0)
	AutoChessModel.instance.settleData = nil

	if ViewMgr.instance:isOpen(ViewName.AutoChessGameView) then
		arg_23_0:exitGame()
	end
end

function var_0_0.checkRankUp(arg_24_0)
	local var_24_0 = Activity182Model.instance:getActMo()

	if var_24_0 and var_24_0.isRankUp then
		ViewMgr.instance:openView(ViewName.AutoChessRankUpView)
	end
end

function var_0_0.isClickDisable(arg_25_0, arg_25_1)
	return not arg_25_0:isOperationEnable(arg_25_1)
end

function var_0_0.isDragDisable(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	return not arg_26_0:isOperationEnable(arg_26_1, arg_26_2, arg_26_3)
end

function var_0_0.isRowIndexEnable(arg_27_0, arg_27_1)
	local var_27_0 = tonumber(GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessSetPlaceIndex))

	if var_27_0 == nil or var_27_0 == 0 then
		return true
	end

	local var_27_1 = var_27_0 == arg_27_1

	if var_27_1 == false then
		if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessToast) then
			local var_27_2 = GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessToast)
			local var_27_3 = tonumber(var_27_2)

			if var_27_2 ~= nil and var_27_3 ~= nil then
				GameFacade.showToast(var_27_3)
			else
				logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
				arg_27_0:showGuideToast()
			end
		else
			logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
			arg_27_0:showGuideToast()
		end
	end

	return var_27_1
end

function var_0_0.isOperationEnable(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = not GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessBanAllOper)

	if arg_28_1 == nil then
		logNormal(string.format("当前是否允许操作：%s", var_28_0))
	else
		local var_28_1 = GuideModel.instance:isFlagEnable(arg_28_1)

		if arg_28_2 ~= nil then
			arg_28_2 = tostring(arg_28_2)

			local var_28_2 = tostring(GuideModel.instance:getFlagValue(arg_28_1))

			var_28_1 = var_28_1 and var_28_2 ~= nil and var_28_2 == arg_28_2

			logNormal(string.format("当前 操作id:%s 参数：%s 是否允许操作：%s", arg_28_1, arg_28_2, var_28_1))
		else
			logNormal(string.format("当前 操作id: %s 是否允许操作：%s", arg_28_1, var_28_1))
		end

		var_28_0 = var_28_0 or var_28_1
	end

	if var_28_0 == false then
		if GuideModel.instance:isFlagEnable(GuideModel.instance.GuideFlag.AutoChessToast) then
			local var_28_3 = GuideModel.instance:getFlagValue(GuideModel.instance.GuideFlag.AutoChessToast)
			local var_28_4 = tonumber(var_28_3)

			if var_28_3 ~= nil and var_28_4 ~= nil then
				GameFacade.showToast(var_28_4)
			else
				logError("自走棋引导没有配置限定操作飘字id 弹出保底飘字")
				arg_28_0:showGuideToast()
			end
		else
			arg_28_0:showGuideToast()
		end
	end

	return var_28_0
end

function var_0_0.showGuideToast(arg_29_0)
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

function var_0_0.isEnableSale(arg_30_0)
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

function var_0_0.isEnableRefresh(arg_31_0)
	if not GuideModel.instance:isStepFinish(25409, 3) then
		GameFacade.showToast(ToastEnum.AutoChessRefreshLock)

		return false
	end

	return true
end

function var_0_0.setGuideEventFlag(arg_32_0, arg_32_1)
	arg_32_0._curRpcType = arg_32_1
end

function var_0_0.checkGuideEventFlag(arg_33_0)
	if arg_33_0._curRpcType and arg_33_0._curRpcType == AutoChessEnum.BuildType.Sell then
		arg_33_0:dispatchEvent(AutoChessEvent.ZSaleChess)
	end
end

function var_0_0.onStartFight(arg_34_0)
	if arg_34_0.startBuyTime then
		local var_34_0 = AutoChessModel.instance:getChessMo()
		local var_34_1 = ServerTime.now() - arg_34_0.startBuyTime

		StatController.instance:track(StatEnum.EventName.AutoChessFightStart, {
			[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
			[StatEnum.EventProperties.RoundNum] = var_34_0.sceneRound,
			[StatEnum.EventProperties.OurRemainingHP] = tonumber(var_34_0.svrFight.mySideMaster.hp),
			[StatEnum.EventProperties.UseTime] = var_34_1,
			[StatEnum.EventProperties.ActivityId] = tostring(AutoChessModel.instance.actId)
		})
	end

	arg_34_0.startFightTime = ServerTime.now()
end

function var_0_0.recordSkipFight(arg_35_0)
	arg_35_0.skipFight = true
end

function var_0_0.statExitGame(arg_36_0)
	local var_36_0 = AutoChessModel.instance:getChessMo()
	local var_36_1 = ServerTime.now() - arg_36_0.startGameTime

	StatController.instance:track(StatEnum.EventName.AutoChessSceneExit, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = var_36_0.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = tonumber(var_36_0.svrFight.mySideMaster.hp),
		[StatEnum.EventProperties.UseTime] = var_36_1,
		[StatEnum.EventProperties.ActivityId] = tostring(AutoChessModel.instance.actId)
	})
end

function var_0_0.statFightEnd(arg_37_0, arg_37_1)
	local var_37_0 = AutoChessModel.instance:getChessMo()
	local var_37_1 = ServerTime.now() - arg_37_0.startFightTime

	StatController.instance:track(StatEnum.EventName.AutoChessFightEnd, {
		[StatEnum.EventProperties.EpisodeId] = tostring(AutoChessModel.instance.episodeId),
		[StatEnum.EventProperties.RoundNum] = var_37_0.sceneRound,
		[StatEnum.EventProperties.OurRemainingHP] = arg_37_1,
		[StatEnum.EventProperties.SkipFight] = arg_37_0.skipFight,
		[StatEnum.EventProperties.UseTime] = var_37_1,
		[StatEnum.EventProperties.ActivityId] = tostring(AutoChessModel.instance.actId)
	})

	arg_37_0.skipFight = nil
end

function var_0_0.statButtonClick(arg_38_0, arg_38_1, arg_38_2)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = tostring(arg_38_1),
		[StatEnum.EventProperties.ButtonName] = tostring(arg_38_2)
	})
end

function var_0_0.addPopupView(arg_39_0, arg_39_1, arg_39_2)
	table.insert(arg_39_0.cachePopupViewList, 1, {
		viewName = arg_39_1,
		param = arg_39_2
	})
end

function var_0_0.popupRewardView(arg_40_0)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0.cachePopupViewList) do
		if iter_40_1.viewName == ViewName.CommonPropView then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, iter_40_1.viewName, iter_40_1.param)
		else
			PopupController.instance:addPopupView(PopupEnum.PriorityType.GainSkinView, iter_40_1.viewName, iter_40_1.param)
		end
	end

	tabletool.clear(arg_40_0.cachePopupViewList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
