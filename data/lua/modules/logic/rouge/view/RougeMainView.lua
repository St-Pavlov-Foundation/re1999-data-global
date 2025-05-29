module("modules.logic.rouge.view.RougeMainView", package.seeall)

local var_0_0 = class("RougeMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfavorite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_favorite")
	arg_1_0._btncultivate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_cultivate")
	arg_1_0._goCultivateCanUp = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_cultivate/#go_up")
	arg_1_0._goCultivateNew = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_cultivate/#go_new")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_reward")
	arg_1_0._goRewardNew = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_reward/#go_new")
	arg_1_0._txtRewardNum = gohelper.findChildText(arg_1_0.viewGO, "Left/#btn_reward/#txt_RewardNum")
	arg_1_0._btndlc = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_dlc")
	arg_1_0._godlcreddot = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_dlc/#go_dlcreddot")
	arg_1_0._btnexchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_exchange")
	arg_1_0._btnachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_achievement")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_start")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_start/#go_new")
	arg_1_0._gofavoritenew = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_favorite/#go_new")
	arg_1_0._goimage_start = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_start/#go_image_start")
	arg_1_0._goimage_start2 = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_start/#go_image_start2")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "Right/#go_locked")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_locked/#txt_time")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "Right/#go_progress")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_progress/#txt_name")
	arg_1_0._txtdiffculty = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_progress/#txt_difficulty")
	arg_1_0._btnend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_end")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "title")
	arg_1_0._gonormaltitle = gohelper.findChild(arg_1_0.viewGO, "title/normal")
	arg_1_0._godlctitles = gohelper.findChild(arg_1_0.viewGO, "title/#go_dlctitles")
	arg_1_0._txttoken = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_token/#txt_token")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_token/#go_tips")
	arg_1_0._txttoken2 = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_token/#go_tips/txt_title/#txt_token2")
	arg_1_0._btnopentips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_token/#btn_opentips")
	arg_1_0._btnclosetips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_token/#go_tips/#btn_closetips")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_token/#go_tips/TipsView/Viewport/Content/#txt_tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfavorite:AddClickListener(arg_2_0._btnfavoriteOnClick, arg_2_0)
	arg_2_0._btncultivate:AddClickListener(arg_2_0._btncultivateOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btndlc:AddClickListener(arg_2_0._btndlcOnClick, arg_2_0)
	arg_2_0._btnexchange:AddClickListener(arg_2_0._btnexchangeOnClick, arg_2_0)
	arg_2_0._btnachievement:AddClickListener(arg_2_0._btnachievementOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnend:AddClickListener(arg_2_0._btnendOnClick, arg_2_0)
	arg_2_0._btnopentips:AddClickListener(arg_2_0._btnopentipsOnClick, arg_2_0)
	arg_2_0._btnclosetips:AddClickListener(arg_2_0._btnclosetipsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfavorite:RemoveClickListener()
	arg_3_0._btncultivate:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btndlc:RemoveClickListener()
	arg_3_0._btnexchange:RemoveClickListener()
	arg_3_0._btnachievement:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnend:RemoveClickListener()
	arg_3_0._btnopentips:RemoveClickListener()
	arg_3_0._btnclosetips:RemoveClickListener()
end

function var_0_0._btnfavoriteOnClick(arg_4_0)
	RougeController.instance:openRougeFavoriteView()
end

function var_0_0._btncultivateOnClick(arg_5_0)
	RougeController.instance:openRougeTalentTreeTrunkView()
end

function var_0_0._btnrewardOnClick(arg_6_0)
	RougeController.instance:openRougeRewardView()
end

function var_0_0._btndlcOnClick(arg_7_0)
	RougeController.instance:openRougeDLCSelectView()
end

function var_0_0._btnexchangeOnClick(arg_8_0)
	return
end

function var_0_0._btnachievementOnClick(arg_9_0)
	JumpController.instance:jump(RougeConfig1.instance:achievementJumpId())
end

function var_0_0._btnstartOnClick(arg_10_0)
	arg_10_0:_start()
end

function var_0_0._btnendOnClick(arg_11_0)
	arg_11_0:_end()
end

function var_0_0._btnopentipsOnClick(arg_12_0)
	arg_12_0:_refreshExtraPointTips(true)
	arg_12_0._tipAnimatorPlayer:Play("open", function()
		return
	end, arg_12_0)
end

function var_0_0._btnclosetipsOnClick(arg_14_0)
	arg_14_0._tipAnimatorPlayer:Play("close", arg_14_0._closeExtraPointTips, arg_14_0)
end

function var_0_0._editableInitView(arg_15_0)
	RougeOutsideController.instance:initDLCReddotInfo()

	arg_15_0._btnstartCanvasGroup = arg_15_0._btnstart.gameObject:GetComponent(gohelper.Type_CanvasGroup)
	arg_15_0._btnEndGo = arg_15_0._btnend.gameObject
	arg_15_0._gotitleeffect = gohelper.findChild(arg_15_0.viewGO, "title/eff_switch")
	arg_15_0._gotipscontent = gohelper.findChild(arg_15_0.viewGO, "Right/#go_token/#go_tips/TipsView/Viewport/Content")

	gohelper.setActive(arg_15_0._goimage_start, false)
	gohelper.setActive(arg_15_0._goimage_start2, false)
	gohelper.setActive(arg_15_0._btnEndGo, false)
	gohelper.setActive(arg_15_0._golocked, false)
	gohelper.setActive(arg_15_0._goprogress, false)
	gohelper.setActive(arg_15_0._gonew, false)

	arg_15_0._btnstartCanvasGroup.alpha = 1
	arg_15_0._txtRewardNum.text = "0"
	arg_15_0._txttime.text = ""
	arg_15_0._originVersionStr = RougeDLCHelper.getCurVersionString()
	arg_15_0._tipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_15_0._gotips)

	arg_15_0:_refreshExtraPointTips(false)
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0:_refresh()
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:onUpdateParam()
	RedDotController.instance:addRedDot(arg_17_0._godlcreddot, RedDotEnum.DotNode.RougeDLCNew)
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfo, arg_17_0._onUpdateRougeInfo, arg_17_0)
	RougeOutsideController.instance:registerCallback(RougeEvent.OnUpdateRougeOutsideInfo, arg_17_0._onUpdateRougeOutsideInfo, arg_17_0)
	arg_17_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, arg_17_0._updateFavoriteNew, arg_17_0)
	arg_17_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, arg_17_0._onUpdateRougeInfo, arg_17_0)
	arg_17_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_17_0._onUpdateRougeInfo, arg_17_0)
	arg_17_0:addEventCb(RougeDLCController.instance, RougeEvent.OnGetVersionInfo, arg_17_0._onUpdateVersion, arg_17_0)
	arg_17_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_17_0._onCloseViewCallBack, arg_17_0)
end

function var_0_0._updateFavoriteNew(arg_18_0)
	local var_18_0 = RougeFavoriteModel.instance:getAllReddotNum() > 0

	gohelper.setActive(arg_18_0._gofavoritenew, var_18_0)
end

function var_0_0.onOpenFinish(arg_19_0)
	RougeController.instance:startEndFlow()
end

function var_0_0.onClose(arg_20_0)
	arg_20_0:_clearCdTick()
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfo, arg_20_0._onUpdateRougeInfo, arg_20_0)
	RougeOutsideController.instance:unregisterCallback(RougeEvent.OnUpdateRougeOutsideInfo, arg_20_0._onUpdateRougeOutsideInfo, arg_20_0)
	arg_20_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, arg_20_0._onUpdateRougeInfo, arg_20_0)
	arg_20_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_20_0._onUpdateRougeInfo, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._onSwitchTitleDone, arg_20_0)
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0:_clearCdTick()
	TaskDispatcher.cancelTask(arg_21_0._refreshDLCTitle, arg_21_0)
end

function var_0_0._onUpdateRougeInfo(arg_22_0)
	arg_22_0:_refresh()
end

function var_0_0._onUpdateRougeOutsideInfo(arg_23_0)
	arg_23_0:_refresh()
end

function var_0_0._isContinueLast(arg_24_0)
	return RougeModel.instance:isContinueLast()
end

function var_0_0._isInCdStart(arg_25_0)
	return not arg_25_0:_isContinueLast() and RougeOutsideModel.instance:isInCdStart()
end

function var_0_0._refresh(arg_26_0)
	arg_26_0:_refreshStartBtn()
	arg_26_0:_refreshProgress()
	arg_26_0:_refreshCDLocked()
	arg_26_0:_updateFavoriteNew()
	arg_26_0:_refreshTalentBtn()
	arg_26_0:_refreshRewardBtn()
	arg_26_0:_refreshExchangeBtn()
	arg_26_0:_refreshTitle()
	arg_26_0:_refreshExtraPoints()
end

function var_0_0._refreshTalentBtn(arg_27_0)
	local var_27_0 = RougeTalentModel.instance:checkIsNewStage()

	gohelper.setActive(arg_27_0._goCultivateNew, var_27_0)

	local var_27_1 = RougeTalentModel.instance:checkAnyNodeCanUp()

	gohelper.setActive(arg_27_0._goCultivateCanUp, var_27_1)
end

function var_0_0._refreshRewardBtn(arg_28_0)
	arg_28_0._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	local var_28_0 = RougeRewardModel.instance:checkIsNewStage()

	gohelper.setActive(arg_28_0._goRewardNew, var_28_0)
end

function var_0_0._refreshStartBtn(arg_29_0)
	local var_29_0 = arg_29_0:_isContinueLast()

	gohelper.setActive(arg_29_0._goimage_start, not var_29_0)
	gohelper.setActive(arg_29_0._goimage_start2, var_29_0)
	arg_29_0:_refreshEndBtn()
end

function var_0_0._refreshEndBtn(arg_30_0)
	local var_30_0 = arg_30_0:_isContinueLast()
	local var_30_1 = arg_30_0:_isInCdStart()

	arg_30_0._btnstartCanvasGroup.alpha = var_30_1 and 0.5 or 1

	gohelper.setActive(arg_30_0._btnEndGo, not var_30_1 and var_30_0)
end

function var_0_0._refreshProgress(arg_31_0)
	gohelper.setActive(arg_31_0._goprogress, false)

	local var_31_0 = RougeModel.instance:getDifficulty()

	if not var_31_0 or var_31_0 == 0 then
		return
	end

	gohelper.setActive(arg_31_0._goprogress, true)

	local var_31_1 = RougeOutsideModel.instance:config():getDifficultyCO(var_31_0)

	arg_31_0._txtdiffculty.text = var_31_1.title

	if RougeModel.instance:isStarted() then
		local var_31_2 = RougeMapModel.instance:getLayerCo()
		local var_31_3 = RougeMapModel.instance:getMiddleLayerCo()

		if var_31_3 then
			arg_31_0._txtname.text = var_31_3.name
		else
			arg_31_0._txtname.text = var_31_2.name
		end
	else
		arg_31_0._txtname.text = ""
	end
end

function var_0_0._refreshCDLocked(arg_32_0)
	arg_32_0:_clearCdTick()

	if not arg_32_0:_isInCdStart() then
		return
	end

	gohelper.setActive(arg_32_0._golocked, true)
	arg_32_0:_onRefreshCdTick()
	TaskDispatcher.runRepeat(arg_32_0._onRefreshCdTick, arg_32_0, 1)
end

function var_0_0._clearCdTick(arg_33_0)
	gohelper.setActive(arg_33_0._golocked, false)
	TaskDispatcher.cancelTask(arg_33_0._onRefreshCdTick, arg_33_0)
end

function var_0_0._onRefreshCdTick(arg_34_0)
	local var_34_0 = RougeOutsideModel.instance:leftCdSec()

	if var_34_0 < 0 then
		arg_34_0:_onCdTickEnd()

		return
	end

	local var_34_1, var_34_2, var_34_3 = TimeUtil.secondToHMS(var_34_0)

	arg_34_0._txttime.text = formatLuaLang("rougemainview_cd_fmt", var_34_1, var_34_2, var_34_3)
end

function var_0_0._onCdTickEnd(arg_35_0)
	arg_35_0._txttime.text = ""

	arg_35_0:_clearCdTick()
	arg_35_0:_refreshStartBtn()
end

function var_0_0._start(arg_36_0)
	if arg_36_0:_isInCdStart() then
		return
	end

	if RougeController.instance:tryShowMessageBox() then
		return
	end

	if arg_36_0:_isContinueLast() then
		if RougeModel.instance:isStarted() then
			RougeController.instance:enterRouge()
		elseif RougeModel.instance:isFinishedStyle() then
			RougeController.instance:openRougeInitTeamView()
		elseif RougeModel.instance:isFinishedLastReward() then
			RougeController.instance:openRougeFactionView()
		elseif RougeModel.instance:isFinishedDifficulty() then
			if RougeModel.instance:isCanSelectRewards() then
				RougeController.instance:openRougeSelectRewardsView()
			else
				RougeController.instance:openRougeFactionView()
			end
		else
			RougeController.instance:enterRouge()
		end

		RougeStatController.instance:statStart()

		return
	end

	RougeController.instance:openRougeDifficultyView()
	RougeStatController.instance:statStart()
end

function var_0_0._end(arg_37_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.RougeMainView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, arg_37_0._endYesCallback, nil, nil, arg_37_0, nil, nil)
end

function var_0_0._endYesCallback(arg_38_0)
	RougeStatController.instance:setReset()
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason(), arg_38_0._onReceiveEndReply, arg_38_0)
end

function var_0_0._onReceiveEndReply(arg_39_0)
	RougeController.instance:startEndFlow()
end

function var_0_0._refreshExchangeBtn(arg_40_0)
	local var_40_0 = RougeOutsideModel.instance:getRougeGameRecord()
	local var_40_1 = var_40_0 and var_40_0:getVersionIds()
	local var_40_2 = var_40_1 and #var_40_1 > 0

	gohelper.setActive(arg_40_0._btnexchange.gameObject, not var_40_2)
end

function var_0_0._refreshTitle(arg_41_0)
	arg_41_0:_switchDLCTitle()
end

local var_0_1 = 1.6

function var_0_0._switchDLCTitle(arg_42_0)
	local var_42_0 = RougeDLCHelper.getCurVersionString()

	if var_42_0 == arg_42_0._originVersionStr then
		arg_42_0:_refreshDLCTitle()

		return
	end

	local var_42_1
	local var_42_2

	if string.nilorempty(arg_42_0._originVersionStr) then
		var_42_1 = arg_42_0._gonormaltitle
	else
		var_42_1 = gohelper.findChild(arg_42_0._godlctitles, arg_42_0._originVersionStr)
	end

	if string.nilorempty(var_42_0) then
		var_42_2 = arg_42_0._gonormaltitle
	else
		var_42_2 = gohelper.findChild(arg_42_0._godlctitles, var_42_0)
	end

	if not gohelper.isNil(var_42_1) then
		gohelper.setActive(var_42_1, true)
		gohelper.onceAddComponent(var_42_1, gohelper.Type_Animator):Play("fadeout", 0, 0)
	end

	if not gohelper.isNil(var_42_2) then
		gohelper.setActive(var_42_2, true)
		gohelper.onceAddComponent(var_42_2, gohelper.Type_Animator):Play("fadein", 0, 0)
	end

	gohelper.setActive(arg_42_0._gotitleeffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.SwitchRougeDLC)
	TaskDispatcher.runDelay(arg_42_0._onSwitchTitleDone, arg_42_0, var_0_1)
end

function var_0_0._onSwitchTitleDone(arg_43_0)
	arg_43_0:_refreshDLCTitle()
end

function var_0_0._refreshDLCTitle(arg_44_0)
	local var_44_0 = RougeDLCHelper.getCurVersionString()
	local var_44_1 = arg_44_0._godlctitles.transform.childCount

	for iter_44_0 = 1, var_44_1 do
		local var_44_2 = arg_44_0._godlctitles.transform:GetChild(iter_44_0 - 1).gameObject
		local var_44_3 = var_44_2.name

		gohelper.setActive(var_44_2, var_44_3 == var_44_0)
	end

	local var_44_4 = string.nilorempty(var_44_0)

	gohelper.setActive(arg_44_0._gonormaltitle, var_44_4)
	gohelper.setActive(arg_44_0._gotitleeffect, false)

	arg_44_0._originVersionStr = var_44_0
end

function var_0_0._refreshExtraPoints(arg_45_0)
	arg_45_0._maxExtraPoint = tonumber(lua_rouge_const.configDict[RougeEnum.Const.MaxExtraPoint].value)
	arg_45_0._recoverExtraPoint = tonumber(lua_rouge_const.configDict[RougeEnum.Const.RecoverExtraPoint].value)
	arg_45_0._curExtraPoint = RougeOutsideModel.instance:getCurExtraPoint()

	local var_45_0 = string.format("%s/%s", arg_45_0._curExtraPoint, arg_45_0._maxExtraPoint)

	arg_45_0._txttoken.text = var_45_0
	arg_45_0._txttoken2.text = var_45_0
end

function var_0_0._refreshExtraPointTips(arg_46_0, arg_46_1)
	gohelper.setActive(arg_46_0._gotips, arg_46_1)

	if not arg_46_1 then
		return
	end

	local var_46_0 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rougemainview_extrapointtips"), arg_46_0._recoverExtraPoint, arg_46_0._maxExtraPoint)
	local var_46_1 = string.split(var_46_0 or "", "|")

	gohelper.CreateObjList(arg_46_0, arg_46_0._refreshSingleExtraPointTip, var_46_1, arg_46_0._gotipscontent, arg_46_0._txttips.gameObject)
end

function var_0_0._closeExtraPointTips(arg_47_0)
	arg_47_0:_refreshExtraPointTips(false)
end

function var_0_0._refreshSingleExtraPointTip(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	gohelper.onceAddComponent(arg_48_1, gohelper.Type_TextMesh).text = arg_48_2
end

function var_0_0._onUpdateVersion(arg_49_0)
	if not arg_49_0:checkIsTopView() then
		arg_49_0._waitUpdate = true

		return
	end

	arg_49_0._waitUpdate = nil

	arg_49_0:_refreshExchangeBtn()
	arg_49_0:_refreshTitle()
end

function var_0_0._onCloseViewCallBack(arg_50_0, arg_50_1)
	if arg_50_1 == ViewName.RougeDLCSelectView and arg_50_0._waitUpdate then
		arg_50_0:_onUpdateVersion()
	end
end

local var_0_2 = {
	[ViewName.ToastView] = true,
	[ViewName.ToastTopView] = true,
	[ViewName.WaterMarkView] = true,
	[ViewName.GuideView] = true
}

function var_0_0.checkIsTopView(arg_51_0)
	local var_51_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_51_0 = #var_51_0, 1, -1 do
		local var_51_1 = var_51_0[iter_51_0]

		if not var_0_2[var_51_1] then
			return var_51_1 == ViewName.RougeMainView
		end
	end
end

return var_0_0
