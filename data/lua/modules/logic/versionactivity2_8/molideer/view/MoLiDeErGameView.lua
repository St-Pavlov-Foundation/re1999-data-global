module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErGameView", package.seeall)

local var_0_0 = class("MoLiDeErGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocameraMain = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain")
	arg_1_0._simageBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/#simage_BG")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Target/TargetList/#go_target")
	arg_1_0._gotarget2 = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Target/TargetList/#go_target2")
	arg_1_0._gotarget3 = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Target/TargetList/#go_target3")
	arg_1_0._txtTarget = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/Target/TargetList/#go_target/#txt_Target")
	arg_1_0._goTurnsBG = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/#go_TurnsBG")
	arg_1_0._txtTurns = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	arg_1_0._txtTurns1 = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns1")
	arg_1_0._goeventMap = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap")
	arg_1_0._goeventItem = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem")
	arg_1_0._goPoint = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/#go_Point")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/#simage_Icon")
	arg_1_0._goStar = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/#go_Star")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/#txt_Num")
	arg_1_0._simageHead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/Dispatch/image_HeadBG/image/#simage_Head")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_eventMap/#go_eventItem/Dispatch/#txt_Time")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/Layout/#btn_Reset")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/Layout/#btn_Skip")
	arg_1_0._btnNextBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/#btn_NextBtn")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._gowarehouseInfo = gohelper.findChild(arg_1_0.viewGO, "#go_warehouseInfo")
	arg_1_0._scrollDetail = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_warehouseInfo/#scroll_Detail")
	arg_1_0._goescaperulecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_warehouseInfo/#scroll_Detail/Viewport/Content/#go_escaperulecontainer")
	arg_1_0._goItemList = gohelper.findChild(arg_1_0.viewGO, "#go_warehouseInfo/#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_warehouseInfo/#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList/#go_item")
	arg_1_0._txtCount = gohelper.findChildText(arg_1_0.viewGO, "#go_warehouseInfo/#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList/#go_item/image_icon/image_Count/#txt_Count")
	arg_1_0._goLineParent = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/Line")
	arg_1_0._goLineVirtual = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/Line/#go_Line1")
	arg_1_0._goLineSolid = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/Line/#go_Line2")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_Tips")
	arg_1_0._goTargetFx = gohelper.findChild(arg_1_0.viewGO, "#go_hpFlyItem_energy")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._btnResetOnClick, arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0._btnSkipOnClick, arg_2_0)
	arg_2_0._btnNextBtn:AddClickListener(arg_2_0._btnNextBtnOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.BeforeOpenView, arg_2_0.onViewOpen, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0.onViewClose, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameReset, arg_2_0.onGameReset, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameExit, arg_2_0.onGameExit, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameSkip, arg_2_0.onGameSkip, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameEventSelect, arg_2_0.onEventChange, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameUIRefresh, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameTipRecycle, arg_2_0.recycleToast, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReset:RemoveClickListener()
	arg_3_0._btnSkip:RemoveClickListener()
	arg_3_0._btnNextBtn:RemoveClickListener()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.BeforeOpenView, arg_3_0.onViewOpen, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0.onViewClose, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, ViewEvent.OnCloseView, arg_3_0.onViewClose, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameReset, arg_3_0.onGameReset, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameExit, arg_3_0.onGameExit, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameSkip, arg_3_0.onGameSkip, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameEventSelect, arg_3_0.onEventChange, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameUIRefresh, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameTipRecycle, arg_3_0.recycleToast, arg_3_0)
end

function var_0_0._btnNextBtnOnClick(arg_4_0)
	local var_4_0 = MoLiDeErModel.instance:getCurActId()
	local var_4_1 = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameController.instance:nextRound(var_4_0, var_4_1)
end

function var_0_0._btnResetOnClick(arg_5_0)
	MoLiDeErGameController.instance:resetGame()
end

function var_0_0._btnSkipOnClick(arg_6_0)
	MoLiDeErGameController.instance:skipGame()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._targetItemList = {}
	arg_7_0._targetResultItemList = {}
	arg_7_0._eventItemList = {}

	if arg_7_0._dispatchItem == nil then
		local var_7_0 = arg_7_0.viewContainer._viewSetting.otherRes[1]
		local var_7_1 = arg_7_0:getResInst(var_7_0, arg_7_0.viewGO)

		arg_7_0._dispatchItem, arg_7_0._goDispatch = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, MoLiDeErDispatchItem), var_7_1
	end

	gohelper.setActive(arg_7_0._goeventItem, false)
	gohelper.setActive(arg_7_0._gotarget, false)
	gohelper.setActive(arg_7_0._goLineVirtual, false)
	gohelper.setActive(arg_7_0._goLineSolid, false)

	arg_7_0._unUseLineSolidList = {}
	arg_7_0._useLineSolidList = {}
	arg_7_0._tweenIdList = {}
	arg_7_0._titleAnimator = gohelper.findChildComponent(arg_7_0.viewGO, "#go_cameraMain/Middle/Title", gohelper.Type_Animator)
	arg_7_0._goTipsParent = arg_7_0._goTips.transform.parent.gameObject

	gohelper.setActive(arg_7_0._goTips, false)

	arg_7_0._unUsedTipsItem = {}
	arg_7_0._usedTipsItem = {}
	arg_7_0._cacheMsgList = {}
	arg_7_0._maxCount = 4
	arg_7_0._showNextToastInterval = 0.1
	arg_7_0._unUseTargetFxList = {}
	arg_7_0._useTargetFxList = {}
	arg_7_0._targetFxTweenList = {}
	arg_7_0._targetProgressFxDic = {}
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._actId = MoLiDeErModel.instance:getCurActId()
	arg_9_0._episodeId = MoLiDeErModel.instance:getCurEpisodeId()
	arg_9_0._episodeConfig = MoLiDeErModel.instance:getCurEpisode()
	arg_9_0._gameConfig = MoLiDeErGameModel.instance:getCurGameConfig()

	MoLiDeErController.instance:statGameStart(arg_9_0._actId, arg_9_0._episodeId)
	arg_9_0:refreshUI(false)
end

function var_0_0.refreshUI(arg_10_0, arg_10_1)
	logNormal("莫莉德尔 角色活动 刷新主界面")

	local var_10_0 = MoLiDeErGameModel.instance:getGameInfo(arg_10_0._actId, arg_10_0._episodeId)

	arg_10_0._infoMo = var_10_0

	local var_10_1 = var_10_0.newFinishEventList
	local var_10_2 = var_10_0.newEventList
	local var_10_3 = not arg_10_1 and (var_10_1 and var_10_1[1] or var_10_2 ~= nil and var_10_2[1])
	local var_10_4 = var_10_0.isEpisodeFinish and var_10_0.passStar ~= 0

	arg_10_0._isEpisodeEnd = var_10_4

	local var_10_5 = var_10_3 and var_10_0.existEventList or var_10_0.eventInfos

	arg_10_0:refreshState()
	arg_10_0:refreshExistEvent(var_10_5)

	if not var_10_3 then
		arg_10_0:delayShowInfo()

		if var_10_4 then
			arg_10_0:_lockScreen(true, MoLiDeErEnum.DelayTime.BlackScreenTime3)
		end

		arg_10_0:checkTargetProgressFx()
	else
		arg_10_0:refreshFinishEvent()
	end
end

function var_0_0.delayShowInfo(arg_11_0)
	logNormal("莫莉德尔 角色活动 刷新信息")
	arg_11_0:refreshInfo()
	arg_11_0:refreshTeam()
end

function var_0_0.refreshState(arg_12_0)
	local var_12_0 = MoLiDeErModel.instance:getCurEpisodeInfo()

	gohelper.setActive(arg_12_0._btnSkip, var_12_0.passCount > 0)
end

function var_0_0.refreshInfo(arg_13_0)
	local var_13_0 = arg_13_0._infoMo
	local var_13_1 = var_13_0.currentRound
	local var_13_2 = var_13_0.previousRound
	local var_13_3 = var_13_2 and var_13_2 < var_13_1
	local var_13_4 = arg_13_0._gameConfig
	local var_13_5 = string.splitToNumber(var_13_4.winCondition, "#")
	local var_13_6 = var_13_5[1]
	local var_13_7

	if var_13_6 == MoLiDeErEnum.TargetType.RoundFinishAll or var_13_6 == MoLiDeErEnum.TargetType.RoundFinishAny then
		var_13_7 = MoLiDeErHelper.getRealRound(var_13_5[2], true)
	end

	if var_13_3 then
		arg_13_0._txtTurns.text = MoLiDeErHelper.getGameRoundTitleDesc(var_13_2, var_13_7)
		arg_13_0._txtTurns1.text = MoLiDeErHelper.getGameRoundTitleDesc(var_13_2, var_13_7)
	else
		arg_13_0._txtTurns.text = MoLiDeErHelper.getGameRoundTitleDesc(var_13_1, var_13_7)
	end

	local var_13_8 = var_13_3 and MoLiDeErEnum.AnimName.GameViewEventTitleCount or MoLiDeErEnum.AnimName.GameViewEventTitleIdle

	if var_13_3 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_mln_no_effect)
	end

	arg_13_0._titleAnimator:Play(var_13_8, 0, 0)
	TaskDispatcher.cancelTask(arg_13_0.onTitleCountTimeEnd, arg_13_0)
	TaskDispatcher.runDelay(arg_13_0.onTitleCountTimeEnd, arg_13_0, 0.167)

	local var_13_9 = {}

	if var_13_0.newGetTeam and var_13_0.newGetTeam[1] then
		for iter_13_0, iter_13_1 in ipairs(var_13_0.newGetTeam) do
			local var_13_10 = MoLiDeErConfig.instance:getTeamConfig(iter_13_1)
			local var_13_11 = luaLang("molideer_team_add_tips")
			local var_13_12 = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_11, var_13_10.name)

			table.insert(var_13_9, var_13_12)
		end
	end

	if var_13_0.newGetItem and var_13_0.newGetItem[1] then
		for iter_13_2, iter_13_3 in ipairs(var_13_0.newGetItem) do
			local var_13_13 = MoLiDeErConfig.instance:getItemConfig(iter_13_3)
			local var_13_14 = luaLang("molideer_item_add_tips")
			local var_13_15 = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_14, var_13_13.name)

			table.insert(var_13_9, var_13_15)
		end
	end

	local var_13_16 = var_13_0.leftRoundEnergy
	local var_13_17 = var_13_0.previousRoundEnergy

	if var_13_17 and var_13_16 ~= var_13_17 then
		local var_13_18 = luaLang("molideer_execution_change_tips")
		local var_13_19 = MoLiDeErHelper.getExecutionCostStr(var_13_16 - var_13_17)
		local var_13_20 = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_18, var_13_19)

		table.insert(var_13_9, var_13_20)
	end

	for iter_13_4, iter_13_5 in ipairs(var_13_9) do
		arg_13_0:addTitleTips(iter_13_5)
	end
end

function var_0_0.onTitleCountTimeEnd(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.onTitleCountTimeEnd, arg_14_0)

	local var_14_0 = arg_14_0._infoMo.currentRound
	local var_14_1 = arg_14_0._gameConfig
	local var_14_2 = string.splitToNumber(var_14_1.winCondition, "#")
	local var_14_3 = var_14_2[1]
	local var_14_4

	if var_14_3 == MoLiDeErEnum.TargetType.RoundFinishAll or var_14_3 == MoLiDeErEnum.TargetType.RoundFinishAny then
		var_14_4 = MoLiDeErHelper.getRealRound(var_14_2[2], true)
	end

	arg_14_0._txtTurns.text = MoLiDeErHelper.getGameRoundTitleDesc(var_14_0, var_14_4)
end

function var_0_0.checkTargetProgressFx(arg_15_0)
	local var_15_0 = MoLiDeErGameModel.instance:getCurGameInfo()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._targetFxTweenList) do
		ZProj.TweenHelper.KillById(iter_15_1, true)
	end

	local var_15_2 = 0
	local var_15_3 = {}

	TaskDispatcher.cancelTask(arg_15_0.onTargetFxAllShowEnd, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.onTargetProgressAddFxShowEnd, arg_15_0)

	if var_15_0.newFinishEventList and var_15_0.newFinishEventList[1] then
		for iter_15_2, iter_15_3 in ipairs(var_15_0.newFinishEventList) do
			local var_15_4 = iter_15_3.optionId
			local var_15_5 = MoLiDeErConfig.instance:getProgressConfig(var_15_4)

			if var_15_5 ~= nil then
				local var_15_6 = string.split(var_15_5.condition, "|")
				local var_15_7 = MoLiDeErConfig.instance:getEventConfig(iter_15_3.finishedEventId)

				for iter_15_4, iter_15_5 in ipairs(var_15_6) do
					local var_15_8 = string.splitToNumber(iter_15_5, "#")

					if var_15_8[1] == var_15_0.gameId then
						local var_15_9 = var_15_8[2]
						local var_15_10 = var_15_0:getTargetProgress(var_15_9)

						if MoLiDeErHelper.getTargetState(var_15_10) ~= MoLiDeErEnum.ProgressChangeType.Failed then
							local var_15_11 = arg_15_0._targetItemList[var_15_9]:getFxTargetTran()
							local var_15_12 = arg_15_0:getOrReturnTargetFxLine()
							local var_15_13 = string.splitToNumber(var_15_7.position, "#")

							transformhelper.setLocalPosXY(var_15_12.transform, var_15_13[1], var_15_13[2])

							local var_15_14, var_15_15 = recthelper.rectToRelativeAnchorPos2(var_15_11.position, arg_15_0._goeventMap.transform)
							local var_15_16 = math.atan2(var_15_13[2] - var_15_15, var_15_13[1] - var_15_14) * (180 / math.pi)

							transformhelper.setEulerAngles(var_15_12.transform, 0, 0, var_15_16)

							local var_15_17 = {
								fxGo = var_15_12
							}
							local var_15_18 = ZProj.TweenHelper.DOLocalMove(var_15_12.transform, var_15_14, var_15_15, 0, MoLiDeErEnum.DelayTime.TargetFxMove, arg_15_0.onTargetFxTweenEnd, arg_15_0, var_15_17)

							table.insert(var_15_1, var_15_18)

							var_15_2 = var_15_2 + 1
						end

						var_15_3[var_15_9] = true
					end
				end
			end
		end
	end

	arg_15_0._targetFxTweenList = var_15_1
	arg_15_0._targetProgressFxDic = var_15_3
	arg_15_0._targetProgressFxCount = var_15_2

	if var_15_2 > 0 then
		TaskDispatcher.runDelay(arg_15_0.onTargetFxAllShowEnd, arg_15_0, MoLiDeErEnum.DelayTime.TargetFxMove)
	else
		arg_15_0:onTargetFxAllShowEnd()
	end
end

function var_0_0.onTargetFxTweenEnd(arg_16_0, arg_16_1)
	arg_16_0:getOrReturnTargetFxLine(arg_16_1.fxGo)
end

function var_0_0.onTargetFxAllShowEnd(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.onTargetFxAllShowEnd, arg_17_0)

	if arg_17_0._targetProgressFxCount > 0 then
		arg_17_0:refreshTarget(true)
		TaskDispatcher.runDelay(arg_17_0.onTargetProgressAddFxShowEnd, arg_17_0, MoLiDeErEnum.DelayTime.TargetFxProgressAdd)
	else
		arg_17_0:onTargetProgressAddFxShowEnd()
	end
end

function var_0_0.onTargetProgressAddFxShowEnd(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.onTargetProgressAddFxShowEnd, arg_18_0)
	arg_18_0:refreshTarget()
	arg_18_0:checkGameOver()
end

function var_0_0.checkGameOver(arg_19_0)
	local var_19_0 = arg_19_0._infoMo

	if var_19_0.isEpisodeFinish and var_19_0.passStar ~= 0 then
		TaskDispatcher.runDelay(arg_19_0.onGameOver, arg_19_0, 1)
	end
end

function var_0_0.onGameOver(arg_20_0)
	arg_20_0:_lockScreen(false)
	TaskDispatcher.cancelTask(arg_20_0.onGameOver, arg_20_0)
	ViewMgr.instance:openView(ViewName.MoLiDeErResultView)
end

function var_0_0.refreshTarget(arg_21_0, arg_21_1)
	local var_21_0 = MoLiDeErGameModel.instance:getCurGameInfo()
	local var_21_1 = {
		MoLiDeErEnum.TargetId.Main,
		MoLiDeErEnum.TargetId.Extra
	}
	local var_21_2 = arg_21_0._gameConfig
	local var_21_3 = arg_21_0._targetItemList
	local var_21_4 = arg_21_0._targetResultItemList
	local var_21_5 = 0
	local var_21_6 = 0
	local var_21_7 = #var_21_4
	local var_21_8 = #var_21_3
	local var_21_9 = arg_21_0._gotarget.transform.parent.gameObject

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		local var_21_10 = var_21_0:getTargetProgress(iter_21_1)
		local var_21_11 = MoLiDeErHelper.getTargetState(var_21_10)
		local var_21_12
		local var_21_13 = false

		if var_21_11 == MoLiDeErEnum.ProgressChangeType.Percentage or arg_21_1 and var_21_0:isNewCompleteTarget(iter_21_1) then
			var_21_6 = var_21_6 + 1

			if var_21_8 < var_21_6 then
				local var_21_14 = gohelper.clone(arg_21_0._gotarget2, var_21_9)

				var_21_12 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_14, MoLiDeErTargetItem)

				table.insert(var_21_3, var_21_12)
			else
				var_21_12 = var_21_3[var_21_6]
			end

			var_21_13 = arg_21_0._targetProgressFxDic[iter_21_1] == true and arg_21_1
		else
			var_21_5 = var_21_5 + 1

			if var_21_7 < var_21_5 then
				local var_21_15 = gohelper.clone(arg_21_0._gotarget3, var_21_9)

				var_21_12 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_15, MoLiDeErTargetResultItem)

				table.insert(var_21_4, var_21_12)
			else
				var_21_12 = var_21_4[var_21_5]
			end

			var_21_13 = var_21_0:isNewCompleteTarget(iter_21_1) or var_21_0:isNewFailTarget(iter_21_1)
		end

		local var_21_16 = iter_21_1 == MoLiDeErEnum.TargetId.Main and var_21_2.winConditionStr or var_21_2.extraConditionStr
		local var_21_17 = iter_21_1 == MoLiDeErEnum.TargetId.Main and var_21_2.winCondition or var_21_2.extraCondition

		var_21_12:setActive(true)
		var_21_12:refreshUI(var_21_16, var_21_17, iter_21_1, var_21_0, var_21_13)
	end

	if var_21_6 < var_21_8 then
		for iter_21_2 = var_21_6 + 1, var_21_8 do
			var_21_3[iter_21_2]:setActive(false)
		end
	end

	if var_21_5 < var_21_7 then
		for iter_21_3 = var_21_5 + 1, var_21_7 do
			var_21_4[iter_21_3]:setActive(false)
		end
	end
end

function var_0_0.refreshExistEvent(arg_22_0, arg_22_1)
	local var_22_0 = #arg_22_1
	local var_22_1 = arg_22_0._eventItemList
	local var_22_2 = #var_22_1
	local var_22_3 = MoLiDeErGameModel.instance:getCurRound()
	local var_22_4 = 0

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_5

		if var_22_2 < iter_22_0 then
			local var_22_6 = gohelper.clone(arg_22_0._goeventItem, arg_22_0._goeventMap)

			var_22_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_6, MoLiDeErEventItem)

			table.insert(var_22_1, var_22_5)
		else
			var_22_5 = var_22_1[iter_22_0]
		end

		var_22_5:setActive(true)

		local var_22_7 = arg_22_0:checkTeamDispatchState(iter_22_1.eventId)
		local var_22_8 = var_22_7 ~= MoLiDeErEnum.TeamDispatchState.Dispatching

		if var_22_7 == MoLiDeErEnum.TeamDispatchState.Dispatch then
			var_22_4 = var_22_4 + 1
		end

		var_22_5:setData(iter_22_1.eventId, iter_22_1.isChose, iter_22_1.eventEndRound, var_22_3, iter_22_1.teamId, var_22_8)
		MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GuideNewEvent, iter_22_1.eventId)
	end

	if var_22_4 > 0 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_leimi_decrypt_correct)
	end

	arg_22_0._existItemCount = var_22_0

	if var_22_0 < var_22_2 then
		for iter_22_2 = var_22_0 + 1, var_22_2 do
			local var_22_9 = var_22_1[iter_22_2]

			if var_22_9 == nil then
				logError(string.format("索引越界 itemCount :%s  index: %s", iter_22_2, tostring(#var_22_1)))
			else
				var_22_9:setActive(false)
			end
		end
	end
end

function var_0_0.refreshFinishEvent(arg_23_0)
	arg_23_0:_lockScreen(true, MoLiDeErEnum.DelayTime.BlackScreenTime)

	local var_23_0 = arg_23_0._infoMo.newFinishEventList
	local var_23_1 = 0

	if var_23_0 and #var_23_0 > 0 then
		local var_23_2 = arg_23_0._eventItemList
		local var_23_3 = #var_23_2
		local var_23_4 = MoLiDeErGameModel.instance:getCurRound()

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			local var_23_5 = iter_23_1.finishedEventId

			if var_23_5 ~= nil and var_23_5 ~= 0 then
				var_23_1 = var_23_1 + 1

				local var_23_6
				local var_23_7 = var_23_1 + arg_23_0._existItemCount

				if var_23_3 < var_23_7 then
					local var_23_8 = gohelper.clone(arg_23_0._goeventItem, arg_23_0._goeventMap)

					var_23_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_23_8, MoLiDeErEventItem)

					table.insert(var_23_2, var_23_6)
				else
					var_23_6 = var_23_2[var_23_7]
				end

				var_23_6:setActive(true)
				var_23_6:setData(var_23_5, false, var_23_4, var_23_4, nil)
				var_23_6:showAnim(MoLiDeErEnum.AnimName.GameViewEventItemFinish, true)
				arg_23_0:checkTeamDispatchState(var_23_5)
			end
		end
	end

	arg_23_0._finishItemCount = var_23_1

	if var_23_1 > 0 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_yuzhou_level_lit)
		TaskDispatcher.runDelay(arg_23_0.onFinishTaskShowTimeEnd, arg_23_0, MoLiDeErEnum.DelayTime.FinishEventShow)
	else
		arg_23_0:onFinishTaskShowTimeEnd()
	end
end

function var_0_0.onFinishTaskShowTimeEnd(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.onFinishTaskShowTimeEnd, arg_24_0)

	if arg_24_0._finishItemCount > 0 then
		arg_24_0:_lockScreen(false)
		MoLiDeErGameController.instance:showFinishEvent()
		logNormal("莫莉德尔 角色活动 事件角色动画播放完毕")
		arg_24_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameFinishEventShowEnd, arg_24_0.onFinishEventShowEnd, arg_24_0)
	else
		arg_24_0:onFinishEventViewShowEnd()
	end
end

function var_0_0.onFinishEventShowEnd(arg_25_0)
	arg_25_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameFinishEventShowEnd, arg_25_0.onFinishEventShowEnd, arg_25_0)

	if arg_25_0._finishItemCount > 0 then
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_molu_arm_repair)

		local var_25_0 = arg_25_0._eventItemList
		local var_25_1 = arg_25_0._existItemCount + 1
		local var_25_2 = var_25_1 + arg_25_0._finishItemCount - 1

		for iter_25_0 = var_25_1, var_25_2 do
			local var_25_3 = var_25_0[iter_25_0]

			if var_25_3 == nil then
				logError(string.format("索引越界 index:%s itemCount :%s  existCount: %s finishItemCount : %s", iter_25_0, tostring(#var_25_0), arg_25_0._existItemCount, arg_25_0._finishItemCount))
			else
				var_25_3:showAnim(MoLiDeErEnum.AnimName.GameViewEventItemClose, true)
			end
		end
	end

	arg_25_0:onFinishEventViewShowEnd()
end

function var_0_0.onFinishEventViewShowEnd(arg_26_0)
	local var_26_0 = arg_26_0._infoMo
	local var_26_1 = arg_26_0._isEpisodeEnd
	local var_26_2 = var_26_1 and MoLiDeErEnum.DelayTime.BlackScreenTime3 or MoLiDeErEnum.DelayTime.BlackScreenTime2

	arg_26_0:_lockScreen(true, var_26_2)
	arg_26_0:delayShowInfo()
	arg_26_0:checkTargetProgressFx()

	if var_26_1 then
		local var_26_3 = arg_26_0._eventItemList
		local var_26_4 = arg_26_0._existItemCount + 1
		local var_26_5 = var_26_4 + arg_26_0._finishItemCount - 1

		for iter_26_0 = var_26_4, var_26_5 do
			local var_26_6 = var_26_3[iter_26_0]

			if var_26_6 == nil then
				logError(string.format("索引越界 index:%s itemCount :%s  existCount: %s finishItemCount : %s", iter_26_0, tostring(#var_26_3), arg_26_0._existItemCount, arg_26_0._finishItemCount))
			else
				var_26_6:setActive(false)
			end
		end

		return
	end

	local var_26_7 = 0
	local var_26_8 = 0
	local var_26_9 = var_26_0.newEventList

	if #var_26_9 > 0 then
		for iter_26_1, iter_26_2 in ipairs(var_26_9) do
			local var_26_10 = iter_26_2.preEventId

			if var_26_10 and var_26_10 ~= 0 then
				var_26_7 = var_26_7 + 1

				local var_26_11 = MoLiDeErConfig.instance:getEventConfig(var_26_10)
				local var_26_12 = MoLiDeErConfig.instance:getEventConfig(iter_26_2.eventId)
				local var_26_13 = string.splitToNumber(var_26_11.position, "#")
				local var_26_14 = string.splitToNumber(var_26_12.position, "#")

				if not MoLiDeErHelper.checkIsInSamePosition(var_26_13, var_26_14) then
					logNormal("莫莉德尔 角色活动 显示延展路线效果 前置id: " .. tostring(var_26_10) .. "新事件id:" .. tostring(iter_26_2.eventId))
					arg_26_0:doEventLineTween(var_26_13, var_26_14)

					var_26_8 = var_26_8 + 1
				end
			end
		end
	end

	if var_26_7 > 0 then
		TaskDispatcher.runDelay(arg_26_0.onNewTaskLineShowTimeEnd, arg_26_0, MoLiDeErEnum.DelayTime.NewEventShow)

		if var_26_8 > 0 then
			AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_fuleyuan_lines_extend)
		end
	elseif arg_26_0._finishItemCount > 0 then
		TaskDispatcher.runDelay(arg_26_0.onNewTaskLineShowTimeEnd, arg_26_0, MoLiDeErEnum.DelayTime.Close)
	else
		arg_26_0:onNewTaskLineShowTimeEnd()
	end
end

function var_0_0.onNewTaskLineShowTimeEnd(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0.onNewTaskLineShowTimeEnd, arg_27_0)

	local var_27_0 = arg_27_0._eventItemList
	local var_27_1 = #var_27_0
	local var_27_2 = arg_27_0._existItemCount + 1
	local var_27_3 = var_27_2 + arg_27_0._finishItemCount - 1
	local var_27_4 = MoLiDeErGameModel.instance:getCurRound()

	for iter_27_0 = var_27_2, var_27_3 do
		local var_27_5 = var_27_0[iter_27_0]

		if var_27_5 == nil then
			logError(string.format("索引越界 index:%s itemCount :%s  existCount: %s finishItemCount : %s", iter_27_0, tostring(#var_27_0), arg_27_0._existItemCount, arg_27_0._finishItemCount))
		else
			var_27_5:setActive(false)
		end
	end

	local var_27_6 = arg_27_0._infoMo.newEventList

	if var_27_6 and var_27_6[1] then
		for iter_27_1, iter_27_2 in ipairs(var_27_6) do
			local var_27_7
			local var_27_8 = iter_27_1 + arg_27_0._existItemCount + arg_27_0._finishItemCount

			if var_27_1 < var_27_8 then
				local var_27_9 = gohelper.clone(arg_27_0._goeventItem, arg_27_0._goeventMap)

				var_27_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_27_9, MoLiDeErEventItem)

				table.insert(var_27_0, var_27_7)
			else
				var_27_7 = var_27_0[var_27_8]
			end

			var_27_7:setActive(true)
			var_27_7:setAtFirst()
			var_27_7:setData(iter_27_2.eventId, iter_27_2.isChose, iter_27_2.eventEndRound, var_27_4, iter_27_2.teamId)
			var_27_7:showAnim(MoLiDeErEnum.AnimName.GameViewEventItemOpen, true)
			MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GuideNewEvent, iter_27_2.eventId)
		end

		TaskDispatcher.runDelay(arg_27_0.onNewTaskShowTimeEnd, arg_27_0, MoLiDeErEnum.DelayTime.BlackEnd)
		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_fuleyuan_newlevels_unlock)
	else
		arg_27_0:onNewTaskShowTimeEnd()
	end
end

function var_0_0.onNewTaskShowTimeEnd(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.onNewTaskShowTimeEnd, arg_28_0)
	arg_28_0:_lockScreen(false)
end

function var_0_0.refreshTeam(arg_29_0)
	arg_29_0._dispatchItem:setData(MoLiDeErEnum.DispatchState.Main)
end

function var_0_0.onEventChange(arg_30_0, arg_30_1)
	if arg_30_1 ~= nil then
		local var_30_0 = MoLiDeErGameModel.instance:getCurGameInfo():getEventInfo(arg_30_1)
		local var_30_1 = var_30_0.isChose and MoLiDeErEnum.DispatchState.Dispatching or MoLiDeErEnum.DispatchState.Dispatch

		ViewMgr.instance:openView(ViewName.MoLiDeErEventView, {
			eventId = arg_30_1,
			state = var_30_1,
			optionId = var_30_0.optionId
		})
	end
end

function var_0_0.checkTeamDispatchState(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._infoMo

	if var_31_0.newDispatchEventDic and var_31_0.newDispatchEventDic[arg_31_1] then
		MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.UIDispatchTeam, var_31_0.newDispatchEventDic[arg_31_1])
		logNormal("莫莉德尔 角色活动 派出小队动效 id:" .. tostring(var_31_0.newDispatchEventDic[arg_31_1]))

		return MoLiDeErEnum.TeamDispatchState.Dispatch
	elseif var_31_0.newBackTeamEventDic and var_31_0.newBackTeamEventDic[arg_31_1] then
		MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.UIWithDrawTeam, var_31_0.newBackTeamEventDic[arg_31_1])
		logNormal("莫莉德尔 角色活动 回收小队动效 id:" .. tostring(var_31_0.newBackTeamEventDic[arg_31_1]))

		return MoLiDeErEnum.TeamDispatchState.WithDraw
	end

	return MoLiDeErEnum.TeamDispatchState.Dispatching
end

function var_0_0.onViewOpen(arg_32_0, arg_32_1)
	if arg_32_1 == ViewName.MoLiDeErEventView then
		gohelper.setActive(arg_32_0._goDispatch, false)
	end
end

function var_0_0.onViewClose(arg_33_0, arg_33_1)
	if arg_33_1 == ViewName.MoLiDeErEventView then
		gohelper.setActive(arg_33_0._goDispatch, true)
	end
end

function var_0_0.forceCloseLock(arg_34_0)
	logError("莫莉德尔 角色活动 事件出现表现超时 已强制关闭遮罩")
	arg_34_0:_lockScreen(false)
	arg_34_0:refreshUI(true)
end

function var_0_0.onGameExit(arg_35_0)
	arg_35_0:closeThis()
end

function var_0_0.onGameReset(arg_36_0)
	arg_36_0:refreshUI(true)
end

function var_0_0.onGameSkip(arg_37_0)
	arg_37_0:closeThis()
end

function var_0_0._lockScreen(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 then
		TaskDispatcher.runDelay(arg_38_0.forceCloseLock, arg_38_0, arg_38_2)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("MoLiDeErGameView")
		logNormal("莫莉德尔 角色活动 开始锁屏")
	else
		TaskDispatcher.cancelTask(arg_38_0.forceCloseLock, arg_38_0)
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock("MoLiDeErGameView")
		logNormal("莫莉德尔 角色活动 结束锁屏")
	end
end

function var_0_0.getOrReturnSolidLine(arg_39_0, arg_39_1)
	if arg_39_1 == nil then
		if arg_39_0._unUseLineSolidList[1] == nil then
			arg_39_1 = gohelper.clone(arg_39_0._goLineVirtual, arg_39_0._goLineParent)
		else
			arg_39_1 = table.remove(arg_39_0._unUseLineSolidList)
		end

		table.insert(arg_39_0._useLineSolidList, arg_39_1)
		gohelper.setActive(arg_39_1, true)

		return arg_39_1
	else
		tabletool.removeValue(arg_39_0._useLineSolidList, arg_39_1)
		table.insert(arg_39_0._unUseLineSolidList, arg_39_1)
		gohelper.setActive(arg_39_1, false)
	end
end

function var_0_0.getOrReturnTargetFxLine(arg_40_0, arg_40_1)
	if arg_40_1 == nil then
		if arg_40_0._unUseTargetFxList[1] == nil then
			arg_40_1 = gohelper.clone(arg_40_0._goTargetFx, arg_40_0._goeventMap)
		else
			arg_40_1 = table.remove(arg_40_0._unUseTargetFxList)
		end

		table.insert(arg_40_0._useTargetFxList, arg_40_1)
		gohelper.setActive(arg_40_1, true)

		return arg_40_1
	else
		tabletool.removeValue(arg_40_0._useTargetFxList, arg_40_1)
		table.insert(arg_40_0._unUseTargetFxList, arg_40_1)
		gohelper.setActive(arg_40_1, false)
	end
end

function var_0_0.doEventLineTween(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_1[1] + MoLiDeErEnum.EventCenterOffset.X
	local var_41_1 = arg_41_1[2] + MoLiDeErEnum.EventCenterOffset.Y
	local var_41_2 = arg_41_2[1] + MoLiDeErEnum.EventCenterOffset.X
	local var_41_3 = arg_41_2[2] + MoLiDeErEnum.EventCenterOffset.Y
	local var_41_4 = math.sqrt((var_41_0 - var_41_2)^2 + (var_41_1 - var_41_3)^2)
	local var_41_5 = math.atan2(var_41_3 - var_41_1, var_41_2 - var_41_0) * (180 / math.pi)

	logNormal("莫莉德尔角色活动 线条开始位置 angle: " .. tostring(var_41_5) .. "x: " .. tostring(var_41_0) .. "y: " .. tostring(var_41_1))

	local var_41_6 = arg_41_0:getOrReturnSolidLine()

	transformhelper.setEulerAngles(var_41_6.transform, 0, 0, var_41_5)
	transformhelper.setLocalPos(var_41_6.transform, var_41_0, var_41_1, 0)
	recthelper.setWidth(var_41_6.transform, 0)
	transformhelper.setLocalScale(var_41_6.transform, 1, 1, 1)

	local var_41_7 = {
		go = var_41_6,
		posX = var_41_2,
		posY = var_41_3
	}
	local var_41_8 = ZProj.TweenHelper.DOWidth(var_41_6.transform, var_41_4, MoLiDeErEnum.DelayTime.NewEventShow, arg_41_0.onTweenLineEnd, arg_41_0, var_41_7, EaseType.Linear)

	table.insert(arg_41_0._tweenIdList, var_41_8)
end

function var_0_0.onTweenLineEnd(arg_42_0, arg_42_1)
	arg_42_0:doEventLineTweenFade(arg_42_1)
end

function var_0_0.doEventLineTweenFade(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1.go
	local var_43_1, var_43_2, var_43_3 = transformhelper.getEulerAngles(var_43_0.transform)
	local var_43_4

	if var_43_3 < 180 then
		var_43_4 = var_43_3 + 180
	else
		var_43_4 = var_43_3 - 180
	end

	transformhelper.setEulerAngles(var_43_0.transform, 0, 0, var_43_4)
	transformhelper.setLocalScale(var_43_0.transform, 1, -1, 1)
	transformhelper.setLocalPos(var_43_0.transform, arg_43_1.posX, arg_43_1.posY, 0)

	local var_43_5 = ZProj.TweenHelper.DOWidth(var_43_0.transform, 0, MoLiDeErEnum.DelayTime.BlackEnd, arg_43_0.onTweenLineFadeEnd, arg_43_0, arg_43_1, EaseType.Linear)

	table.insert(arg_43_0._tweenIdList, var_43_5)
end

function var_0_0.onTweenLineFadeEnd(arg_44_0, arg_44_1)
	arg_44_0:getOrReturnSolidLine(arg_44_1.go)
end

function var_0_0.addTitleTips(arg_45_0, arg_45_1)
	table.insert(arg_45_0._cacheMsgList, arg_45_1)

	if not arg_45_0.hadTask then
		arg_45_0:_showToast()
		TaskDispatcher.runRepeat(arg_45_0._showToast, arg_45_0, arg_45_0._showNextToastInterval)

		arg_45_0.hadTask = true
	end
end

function var_0_0._showToast(arg_46_0)
	local var_46_0 = table.remove(arg_46_0._cacheMsgList, 1)

	if not var_46_0 then
		TaskDispatcher.cancelTask(arg_46_0._showToast, arg_46_0)

		arg_46_0.hadTask = false

		return
	end

	local var_46_1 = table.remove(arg_46_0._unUsedTipsItem, 1)

	if not var_46_1 then
		local var_46_2 = gohelper.clone(arg_46_0._goTips, arg_46_0._goTipsParent)

		var_46_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_46_2, MoLiDeErTipItem)
	end

	local var_46_3

	if #arg_46_0._usedTipsItem >= arg_46_0._maxCount then
		local var_46_4 = arg_46_0._usedTipsItem[1]

		arg_46_0:recycleToast(var_46_4, true)
	end

	table.insert(arg_46_0._usedTipsItem, var_46_1)
	var_46_1:setMsg(var_46_0)
	var_46_1:setActive(true)
	var_46_1:appearAnimation()
end

function var_0_0.recycleToast(arg_47_0, arg_47_1)
	local var_47_0 = tabletool.indexOf(arg_47_0._usedTipsItem, arg_47_1)

	if var_47_0 then
		table.remove(arg_47_0._usedTipsItem, var_47_0)
	end

	arg_47_1:reset()
	table.insert(arg_47_0._unUsedTipsItem, arg_47_1)
end

function var_0_0.onClose(arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.onFinishTaskShowTimeEnd, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.onNewTaskLineShowTimeEnd, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.onNewTaskShowTimeEnd, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.onTitleCountTimeEnd, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._showToast, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.onGameOver, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.forceCloseLock, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.onTargetFxAllShowEnd, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.onTargetProgressAddFxShowEnd, arg_48_0)
	MoLiDeErGameModel.instance:resetSelect()

	if arg_48_0._tweenIdList[1] then
		for iter_48_0, iter_48_1 in ipairs(arg_48_0._tweenIdList) do
			ZProj.TweenHelper.KillById(iter_48_1, false)
		end
	end

	arg_48_0._tweenIdList = nil

	for iter_48_2, iter_48_3 in ipairs(arg_48_0._targetFxTweenList) do
		ZProj.TweenHelper.KillById(iter_48_3)
	end

	arg_48_0._targetFxTweenList = nil
end

function var_0_0.onDestroyView(arg_49_0)
	return
end

return var_0_0
