module("modules.logic.rouge.view.RougeSettlementView", package.seeall)

slot0 = class("RougeSettlementView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#go_fail/#simage_mask")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title/#txt_Title")
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_replay")
	slot0._simagerightmask = gohelper.findChildSingleImage(slot0.viewGO, "img_dec/#simage_rightmask")
	slot0._simageleftmask = gohelper.findChildSingleImage(slot0.viewGO, "img_dec/#simage_leftmask")
	slot0._simagerightmask2 = gohelper.findChildSingleImage(slot0.viewGO, "img_dec/#simage_rightmask2")
	slot0._simageleftmask2 = gohelper.findChildSingleImage(slot0.viewGO, "img_dec/#simage_leftmask2")
	slot0._simagepoint = gohelper.findChildSingleImage(slot0.viewGO, "img_dec/#simage_point")
	slot0._simagepoint2 = gohelper.findChildSingleImage(slot0.viewGO, "img_dec/#simage_point2")
	slot0._txtscore1 = gohelper.findChildText(slot0.viewGO, "mode1/#txt_score1")
	slot0._txtnum1 = gohelper.findChildText(slot0.viewGO, "mode1/#txt_num1")
	slot0._txtscore2 = gohelper.findChildText(slot0.viewGO, "mode2/#txt_score2")
	slot0._txtnum2 = gohelper.findChildText(slot0.viewGO, "mode2/#txt_num2")
	slot0._txtscore3 = gohelper.findChildText(slot0.viewGO, "mode3/#txt_score3")
	slot0._txtnum3 = gohelper.findChildText(slot0.viewGO, "mode3/#txt_num3")
	slot0._gocollection = gohelper.findChild(slot0.viewGO, "#go_collection")
	slot0._txtcollectionscore = gohelper.findChildText(slot0.viewGO, "#go_collection/#txt_collectionscore")
	slot0._txtcollectionnum = gohelper.findChildText(slot0.viewGO, "#go_collection/#txt_collectionnum")
	slot0._golevel = gohelper.findChild(slot0.viewGO, "#go_level")
	slot0._txtlevelscore = gohelper.findChildText(slot0.viewGO, "#go_level/#txt_levelscore")
	slot0._txtlevelnum = gohelper.findChildText(slot0.viewGO, "#go_level/#txt_levelnum")
	slot0._gotask = gohelper.findChild(slot0.viewGO, "#go_task")
	slot0._txttaskscore = gohelper.findChildText(slot0.viewGO, "#go_task/#txt_taskscore")
	slot0._txttasknum = gohelper.findChildText(slot0.viewGO, "#go_task/#txt_tasknum")
	slot0._goending = gohelper.findChild(slot0.viewGO, "#go_ending")
	slot0._txtendingscore = gohelper.findChildText(slot0.viewGO, "#go_ending/#txt_endingscore")
	slot0._txtendingnum = gohelper.findChildText(slot0.viewGO, "#go_ending/#txt_endingnum")
	slot0._goachieve = gohelper.findChild(slot0.viewGO, "#go_achieve")
	slot0._simagetitlebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_achieve/#simage_titlebg")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_achieve/#scroll_view")
	slot0._goachieveitem = gohelper.findChild(slot0.viewGO, "#go_achieve/#scroll_view/Viewport/Content/#go_achieveitem")
	slot0._simageachieveicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_achieve/#scroll_view/Viewport/Content/#go_achieveitem/normal/#simage_achieveicon")
	slot0._goscore = gohelper.findChild(slot0.viewGO, "#go_score")
	slot0._txtbase = gohelper.findChildText(slot0.viewGO, "#go_score/#txt_base")
	slot0._txtmultiple = gohelper.findChildText(slot0.viewGO, "#go_score/#txt_multiple")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_score/#txt_total")
	slot0._txtaddpoint = gohelper.findChildText(slot0.viewGO, "#go_score/score/#txt_addpoint")
	slot0._sliderprogress = gohelper.findChildSlider(slot0.viewGO, "#go_score/score/#slider_progress")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_score/collection/#simage_icon")
	slot0._txtaddgenius = gohelper.findChildText(slot0.viewGO, "#go_score/collection/#txt_addgenius")
	slot0._slidergeniusprogress = gohelper.findChildSlider(slot0.viewGO, "#go_score/collection/#slider_geniusprogress")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gotipscontainer = gohelper.findChild(slot0.viewGO, "#go_achieve/#go_tipscontainer")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_achieve/#go_tipscontainer/#go_tips")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#go_achieve/#go_tipscontainer/#go_tips/#txt_tips")
	slot0._btnclosetips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_achieve/#go_tipscontainer/#go_tips/#btn_closetips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreplay:AddClickListener(slot0._btnreplayOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclosetips:AddClickListener(slot0._btnclosetipsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreplay:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnclosetips:RemoveClickListener()
end

function slot0._btnreplayOnClick(slot0)
	RougeController.instance:openRougeResultView()
end

function slot0._btncloseOnClick(slot0)
	if (RougeModel.instance:getRougeResult() and slot1.finalScore or 0) > 0 then
		RougeController.instance:openRougeResultReView({
			reviewInfo = slot1.reviewInfo
		})
	else
		ViewMgr.instance:closeView(ViewName.RougeEndingThreeView)
		ViewMgr.instance:closeView(ViewName.RougeResultView)
		slot0:closeThis()
	end
end

function slot0._btnclosetipsOnClick(slot0)
	gohelper.setActive(slot0._gotips, false)
end

function slot0._editableInitView(slot0)
	slot0._badgeItemTab = slot0:getUserDataTb_()

	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinishCallBack, slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, RougeMapHelper.blockEsc)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot2 = RougeModel.instance:getRougeResult() and slot1:isSucceed()

	gohelper.setActive(slot0._gofail, not slot2)
	gohelper.setActive(slot0._gosuccess, slot2)
	slot0:refrehScores(slot1)
	slot0:updateBadgeList(slot1)
end

function slot0.refrehScores(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._txtnum1.text, slot0._txtscore1.text = slot1:getNormalFightCountAndScore()
	slot0._txtnum2.text, slot0._txtscore2.text = slot1:getDifficultFightCountAndScore()
	slot0._txtnum3.text, slot0._txtscore3.text = slot1:getDangerousFightCountAndScore()

	slot0:refreshOverView(slot1)
	slot0:refreshScoreInfo(slot1)
	slot0:refreshRewardPoint(slot1)
	slot0:refreshTalentPoint(slot1)
end

function slot0.refreshOverView(slot0, slot1)
	slot0._txtcollectionnum.text, slot0._txtcollectionscore.text = slot1:getCollectionCountAndScore()
	slot0._txtlevelnum.text, slot0._txtlevelscore.text = slot1:getLayerCountAndScore()
	slot0._txttasknum.text, slot0._txttaskscore.text = slot1:getEntrustCountAndScore()
	slot0._txtendingnum.text, slot0._txtendingscore.text = slot1:getEndCountAndScore()
end

slot0.FinalScoreDuration = 2
slot0.RewardPointDuration = 2
slot0.TalentPointDuration = 2
slot0.RewardPointProgressDuration = 2
slot0.TalentPointProgressDuration = 2
slot0.MaxProgressValue = 1

function slot0.refreshScoreInfo(slot0, slot1)
	slot4 = slot1.finalScore or 0
	slot0._txtbase.text = slot1.beforeScore or 0
	slot0._txtmultiple.text = string.format("%s%%", slot1.scoreReward or 0)

	slot0:killTween("_totalScoreTweenId")

	slot0._totalScoreTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot4, uv0.FinalScoreDuration, slot0.framChangeScoreCallBack, slot0.changeScoreDone, slot0)

	if slot4 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.ComputeScore)
	end
end

function slot0.framChangeScoreCallBack(slot0, slot1)
	slot0._txttotal.text = math.ceil(slot1)
end

function slot0.changeScoreDone(slot0)
	slot0._totalScoreTweenId = nil
end

function slot0.refreshRewardPoint(slot0, slot1)
	slot0:killTween("_rewardPointTweenId")

	slot0._rewardPointTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot1.addPoint or 0, uv0.RewardPointDuration, slot0.frameRewardPointFunc, slot0.rewardPointDone, slot0)

	if slot1.remainScore2Point / tonumber(lua_rouge_const.configDict[RougeEnum.Const.RewardTranslation].value) < (slot1.preRemainScore2Point or 0) / slot5 then
		slot6 = slot6 + uv0.MaxProgressValue
	end

	slot0:killTween("_rewardPointProgressTweenId")

	slot0._rewardPointProgressTweenId = ZProj.TweenHelper.DOTweenFloat(slot8, slot6, uv0.RewardPointProgressDuration, slot0.frameRewardPointProgressFunc, slot0.rewardPointProgressDone, slot0)
end

function slot0.frameRewardPointFunc(slot0, slot1)
	slot0._txtaddpoint.text = math.ceil(slot1)
end

function slot0.rewardPointDone(slot0)
	slot0._rewardPointTweenId = nil
end

function slot0.frameRewardPointProgressFunc(slot0, slot1)
	slot0._sliderprogress:SetValue(slot1 % uv0.MaxProgressValue)
end

function slot0.rewardPointProgressDone(slot0)
	slot0._rewardPointProgressTweenId = nil
end

function slot0.refreshTalentPoint(slot0, slot1)
	slot0:killTween("_talentPointTweenId")

	slot0._talentPointTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot1.addGeniusPoint, uv0.RewardPointDuration, slot0.frameTalentPointFunc, slot0.talentPointDone, slot0)

	if slot1.remainScore2GeniusPoint / tonumber(lua_rouge_const.configDict[RougeEnum.Const.TalentTranslation].value) < (slot1.preRemainScore2GeniusPoint or 0) / slot5 then
		slot6 = slot6 + uv0.MaxProgressValue
	end

	slot0:killTween("_talentPointProgressTweenId")

	slot0._talentPointProgressTweenId = ZProj.TweenHelper.DOTweenFloat(slot8, slot6, uv0.TalentPointProgressDuration, slot0.framTalentPointProgressFunc, slot0.talentPointProgressDone, slot0)
end

function slot0.frameTalentPointFunc(slot0, slot1)
	slot0._txtaddgenius.text = math.ceil(slot1)
end

function slot0.talentPointDone(slot0)
	slot0._talentPointTweenId = nil
end

function slot0.framTalentPointProgressFunc(slot0, slot1)
	slot0._slidergeniusprogress:SetValue(slot1 % uv0.MaxProgressValue)
end

function slot0.talentPointProgressDone(slot0)
	slot0._talentPointProgressTweenId = nil
end

function slot0.killTween(slot0, slot1)
	if slot0[slot1] then
		ZProj.TweenHelper.KillById(slot2)

		slot0[slot1] = nil
	end
end

slot1 = 8

function slot0.updateBadgeList(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._badgeList = slot1.badge2Score
	slot0._badgeSeason = slot1.season
	slot3 = {
		[slot10] = true
	}
	slot4 = slot0._badgeList and #slot0._badgeList or 0

	for slot9 = 1, uv0 < slot4 and slot4 or uv0 do
		slot0:refreshBadgeItemUI(slot2, slot0:getOrCreateBadgeItem(slot9), slot0._badgeList and slot0._badgeList[slot9])
	end

	if slot0._badgeItemTab then
		for slot9, slot10 in pairs(slot0._badgeItemTab) do
			if not slot3[slot10] then
				gohelper.setActive(slot10.viewGO, false)
			end
		end
	end

	if slot4 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.ShowAchievement)
	end
end

function slot0.refreshBadgeItemUI(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot2.viewGO, true)
	gohelper.setActive(slot2.gonormal, slot3 ~= nil)
	gohelper.setActive(slot2.goempty, slot3 == nil)

	if slot3 then
		slot4 = RougeConfig.instance:getRougeBadgeCO(slot1, slot3[1])
		slot2.txtscore.text = slot3[2]
		slot2.txtname.text = slot4.name

		UISpriteSetMgr.instance:setRouge3Sprite(slot2.imageicon, slot4.icon)
	end
end

function slot0.getOrCreateBadgeItem(slot0, slot1)
	if not slot0._badgeItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goachieveitem, "item_" .. tostring(slot1))
		slot2.gonormal = gohelper.findChild(slot2.viewGO, "normal")
		slot2.imageicon = gohelper.findChildImage(slot2.viewGO, "normal/#simage_achieveicon")
		slot2.txtscore = gohelper.findChildText(slot2.viewGO, "normal/#txt_score")
		slot2.txtname = gohelper.findChildText(slot2.viewGO, "normal/namebg/#txt_name")
		slot2.goempty = gohelper.findChild(slot2.viewGO, "empty")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "normal/btn_click")

		slot2.btnclick:AddClickListener(slot0._onClickBadgeItem, slot0, slot1)

		slot0._badgeItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onClickBadgeItem(slot0, slot1)
	slot0:openBadgeTips(slot0._badgeSeason, slot0._badgeList[slot1] and slot2[1], slot1)
end

function slot0.openBadgeTips(slot0, slot1, slot2, slot3)
	if not RougeConfig.instance:getRougeBadgeCO(slot1, slot2) then
		return
	end

	gohelper.setActive(slot0._gotips, true)

	slot0._txttips.text = slot4.desc

	slot0:setBadgeTipsPos(slot3)
end

function slot0.setBadgeTipsPos(slot0, slot1)
	if not slot0._badgeItemTab[slot1] then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._gotips.transform)

	slot7 = recthelper.getWidth(slot0._gotips.transform) / 2
	slot8 = recthelper.getWidth(slot0._gotipscontainer.transform) / 2

	recthelper.setAnchorX(slot0._gotips.transform, Mathf.Clamp(recthelper.rectToRelativeAnchorPos2(slot2.viewGO.transform.position, slot0._gotipscontainer.transform), -slot8 + slot7, slot8 - slot7))
end

function slot0._onOpenViewFinishCallBack(slot0, slot1)
	if slot1 == ViewName.RougeResultReView then
		ViewMgr.instance:closeView(ViewName.RougeEndingThreeView)
		ViewMgr.instance:closeView(ViewName.RougeResultView)
		slot0:closeThis()
	end
end

function slot0.releaseAllBadgeItems(slot0)
	if slot0._badgeItemTab then
		for slot4, slot5 in ipairs(slot0._badgeItemTab) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:killTween("_totalScoreTweenId")
	slot0:killTween("_rewardPointTweenId")
	slot0:killTween("_talentPointTweenId")
	slot0:killTween("_rewardPointProgressTweenId")
	slot0:killTween("_talentPointProgressTweenId")
	slot0:releaseAllBadgeItems()
end

return slot0
