module("modules.logic.versionactivity1_9.enter.view.subview.V1a9_Season123EnterView", package.seeall)

slot0 = class("V1a9_Season123EnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._goDesc = gohelper.findChild(slot0.viewGO, "Dec")
	slot0._btnnormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Normal")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "LimitTime/#txt_LimitTime")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "Store/#go_store/#btn_store")
	slot0._txtstoretime = gohelper.findChildText(slot0.viewGO, "Store/#go_taglimit/#txt_limit")
	slot0._txtstoreCoinNum = gohelper.findChildText(slot0.viewGO, "Store/#go_store/#txt_num")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_Normal/#image_reddot")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Locked")
	slot0._txtLocked = gohelper.findChildText(slot0.viewGO, "#btn_Locked/txt_Locked")
	slot0._txtLockedEn = gohelper.findChildText(slot0.viewGO, "#btn_Locked/txt_LockedEn")
	slot0._txtUnlockedTips = gohelper.findChildText(slot0.viewGO, "#btn_Locked/#txt_UnLockedTips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnormal:AddClickListener(slot0._btnNormalOnClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._btnLockedOnClick, slot0)
	slot0._btnstore:AddClickListener(slot0._btnStoreOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshStoreCoin, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnormal:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshStoreCoin, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0._btnNormalOnClick(slot0)
	if slot0.actId ~= nil and ActivityModel.instance:getActMO(slot0.actId) and slot1:isOpen() then
		Season123Controller.instance:openSeasonEntry({
			actId = slot0.actId
		})

		return
	end

	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function slot0._btnLockedOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal and slot2 then
		GameFacade.showToast(slot2, slot3)
	end
end

function slot0._btnStoreOnClick(slot0)
	Season123Controller.instance:openSeasonStoreView(slot0.actId)
end

function slot0._editableInitView(slot0)
	slot4 = slot0
	slot0.animComp = VersionActivitySubAnimatorComp.get(slot0.viewGO, slot4)
	slot0.descTab = slot0:getUserDataTb_()

	for slot4 = 1, 4 do
		table.insert(slot0.descTab, gohelper.findChildText(slot0.viewGO, "Dec/txt_dec" .. slot4))
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.animComp:playOpenAnim()

	slot0.actId = VersionActivity1_9Enum.ActivityId.Season

	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.Season123Enter)
	slot0:refreshUI()
	VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, slot0.actId, slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshEnterBtn()
	slot0:refreshDesc()
	slot0:refreshStoreCoin()
	slot0:refreshRemainTime()
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

function slot0.refreshStoreCoin(slot0)
	slot0._txtstoreCoinNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(Season123Config.instance:getSeasonConstNum(slot0.actId, Activity123Enum.Const.StoreCoinId)) and slot2.quantity or 0)
end

function slot0.refreshEnterBtn(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)
	slot4 = slot1 ~= ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(slot0._btnnormal.gameObject, not slot4)
	gohelper.setActive(slot0._btnLocked.gameObject, slot4)

	if slot2 then
		slot0._txtUnlockedTips.text = GameUtil.getSubPlaceholderLuaLang(ToastConfig.instance:getToastCO(slot2).tips, slot3)
	else
		slot0._txtUnlockedTips.text = ""
	end

	gohelper.setActive(slot0._txtUnlockedTips.gameObject, slot1 ~= ActivityEnum.ActivityStatus.Expired)

	slot0._txtLocked.text = slot1 == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	slot0._txtLockedEn.text = slot1 == ActivityEnum.ActivityStatus.Expired and "ENDED" or "LOCKED"
end

function slot0.refreshRemainTime(slot0)
	slot0:refreshMainTime()
	slot0:refreshStoreTime()
end

function slot0.refreshMainTime(slot0)
	if not ActivityModel.instance:getActMO(slot0.actId) then
		slot0._txtLimitTime.text = ""

		return
	end

	if slot1:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
	else
		slot0._txtLimitTime.text = luaLang("ended")
	end
end

function slot0.refreshStoreTime(slot0)
	if not ActivityModel.instance:getActMO(Season123Config.instance:getSeasonConstNum(slot0.actId, Activity123Enum.Const.StoreActId)) then
		return
	end

	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(slot1)

	if slot3 ~= ActivityEnum.ActivityStatus.Normal and slot4 then
		slot0._txtstoretime.text = slot3 == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	else
		slot0._txtstoretime.text = slot2:getRemainTimeStr2ByEndTime(true)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.animComp:destroy()
end

return slot0
