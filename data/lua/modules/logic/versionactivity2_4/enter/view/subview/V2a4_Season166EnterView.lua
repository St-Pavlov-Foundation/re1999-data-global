module("modules.logic.versionactivity2_4.enter.view.subview.V2a4_Season166EnterView", package.seeall)

slot0 = class("V2a4_Season166EnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._goDesc = gohelper.findChild(slot0.viewGO, "#simage_FullBG/Dec")
	slot0._btnnormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Normal")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "LimitTime/#txt_LimitTime")
	slot0._btnInformation = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_information")
	slot0._txtcoinNum = gohelper.findChildText(slot0.viewGO, "#btn_information/#txt_coinNum")
	slot0._goinfoReddot = gohelper.findChild(slot0.viewGO, "#btn_information/#go_infoReddot")
	slot0._goinfoNewReddot = gohelper.findChild(slot0.viewGO, "#btn_information/#go_infoNewReddot")
	slot0._goinfoTime = gohelper.findChildText(slot0.viewGO, "#btn_information/#go_infoTime")
	slot0._txtinfoTime = gohelper.findChildText(slot0.viewGO, "#btn_information/#go_infoTime/#txt_time")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_Normal/#image_reddot")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Locked")
	slot0._txtLocked = gohelper.findChildText(slot0.viewGO, "#btn_Locked/txt_Locked")
	slot0._txtLockedEn = gohelper.findChildText(slot0.viewGO, "#btn_Locked/txt_LockedEn")
	slot0._txtUnlockedTips = gohelper.findChildText(slot0.viewGO, "#btn_Locked/#txt_UnLockedTips")
	slot0._btnEnd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_End")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnormal:AddClickListener(slot0._btnNormalOnClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._btnLockedOnClick, slot0)
	slot0._btnEnd:AddClickListener(slot0._btnEndOnClick, slot0)
	slot0._btnInformation:AddClickListener(slot0._btnInformationOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshInformationCoin, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
	slot0._btnnormal:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
	slot0._btnEnd:RemoveClickListener()
	slot0._btnInformation:RemoveClickListener()
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshInformationCoin, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0._btnNormalOnClick(slot0)
	if slot0.actId ~= nil and ActivityModel.instance:getActMO(slot0.actId) and slot1:isOpen() then
		Season166Controller.instance:openSeasonView({
			actId = slot0.actId
		})

		return
	end

	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function slot0._btnLockedOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal and slot1 ~= ActivityEnum.ActivityStatus.Expired and slot2 then
		GameFacade.showToast(slot2, slot3)
	end
end

function slot0._btnEndOnClick(slot0)
	if slot0.isCloseEnter then
		GameFacade.showToast(ToastEnum.ActivityEnd)
	end
end

function slot0._btnInformationOnClick(slot0)
	Activity166Rpc.instance:sendGet166InfosRequest(slot0.actId, function ()
		ViewMgr.instance:openView(ViewName.Season166InformationMainView, {
			actId = uv0.actId
		})
	end, slot0)
end

function slot0._editableInitView(slot0)
	slot0.descTab = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		table.insert(slot0.descTab, gohelper.findChildText(slot0.viewGO, "#simage_FullBG/Dec/go_desc" .. slot4 .. "/txt_desc"))
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	slot0.actId = VersionActivity2_4Enum.ActivityId.Season
	slot0.infoCoinId = Season166Config.instance:getSeasonConstNum(slot0.actId, Season166Enum.InfoCostId)

	if ActivityHelper.getActivityStatusAndToast(slot0.actId) == ActivityEnum.ActivityStatus.Normal then
		Activity166Rpc.instance:sendGet166InfosRequest(slot0.actId)
	end

	slot0.closeEnterTimeOffset = Season166Config.instance:getSeasonConstNum(slot0.actId, Season166Enum.CloseSeasonEnterTime)

	slot0._simageFullBG:LoadImage(Season166Config.instance:getSeasonConstStr(slot0.actId, Season166Enum.EnterViewBgUrl))
	slot0:refreshUI()
	VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, slot0.actId, slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshRemainTime()
	slot0:refreshEnterBtn()
	slot0:refreshDesc()
	slot0:refreshInformationCoin()
	slot0:refreshReddot()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
end

function slot0.refreshDesc(slot0)
	if not ActivityConfig.instance:getActivityCo(slot0.actId) then
		gohelper.setActive(slot0._goDesc, false)
	else
		gohelper.setActive(slot0._goDesc, true)

		for slot6 = 1, #string.split(slot1.actDesc, "#") do
			if not slot0.descTab[slot6] then
				return
			end

			gohelper.setActive(slot0.descTab[slot6].gameObject, true)

			slot0.descTab[slot6].text = slot2[slot6]
		end

		for slot6 = #slot2 + 1, #slot0.descTab do
			gohelper.setActive(slot0.descTab[slot6].gameObject, false)
		end
	end
end

function slot0.refreshEnterBtn(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)
	slot4 = slot1 ~= ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(slot0._btnnormal.gameObject, not slot4 and not slot0.isCloseEnter)
	gohelper.setActive(slot0._btnEnd.gameObject, not slot4 and slot0.isCloseEnter)
	gohelper.setActive(slot0._btnLocked.gameObject, slot4)

	if slot2 then
		slot0._txtUnlockedTips.text = GameUtil.getSubPlaceholderLuaLang(ToastConfig.instance:getToastCO(slot2).tips, slot3)
	else
		slot0._txtUnlockedTips.text = ""
	end

	gohelper.setActive(slot0._txtUnlockedTips.gameObject, slot1 ~= ActivityEnum.ActivityStatus.Expired)

	slot0._txtLocked.text = luaLang("notOpen")
	slot0._txtLockedEn.text = "LOCKED"
end

function slot0.refreshRemainTime(slot0)
	if not ActivityModel.instance:getActMO(slot0.actId) then
		slot0._txtLimitTime.text = ""

		gohelper.setActive(slot0._goinfoTime, false)

		return
	end

	slot0.isCloseEnter = slot0:checkIsCloseEnter(slot1)
	slot3 = slot1:getRealEndTimeStamp() - ServerTime.now()

	if slot0.enterCloseTime - ServerTime.now() > 0 then
		slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
	else
		slot0._txtLimitTime.text = luaLang("ended")
	end

	gohelper.setActive(slot0._goinfoTime, slot3 > 0)

	slot0._txtinfoTime.text = slot1:getRemainTimeStr2ByEndTime(true)
end

function slot0.checkIsCloseEnter(slot0, slot1)
	slot3 = slot1:getRealStartTimeStamp()
	slot4 = slot1:getRealEndTimeStamp() - ServerTime.now() > 0

	if slot0.closeEnterTimeOffset == 0 then
		slot0.enterCloseTime = slot2

		return false
	end

	slot0.enterCloseTime = slot3 + slot0.closeEnterTimeOffset * TimeUtil.OneDaySecond

	return slot4 and slot0.enterCloseTime < ServerTime.now()
end

function slot0.refreshInformationCoin(slot0)
	slot0._txtcoinNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(slot0.infoCoinId).quantity)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.Season166InformationMainView then
		slot0:refreshReddot()
	end
end

function slot0.refreshReddot(slot0)
	RedDotController.instance:addRedDot(slot0._goinfoReddot, RedDotEnum.DotNode.Season166InformationEnter, nil, slot0.checkReddotShow, slot0)
end

function slot0.checkReddotShow(slot0, slot1)
	slot1:defaultRefreshDot()

	if Season166Model.instance:checkHasNewUnlockInfo() then
		gohelper.setActive(slot0._goinfoNewReddot, true)
		gohelper.setActive(slot0._goinfoReddot, false)
	else
		gohelper.setActive(slot0._goinfoNewReddot, false)
		gohelper.setActive(slot0._goinfoReddot, true)
		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
