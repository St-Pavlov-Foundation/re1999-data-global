module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiGameView", package.seeall)

local var_0_0 = class("YeShuMeiGameView", BaseView)

var_0_0.GuideId = 31401

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gogame = gohelper.findChild(arg_1_0.viewGO, "#go_Game")
	arg_1_0._goshadow = gohelper.findChild(arg_1_0._gogame, "#go_shadow")
	arg_1_0._goComplete = gohelper.findChild(arg_1_0._gogame, "#go_Complete")
	arg_1_0._simageshadow = gohelper.findChildSingleImage(arg_1_0._gogame, "#go_shadow/#simage_shadow")
	arg_1_0._imageshadow = gohelper.findChildImage(arg_1_0._gogame, "#go_shadow/#simage_shadow")
	arg_1_0._goreview = gohelper.findChild(arg_1_0._gogame, "#btn_review")
	arg_1_0._btnreview = gohelper.findChildButtonWithAudio(arg_1_0._gogame, "#btn_review")
	arg_1_0._goreviewoff = gohelper.findChild(arg_1_0._gogame, "#btn_review/#go_State1")
	arg_1_0._goreviewon = gohelper.findChild(arg_1_0._gogame, "#btn_review/#go_State2")
	arg_1_0._gopointroot = gohelper.findChild(arg_1_0._gogame, "pointroot")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0._gogame, "pointroot/#go_point")
	arg_1_0._golineroot = gohelper.findChild(arg_1_0._gogame, "lineroot")
	arg_1_0._goline = gohelper.findChild(arg_1_0._gogame, "lineroot/#go_line")
	arg_1_0._goshowline = gohelper.findChild(arg_1_0._gogame, "#go_showline")
	arg_1_0._godrag = gohelper.findChild(arg_1_0._gogame, "#go_drag")
	arg_1_0._goguid = gohelper.findChild(arg_1_0._gogame, "#go_guid")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0._gogame, "LeftTop/TargetList")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0._gogame, "LeftTop/TargetList/#go_TargetItem")
	arg_1_0._goconditiontip = gohelper.findChild(arg_1_0.viewGO, "#go_conditiontip")
	arg_1_0._txtconditiontip = gohelper.findChildText(arg_1_0.viewGO, "#go_conditiontip/Target/#txt_TargetDescr")
	arg_1_0._btncomplete = gohelper.findChildButtonWithAudio(arg_1_0._gogame, "#go_Complete/#btn_complete")
	arg_1_0._isHidePoint = false
	arg_1_0._isReviewing = false

	gohelper.setActive(arg_1_0._goreviewoff, not arg_1_0._isReviewing)
	gohelper.setActive(arg_1_0._goreviewon, arg_1_0._isReviewing)
	gohelper.setActive(arg_1_0._btncomplete.gameObject, false)

	arg_1_0._shadowAnimator = arg_1_0._goshadow:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._pointRootAnimator = arg_1_0._gopointroot:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._lineRootAnimator = arg_1_0._golineroot:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._shadowAnimOutTime = 0.333

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreview:AddClickListener(arg_2_0._onClickReview, arg_2_0)
	arg_2_0._btncomplete:AddClickListener(arg_2_0._onBtnComlete, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._godrag, arg_2_0._onDragBeginPoint, arg_2_0._onDragPoint, arg_2_0._onDragEndPoint, nil, arg_2_0, nil, true)
	arg_2_0:addEventCb(YeShuMeiController.instance, YeShuMeiEvent.ShowGuideDrag, arg_2_0._showGuideDrag, arg_2_0)
	arg_2_0:addEventCb(YeShuMeiController.instance, YeShuMeiEvent.OnClickShadowGuide, arg_2_0._onClickShadow, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreview:RemoveClickListener()
	arg_3_0._btncomplete:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._godrag)
	arg_3_0:removeEventCb(YeShuMeiController.instance, YeShuMeiEvent.ShowGuideDrag, arg_3_0._showGuideDrag, arg_3_0)
	arg_3_0:removeEventCb(YeShuMeiController.instance, YeShuMeiEvent.OnClickShadowGuide, arg_3_0._onClickShadow, arg_3_0)
end

function var_0_0._onClickShadow(arg_4_0)
	gohelper.setActive(arg_4_0._goshadow, false)
	arg_4_0._pointRootAnimator:Play("in", 0, 0)
	arg_4_0._lineRootAnimator:Play("in", 0, 0)
	arg_4_0:_initPoint()
	gohelper.setActive(arg_4_0._godrag, true)
end

function var_0_0._onClickReview(arg_5_0)
	if GuideModel.instance:isGuideRunning(var_0_0.GuideId) then
		return
	end

	if arg_5_0._pointItem == nil then
		return
	end

	if arg_5_0._isReviewing then
		return
	end

	local var_5_0 = YeShuMeiGameModel.instance:getNeedCheckPointList()

	if var_5_0 and #var_5_0 >= 2 then
		GameFacade.showMessageBox(MessageBoxIdDefine.V3A1YeShuMei_ResetGame, MsgBoxEnum.BoxType.Yes_No, arg_5_0.resetGame, nil, nil, arg_5_0)
	else
		arg_5_0:_reviewShadow()
	end
end

function var_0_0._reviewShadow(arg_6_0)
	arg_6_0:_hidePoint()
	gohelper.setActive(arg_6_0._goshadow, true)
	gohelper.setActive(arg_6_0._godrag, false)

	arg_6_0._isReviewing = true

	gohelper.setActive(arg_6_0._goreviewoff, not arg_6_0._isReviewing)
	gohelper.setActive(arg_6_0._goreviewon, arg_6_0._isReviewing)
	TaskDispatcher.runDelay(arg_6_0._onClickUp, arg_6_0, arg_6_0._reviewShowShadowTime)
end

function var_0_0._onClickUp(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._onClickUp, arg_7_0)
	arg_7_0._shadowAnimator:Play("out", 0, 0)
	TaskDispatcher.runDelay(arg_7_0._onClickShadowOut, arg_7_0, arg_7_0._shadowAnimOutTime)
end

function var_0_0._onClickShadowOut(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onClickShadowOut, arg_8_0)
	arg_8_0:_showPoint()
	gohelper.setActive(arg_8_0._goshadow, false)
	gohelper.setActive(arg_8_0._godrag, true)
	arg_8_0:_clearReview()
end

function var_0_0._clearReview(arg_9_0)
	arg_9_0._isReviewing = false

	gohelper.setActive(arg_9_0._goreviewoff, not arg_9_0._isReviewing)
	gohelper.setActive(arg_9_0._goreviewon, arg_9_0._isReviewing)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._episodeId = arg_10_0.viewParam
	arg_10_0._config = YeShuMeiGameModel.instance:getCurGameConfig()
	arg_10_0._beforeShowShadowTime = YeShuMeiConfig.instance:getConstValueNumber(YeShuMeiEnum.BeForePlayGame)
	arg_10_0._finishShowShadowTime = YeShuMeiConfig.instance:getConstValueNumber(YeShuMeiEnum.AfterPlayGame)
	arg_10_0._reviewShowShadowTime = YeShuMeiConfig.instance:getConstValueNumber(YeShuMeiEnum.ReViewTime)
	arg_10_0._switchShowShadowTime = 1.5

	arg_10_0:_initView()
end

function var_0_0._initView(arg_11_0)
	arg_11_0._gameMo = YeShuMeiGameModel.instance:getGameMo()

	arg_11_0:_initCondition()
	arg_11_0:_showCondition()
end

function var_0_0._initCondition(arg_12_0)
	arg_12_0._txtconditiontip.text = arg_12_0._config and arg_12_0._config.desc
end

function var_0_0._showCondition(arg_13_0)
	gohelper.setActive(arg_13_0._goconditiontip, true)
	AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_mubiao)
	gohelper.setActive(arg_13_0._gogame, false)
	TaskDispatcher.runDelay(arg_13_0._initGame, arg_13_0, 2.8)
end

function var_0_0._initGame(arg_14_0)
	gohelper.setActive(arg_14_0._gogame, true)
	gohelper.setActive(arg_14_0._goconditiontip, false)
	gohelper.setActive(arg_14_0._goComplete, false)
	arg_14_0:_initTargetList()

	if GuideModel.instance:isStepFinish(var_0_0.GuideId, 2) or GuideController.instance:isForbidGuides() then
		arg_14_0:_showShadow()
	else
		local var_14_0 = YeShuMeiGameModel.instance:getCurrentLevelIndex()

		if not arg_14_0._bgList then
			if not arg_14_0._config or not arg_14_0._config.shadowBg then
				return
			end

			arg_14_0._bgList = string.split(arg_14_0._config.shadowBg, "#")
		end

		if arg_14_0._bgList and #arg_14_0._bgList > 0 then
			local var_14_1 = arg_14_0._bgList[var_14_0]

			arg_14_0._simageshadow:LoadImage(ResUrl.getV3a1YeShuMeiSingleBg(var_14_1), arg_14_0._loadedImage, arg_14_0)
		end

		gohelper.setActive(arg_14_0._goshadow, true)
		gohelper.setActive(arg_14_0._godrag, false)
	end
end

function var_0_0.resetGame(arg_15_0)
	YeShuMeiStatHelper.instance:sendGameReset()
	arg_15_0:_deletePoint()
	arg_15_0:_clearLines()
	YeShuMeiGameModel.instance:_onStart()
	arg_15_0:_initPoint()
	arg_15_0:_reviewShadow()
end

function var_0_0._initTargetList(arg_16_0)
	arg_16_0._targetDescList = {}
	arg_16_0._targetItemList = {}

	local var_16_0 = arg_16_0._config and arg_16_0._config.targetDesc

	if not string.nilorempty(var_16_0) then
		arg_16_0._targetdescList = string.split(var_16_0, "#")
	end

	if #arg_16_0._targetdescList > 0 then
		gohelper.CreateObjList(arg_16_0, arg_16_0._createTargetItem, arg_16_0._targetdescList, arg_16_0._gotarget, arg_16_0._gotargetitem)
	end
end

function var_0_0._createTargetItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0:getUserDataTb_()

	var_17_0.index = arg_17_3
	var_17_0.gook = gohelper.findChild(arg_17_1, "#go_TargetOK")
	var_17_0.txtdesc = gohelper.findChildText(arg_17_1, "#txt_TargetDesc")
	var_17_0.govx = gohelper.findChild(arg_17_1, "vx_glow")
	var_17_0.txtdesc.text = arg_17_2
	arg_17_0._targetItemList[arg_17_3] = var_17_0
end

function var_0_0._showShadow(arg_18_0, arg_18_1)
	local var_18_0 = YeShuMeiGameModel.instance:getCurrentLevelIndex()

	if not arg_18_0._bgList then
		if not arg_18_0._config or not arg_18_0._config.shadowBg then
			return
		end

		arg_18_0._bgList = string.split(arg_18_0._config.shadowBg, "#")
	end

	if arg_18_0._bgList and #arg_18_0._bgList > 0 then
		local var_18_1 = arg_18_0._bgList[var_18_0]

		arg_18_0._simageshadow:LoadImage(ResUrl.getV3a1YeShuMeiSingleBg(var_18_1), arg_18_0._loadedImage, arg_18_0)
	end

	gohelper.setActive(arg_18_0._goshadow, true)
	gohelper.setActive(arg_18_0._godrag, false)

	if arg_18_1 then
		arg_18_0._shadowAnimator:Play("insp", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_wipe)
		TaskDispatcher.runDelay(arg_18_0._switchShowShadow, arg_18_0, arg_18_0._switchShowShadowTime)
	else
		TaskDispatcher.runDelay(arg_18_0._afterShowShadow, arg_18_0, arg_18_0._beforeShowShadowTime)
	end
end

function var_0_0._switchShowShadow(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._switchShowShadow, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0._afterShowShadow, arg_19_0, arg_19_0._beforeShowShadowTime)
end

function var_0_0._loadedImage(arg_20_0)
	arg_20_0._imageshadow:SetNativeSize()
end

function var_0_0._afterShowShadow(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._afterShowShadow, arg_21_0)
	gohelper.setActive(arg_21_0._btnreview.gameObject, true)
	gohelper.setActive(arg_21_0._goshadow, false)
	gohelper.setActive(arg_21_0._godrag, true)
	arg_21_0._pointRootAnimator:Play("in", 0, 0)
	arg_21_0._lineRootAnimator:Play("in", 0, 0)
	arg_21_0:_initPoint()
	arg_21_0:_showPoint()
end

function var_0_0._hidePoint(arg_22_0)
	if arg_22_0._isHidePoint then
		return
	end

	arg_22_0._isHidePoint = true

	if arg_22_0._pointItem and #arg_22_0._pointItem > 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._pointItem) do
			gohelper.setActive(iter_22_1.go, false)
		end
	end
end

function var_0_0._showPoint(arg_23_0)
	arg_23_0._isHidePoint = false

	if arg_23_0._pointItem and #arg_23_0._pointItem > 0 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0._pointItem) do
			gohelper.setActive(iter_23_1.go, true)
		end
	end

	AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_dian)
end

function var_0_0._deletePoint(arg_24_0)
	if not arg_24_0._pointItem then
		return
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._pointItem) do
		gohelper.destroy(iter_24_1.go)
		iter_24_1.mo:clearPoint()
	end

	arg_24_0._pointItem = nil
end

function var_0_0._initPoint(arg_25_0)
	if arg_25_0._pointItem == nil then
		arg_25_0._pointItem = arg_25_0:getUserDataTb_()
	end

	local var_25_0 = arg_25_0._gameMo:getAllPoint()

	if var_25_0 == nil then
		return
	end

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		if arg_25_0._pointItem[iter_25_1.id] == nil then
			local var_25_1 = arg_25_0:getUserDataTb_()

			var_25_1.go = gohelper.clone(arg_25_0._gopoint, arg_25_0._gopointroot, "point" .. iter_25_1.id)
			var_25_1.comp = MonoHelper.addNoUpdateLuaComOnceToGo(var_25_1.go, YeShuMeiPointItem)
			var_25_1.mo = iter_25_1
			arg_25_0._pointItem[iter_25_1.id] = var_25_1

			var_25_1.comp:updateInfo(iter_25_1)
		end
	end
end

function var_0_0._onDragBeginPoint(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0._isReviewing then
		return
	end

	local var_26_0 = arg_26_2.position
	local var_26_1, var_26_2 = recthelper.screenPosToAnchorPos2(var_26_0, arg_26_0.viewGO.transform)

	if YeShuMeiGameModel.instance:checkNeedCheckListEmpty() then
		local var_26_3 = YeShuMeiGameModel.instance:getStartPointIds()

		if var_26_3 then
			for iter_26_0, iter_26_1 in ipairs(var_26_3) do
				local var_26_4 = YeShuMeiGameModel.instance:getPointById(iter_26_1)

				if var_26_4 and var_26_4:isInCanConnectionRange(var_26_1, var_26_2) then
					arg_26_0._canDrag = true

					break
				end
			end
		end
	else
		local var_26_5 = YeShuMeiGameModel.instance:getCurStartPointId()
		local var_26_6 = YeShuMeiGameModel.instance:getPointById(var_26_5)

		if var_26_6 and var_26_6:isInCanConnectionRange(var_26_1, var_26_2) then
			arg_26_0._canDrag = true
		else
			arg_26_0._canDrag = false
		end
	end
end

function var_0_0._onDragPoint(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0._canDrag then
		return
	end

	local var_27_0 = arg_27_2.position
	local var_27_1, var_27_2 = recthelper.screenPosToAnchorPos2(var_27_0, arg_27_0.viewGO.transform)

	if YeShuMeiGameModel.instance:checkDiffPosAndConnection(var_27_1, var_27_2) then
		local var_27_3 = YeShuMeiGameModel.instance:getStartState()
		local var_27_4 = YeShuMeiGameModel.instance:getNeedCheckPointList()
		local var_27_5 = YeShuMeiGameModel.instance:getConfigStartPointIds()

		if not var_27_3 then
			for iter_27_0, iter_27_1 in ipairs(var_27_5) do
				local var_27_6 = arg_27_0._pointItem[iter_27_1]

				if var_27_6 and var_27_6.comp then
					var_27_6.comp:updateUI()
				end
			end

			YeShuMeiGameModel.instance:setStartState(true)
		end

		if var_27_4 and #var_27_4 > 0 then
			for iter_27_2, iter_27_3 in ipairs(var_27_4) do
				local var_27_7 = arg_27_0._pointItem[iter_27_3]

				if var_27_7 and var_27_7.comp then
					var_27_7.comp:updateUI()
				end
			end

			arg_27_0:checkCreateLine(var_27_4)
		end
	end

	if YeShuMeiGameModel.instance:getCurrentLevelComplete() then
		arg_27_0:_updateTargetList()

		if YeShuMeiGameModel.instance:checkHaveNextLevel() then
			UIBlockMgr.instance:startBlock("YeShuMeiGameView_NextLevel")
			arg_27_0:updateCurLine(nil, false)
			gohelper.setActive(arg_27_0._goshadow, true)
			AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_shadow)
			gohelper.setActive(arg_27_0._godrag, false)
			gohelper.setActive(arg_27_0._btnreview.gameObject, false)
			TaskDispatcher.runDelay(arg_27_0._toNextLevel, arg_27_0, arg_27_0._finishShowShadowTime)
		else
			arg_27_0:_finishGame()
		end
	else
		local var_27_8 = YeShuMeiGameModel.instance:getNeedCheckPointList() or {}

		arg_27_0:updateCurLine(var_27_8, true, var_27_1, var_27_2)
	end
end

function var_0_0._toNextLevel(arg_28_0)
	UIBlockMgr.instance:endBlock("YeShuMeiGameView_NextLevel")
	TaskDispatcher.cancelTask(arg_28_0._toNextLevel, arg_28_0)
	arg_28_0._shadowAnimator:Play("out", 0, 0)
	arg_28_0._pointRootAnimator:Play("out", 0, 0)
	arg_28_0._lineRootAnimator:Play("out", 0, 0)
	TaskDispatcher.runDelay(arg_28_0._animShadowOut, arg_28_0, arg_28_0._shadowAnimOutTime)
end

function var_0_0._animShadowOut(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._animShadowOut, arg_29_0)
	gohelper.setActive(arg_29_0._goshadow, false)
	gohelper.setActive(arg_29_0._godrag, true)
	arg_29_0:_updateTargetList()
	YeShuMeiGameModel.instance:setNextLevelGame()
	arg_29_0:setNextLevelGame()
end

function var_0_0._updateTargetList(arg_30_0)
	local var_30_0 = YeShuMeiGameModel.instance:getCurrentLevelIndex()
	local var_30_1 = arg_30_0._targetItemList[var_30_0]

	if var_30_1 then
		gohelper.setActive(var_30_1.gook, true)
		gohelper.setActive(var_30_1.govx, true)
	end
end

function var_0_0._finishGame(arg_31_0)
	arg_31_0:updateCurLine(nil, false)
	gohelper.setActive(arg_31_0._goshadow, true)
	gohelper.setActive(arg_31_0._godrag, false)
	gohelper.setActive(arg_31_0._goreview, false)
	gohelper.setActive(arg_31_0._goComplete, true)
	AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_finish)
	TaskDispatcher.runDelay(arg_31_0._gameFinish, arg_31_0, arg_31_0._finishShowShadowTime)
end

function var_0_0._gameFinish(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._gameFinish, arg_32_0)
	gohelper.setActive(arg_32_0._btncomplete.gameObject, true)
end

function var_0_0._onDragEndPoint(arg_33_0, arg_33_1, arg_33_2)
	if YeShuMeiGameModel.instance:getCurrentLevelComplete() then
		arg_33_0:_updateTargetList()

		if YeShuMeiGameModel.instance:checkHaveNextLevel() then
			UIBlockMgr.instance:startBlock("YeShuMeiGameView_NextLevel")
			arg_33_0:updateCurLine(nil, false)
			TaskDispatcher.runDelay(arg_33_0._toNextLevel, arg_33_0, arg_33_0._finishShowShadowTime)
		else
			arg_33_0:_finishGame()
		end
	else
		local var_33_0 = YeShuMeiGameModel.instance:getNeedCheckPointList()

		if var_33_0 and #var_33_0 < 2 then
			arg_33_0:resetPoint(var_33_0)
			YeShuMeiGameModel.instance:setStartState(false)
			YeShuMeiGameModel.instance:resetToLastConnection()

			local var_33_1 = YeShuMeiGameModel.instance:getConfigStartPointIds()

			for iter_33_0, iter_33_1 in ipairs(var_33_1) do
				local var_33_2 = arg_33_0._pointItem[iter_33_1]

				if var_33_2 and var_33_2.comp then
					var_33_2.comp:updateUI()
				end
			end
		else
			local var_33_3 = YeShuMeiGameModel.instance:getCurStartPointAfter()

			YeShuMeiGameModel.instance:checkCorrectConnection()
			arg_33_0:checkDeleteLineAndResetPoint(var_33_3)
		end
	end

	arg_33_0:updateCurLine(nil, false)
	YeShuMeiController.instance:dispatchEvent(YeShuMeiEvent.OnDragGuideFinish)

	arg_33_0._canDrag = false
end

function var_0_0.checkCreateLine(arg_34_0, arg_34_1)
	if not arg_34_1 or #arg_34_1 < 2 then
		return
	else
		for iter_34_0 = 1, #arg_34_1 - 1 do
			local var_34_0 = arg_34_0._pointItem[arg_34_1[iter_34_0]]
			local var_34_1 = arg_34_0._pointItem[arg_34_1[iter_34_0 + 1]]

			if var_34_0 and var_34_1 and not YeShuMeiGameModel.instance:checkLineExist(var_34_0.comp.id, var_34_1.comp.id) then
				local var_34_2 = YeShuMeiGameModel.instance:addLines(var_34_0.comp.id, var_34_1.comp.id)
				local var_34_3 = arg_34_0:createLine()

				var_34_3.comp:initData(var_34_2)
				var_34_3.comp:updatePoint(var_34_0.comp, var_34_1.comp)

				if arg_34_0._lineItemList == nil then
					arg_34_0._lineItemList = {}
				end

				arg_34_0._lineItemList[var_34_2.id] = var_34_3

				if YeShuMeiGameModel.instance:getWrong() then
					AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_wrong)
				else
					AudioMgr.instance:trigger(AudioEnum3_1.YeShuMei.play_ui_mingdi_ysm_right)
				end
			end
		end

		YeShuMeiController.instance:dispatchEvent(YeShuMeiEvent.OnDragGuideFinish)
	end
end

function var_0_0.checkDeleteLineAndResetPoint(arg_35_0, arg_35_1)
	local var_35_0 = YeShuMeiGameModel.instance:getNeedCheckPointList()

	if not var_35_0 then
		arg_35_0:_clearLines()
	else
		if #var_35_0 < 2 then
			arg_35_0:resetPoint(var_35_0)
			YeShuMeiGameModel.instance:resetToLastConnection()
			YeShuMeiGameModel.instance:setStartState(false)

			local var_35_1 = YeShuMeiGameModel.instance:getConfigStartPointIds()

			for iter_35_0, iter_35_1 in ipairs(var_35_1) do
				local var_35_2 = arg_35_0._pointItem[iter_35_1]

				if var_35_2 and var_35_2.comp then
					var_35_2.comp:updateUI()
				end
			end
		end

		if arg_35_1 and #arg_35_1 > 0 then
			for iter_35_2, iter_35_3 in ipairs(arg_35_1) do
				local var_35_3 = YeShuMeiGameModel.instance:getLineMoByErrorId(iter_35_3)

				if var_35_3 then
					local var_35_4 = arg_35_0._lineItemList[var_35_3.id]

					var_35_4.comp:onDestroy()
					gohelper.destroy(var_35_4.go)

					local var_35_5

					YeShuMeiGameModel.instance:deleteLines({
						var_35_3.id
					})
				end
			end

			arg_35_0:resetPoint(arg_35_1)
		end
	end
end

function var_0_0.createLine(arg_36_0)
	local var_36_0 = arg_36_0:getUserDataTb_()

	var_36_0.go = gohelper.clone(arg_36_0._goline, arg_36_0._golineroot, "line")
	var_36_0.comp = MonoHelper.addNoUpdateLuaComOnceToGo(var_36_0.go, YeShuMeiLineItem)

	gohelper.setActive(var_36_0.go, true)

	return var_36_0
end

function var_0_0._clearLines(arg_37_0)
	YeShuMeiGameModel.instance:deleteLines()

	if arg_37_0._lineItemList and #arg_37_0._lineItemList > 0 then
		for iter_37_0, iter_37_1 in ipairs(arg_37_0._lineItemList) do
			iter_37_1.comp:onDestroy()
			gohelper.destroy(iter_37_1.go)
		end
	end
end

function var_0_0.resetPoint(arg_38_0, arg_38_1)
	if arg_38_1 and #arg_38_1 > 0 then
		for iter_38_0, iter_38_1 in ipairs(arg_38_1) do
			YeShuMeiGameModel.instance:getPointById(iter_38_1):clearPoint()
			arg_38_0._pointItem[iter_38_1].comp:updateUI()
		end
	end
end

function var_0_0.updateCurLine(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	if not arg_39_2 and arg_39_0._curShowLine and arg_39_0._curLinePointId then
		arg_39_0:recycleLineGo(arg_39_0._curShowLine)

		arg_39_0._curShowLine = nil

		return
	end

	if arg_39_1 == nil or #arg_39_1 == 0 then
		return
	end

	local var_39_0 = arg_39_1[#arg_39_1]

	if arg_39_0._curLinePointId ~= var_39_0 and arg_39_0._curShowLine ~= nil then
		arg_39_0:recycleLineGo(arg_39_0._curShowLine)

		arg_39_0._curShowLine = nil
	end

	if var_39_0 ~= nil and arg_39_2 and arg_39_0._curShowLine == nil then
		arg_39_0._curShowLine = arg_39_0:getLineObject()

		local var_39_1 = YeShuMeiGameModel.instance:getPointById(var_39_0)

		if var_39_1 then
			local var_39_2, var_39_3 = var_39_1:getPosXY()

			arg_39_0:setLineData(arg_39_0._curShowLine, var_39_2, var_39_3, arg_39_3 or var_39_2, arg_39_4 or var_39_3)
			gohelper.setActive(arg_39_0._curShowLine.go, true)
		end

		arg_39_0._curLinePointId = var_39_0
	end

	if arg_39_0._curShowLine ~= nil then
		local var_39_4 = YeShuMeiGameModel.instance:getPointById(var_39_0)

		if var_39_4 then
			local var_39_5, var_39_6 = var_39_4:getPosXY()

			arg_39_0:setLineData(arg_39_0._curShowLine, var_39_5, var_39_6, arg_39_3 or var_39_5, arg_39_4 or var_39_6)
		end
	end
end

function var_0_0.setLineData(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	local var_40_0 = arg_40_1.transform

	transformhelper.setLocalPosXY(var_40_0, arg_40_2, arg_40_3)

	local var_40_1 = MathUtil.vec2_length(arg_40_2, arg_40_3, arg_40_4, arg_40_5)

	recthelper.setWidth(var_40_0, var_40_1)

	local var_40_2 = MathUtil.calculateV2Angle(arg_40_4, arg_40_5, arg_40_2, arg_40_3)

	transformhelper.setEulerAngles(var_40_0, 0, 0, var_40_2)

	local var_40_3 = YeShuMeiGameModel.instance:getWrong()

	gohelper.setActive(arg_40_1.gonormal, not var_40_3)
	gohelper.setActive(arg_40_1.godisturb, var_40_3)
end

function var_0_0.getLineObject(arg_41_0)
	if arg_41_0._lineItemPools == nil then
		local var_41_0 = 20

		arg_41_0._lineItemPools = LuaObjPool.New(var_41_0, function()
			local var_42_0 = arg_41_0:getUserDataTb_()

			var_42_0.go = gohelper.cloneInPlace(arg_41_0._goshowline, "showLine")
			var_42_0.transform = var_42_0.go.transform
			var_42_0.gonormal = gohelper.findChild(var_42_0.go, "#go_normal")
			var_42_0.godisturb = gohelper.findChild(var_42_0.go, "#go_disturb")

			return var_42_0
		end, function(arg_43_0)
			if arg_43_0 then
				gohelper.destroy(arg_43_0.go)
			end
		end, function(arg_44_0)
			if arg_44_0 then
				gohelper.setActive(arg_44_0.go, false)
				gohelper.setActive(arg_44_0.gonormal, true)
				gohelper.setActive(arg_44_0.godisturb, false)
			end
		end)
	end

	return (arg_41_0._lineItemPools:getObject())
end

function var_0_0.recycleLineGo(arg_45_0, arg_45_1)
	if arg_45_1 == nil then
		return
	end

	gohelper.setActive(arg_45_1.gameObject, false)

	if arg_45_0._lineItemPools ~= nil then
		arg_45_0._lineItemPools:putObject(arg_45_1)
	end
end

function var_0_0.setNextLevelGame(arg_46_0)
	arg_46_0:_deletePoint()
	arg_46_0:_clearLines()
	arg_46_0:_showShadow(true)

	arg_46_0._canDrag = false
	arg_46_0._gameMo = YeShuMeiGameModel.instance:getGameMo()
end

function var_0_0._onBtnComlete(arg_47_0)
	YeShuMeiController.instance:_onGameFinished(VersionActivity3_1Enum.ActivityId.YeShuMei, arg_47_0._episodeId)
end

function var_0_0._showGuideDrag(arg_48_0, arg_48_1)
	local var_48_0 = tonumber(arg_48_1) == 1

	gohelper.setActive(arg_48_0._goguid, var_48_0)
end

function var_0_0.onClose(arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._toNextLevel, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._afterShowShadow, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._initGame, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._gameFinish, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._animShadowOut, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._switchShowShadow, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._onClickUp, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._onClickShadowOut, arg_49_0)
end

return var_0_0
