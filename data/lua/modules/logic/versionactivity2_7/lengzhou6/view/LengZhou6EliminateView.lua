module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6EliminateView", package.seeall)

local var_0_0 = class("LengZhou6EliminateView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.viewGO = gohelper.findChild(arg_1_0.viewGO, "#go_Right")
	arg_1_0._simageGrid = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Grid")
	arg_1_0._goTimes = gohelper.findChild(arg_1_0.viewGO, "#go_Times")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Times/#btn_Left")
	arg_1_0._txtTimes = gohelper.findChildText(arg_1_0.viewGO, "#go_Times/#txt_Times")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Times/#btn_Right")
	arg_1_0._goChessBG = gohelper.findChild(arg_1_0.viewGO, "#go_ChessBG")
	arg_1_0._gochessBoard = gohelper.findChild(arg_1_0.viewGO, "#go_ChessBG/#go_chessBoard")
	arg_1_0._gochess = gohelper.findChild(arg_1_0.viewGO, "#go_ChessBG/#go_chess")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ChessBG/#go_chess/#btn_click")
	arg_1_0._goChessEffect = gohelper.findChild(arg_1_0.viewGO, "#go_ChessEffect")
	arg_1_0._goLoading = gohelper.findChild(arg_1_0.viewGO, "#go_Loading")
	arg_1_0._sliderloading = gohelper.findChildSlider(arg_1_0.viewGO, "#go_Loading/#slider_loading")
	arg_1_0._goContinue = gohelper.findChild(arg_1_0.viewGO, "#go_Continue")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Continue/#simage_Mask")
	arg_1_0._btnContinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Continue/#btn_Continue")
	arg_1_0._goMask = gohelper.findChild(arg_1_0.viewGO, "#go_Mask")
	arg_1_0._goAssess = gohelper.findChild(arg_1_0.viewGO, "#go_Assess")
	arg_1_0._imageAssess = gohelper.findChildImage(arg_1_0.viewGO, "#go_Assess/#image_Assess")
	arg_1_0._goAssess2 = gohelper.findChild(arg_1_0.viewGO, "#go_Assess2")
	arg_1_0._imageAssess2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_Assess2/#image_Assess2")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Assess2/#txt_Num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnContinue:AddClickListener(arg_2_0._btnContinueOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnContinue:RemoveClickListener()
end

function var_0_0._btnLeftOnClick(arg_4_0)
	return
end

function var_0_0._btnRightOnClick(arg_5_0)
	return
end

function var_0_0._btnclickOnClick(arg_6_0)
	return
end

function var_0_0._btnContinueOnClick(arg_7_0)
	if #LengZhou6GameModel.instance:getSelectSkillIdList() < LengZhou6Enum.defaultPlayerSkillSelectMax then
		GameFacade.showMessageBox(MessageBoxIdDefine.LengZhou6EndLessContinue, MsgBoxEnum.BoxType.Yes_No, arg_7_0._continueGame, nil, nil, arg_7_0)
	else
		arg_7_0:_continueGame()
	end
end

function var_0_0._continueGame(arg_8_0)
	LengZhou6GameModel.instance:enterNextLayer()

	local var_8_0 = LengZhou6GameModel.instance:getSelectSkillIdList()

	LengZhou6GameModel.instance:resetSelectSkillId()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = var_8_0[iter_8_0]

		LengZhou6GameModel.instance:setPlayerSelectSkillId(iter_8_0, var_8_1)
	end
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActiveCanvasGroup(arg_9_0._gochess, false)

	if LengZhou6EliminateChessItemController.instance:InitCloneGo(arg_9_0._gochess, arg_9_0._gochessBoard, arg_9_0._goChessBG, arg_9_0._goChessBG) then
		LengZhou6EliminateChessItemController.instance:InitChess()
	end

	gohelper.setActive(arg_9_0._goeffect, false)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	gohelper.setActive(arg_11_0._goAssess, false)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.OnChessSelect, arg_11_0.onSelectItem, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdateGameInfo, arg_11_0.updateRound, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.PerformBegin, arg_11_0.onPerformBegin, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.PerformEnd, arg_11_0.onPerformEnd, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ReleaseSkill, arg_11_0.onReleaseSkill, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ShowAssess, arg_11_0.OnShowAssess, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.CancelSkill, arg_11_0.cancelSkill, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ShowEffect, arg_11_0.showEffect, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.HideEffect, arg_11_0.hideEffect, arg_11_0)
	arg_11_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ClearEliminateEffect, arg_11_0.clearAllEffect, arg_11_0)
	arg_11_0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.OnEndlessChangeSelectState, arg_11_0.endLessModelRefreshView, arg_11_0)
	arg_11_0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.GameReStart, arg_11_0._gameReStart, arg_11_0)
	arg_11_0:initView()
end

function var_0_0._gameReStart(arg_12_0)
	gohelper.setActive(arg_12_0._goAssess, false)
	arg_12_0:initView()
end

function var_0_0.onSelectItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0._mask then
		return
	end

	local var_13_0 = LocalEliminateChessModel.instance:getCell(arg_13_1, arg_13_2)

	if var_13_0 then
		local var_13_1 = var_13_0:haveStatus(EliminateEnum_2_7.ChessState.Frost)
		local var_13_2 = var_13_0:getEliminateID() == EliminateEnum_2_7.ChessType.stone

		if arg_13_0._needReleaseSkill == nil and (var_13_1 or var_13_2) then
			return
		end
	end

	if arg_13_0._needReleaseSkill ~= nil then
		if arg_13_0._lastSelectX and arg_13_0._lastSelectY then
			arg_13_0:setSelect(false, arg_13_0._lastSelectX, arg_13_0._lastSelectY)
			arg_13_0:recordLastSelect(nil, nil)
		end

		arg_13_0:setSkillParams(arg_13_1, arg_13_2)

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_click)

	if arg_13_0._lastSelectX and arg_13_0._lastSelectY then
		if arg_13_0._lastSelectX ~= arg_13_1 or arg_13_0._lastSelectY ~= arg_13_2 then
			arg_13_0:setSelect(false, arg_13_0._lastSelectX, arg_13_0._lastSelectY)
			LengZhou6EliminateController.instance:exchangeCell(arg_13_0._lastSelectX, arg_13_0._lastSelectY, arg_13_1, arg_13_2)
			arg_13_0:recordLastSelect(nil, nil)
			arg_13_0:setSelect(false, arg_13_1, arg_13_2)
		else
			arg_13_0:setSelect(false, arg_13_0._lastSelectX, arg_13_0._lastSelectY)
			arg_13_0:recordLastSelect(nil, nil)
		end
	else
		if arg_13_3 then
			arg_13_0:setSelect(true, arg_13_1, arg_13_2)
		end

		arg_13_0:recordLastSelect(arg_13_1, arg_13_2)
	end
end

function var_0_0.setSelect(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0

	if arg_14_2 and arg_14_3 then
		var_14_0 = LengZhou6EliminateChessItemController.instance:getChessItem(arg_14_2, arg_14_3)
	else
		var_14_0 = LengZhou6EliminateChessItemController.instance:getChessItem(arg_14_0._lastSelectX, arg_14_0._lastSelectY)
	end

	if var_14_0 ~= nil then
		var_14_0:setSelect(arg_14_1)
	end
end

function var_0_0.recordLastSelect(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._lastSelectX = arg_15_1
	arg_15_0._lastSelectY = arg_15_2

	arg_15_0:updateTipTime()
	arg_15_0:tip(false)
end

function var_0_0.initView(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.showViewByModel, arg_16_0)

	if LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.normal then
		arg_16_0:updateRound()
		arg_16_0:showLoading(true)
	else
		arg_16_0:endLessModelRefreshView(true)
	end
end

function var_0_0.endLessModelRefreshView(arg_17_0, arg_17_1)
	local var_17_0 = LengZhou6GameModel.instance:getEndLessBattleProgress()
	local var_17_1 = var_17_0 == LengZhou6Enum.BattleProgress.selectSkill

	gohelper.setActive(arg_17_0._goContinue, var_17_1)
	gohelper.setActive(arg_17_0._goLoading, not var_17_1)
	gohelper.setActive(arg_17_0._goChessBG, not var_17_1)
	gohelper.setActive(arg_17_0._goChessEffect, not var_17_1)
	arg_17_0:setMaskActive(false)
	arg_17_0:updateRound()

	if var_17_0 == LengZhou6Enum.BattleProgress.selectFinish then
		arg_17_0:showLoading(arg_17_1)
	else
		arg_17_0:changeTipState(false, true, false)
		LengZhou6GameModel.instance:recordChessData()

		local var_17_2 = LengZhou6GameModel.instance:getEndLessModelLayer()

		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.ChangePlayerSkill, var_17_2)
	end
end

function var_0_0.updateRound(arg_18_0)
	local var_18_0 = LengZhou6GameModel.instance:getCurRound()

	arg_18_0._txtTimes.text = var_18_0
end

function var_0_0.setMaskActive(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goMask, arg_19_1)

	arg_19_0._mask = arg_19_1
end

function var_0_0.onPerformBegin(arg_20_0)
	arg_20_0:setMaskActive(true)
	arg_20_0:changeTipState(false, true, false)
end

function var_0_0.onPerformEnd(arg_21_0)
	arg_21_0:setMaskActive(false)
	arg_21_0:changeTipState(true, false, true)
end

function var_0_0.showLoading(arg_22_0, arg_22_1)
	arg_22_0:setMaskActive(true)
	gohelper.setActive(arg_22_0._goLoading, true)
	gohelper.setActive(arg_22_0._goChessBG, false)
	gohelper.setActive(arg_22_0._goContinue, false)
	gohelper.setActive(arg_22_0._goChessEffect, false)
	arg_22_0:setMaskActive(true)
	arg_22_0._sliderloading:SetValue(0)

	if arg_22_1 then
		TaskDispatcher.runDelay(arg_22_0._showLoading, arg_22_0, LengZhou6Enum.openViewAniTime)
	else
		arg_22_0:_showLoading()
	end
end

function var_0_0._showLoading(arg_23_0)
	if arg_23_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_23_0._conTweenId)

		arg_23_0._conTweenId = nil
	end

	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_loading)

	arg_23_0._conTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, LengZhou6Enum.LoadingTime, arg_23_0._updateLoading, arg_23_0._finishLoading, arg_23_0, nil, EaseType.Linear)
end

function var_0_0._updateLoading(arg_24_0, arg_24_1)
	if arg_24_0._sliderloading then
		arg_24_0._sliderloading:SetValue(arg_24_1)
	end
end

function var_0_0._finishLoading(arg_25_0)
	LengZhou6EliminateController.instance:createInitMoveStepAndUpdatePos()
	gohelper.setActive(arg_25_0._goLoading, false)
	gohelper.setActive(arg_25_0._goChessBG, true)
	gohelper.setActive(arg_25_0._goChessEffect, true)
	arg_25_0:setMaskActive(false)

	local var_25_0 = LengZhou6GameModel.instance:getBattleModel()
	local var_25_1 = LengZhou6GameModel.instance:getEndLessBattleProgress()

	if var_25_0 == LengZhou6Enum.BattleModel.infinite then
		if var_25_1 == LengZhou6Enum.BattleProgress.selectFinish then
			if not LengZhou6GameModel.instance:isFirstEnterLayer() then
				arg_25_0:clearAllEffect()
			end

			LengZhou6GameModel.instance:recordChessData()
		end
	else
		local var_25_2 = LengZhou6Model.instance:getCurEpisodeId()

		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnterGameLevel, var_25_2)
	end

	arg_25_0:changeTipState(true, false, true)
end

function var_0_0.onReleaseSkill(arg_26_0, arg_26_1)
	if not arg_26_1:paramIsFull() then
		arg_26_0._needReleaseSkill = arg_26_1

		arg_26_0:changeTipState(false, true, false)
	end
end

function var_0_0.setSkillParams(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0._needReleaseSkill ~= nil then
		arg_27_0._needReleaseSkill:setParams(arg_27_1, arg_27_2)
	end

	if arg_27_0._needReleaseSkill:paramIsFull() then
		arg_27_0._needReleaseSkill:execute()

		arg_27_0._needReleaseSkill = nil

		arg_27_0:changeTipState(true, false, true)
	end
end

function var_0_0.cancelSkill(arg_28_0)
	arg_28_0._needReleaseSkill = nil

	arg_28_0:changeTipState(true, false, true)
end

function var_0_0.OnShowAssess(arg_29_0, arg_29_1)
	if arg_29_1 == nil then
		return
	end

	local var_29_0 = EliminateEnum_2_7.AssessLevelToImageName[arg_29_1]

	UISpriteSetMgr.instance:setHisSaBethSprite(arg_29_0._imageAssess, var_29_0, false)
	gohelper.setActive(arg_29_0._goAssess, true)
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_result)
	TaskDispatcher.runDelay(arg_29_0.hideAssess, arg_29_0, EliminateEnum_2_7.AssessShowTime)
end

function var_0_0.hideAssess(arg_30_0)
	gohelper.setActive(arg_30_0._goAssess, false)
end

function var_0_0.onClose(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.hideAssess, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.checkTip, arg_31_0)

	if arg_31_0.effectPool ~= nil then
		arg_31_0.effectPool:dispose()

		arg_31_0.flyItemPool = nil
	end
end

function var_0_0.showEffect(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_1 == nil or arg_32_2 == nil or arg_32_3 == nil then
		return
	end

	local var_32_0 = arg_32_0:getEffectIndex(arg_32_1, arg_32_2)

	if arg_32_0._effectList == nil then
		arg_32_0._effectList = arg_32_0:getUserDataTb_()
	end

	local var_32_1 = arg_32_0._effectList[var_32_0]

	if var_32_1 == nil then
		local var_32_2 = arg_32_0.viewContainer:getSetting().otherRes[4]

		var_32_1 = arg_32_0:getResInst(var_32_2, arg_32_0._goChessEffect, "effect_" .. var_32_0)
		arg_32_0._effectList[var_32_0] = var_32_1
	end

	arg_32_0:updateEffectInfo(var_32_1, arg_32_1, arg_32_2, arg_32_3)
	LocalEliminateChessModel.instance:recordSpEffect(arg_32_1, arg_32_2, arg_32_3)
end

function var_0_0.hideEffect(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_1 == nil or arg_33_2 == nil or arg_33_3 == nil or arg_33_0._effectList == nil then
		return
	end

	local var_33_0 = LocalEliminateChessModel.instance:getSpEffect(arg_33_1, arg_33_2)

	if var_33_0 and arg_33_3 == var_33_0 then
		local var_33_1 = arg_33_0:getEffectIndex(arg_33_1, arg_33_2)
		local var_33_2 = arg_33_0._effectList[var_33_1]

		if var_33_2 ~= nil and arg_33_3 == EliminateEnum_2_7.ChessEffect.frost then
			gohelper.findChild(var_33_2, "#image_sprite2"):GetComponent(typeof(UnityEngine.Animator)):Play("out", 0, 0)

			if arg_33_0._needHidePos == nil then
				arg_33_0._needHidePos = {}
			end

			table.insert(arg_33_0._needHidePos, {
				arg_33_1,
				arg_33_2
			})
			TaskDispatcher.cancelTask(arg_33_0._delayHideEffect, arg_33_0)
			TaskDispatcher.runDelay(arg_33_0._delayHideEffect, arg_33_0, 0.5)
		else
			arg_33_0:_realHideEffect(arg_33_1, arg_33_2)
		end
	end
end

function var_0_0._delayHideEffect(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._delayHideEffect, arg_34_0)

	if arg_34_0._needHidePos == nil then
		return
	end

	local var_34_0 = #arg_34_0._needHidePos

	for iter_34_0 = 1, var_34_0 do
		local var_34_1 = table.remove(arg_34_0._needHidePos, 1)
		local var_34_2 = var_34_1[1]
		local var_34_3 = var_34_1[2]

		arg_34_0:_realHideEffect(var_34_2, var_34_3)
	end
end

function var_0_0._realHideEffect(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_0._effectList == nil then
		return
	end

	local var_35_0 = arg_35_0:getEffectIndex(arg_35_1, arg_35_2)

	if arg_35_0._effectList[var_35_0] ~= nil then
		LocalEliminateChessModel.instance:recordSpEffect(arg_35_1, arg_35_2, nil)
		gohelper.setActive(arg_35_0._effectList[var_35_0], false)
	end
end

function var_0_0.clearAllEffect(arg_36_0)
	if arg_36_0._effectList == nil then
		return
	end

	LocalEliminateChessModel.instance:clearAllEffect()

	for iter_36_0, iter_36_1 in pairs(arg_36_0._effectList) do
		if iter_36_1 ~= nil then
			gohelper.setActive(iter_36_1, false)
			gohelper.destroy(iter_36_1)
		end
	end

	if arg_36_0._needHidePos ~= nil then
		tabletool.clear(arg_36_0._needHidePos)
	end

	if arg_36_0._effectList ~= nil then
		tabletool.clear(arg_36_0._effectList)
	end
end

function var_0_0.getEffectIndex(arg_37_0, arg_37_1, arg_37_2)
	return arg_37_1 .. "_" .. arg_37_2
end

function var_0_0.updateEffectInfo(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	if arg_38_2 == nil or arg_38_3 == nil or arg_38_4 == nil then
		return
	end

	local var_38_0 = gohelper.findChildImage(arg_38_1, "#image_sprite")
	local var_38_1 = gohelper.findChildImage(arg_38_1, "#image_sprite2")
	local var_38_2 = arg_38_4 == EliminateEnum_2_7.ChessEffect.frost

	gohelper.setActive(var_38_0.gameObject, not var_38_2)
	gohelper.setActive(var_38_1.gameObject, var_38_2)

	local var_38_3, var_38_4 = LocalEliminateChessUtils.instance.getChessPos(arg_38_2, arg_38_3)

	transformhelper.setLocalPosXY(arg_38_1.transform, var_38_3, var_38_4)
	gohelper.setActive(arg_38_1, true)
end

function var_0_0.updateTipTime(arg_39_0)
	arg_39_0._lastClickTime = os.time()
end

function var_0_0.checkTip(arg_40_0)
	if arg_40_0._lastClickTime == nil then
		arg_40_0._lastClickTime = os.time()
	end

	if os.time() - arg_40_0._lastClickTime >= EliminateEnum.DotMoveTipInterval then
		arg_40_0:tip(true)
	end
end

function var_0_0.tip(arg_41_0, arg_41_1)
	if arg_41_0._lastTipActive ~= nil and arg_41_0._lastTipActive == arg_41_1 then
		return
	end

	if arg_41_1 and not arg_41_0.canTip then
		return
	end

	if arg_41_1 then
		local var_41_0 = LocalEliminateChessModel.instance:canEliminate()

		if var_41_0 and #var_41_0 >= 3 then
			for iter_41_0 = 1, #var_41_0 do
				local var_41_1 = var_41_0[iter_41_0]
				local var_41_2 = var_41_1.x
				local var_41_3 = var_41_1.y
				local var_41_4 = LengZhou6EliminateChessItemController.instance:getChessItem(var_41_2, var_41_3)

				if var_41_4 ~= nil then
					var_41_4:toTip(arg_41_1)
				end
			end
		end
	else
		local var_41_5 = LengZhou6EliminateChessItemController.instance:getChess()

		for iter_41_1 = 1, #var_41_5 do
			local var_41_6 = var_41_5[iter_41_1]

			for iter_41_2 = 1, #var_41_6 do
				local var_41_7 = var_41_6[iter_41_2]

				if var_41_7 ~= nil then
					var_41_7:toTip(arg_41_1)
				end
			end
		end
	end

	arg_41_0._lastTipActive = arg_41_1
end

function var_0_0.changeTipState(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_0.canTip = arg_42_1

	if arg_42_2 then
		arg_42_0:tip(false)

		arg_42_0._lastClickTime = nil

		TaskDispatcher.cancelTask(arg_42_0.checkTip, arg_42_0)
	end

	if arg_42_3 then
		arg_42_0._lastClickTime = nil

		TaskDispatcher.cancelTask(arg_42_0.checkTip, arg_42_0)
		TaskDispatcher.runRepeat(arg_42_0.checkTip, arg_42_0, 1)
	end
end

function var_0_0.onDestroyView(arg_43_0)
	if arg_43_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_43_0._conTweenId)

		arg_43_0._conTweenId = nil
	end

	arg_43_0._needHidePos = nil

	TaskDispatcher.cancelTask(arg_43_0._delayHideEffect, arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._showLoading, arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0.checkTip, arg_43_0)
end

return var_0_0
