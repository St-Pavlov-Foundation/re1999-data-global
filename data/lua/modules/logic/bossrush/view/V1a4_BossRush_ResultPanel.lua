module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanel", package.seeall)

local var_0_0 = class("V1a4_BossRush_ResultPanel", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._goDouble = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_Double")
	arg_1_0._goask = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_Double/#go_ask")
	arg_1_0._txtDouble = gohelper.findChildText(arg_1_0.viewGO, "Root/Right/#go_Double/#go_ask/#txt_Double")
	arg_1_0._btnOK = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#go_Double/#go_ask/#btn_OK")
	arg_1_0._goconfirm = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#go_Double/#go_confirm")
	arg_1_0._btnScore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/Total/txt_Total/#btn_Score")
	arg_1_0._goDetailsRootXY = gohelper.findChild(arg_1_0.viewGO, "Root/Right/Total/txt_Total/#btn_Score/#go_DetailsRootXY")
	arg_1_0._txtTotalScore = gohelper.findChildText(arg_1_0.viewGO, "Root/Right/Total/#txt_TotalScore")
	arg_1_0._goSlider = gohelper.findChild(arg_1_0.viewGO, "Root/Right/Slider/#go_Slider")
	arg_1_0._scrollprogress = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress")
	arg_1_0._goprefabInst = gohelper.findChild(arg_1_0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	arg_1_0._imageSliderBG = gohelper.findChildImage(arg_1_0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	arg_1_0._imageSliderFG1 = gohelper.findChildImage(arg_1_0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	arg_1_0._imageSliderFG2 = gohelper.findChildImage(arg_1_0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	arg_1_0._goAssessScore = gohelper.findChild(arg_1_0.viewGO, "Root/#go_AssessScore")
	arg_1_0._goDetailsRoot = gohelper.findChild(arg_1_0.viewGO, "Root/#go_DetailsRoot")
	arg_1_0._btnempty = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#go_DetailsRoot/#btn_empty")
	arg_1_0._godetails = gohelper.findChild(arg_1_0.viewGO, "Root/#go_DetailsRoot/#go_details")
	arg_1_0._scrollscore = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score")
	arg_1_0._goscore = gohelper.findChild(arg_1_0.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score/Viewport/Content/#go_score")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score/Viewport/Content/#go_score/#txt_score")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_DetailsRoot/#go_details/#txt_total")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnOK:AddClickListener(arg_2_0._btnOKOnClick, arg_2_0)
	arg_2_0._btnScore:AddClickListener(arg_2_0._btnScoreOnClick, arg_2_0)
	arg_2_0._btnempty:AddClickListener(arg_2_0._btnemptyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnOK:RemoveClickListener()
	arg_3_0._btnScore:RemoveClickListener()
	arg_3_0._btnempty:RemoveClickListener()
end

local var_0_1 = string.format
local var_0_2 = BossRushEnum.AnimEvtResultPanel
local var_0_3 = 1.5

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnOKOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.ui_role.play_ui_role_cover_open_1)

	local var_5_0 = arg_5_0._curStage

	BossRushRpc.instance:sendAct128DoublePointRequest(var_5_0)
end

function var_0_0._btnScoreOnClick(arg_6_0)
	arg_6_0:_setActiveDetail(true)
end

function var_0_0._btnemptyOnClick(arg_7_0)
	arg_7_0:_setActiveDetail(false)
end

function var_0_0._editableInitView(arg_8_0)
	FightController.instance:checkFightQuitTipViewClose()

	arg_8_0._goDetailsRootTran = arg_8_0._goDetailsRoot.transform
	arg_8_0._goDetailsRootXYTran = arg_8_0._goDetailsRootXY.transform
	arg_8_0._anim = arg_8_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_8_0._animEvent = arg_8_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_8_0._completeAnimEvent = gohelper.findChild(arg_8_0.viewGO, "Root/Complete"):GetComponent(gohelper.Type_AnimationEventWrap)

	arg_8_0:_initAssessScore()

	arg_8_0._imageSliderFG1Tran = arg_8_0._imageSliderFG1:GetComponent(gohelper.Type_RectTransform)
	arg_8_0._imageSliderFG2Tran = arg_8_0._imageSliderFG2:GetComponent(gohelper.Type_RectTransform)
	arg_8_0._imageSliderBGTran = arg_8_0._imageSliderBG:GetComponent(gohelper.Type_RectTransform)

	arg_8_0._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_resultpanelbg"))

	arg_8_0._txtDouble.text = ""
	arg_8_0._txtTotalScore.text = ""

	recthelper.setWidth(arg_8_0._imageSliderFG1Tran, 0)
	recthelper.setWidth(arg_8_0._imageSliderFG2Tran, 0)
	gohelper.setActive(arg_8_0._goconfirm, false)
	gohelper.setActive(arg_8_0._goprefabInst, false)
	arg_8_0:_setActiveDetail(false)

	arg_8_0._viewportWidth = recthelper.getWidth(arg_8_0._scrollprogress.transform)
	arg_8_0._goprefabInstX = recthelper.getAnchorX(arg_8_0._goprefabInst.transform)

	arg_8_0._animEvent:AddEventListener(var_0_2.onOpenEnd, arg_8_0._onOpenEnd, arg_8_0)
	arg_8_0._completeAnimEvent:AddEventListener(var_0_2.onCompleteOpenStart, arg_8_0._onCompleteOpenStart, arg_8_0)
	gohelper.setActive(arg_8_0._btnScore, false)

	arg_8_0._scrollprogressContentTran = arg_8_0._scrollprogress.content
end

function var_0_0._initAssessScore(arg_9_0)
	local var_9_0 = V1a4_BossRush_Assess_Score
	local var_9_1 = arg_9_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, arg_9_0._goAssessScore, var_9_0.__cname)

	arg_9_0._assessScore = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, var_9_0)

	arg_9_0._assessScore:setActiveDesc(false)
	arg_9_0._assessIcon:initData(arg_9_0, false)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._curStage, arg_11_0._curLayer = BossRushModel.instance:getBattleStageAndLayer()

	local var_11_0 = arg_11_0._curStage
	local var_11_1 = BossRushController.instance:isInBossRushInfiniteFight(true)
	local var_11_2 = BossRushModel.instance:getFightScore()
	local var_11_3 = BossRushModel.instance:getDoubleTimesInfo(var_11_0)
	local var_11_4 = var_11_2 > 0 and var_11_1 and var_11_3.cur > 0
	local var_11_5 = BossRushModel.instance:getStagePointInfo(var_11_0)

	gohelper.setActive(arg_11_0._goDouble, var_11_4)
	arg_11_0._assessScore:setData(var_11_0, var_11_2)
	arg_11_0._assessScore:setActiveNewRecord(BossRushModel.instance:checkIsNewHighestPointRecord(var_11_0))

	local var_11_6 = BossRushModel.instance:isSpecialLayer(arg_11_0._curLayer)
	local var_11_7, var_11_8 = BossRushConfig.instance:getAssessSpriteName(var_11_0, var_11_2, var_11_6)

	if var_11_8 > 0 then
		arg_11_0._anim:Play(BossRushEnum.AnimResultPanel.InNotEmpty)
	else
		arg_11_0._anim:Play(BossRushEnum.AnimResultPanel.InEmpty)
	end

	arg_11_0._maxValue = var_11_5.max
	arg_11_0._lastValue = var_11_5.cur
	arg_11_0._firstValue = math.min(var_11_5.max, var_11_5.cur + var_11_2)

	arg_11_0:_refreshDoubleInfo()
	arg_11_0:_refreshDetailScore()
	arg_11_0:_refreshProgressBar(var_11_5.cur)
	arg_11_0:_refreshTxtTotalScore(var_11_5.cur, var_11_5.max)
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveAct128DoublePointRequestReply, arg_11_0._onReceiveAct128DoublePointRequestReply, arg_11_0)
end

function var_0_0.onOpenFinish(arg_12_0)
	arg_12_0:_updateContentPosX()
end

function var_0_0.onClose(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveAct128DoublePointRequestReply, arg_13_0._onReceiveAct128DoublePointRequestReply, arg_13_0)
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ResultView, arg_13_0.viewParam)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0:_setActiveDetail(false)
	arg_14_0:_deleteTweens()
	arg_14_0._animEvent:RemoveEventListener(var_0_2.onOpenEnd)
	arg_14_0._completeAnimEvent:RemoveEventListener(var_0_2.onCompleteOpenStart)
	arg_14_0._simagePanelBG:UnLoadImage()
end

function var_0_0._refreshTxtTotalScore(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._txtTotalScore.text = var_0_1("<color=#FF8640>%s</color>/%s", arg_15_1 or 0, arg_15_2 or 0)
end

function var_0_0._refresh(arg_16_0)
	arg_16_0:_progressBarTween(arg_16_0._firstValue)
end

function var_0_0._refreshDoubleInfo(arg_17_0)
	local var_17_0 = arg_17_0._curStage
	local var_17_1 = BossRushModel.instance:getDoubleTimesInfo(var_17_0)
	local var_17_2 = {
		var_17_1.cur,
		var_17_1.max
	}

	arg_17_0._txtDouble.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_bossrush_resultpanel_txt_double"), var_17_2)
end

function var_0_0._refreshProgressBar(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.viewContainer:getListScrollParam()
	local var_18_1 = arg_18_0._curStage
	local var_18_2 = arg_18_0._maxValue
	local var_18_3 = arg_18_0._goprefabInstX
	local var_18_4, var_18_5 = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(var_18_1, arg_18_1, var_18_0, var_18_3, 0, 0)

	recthelper.setWidth(arg_18_0._imageSliderBGTran, var_18_5)
	recthelper.setWidth(arg_18_0._imageSliderFG1Tran, var_18_4)

	local var_18_6 = var_18_4

	if arg_18_2 then
		local var_18_7 = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(var_18_1, arg_18_2, var_18_0, var_18_3, 0, 0)

		recthelper.setWidth(arg_18_0._imageSliderFG2Tran, math.max(0, var_18_7 - var_18_4))
	end

	arg_18_0:_refreshProgressBarPoints(arg_18_2 or arg_18_1)
	arg_18_0:_refreshTxtTotalScore(arg_18_2 or arg_18_1, var_18_2)
end

function var_0_0._calcProgressBarWidth(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.viewContainer:getListScrollParam()
	local var_19_1 = arg_19_0._curStage
	local var_19_2 = arg_19_0._goprefabInstX
	local var_19_3, var_19_4 = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(var_19_1, arg_19_1, var_19_0, var_19_2, 0, 0)
	local var_19_5 = var_19_3

	if arg_19_2 then
		var_19_5 = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(var_19_1, arg_19_2, var_19_0, var_19_2, 0, 0)
	end

	return var_19_3, var_19_5, var_19_4
end

function var_0_0._deleteTweens(arg_20_0)
	GameUtil.onDestroyViewMember_TweenId(arg_20_0, "_progressBar1TweenId")
	GameUtil.onDestroyViewMember_TweenId(arg_20_0, "_progressBar2TweenId")
	GameUtil.onDestroyViewMember_TweenId(arg_20_0, "_txtTotalScoreTweenId")
end

function var_0_0._progressBarTween(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._maxValue

	arg_21_0:_deleteTweens()

	local var_21_1, var_21_2, var_21_3 = arg_21_0:_calcProgressBarWidth(arg_21_1, arg_21_2)
	local var_21_4 = math.max(0, var_21_2 - var_21_1)
	local var_21_5
	local var_21_6

	recthelper.setWidth(arg_21_0._imageSliderBGTran, var_21_3)

	local var_21_7 = recthelper.getWidth(arg_21_0._imageSliderFG1Tran)
	local var_21_8 = var_21_1

	if math.abs(var_21_7 - var_21_8) > 0.1 and var_21_7 < var_21_0 then
		arg_21_0._progressBar1TweenId = ZProj.TweenHelper.DOTweenFloat(var_21_7, var_21_8, var_0_3, arg_21_0._progressBar1TweenUpdateCb, arg_21_0._progressBar1TweenEndCb, arg_21_0, nil, EaseType.OutQuad)

		AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_progress_loop)
	end

	if arg_21_2 then
		var_21_7 = recthelper.getWidth(arg_21_0._imageSliderFG2Tran)
		var_21_8 = var_21_4

		if math.abs(var_21_7 - var_21_8) > 0.1 and var_21_7 < var_21_0 then
			arg_21_0._progressBar2TweenId = ZProj.TweenHelper.DOTweenFloat(var_21_7, var_21_8, var_0_3, arg_21_0._progressBar2TweenUpdateCb, arg_21_0._progressBar2TweenEndCb, arg_21_0, nil, EaseType.OutQuad)

			AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_progress_loop)
		end
	end

	if not arg_21_2 then
		var_21_7 = arg_21_0._lastValue
		var_21_8 = arg_21_1
	else
		var_21_7 = arg_21_1
		var_21_8 = arg_21_2
	end

	arg_21_0._txtTotalScoreTweenId = ZProj.TweenHelper.DOTweenFloat(var_21_7, var_21_8, var_0_3, arg_21_0._txtTotalScoreTweenUpdateCb, nil, arg_21_0, nil, EaseType.OutQuad)

	arg_21_0:_refreshProgressBarPoints(arg_21_2 or arg_21_1)
end

function var_0_0._updateContentPosX(arg_22_0)
	local var_22_0 = arg_22_0._viewportWidth * 0.5
	local var_22_1 = recthelper.getWidth(arg_22_0._imageSliderFG1Tran)
	local var_22_2 = recthelper.getWidth(arg_22_0._imageSliderFG2Tran)
	local var_22_3 = recthelper.getWidth(arg_22_0._scrollprogressContentTran)
	local var_22_4 = math.max(0, var_22_3 - arg_22_0._viewportWidth)
	local var_22_5 = var_22_1 + var_22_2
	local var_22_6 = -math.min(var_22_4, var_22_5 < var_22_0 and 0 or var_22_5 - var_22_0)
	local var_22_7 = recthelper.getAnchorX(arg_22_0._scrollprogressContentTran)

	if math.abs(var_22_6 - var_22_7) < 0.1 then
		return
	end

	recthelper.setAnchorX(arg_22_0._scrollprogressContentTran, var_22_6)
end

function var_0_0._progressBar1TweenUpdateCb(arg_23_0, arg_23_1)
	recthelper.setWidth(arg_23_0._imageSliderFG1Tran, arg_23_1)
	arg_23_0:_updateContentPosX()
end

function var_0_0._progressBar1TweenEndCb(arg_24_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
end

function var_0_0._progressBar2TweenUpdateCb(arg_25_0, arg_25_1)
	recthelper.setWidth(arg_25_0._imageSliderFG2Tran, arg_25_1)
	arg_25_0:_updateContentPosX()
end

function var_0_0._progressBar2TweenEndCb(arg_26_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
end

function var_0_0._txtTotalScoreTweenUpdateCb(arg_27_0, arg_27_1)
	arg_27_1 = math.modf(arg_27_1)

	arg_27_0:_refreshTxtTotalScore(arg_27_1, arg_27_0._maxValue)
end

function var_0_0._refreshProgressBarPoints(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._curStage
	local var_28_1 = BossRushModel.instance:getResultPanelProgressBarPointList(var_28_0, arg_28_1)

	V1a4_BossRush_ResultPanelListModel.instance:setList(var_28_1)
end

function var_0_0._onReceiveAct128DoublePointRequestReply(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_0._goconfirm, true)
	gohelper.setActive(arg_29_0._goask, false)
	arg_29_0:_progressBarTween(arg_29_0._firstValue, arg_29_1)
end

function var_0_0._refreshDetailScore(arg_30_0)
	arg_30_0._txttotal.text = formatLuaLang("v1a4_bossrush_resultpanel_txt_total", BossRushModel.instance:getFightScore())

	local var_30_0 = BossRushModel.instance:getStageScore(arg_30_0._curStage, arg_30_0._curLayer)
	local var_30_1 = #var_30_0

	if not arg_30_0._itemsetailScore then
		arg_30_0._itemsetailScore = arg_30_0:getUserDataTb_()
	end

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		if iter_30_0 > #arg_30_0._itemsetailScore then
			local var_30_2 = gohelper.cloneInPlace(arg_30_0._goscore)

			arg_30_0._itemsetailScore[iter_30_0] = var_30_2
		end

		local var_30_3 = gohelper.findChildText(arg_30_0._itemsetailScore[iter_30_0], "#txt_score")
		local var_30_4 = luaLang("p_v1a4_bossrush_resultpanel_txt_bosslosehp")

		var_30_3.text = string.format(var_30_4, iter_30_0, iter_30_1)
	end

	for iter_30_2, iter_30_3 in ipairs(arg_30_0._itemsetailScore) do
		gohelper.setActive(iter_30_3, iter_30_2 <= var_30_1)
	end
end

function var_0_0._onCompleteOpenStart(arg_31_0)
	AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_win)
end

function var_0_0._onOpenEnd(arg_32_0)
	arg_32_0:_refresh()
end

function var_0_0._setActiveDetail(arg_33_0, arg_33_1)
	if arg_33_1 then
		local var_33_0, var_33_1 = recthelper.getAnchor(arg_33_0._goDetailsRootXYTran)

		recthelper.setAnchor(arg_33_0._goDetailsRootTran, var_33_0, var_33_1)
	end

	gohelper.setActive(arg_33_0._goDetailsRoot, arg_33_1)
end

return var_0_0
