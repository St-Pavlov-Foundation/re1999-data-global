module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanel", package.seeall)

slot0 = class("V1a4_BossRush_ResultPanel", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._goDouble = gohelper.findChild(slot0.viewGO, "Root/Right/#go_Double")
	slot0._goask = gohelper.findChild(slot0.viewGO, "Root/Right/#go_Double/#go_ask")
	slot0._txtDouble = gohelper.findChildText(slot0.viewGO, "Root/Right/#go_Double/#go_ask/#txt_Double")
	slot0._btnOK = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/#go_Double/#go_ask/#btn_OK")
	slot0._goconfirm = gohelper.findChild(slot0.viewGO, "Root/Right/#go_Double/#go_confirm")
	slot0._btnScore = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/Total/txt_Total/#btn_Score")
	slot0._goDetailsRootXY = gohelper.findChild(slot0.viewGO, "Root/Right/Total/txt_Total/#btn_Score/#go_DetailsRootXY")
	slot0._txtTotalScore = gohelper.findChildText(slot0.viewGO, "Root/Right/Total/#txt_TotalScore")
	slot0._goSlider = gohelper.findChild(slot0.viewGO, "Root/Right/Slider/#go_Slider")
	slot0._scrollprogress = gohelper.findChildScrollRect(slot0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress")
	slot0._goprefabInst = gohelper.findChild(slot0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	slot0._imageSliderBG = gohelper.findChildImage(slot0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	slot0._imageSliderFG1 = gohelper.findChildImage(slot0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	slot0._imageSliderFG2 = gohelper.findChildImage(slot0.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	slot0._goAssessScore = gohelper.findChild(slot0.viewGO, "Root/#go_AssessScore")
	slot0._goDetailsRoot = gohelper.findChild(slot0.viewGO, "Root/#go_DetailsRoot")
	slot0._btnempty = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#go_DetailsRoot/#btn_empty")
	slot0._godetails = gohelper.findChild(slot0.viewGO, "Root/#go_DetailsRoot/#go_details")
	slot0._scrollscore = gohelper.findChildScrollRect(slot0.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score")
	slot0._goscore = gohelper.findChild(slot0.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score/Viewport/Content/#go_score")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score/Viewport/Content/#go_score/#txt_score")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "Root/#go_DetailsRoot/#go_details/#txt_total")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnOK:AddClickListener(slot0._btnOKOnClick, slot0)
	slot0._btnScore:AddClickListener(slot0._btnScoreOnClick, slot0)
	slot0._btnempty:AddClickListener(slot0._btnemptyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnOK:RemoveClickListener()
	slot0._btnScore:RemoveClickListener()
	slot0._btnempty:RemoveClickListener()
end

slot1 = string.format
slot2 = BossRushEnum.AnimEvtResultPanel
slot3 = 1.5

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._btnOKOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_role.play_ui_role_cover_open_1)
	BossRushRpc.instance:sendAct128DoublePointRequest(slot0._curStage)
end

function slot0._btnScoreOnClick(slot0)
	slot0:_setActiveDetail(true)
end

function slot0._btnemptyOnClick(slot0)
	slot0:_setActiveDetail(false)
end

function slot0._editableInitView(slot0)
	FightController.instance:checkFightQuitTipViewClose()

	slot0._goDetailsRootTran = slot0._goDetailsRoot.transform
	slot0._goDetailsRootXYTran = slot0._goDetailsRootXY.transform
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._animEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0._completeAnimEvent = gohelper.findChild(slot0.viewGO, "Root/Complete"):GetComponent(gohelper.Type_AnimationEventWrap)

	slot0:_initAssessScore()

	slot0._imageSliderFG1Tran = slot0._imageSliderFG1:GetComponent(gohelper.Type_RectTransform)
	slot0._imageSliderFG2Tran = slot0._imageSliderFG2:GetComponent(gohelper.Type_RectTransform)
	slot0._imageSliderBGTran = slot0._imageSliderBG:GetComponent(gohelper.Type_RectTransform)

	slot0._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_resultpanelbg"))

	slot0._txtDouble.text = ""
	slot0._txtTotalScore.text = ""

	recthelper.setWidth(slot0._imageSliderFG1Tran, 0)
	recthelper.setWidth(slot0._imageSliderFG2Tran, 0)
	gohelper.setActive(slot0._goconfirm, false)
	gohelper.setActive(slot0._goprefabInst, false)
	slot0:_setActiveDetail(false)

	slot0._viewportWidth = recthelper.getWidth(slot0._scrollprogress.transform)
	slot0._goprefabInstX = recthelper.getAnchorX(slot0._goprefabInst.transform)

	slot0._animEvent:AddEventListener(uv0.onOpenEnd, slot0._onOpenEnd, slot0)
	slot0._completeAnimEvent:AddEventListener(uv0.onCompleteOpenStart, slot0._onCompleteOpenStart, slot0)
	gohelper.setActive(slot0._btnScore, false)

	slot0._scrollprogressContentTran = slot0._scrollprogress.content
end

function slot0._initAssessScore(slot0)
	slot1 = V1a4_BossRush_Assess_Score
	slot0._assessScore = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, slot0._goAssessScore, slot1.__cname), slot1)

	slot0._assessScore:setActiveDesc(false)
	slot0._assessIcon:initData(slot0, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._curStage, slot0._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	slot6 = BossRushModel.instance:getStagePointInfo(slot1)

	gohelper.setActive(slot0._goDouble, BossRushModel.instance:getFightScore() > 0 and BossRushController.instance:isInBossRushInfiniteFight(true) and BossRushModel.instance:getDoubleTimesInfo(slot0._curStage).cur > 0)
	slot0._assessScore:setData(slot1, slot3)
	slot0._assessScore:setActiveNewRecord(BossRushModel.instance:checkIsNewHighestPointRecord(slot1))

	slot8, slot9 = BossRushConfig.instance:getAssessSpriteName(slot1, slot3, BossRushModel.instance:isSpecialLayer(slot0._curLayer))

	if slot9 > 0 then
		slot0._anim:Play(BossRushEnum.AnimResultPanel.InNotEmpty)
	else
		slot0._anim:Play(BossRushEnum.AnimResultPanel.InEmpty)
	end

	slot0._maxValue = slot6.max
	slot0._lastValue = slot6.cur
	slot0._firstValue = math.min(slot6.max, slot6.cur + slot3)

	slot0:_refreshDoubleInfo()
	slot0:_refreshDetailScore()
	slot0:_refreshProgressBar(slot6.cur)
	slot0:_refreshTxtTotalScore(slot6.cur, slot6.max)
	BossRushController.instance:registerCallback(BossRushEvent.OnReceiveAct128DoublePointRequestReply, slot0._onReceiveAct128DoublePointRequestReply, slot0)
end

function slot0.onOpenFinish(slot0)
	slot0:_updateContentPosX()
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveAct128DoublePointRequestReply, slot0._onReceiveAct128DoublePointRequestReply, slot0)
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ResultView, slot0.viewParam)
end

function slot0.onDestroyView(slot0)
	slot0:_setActiveDetail(false)
	slot0:_deleteTweens()
	slot0._animEvent:RemoveEventListener(uv0.onOpenEnd)
	slot0._completeAnimEvent:RemoveEventListener(uv0.onCompleteOpenStart)
	slot0._simagePanelBG:UnLoadImage()
end

function slot0._refreshTxtTotalScore(slot0, slot1, slot2)
	slot0._txtTotalScore.text = uv0("<color=#FF8640>%s</color>/%s", slot1 or 0, slot2 or 0)
end

function slot0._refresh(slot0)
	slot0:_progressBarTween(slot0._firstValue)
end

function slot0._refreshDoubleInfo(slot0)
	slot2 = BossRushModel.instance:getDoubleTimesInfo(slot0._curStage)
	slot0._txtDouble.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_bossrush_resultpanel_txt_double"), {
		slot2.cur,
		slot2.max
	})
end

function slot0._refreshProgressBar(slot0, slot1, slot2)
	slot5 = slot0._maxValue
	slot7, slot8 = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(slot0._curStage, slot1, slot0.viewContainer:getListScrollParam(), slot0._goprefabInstX, 0, 0)

	recthelper.setWidth(slot0._imageSliderBGTran, slot8)
	recthelper.setWidth(slot0._imageSliderFG1Tran, slot7)

	slot9 = slot7

	if slot2 then
		recthelper.setWidth(slot0._imageSliderFG2Tran, math.max(0, BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(slot4, slot2, slot3, slot6, 0, 0) - slot7))
	end

	slot0:_refreshProgressBarPoints(slot2 or slot1)
	slot0:_refreshTxtTotalScore(slot2 or slot1, slot5)
end

function slot0._calcProgressBarWidth(slot0, slot1, slot2)
	slot8, slot7 = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(slot0._curStage, slot1, slot0.viewContainer:getListScrollParam(), slot0._goprefabInstX, 0, 0)

	if slot2 then
		slot8 = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(slot4, slot2, slot3, slot5, 0, 0)
	end

	return slot6, slot8, slot7
end

function slot0._deleteTweens(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_progressBar1TweenId")
	GameUtil.onDestroyViewMember_TweenId(slot0, "_progressBar2TweenId")
	GameUtil.onDestroyViewMember_TweenId(slot0, "_txtTotalScoreTweenId")
end

function slot0._progressBarTween(slot0, slot1, slot2)
	slot3 = slot0._maxValue

	slot0:_deleteTweens()

	slot4, slot5, slot6 = slot0:_calcProgressBarWidth(slot1, slot2)
	slot7 = math.max(0, slot5 - slot4)
	slot8, slot9 = nil

	recthelper.setWidth(slot0._imageSliderBGTran, slot6)

	if math.abs(recthelper.getWidth(slot0._imageSliderFG1Tran) - slot4) > 0.1 and slot8 < slot3 then
		slot0._progressBar1TweenId = ZProj.TweenHelper.DOTweenFloat(slot8, slot9, uv0, slot0._progressBar1TweenUpdateCb, slot0._progressBar1TweenEndCb, slot0, nil, EaseType.OutQuad)

		AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_progress_loop)
	end

	if slot2 and math.abs(recthelper.getWidth(slot0._imageSliderFG2Tran) - slot7) > 0.1 and slot8 < slot3 then
		slot0._progressBar2TweenId = ZProj.TweenHelper.DOTweenFloat(slot8, slot9, uv0, slot0._progressBar2TweenUpdateCb, slot0._progressBar2TweenEndCb, slot0, nil, EaseType.OutQuad)

		AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_progress_loop)
	end

	if not slot2 then
		slot8 = slot0._lastValue
		slot9 = slot1
	else
		slot8 = slot1
		slot9 = slot2
	end

	slot0._txtTotalScoreTweenId = ZProj.TweenHelper.DOTweenFloat(slot8, slot9, uv0, slot0._txtTotalScoreTweenUpdateCb, nil, slot0, nil, EaseType.OutQuad)

	slot0:_refreshProgressBarPoints(slot2 or slot1)
end

function slot0._updateContentPosX(slot0)
	if math.abs(-math.min(math.max(0, recthelper.getWidth(slot0._scrollprogressContentTran) - slot0._viewportWidth), recthelper.getWidth(slot0._imageSliderFG1Tran) + recthelper.getWidth(slot0._imageSliderFG2Tran) < slot0._viewportWidth * 0.5 and 0 or slot6 - slot1) - recthelper.getAnchorX(slot0._scrollprogressContentTran)) < 0.1 then
		return
	end

	recthelper.setAnchorX(slot0._scrollprogressContentTran, slot7)
end

function slot0._progressBar1TweenUpdateCb(slot0, slot1)
	recthelper.setWidth(slot0._imageSliderFG1Tran, slot1)
	slot0:_updateContentPosX()
end

function slot0._progressBar1TweenEndCb(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
end

function slot0._progressBar2TweenUpdateCb(slot0, slot1)
	recthelper.setWidth(slot0._imageSliderFG2Tran, slot1)
	slot0:_updateContentPosX()
end

function slot0._progressBar2TweenEndCb(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
end

function slot0._txtTotalScoreTweenUpdateCb(slot0, slot1)
	slot0:_refreshTxtTotalScore(math.modf(slot1), slot0._maxValue)
end

function slot0._refreshProgressBarPoints(slot0, slot1)
	V1a4_BossRush_ResultPanelListModel.instance:setList(BossRushModel.instance:getResultPanelProgressBarPointList(slot0._curStage, slot1))
end

function slot0._onReceiveAct128DoublePointRequestReply(slot0, slot1)
	gohelper.setActive(slot0._goconfirm, true)
	gohelper.setActive(slot0._goask, false)
	slot0:_progressBarTween(slot0._firstValue, slot1)
end

function slot0._refreshDetailScore(slot0)
	slot0._txttotal.text = formatLuaLang("v1a4_bossrush_resultpanel_txt_total", BossRushModel.instance:getFightScore())
	slot2 = #BossRushModel.instance:getStageScore(slot0._curStage, slot0._curLayer)

	if not slot0._itemsetailScore then
		slot0._itemsetailScore = slot0:getUserDataTb_()
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot6 > #slot0._itemsetailScore then
			slot0._itemsetailScore[slot6] = gohelper.cloneInPlace(slot0._goscore)
		end

		gohelper.findChildText(slot0._itemsetailScore[slot6], "#txt_score").text = string.format(luaLang("p_v1a4_bossrush_resultpanel_txt_bosslosehp"), slot6, slot7)
	end

	for slot6, slot7 in ipairs(slot0._itemsetailScore) do
		gohelper.setActive(slot7, slot6 <= slot2)
	end
end

function slot0._onCompleteOpenStart(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_win)
end

function slot0._onOpenEnd(slot0)
	slot0:_refresh()
end

function slot0._setActiveDetail(slot0, slot1)
	if slot1 then
		slot2, slot3 = recthelper.getAnchor(slot0._goDetailsRootXYTran)

		recthelper.setAnchor(slot0._goDetailsRootTran, slot2, slot3)
	end

	gohelper.setActive(slot0._goDetailsRoot, slot1)
end

return slot0
