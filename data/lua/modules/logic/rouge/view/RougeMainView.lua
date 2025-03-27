module("modules.logic.rouge.view.RougeMainView", package.seeall)

slot0 = class("RougeMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnfavorite = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_favorite")
	slot0._btncultivate = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_cultivate")
	slot0._goCultivateCanUp = gohelper.findChild(slot0.viewGO, "Left/#btn_cultivate/#go_up")
	slot0._goCultivateNew = gohelper.findChild(slot0.viewGO, "Left/#btn_cultivate/#go_new")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_reward")
	slot0._goRewardNew = gohelper.findChild(slot0.viewGO, "Left/#btn_reward/#go_new")
	slot0._txtRewardNum = gohelper.findChildText(slot0.viewGO, "Left/#btn_reward/#txt_RewardNum")
	slot0._btndlc = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_dlc")
	slot0._btnexchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_exchange")
	slot0._btnachievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_achievement")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_start")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "Right/#btn_start/#go_new")
	slot0._gofavoritenew = gohelper.findChild(slot0.viewGO, "Left/#btn_favorite/#go_new")
	slot0._goimage_start = gohelper.findChild(slot0.viewGO, "Right/#btn_start/#go_image_start")
	slot0._goimage_start2 = gohelper.findChild(slot0.viewGO, "Right/#btn_start/#go_image_start2")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "Right/#go_locked")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "Right/#go_locked/#txt_time")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "Right/#go_progress")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "Right/#go_progress/#txt_name")
	slot0._txtdiffculty = gohelper.findChildText(slot0.viewGO, "Right/#go_progress/#txt_difficulty")
	slot0._btnend = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_end")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "title")
	slot0._gonormaltitle = gohelper.findChild(slot0.viewGO, "title/normal")
	slot0._godlctitles = gohelper.findChild(slot0.viewGO, "title/#go_dlctitles")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfavorite:AddClickListener(slot0._btnfavoriteOnClick, slot0)
	slot0._btncultivate:AddClickListener(slot0._btncultivateOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btndlc:AddClickListener(slot0._btndlcOnClick, slot0)
	slot0._btnexchange:AddClickListener(slot0._btnexchangeOnClick, slot0)
	slot0._btnachievement:AddClickListener(slot0._btnachievementOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnend:AddClickListener(slot0._btnendOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfavorite:RemoveClickListener()
	slot0._btncultivate:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btndlc:RemoveClickListener()
	slot0._btnexchange:RemoveClickListener()
	slot0._btnachievement:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnend:RemoveClickListener()
end

function slot0._btnfavoriteOnClick(slot0)
	RougeController.instance:openRougeFavoriteView()
end

function slot0._btncultivateOnClick(slot0)
	RougeController.instance:openRougeTalentTreeTrunkView()
end

function slot0._btnrewardOnClick(slot0)
	RougeController.instance:openRougeRewardView()
end

function slot0._btndlcOnClick(slot0)
	RougeController.instance:openRougeDLCSelectView()
end

function slot0._btnexchangeOnClick(slot0)
end

function slot0._btnachievementOnClick(slot0)
	JumpController.instance:jump(RougeConfig1.instance:achievementJumpId())
end

function slot0._btnstartOnClick(slot0)
	slot0:_start()
end

function slot0._btnendOnClick(slot0)
	slot0:_end()
end

function slot0._editableInitView(slot0)
	slot0._btnstartCanvasGroup = slot0._btnstart.gameObject:GetComponent(gohelper.Type_CanvasGroup)
	slot0._btnEndGo = slot0._btnend.gameObject
	slot0._gotitleeffect = gohelper.findChild(slot0.viewGO, "title/eff_switch")

	gohelper.setActive(slot0._goimage_start, false)
	gohelper.setActive(slot0._goimage_start2, false)
	gohelper.setActive(slot0._btnEndGo, false)
	gohelper.setActive(slot0._golocked, false)
	gohelper.setActive(slot0._goprogress, false)
	gohelper.setActive(slot0._gonew, false)

	slot0._btnstartCanvasGroup.alpha = 1
	slot0._txtRewardNum.text = "0"
	slot0._txttime.text = ""
	slot0._originVersionStr = RougeDLCHelper.getCurVersionString()
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfo, slot0._onUpdateRougeInfo, slot0)
	RougeOutsideController.instance:registerCallback(RougeEvent.OnUpdateRougeOutsideInfo, slot0._onUpdateRougeOutsideInfo, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, slot0._updateFavoriteNew, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, slot0._onUpdateRougeInfo, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, slot0._onUpdateRougeInfo, slot0)
	slot0:addEventCb(RougeDLCController.instance, RougeEvent.OnGetVersionInfo, slot0._onUpdateVersion, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewCallBack, slot0)
end

function slot0._updateFavoriteNew(slot0)
	gohelper.setActive(slot0._gofavoritenew, RougeFavoriteModel.instance:getAllReddotNum() > 0)
end

function slot0.onOpenFinish(slot0)
	RougeController.instance:startEndFlow()
end

function slot0.onClose(slot0)
	slot0:_clearCdTick()
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfo, slot0._onUpdateRougeInfo, slot0)
	RougeOutsideController.instance:unregisterCallback(RougeEvent.OnUpdateRougeOutsideInfo, slot0._onUpdateRougeOutsideInfo, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, slot0._onUpdateRougeInfo, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, slot0._onUpdateRougeInfo, slot0)
	TaskDispatcher.cancelTask(slot0._onSwitchTitleDone, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_clearCdTick()
	TaskDispatcher.cancelTask(slot0._refreshDLCTitle, slot0)
end

function slot0._onUpdateRougeInfo(slot0)
	slot0:_refresh()
end

function slot0._onUpdateRougeOutsideInfo(slot0)
	slot0:_refresh()
end

function slot0._isContinueLast(slot0)
	return RougeModel.instance:isContinueLast()
end

function slot0._isInCdStart(slot0)
	return not slot0:_isContinueLast() and RougeOutsideModel.instance:isInCdStart()
end

function slot0._refresh(slot0)
	slot0:_refreshStartBtn()
	slot0:_refreshProgress()
	slot0:_refreshCDLocked()
	slot0:_updateFavoriteNew()
	slot0:_refreshTalentBtn()
	slot0:_refreshRewardBtn()
	slot0:_refreshExchangeBtn()
	slot0:_refreshTitle()
end

function slot0._refreshTalentBtn(slot0)
	gohelper.setActive(slot0._goCultivateNew, RougeTalentModel.instance:checkIsNewStage())
	gohelper.setActive(slot0._goCultivateCanUp, RougeTalentModel.instance:checkAnyNodeCanUp())
end

function slot0._refreshRewardBtn(slot0)
	slot0._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	gohelper.setActive(slot0._goRewardNew, RougeRewardModel.instance:checkIsNewStage())
end

function slot0._refreshStartBtn(slot0)
	slot1 = slot0:_isContinueLast()

	gohelper.setActive(slot0._goimage_start, not slot1)
	gohelper.setActive(slot0._goimage_start2, slot1)
	slot0:_refreshEndBtn()
end

function slot0._refreshEndBtn(slot0)
	slot0._btnstartCanvasGroup.alpha = slot0:_isInCdStart() and 0.5 or 1

	gohelper.setActive(slot0._btnEndGo, not slot2 and slot0:_isContinueLast())
end

function slot0._refreshProgress(slot0)
	gohelper.setActive(slot0._goprogress, false)

	if not RougeModel.instance:getDifficulty() or slot1 == 0 then
		return
	end

	gohelper.setActive(slot0._goprogress, true)

	slot0._txtdiffculty.text = RougeOutsideModel.instance:config():getDifficultyCO(slot1).title

	if RougeModel.instance:isStarted() then
		slot4 = RougeMapModel.instance:getLayerCo()

		if RougeMapModel.instance:getMiddleLayerCo() then
			slot0._txtname.text = slot5.name
		else
			slot0._txtname.text = slot4.name
		end
	else
		slot0._txtname.text = ""
	end
end

function slot0._refreshCDLocked(slot0)
	slot0:_clearCdTick()

	if not slot0:_isInCdStart() then
		return
	end

	gohelper.setActive(slot0._golocked, true)
	slot0:_onRefreshCdTick()
	TaskDispatcher.runRepeat(slot0._onRefreshCdTick, slot0, 1)
end

function slot0._clearCdTick(slot0)
	gohelper.setActive(slot0._golocked, false)
	TaskDispatcher.cancelTask(slot0._onRefreshCdTick, slot0)
end

function slot0._onRefreshCdTick(slot0)
	if RougeOutsideModel.instance:leftCdSec() < 0 then
		slot0:_onCdTickEnd()

		return
	end

	slot2, slot3, slot4 = TimeUtil.secondToHMS(slot1)
	slot0._txttime.text = formatLuaLang("rougemainview_cd_fmt", slot2, slot3, slot4)
end

function slot0._onCdTickEnd(slot0)
	slot0._txttime.text = ""

	slot0:_clearCdTick()
	slot0:_refreshStartBtn()
end

function slot0._start(slot0)
	if slot0:_isInCdStart() then
		return
	end

	if RougeController.instance:tryShowMessageBox() then
		return
	end

	if slot0:_isContinueLast() then
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

function slot0._end(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.RougeMainView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, slot0._endYesCallback, nil, , slot0, nil, )
end

function slot0._endYesCallback(slot0)
	RougeStatController.instance:setReset()
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason(), slot0._onReceiveEndReply, slot0)
end

function slot0._onReceiveEndReply(slot0)
	RougeController.instance:startEndFlow()
end

function slot0._refreshExchangeBtn(slot0)
	slot2 = RougeOutsideModel.instance:getRougeGameRecord() and slot1:getVersionIds()

	gohelper.setActive(slot0._btnexchange.gameObject, not (slot2 and #slot2 > 0))
end

function slot0._refreshTitle(slot0)
	slot0:_switchDLCTitle()
end

slot1 = 1.6

function slot0._switchDLCTitle(slot0)
	if RougeDLCHelper.getCurVersionString() == slot0._originVersionStr then
		slot0:_refreshDLCTitle()

		return
	end

	slot2, slot3 = nil
	slot3 = (not string.nilorempty(slot1) or slot0._gonormaltitle) and gohelper.findChild(slot0._godlctitles, slot1)

	if not gohelper.isNil((not string.nilorempty(slot0._originVersionStr) or slot0._gonormaltitle) and gohelper.findChild(slot0._godlctitles, slot0._originVersionStr)) then
		gohelper.setActive(slot2, true)
		gohelper.onceAddComponent(slot2, gohelper.Type_Animator):Play("fadeout", 0, 0)
	end

	if not gohelper.isNil(slot3) then
		gohelper.setActive(slot3, true)
		gohelper.onceAddComponent(slot3, gohelper.Type_Animator):Play("fadein", 0, 0)
	end

	gohelper.setActive(slot0._gotitleeffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.SwitchRougeDLC)
	TaskDispatcher.runDelay(slot0._onSwitchTitleDone, slot0, uv0)
end

function slot0._onSwitchTitleDone(slot0)
	slot0:_refreshDLCTitle()
end

function slot0._refreshDLCTitle(slot0)
	slot1 = RougeDLCHelper.getCurVersionString()

	for slot6 = 1, slot0._godlctitles.transform.childCount do
		slot7 = slot0._godlctitles.transform:GetChild(slot6 - 1).gameObject

		gohelper.setActive(slot7, slot7.name == slot1)
	end

	gohelper.setActive(slot0._gonormaltitle, string.nilorempty(slot1))
	gohelper.setActive(slot0._gotitleeffect, false)

	slot0._originVersionStr = slot1
end

function slot0._onUpdateVersion(slot0)
	if not slot0:checkIsTopView() then
		slot0._waitUpdate = true

		return
	end

	slot0._waitUpdate = nil

	slot0:_refreshExchangeBtn()
	slot0:_refreshTitle()
end

function slot0._onCloseViewCallBack(slot0, slot1)
	if slot1 == ViewName.RougeDLCSelectView and slot0._waitUpdate then
		slot0:_onUpdateVersion()
	end
end

slot2 = {
	[ViewName.ToastView] = true,
	[ViewName.ToastTopView] = true,
	[ViewName.WaterMarkView] = true,
	[ViewName.GuideView] = true
}

function slot0.checkIsTopView(slot0)
	for slot5 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if not uv0[slot1[slot5]] then
			return slot6 == ViewName.RougeMainView
		end
	end
end

return slot0
