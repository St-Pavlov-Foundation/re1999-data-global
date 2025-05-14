module("modules.logic.rouge.view.RougeSettlementView", package.seeall)

local var_0_0 = class("RougeSettlementView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_fail/#simage_mask")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_Title")
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_replay")
	arg_1_0._simagerightmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_dec/#simage_rightmask")
	arg_1_0._simageleftmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_dec/#simage_leftmask")
	arg_1_0._simagerightmask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_dec/#simage_rightmask2")
	arg_1_0._simageleftmask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_dec/#simage_leftmask2")
	arg_1_0._simagepoint = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_dec/#simage_point")
	arg_1_0._simagepoint2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_dec/#simage_point2")
	arg_1_0._txtscore1 = gohelper.findChildText(arg_1_0.viewGO, "mode1/#txt_score1")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "mode1/#txt_num1")
	arg_1_0._txtscore2 = gohelper.findChildText(arg_1_0.viewGO, "mode2/#txt_score2")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "mode2/#txt_num2")
	arg_1_0._txtscore3 = gohelper.findChildText(arg_1_0.viewGO, "mode3/#txt_score3")
	arg_1_0._txtnum3 = gohelper.findChildText(arg_1_0.viewGO, "mode3/#txt_num3")
	arg_1_0._gocollection = gohelper.findChild(arg_1_0.viewGO, "#go_collection")
	arg_1_0._txtcollectionscore = gohelper.findChildText(arg_1_0.viewGO, "#go_collection/#txt_collectionscore")
	arg_1_0._txtcollectionnum = gohelper.findChildText(arg_1_0.viewGO, "#go_collection/#txt_collectionnum")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "#go_level")
	arg_1_0._txtlevelscore = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#txt_levelscore")
	arg_1_0._txtlevelnum = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#txt_levelnum")
	arg_1_0._gotask = gohelper.findChild(arg_1_0.viewGO, "#go_task")
	arg_1_0._txttaskscore = gohelper.findChildText(arg_1_0.viewGO, "#go_task/#txt_taskscore")
	arg_1_0._txttasknum = gohelper.findChildText(arg_1_0.viewGO, "#go_task/#txt_tasknum")
	arg_1_0._goending = gohelper.findChild(arg_1_0.viewGO, "#go_ending")
	arg_1_0._txtendingscore = gohelper.findChildText(arg_1_0.viewGO, "#go_ending/#txt_endingscore")
	arg_1_0._txtendingnum = gohelper.findChildText(arg_1_0.viewGO, "#go_ending/#txt_endingnum")
	arg_1_0._goachieve = gohelper.findChild(arg_1_0.viewGO, "#go_achieve")
	arg_1_0._simagetitlebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_achieve/#simage_titlebg")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_achieve/#scroll_view")
	arg_1_0._goachieveitem = gohelper.findChild(arg_1_0.viewGO, "#go_achieve/#scroll_view/Viewport/Content/#go_achieveitem")
	arg_1_0._simageachieveicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_achieve/#scroll_view/Viewport/Content/#go_achieveitem/normal/#simage_achieveicon")
	arg_1_0._goscore = gohelper.findChild(arg_1_0.viewGO, "#go_score")
	arg_1_0._txtbase = gohelper.findChildText(arg_1_0.viewGO, "#go_score/#txt_base")
	arg_1_0._txtmultiple = gohelper.findChildText(arg_1_0.viewGO, "#go_score/#txt_multiple")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_score/#txt_total")
	arg_1_0._txtaddpoint = gohelper.findChildText(arg_1_0.viewGO, "#go_score/score/#txt_addpoint")
	arg_1_0._sliderprogress = gohelper.findChildSlider(arg_1_0.viewGO, "#go_score/score/#slider_progress")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_score/collection/#simage_icon")
	arg_1_0._txtaddgenius = gohelper.findChildText(arg_1_0.viewGO, "#go_score/collection/#txt_addgenius")
	arg_1_0._slidergeniusprogress = gohelper.findChildSlider(arg_1_0.viewGO, "#go_score/collection/#slider_geniusprogress")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gotipscontainer = gohelper.findChild(arg_1_0.viewGO, "#go_achieve/#go_tipscontainer")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_achieve/#go_tipscontainer/#go_tips")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "#go_achieve/#go_tipscontainer/#go_tips/#txt_tips")
	arg_1_0._btnclosetips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_achieve/#go_tipscontainer/#go_tips/#btn_closetips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnreplayOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclosetips:AddClickListener(arg_2_0._btnclosetipsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclosetips:RemoveClickListener()
end

function var_0_0._btnreplayOnClick(arg_4_0)
	RougeController.instance:openRougeResultView()
end

function var_0_0._btncloseOnClick(arg_5_0)
	local var_5_0 = RougeModel.instance:getRougeResult()

	if (var_5_0 and var_5_0.finalScore or 0) > 0 then
		local var_5_1 = var_5_0.reviewInfo
		local var_5_2 = {
			reviewInfo = var_5_1
		}

		RougeController.instance:openRougeResultReView(var_5_2)
	else
		ViewMgr.instance:closeView(ViewName.RougeEndingThreeView)
		ViewMgr.instance:closeView(ViewName.RougeResultView)
		arg_5_0:closeThis()
	end
end

function var_0_0._btnclosetipsOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._gotips, false)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._badgeItemTab = arg_7_0:getUserDataTb_()

	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_7_0._onOpenViewFinishCallBack, arg_7_0)
	NavigateMgr.instance:addEscape(arg_7_0.viewName, RougeMapHelper.blockEsc)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = RougeModel.instance:getRougeResult()
	local var_9_1 = var_9_0 and var_9_0:isSucceed()

	gohelper.setActive(arg_9_0._gofail, not var_9_1)
	gohelper.setActive(arg_9_0._gosuccess, var_9_1)
	arg_9_0:refrehScores(var_9_0)
	arg_9_0:updateBadgeList(var_9_0)
end

function var_0_0.refrehScores(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0, var_10_1 = arg_10_1:getNormalFightCountAndScore()

	arg_10_0._txtnum1.text = var_10_0
	arg_10_0._txtscore1.text = var_10_1

	local var_10_2, var_10_3 = arg_10_1:getDifficultFightCountAndScore()

	arg_10_0._txtnum2.text = var_10_2
	arg_10_0._txtscore2.text = var_10_3

	local var_10_4, var_10_5 = arg_10_1:getDangerousFightCountAndScore()

	arg_10_0._txtnum3.text = var_10_4
	arg_10_0._txtscore3.text = var_10_5

	arg_10_0:refreshOverView(arg_10_1)
	arg_10_0:refreshScoreInfo(arg_10_1)
	arg_10_0:refreshRewardPoint(arg_10_1)
	arg_10_0:refreshTalentPoint(arg_10_1)
end

function var_0_0.refreshOverView(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_1:getCollectionCountAndScore()

	arg_11_0._txtcollectionnum.text = var_11_0
	arg_11_0._txtcollectionscore.text = var_11_1

	local var_11_2, var_11_3 = arg_11_1:getLayerCountAndScore()

	arg_11_0._txtlevelnum.text = var_11_2
	arg_11_0._txtlevelscore.text = var_11_3

	local var_11_4, var_11_5 = arg_11_1:getEntrustCountAndScore()

	arg_11_0._txttasknum.text = var_11_4
	arg_11_0._txttaskscore.text = var_11_5

	local var_11_6, var_11_7 = arg_11_1:getEndCountAndScore()

	arg_11_0._txtendingnum.text = var_11_6
	arg_11_0._txtendingscore.text = var_11_7
end

var_0_0.FinalScoreDuration = 2
var_0_0.RewardPointDuration = 2
var_0_0.TalentPointDuration = 2
var_0_0.RewardPointProgressDuration = 2
var_0_0.TalentPointProgressDuration = 2
var_0_0.MaxProgressValue = 1

function var_0_0.refreshScoreInfo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.beforeScore or 0
	local var_12_1 = arg_12_1.scoreReward or 0
	local var_12_2 = arg_12_1.finalScore or 0

	arg_12_0._txtbase.text = var_12_0
	arg_12_0._txtmultiple.text = string.format("%s%%", var_12_1)

	local var_12_3 = 0

	arg_12_0:killTween("_totalScoreTweenId")

	arg_12_0._totalScoreTweenId = ZProj.TweenHelper.DOTweenFloat(var_12_3, var_12_2, var_0_0.FinalScoreDuration, arg_12_0.framChangeScoreCallBack, arg_12_0.changeScoreDone, arg_12_0)

	if var_12_2 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.ComputeScore)
	end
end

function var_0_0.framChangeScoreCallBack(arg_13_0, arg_13_1)
	arg_13_0._txttotal.text = math.ceil(arg_13_1)
end

function var_0_0.changeScoreDone(arg_14_0)
	arg_14_0._totalScoreTweenId = nil
end

function var_0_0.refreshRewardPoint(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.addPoint or 0
	local var_15_1 = 0

	arg_15_0:killTween("_rewardPointTweenId")

	arg_15_0._rewardPointTweenId = ZProj.TweenHelper.DOTweenFloat(var_15_1, var_15_0, var_0_0.RewardPointDuration, arg_15_0.frameRewardPointFunc, arg_15_0.rewardPointDone, arg_15_0)

	local var_15_2 = arg_15_1.remainScore2Point
	local var_15_3 = tonumber(lua_rouge_const.configDict[RougeEnum.Const.RewardTranslation].value)
	local var_15_4 = var_15_2 / var_15_3
	local var_15_5 = (arg_15_1.preRemainScore2Point or 0) / var_15_3

	if var_15_4 < var_15_5 then
		var_15_4 = var_15_4 + var_0_0.MaxProgressValue
	end

	arg_15_0:killTween("_rewardPointProgressTweenId")

	arg_15_0._rewardPointProgressTweenId = ZProj.TweenHelper.DOTweenFloat(var_15_5, var_15_4, var_0_0.RewardPointProgressDuration, arg_15_0.frameRewardPointProgressFunc, arg_15_0.rewardPointProgressDone, arg_15_0)
end

function var_0_0.frameRewardPointFunc(arg_16_0, arg_16_1)
	arg_16_0._txtaddpoint.text = math.ceil(arg_16_1)
end

function var_0_0.rewardPointDone(arg_17_0)
	arg_17_0._rewardPointTweenId = nil
end

function var_0_0.frameRewardPointProgressFunc(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 % var_0_0.MaxProgressValue

	arg_18_0._sliderprogress:SetValue(var_18_0)
end

function var_0_0.rewardPointProgressDone(arg_19_0)
	arg_19_0._rewardPointProgressTweenId = nil
end

function var_0_0.refreshTalentPoint(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.addGeniusPoint
	local var_20_1 = 0

	arg_20_0:killTween("_talentPointTweenId")

	arg_20_0._talentPointTweenId = ZProj.TweenHelper.DOTweenFloat(var_20_1, var_20_0, var_0_0.RewardPointDuration, arg_20_0.frameTalentPointFunc, arg_20_0.talentPointDone, arg_20_0)

	local var_20_2 = arg_20_1.remainScore2GeniusPoint
	local var_20_3 = tonumber(lua_rouge_const.configDict[RougeEnum.Const.TalentTranslation].value)
	local var_20_4 = var_20_2 / var_20_3
	local var_20_5 = (arg_20_1.preRemainScore2GeniusPoint or 0) / var_20_3

	if var_20_4 < var_20_5 then
		var_20_4 = var_20_4 + var_0_0.MaxProgressValue
	end

	arg_20_0:killTween("_talentPointProgressTweenId")

	arg_20_0._talentPointProgressTweenId = ZProj.TweenHelper.DOTweenFloat(var_20_5, var_20_4, var_0_0.TalentPointProgressDuration, arg_20_0.framTalentPointProgressFunc, arg_20_0.talentPointProgressDone, arg_20_0)
end

function var_0_0.frameTalentPointFunc(arg_21_0, arg_21_1)
	arg_21_0._txtaddgenius.text = math.ceil(arg_21_1)
end

function var_0_0.talentPointDone(arg_22_0)
	arg_22_0._talentPointTweenId = nil
end

function var_0_0.framTalentPointProgressFunc(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 % var_0_0.MaxProgressValue

	arg_23_0._slidergeniusprogress:SetValue(var_23_0)
end

function var_0_0.talentPointProgressDone(arg_24_0)
	arg_24_0._talentPointProgressTweenId = nil
end

function var_0_0.killTween(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0[arg_25_1]

	if var_25_0 then
		ZProj.TweenHelper.KillById(var_25_0)

		arg_25_0[arg_25_1] = nil
	end
end

local var_0_1 = 8

function var_0_0.updateBadgeList(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	local var_26_0 = arg_26_1.season

	arg_26_0._badgeList = arg_26_1.badge2Score
	arg_26_0._badgeSeason = var_26_0

	local var_26_1 = {}
	local var_26_2 = arg_26_0._badgeList and #arg_26_0._badgeList or 0
	local var_26_3 = var_26_2 > var_0_1 and var_26_2 or var_0_1

	for iter_26_0 = 1, var_26_3 do
		local var_26_4 = arg_26_0:getOrCreateBadgeItem(iter_26_0)
		local var_26_5 = arg_26_0._badgeList and arg_26_0._badgeList[iter_26_0]

		arg_26_0:refreshBadgeItemUI(var_26_0, var_26_4, var_26_5)

		var_26_1[var_26_4] = true
	end

	if arg_26_0._badgeItemTab then
		for iter_26_1, iter_26_2 in pairs(arg_26_0._badgeItemTab) do
			if not var_26_1[iter_26_2] then
				gohelper.setActive(iter_26_2.viewGO, false)
			end
		end
	end

	if var_26_2 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.ShowAchievement)
	end
end

function var_0_0.refreshBadgeItemUI(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	gohelper.setActive(arg_27_2.viewGO, true)
	gohelper.setActive(arg_27_2.gonormal, arg_27_3 ~= nil)
	gohelper.setActive(arg_27_2.goempty, arg_27_3 == nil)

	if arg_27_3 then
		local var_27_0 = RougeConfig.instance:getRougeBadgeCO(arg_27_1, arg_27_3[1])

		arg_27_2.txtscore.text = arg_27_3[2]
		arg_27_2.txtname.text = var_27_0.name

		UISpriteSetMgr.instance:setRouge3Sprite(arg_27_2.imageicon, var_27_0.icon)
	end
end

function var_0_0.getOrCreateBadgeItem(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._badgeItemTab[arg_28_1]

	if not var_28_0 then
		var_28_0 = arg_28_0:getUserDataTb_()
		var_28_0.viewGO = gohelper.cloneInPlace(arg_28_0._goachieveitem, "item_" .. tostring(arg_28_1))
		var_28_0.gonormal = gohelper.findChild(var_28_0.viewGO, "normal")
		var_28_0.imageicon = gohelper.findChildImage(var_28_0.viewGO, "normal/#simage_achieveicon")
		var_28_0.txtscore = gohelper.findChildText(var_28_0.viewGO, "normal/#txt_score")
		var_28_0.txtname = gohelper.findChildText(var_28_0.viewGO, "normal/namebg/#txt_name")
		var_28_0.goempty = gohelper.findChild(var_28_0.viewGO, "empty")
		var_28_0.btnclick = gohelper.findChildButtonWithAudio(var_28_0.viewGO, "normal/btn_click")

		var_28_0.btnclick:AddClickListener(arg_28_0._onClickBadgeItem, arg_28_0, arg_28_1)

		arg_28_0._badgeItemTab[arg_28_1] = var_28_0
	end

	return var_28_0
end

function var_0_0._onClickBadgeItem(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0._badgeList[arg_29_1]
	local var_29_1 = var_29_0 and var_29_0[1]

	arg_29_0:openBadgeTips(arg_29_0._badgeSeason, var_29_1, arg_29_1)
end

function var_0_0.openBadgeTips(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = RougeConfig.instance:getRougeBadgeCO(arg_30_1, arg_30_2)

	if not var_30_0 then
		return
	end

	gohelper.setActive(arg_30_0._gotips, true)

	arg_30_0._txttips.text = var_30_0.desc

	arg_30_0:setBadgeTipsPos(arg_30_3)
end

function var_0_0.setBadgeTipsPos(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._badgeItemTab[arg_31_1]

	if not var_31_0 then
		return
	end

	local var_31_1 = var_31_0.viewGO.transform
	local var_31_2 = recthelper.rectToRelativeAnchorPos2(var_31_1.position, arg_31_0._gotipscontainer.transform)

	ZProj.UGUIHelper.RebuildLayout(arg_31_0._gotips.transform)

	local var_31_3 = recthelper.getWidth(arg_31_0._gotips.transform)
	local var_31_4 = recthelper.getWidth(arg_31_0._gotipscontainer.transform)
	local var_31_5 = var_31_3 / 2
	local var_31_6 = var_31_4 / 2
	local var_31_7 = Mathf.Clamp(var_31_2, -var_31_6 + var_31_5, var_31_6 - var_31_5)

	recthelper.setAnchorX(arg_31_0._gotips.transform, var_31_7)
end

function var_0_0._onOpenViewFinishCallBack(arg_32_0, arg_32_1)
	if arg_32_1 == ViewName.RougeResultReView then
		ViewMgr.instance:closeView(ViewName.RougeEndingThreeView)
		ViewMgr.instance:closeView(ViewName.RougeResultView)
		arg_32_0:closeThis()
	end
end

function var_0_0.releaseAllBadgeItems(arg_33_0)
	if arg_33_0._badgeItemTab then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0._badgeItemTab) do
			iter_33_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.onClose(arg_34_0)
	return
end

function var_0_0.onDestroyView(arg_35_0)
	arg_35_0:killTween("_totalScoreTweenId")
	arg_35_0:killTween("_rewardPointTweenId")
	arg_35_0:killTween("_talentPointTweenId")
	arg_35_0:killTween("_rewardPointProgressTweenId")
	arg_35_0:killTween("_talentPointProgressTweenId")
	arg_35_0:releaseAllBadgeItems()
end

return var_0_0
