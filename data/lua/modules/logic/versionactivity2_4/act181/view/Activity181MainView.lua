module("modules.logic.versionactivity2_4.act181.view.Activity181MainView", package.seeall)

slot0 = class("Activity181MainView", BaseView)
slot0.OPEN_ANIM = "open"
slot0.OPEN_ANIM_FIRST_DAY = "openfrist"
slot0.POP_UP_DELAY = 0.8

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageBoxShadow = gohelper.findChildSingleImage(slot0.viewGO, "Box/#simage_BoxShadow")
	slot0._simageBoxShadow2 = gohelper.findChildSingleImage(slot0.viewGO, "Box/#simage_BoxShadow2")
	slot0._simageBox = gohelper.findChildSingleImage(slot0.viewGO, "Box/#simage_Box")
	slot0._txtOpenTimes = gohelper.findChildText(slot0.viewGO, "Box/OpenTimes/#txt_OpenTimes")
	slot0._goClaimed = gohelper.findChild(slot0.viewGO, "Box/OpenTimes/#go_Claimed")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "Box/Grid/#go_Item")
	slot0._simageItem = gohelper.findChildSingleImage(slot0.viewGO, "Box/Grid/#go_Item/OptionalItem/#simage_Item")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "Box/Grid/#go_Item/OptionalItem/image_NumBG/#txt_Num")
	slot0._txtItemName = gohelper.findChildText(slot0.viewGO, "Box/Grid/#go_Item/OptionalItem/#txt_ItemName")
	slot0._goCover = gohelper.findChild(slot0.viewGO, "Box/Grid/#go_Item/#go_Cover")
	slot0._goType1 = gohelper.findChild(slot0.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type1")
	slot0._goType2 = gohelper.findChild(slot0.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type2")
	slot0._goType3 = gohelper.findChild(slot0.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type3")
	slot0._goType4 = gohelper.findChild(slot0.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type4")
	slot0._goTips1 = gohelper.findChild(slot0.viewGO, "Box/Tips/#go_Tips1")
	slot0._goTips2 = gohelper.findChild(slot0.viewGO, "Box/Tips/#go_Tips2")
	slot0._btnInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "Reward/#btn_Info")
	slot0._btnSpInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/Reward/#btn_SpInfo")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/#txt_Descr")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	slot0._btnspBonus = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/Reward/image_Reward/#btn_spBonus")
	slot0._goCanGet = gohelper.findChild(slot0.viewGO, "Right/Reward/#go_CanGet")
	slot0._goSpClaimed = gohelper.findChild(slot0.viewGO, "Right/Reward/#go_SpClaimed")
	slot0._simageRewardName = gohelper.findChildSingleImage(slot0.viewGO, "Right/Reward/#simage_RewardName")
	slot0._txtRewardDescr = gohelper.findChildText(slot0.viewGO, "Right/Reward/#txt_RewardDescr")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnInfo:AddClickListener(slot0._btnInfoOnClick, slot0)
	slot0._btnspBonus:AddClickListener(slot0._btnspBonusOnClick, slot0)
	slot0._btnSpInfo:AddClickListener(slot0._btnSpInfoOnClick, slot0)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetBonus, slot0.onGetBonus, slot0)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetInfo, slot0.refreshUI, slot0)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetSPBonus, slot0.onGetSPBonus, slot0)
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneSecond)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.updateInfo, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDay, slot0.refreshSpBonusZeroTime, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnInfo:RemoveClickListener()
	slot0._btnspBonus:RemoveClickListener()
	slot0._btnSpInfo:RemoveClickListener()
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetBonus, slot0.onGetBonus, slot0)
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetInfo, slot0.refreshUI, slot0)
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetSPBonus, slot0.onGetSPBonus, slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.updateInfo, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDay, slot0.refreshSpBonusZeroTime, slot0)
end

function slot0._btnspBonusOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if not Activity181Model.instance:isActivityInTime(slot0._actId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if not Activity181Model.instance:getActivityInfo(slot0._actId) then
		return
	end

	if slot1.spBonusState == Activity181Enum.SPBonusState.Locked then
		GameFacade.showToast(ToastEnum.NorSign)

		return
	elseif slot1.spBonusState == Activity181Enum.SPBonusState.HaveGet then
		slot2 = string.splitToNumber(slot1.config.bonus, "#")

		MaterialTipController.instance:showMaterialInfo(slot2[1], slot2[2], false)

		return
	end

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	Activity181Controller.instance:getSPBonus(slot0._actId)
end

function slot0._btnSpInfoOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if not Activity181Model.instance:getActivityInfo(slot0._actId) then
		return
	end

	slot2 = string.splitToNumber(slot1.config.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(slot2[1], slot2[2], false)
end

function slot0._btnInfoOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	ViewMgr.instance:openView(ViewName.Activity181RewardView, {
		actId = slot0._actId
	})
end

function slot0._editableInitView(slot0)
	slot0._bonusItemList = {}

	gohelper.setActive(slot0._goItem, false)

	slot0._animator = gohelper.findChildComponent(slot0.viewGO, "", gohelper.Type_Animator)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = slot0.viewParam.actId

	slot0:updateInfo()
	slot0:playOpenAnim()
end

function slot0.updateInfo(slot0)
	Activity181Controller.instance:getActivityInfo(slot0._actId)
end

function slot0.playOpenAnim(slot0)
	if Activity181Model.instance:getHaveFirstDayLogin(slot0._actId) then
		Activity181Model.instance:setHaveFirstDayLogin(slot0._actId)
	end

	slot0._animator:Play(slot1 and slot0.OPEN_ANIM_FIRST_DAY or slot0.OPEN_ANIM)
	AudioMgr.instance:trigger(AudioEnum.Act181.play_ui_diqiu_xueye_open)
end

function slot0.refreshUI(slot0)
	slot0:refreshTime()
	slot0:refreshBonus()
end

function slot0.onGetBonus(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0._actId then
		return
	end

	slot0._bonusItemList[slot3]:onUpdateMO(slot3, slot1, true)

	if not Activity181Model.instance:getActivityInfo(slot0._actId) then
		return
	end

	if slot6:getBonusTimes() <= 0 then
		for slot10, slot11 in ipairs(slot4) do
			if slot10 ~= slot3 then
				slot11:setBonusFxState(slot6:getBonusState(slot10) == Activity181Enum.BonusState.HaveGet, false)
			end
		end
	end

	slot0:refreshBonusDesc(slot6)
	slot0:refreshSPBonus(slot6)
	Activity181Model.instance:setPopUpPauseState(true)
	TaskDispatcher.runDelay(slot0.onBonusAnimationEnd, slot0, slot0.POP_UP_DELAY)
end

function slot0.onBonusAnimationEnd(slot0)
	Activity181Model.instance:setPopUpPauseState(false)
	TaskDispatcher.cancelTask(slot0.onBonusAnimationEnd, slot0)
end

function slot0.onGetSPBonus(slot0, slot1)
	if slot1 ~= slot0._actId then
		return
	end

	if not Activity181Model.instance:getActivityInfo(slot0._actId) then
		return
	end

	slot0:refreshSPBonus(slot2)
end

function slot0.refreshSpBonusZeroTime(slot0)
	logNormal("Activity181MainView : refreshSpBonusZeroTime")

	if ActivityModel.instance:getActMO(slot0._actId):getRealEndTimeStamp() <= ServerTime.now() then
		return
	end

	if not Activity181Model.instance:getActivityInfo(slot0._actId) then
		return
	end

	if slot3 <= TimeUtil.stringToTimestamp(slot4.config.obtainStart) - TimeUtil.OneDaySecond or slot3 >= TimeUtil.stringToTimestamp(slot5.obtainEnd) + TimeUtil.OneDaySecond then
		return
	end

	logNormal("Activity181MainView : refreshSpBonusInfo")
	slot4:refreshSpBonusInfo()
end

function slot0.refreshTime(slot0)
	if ActivityModel.instance:getActMO(slot0._actId):getRealEndTimeStamp() <= ServerTime.now() then
		slot0._txtLimitTime.text = luaLang("ended")

		return
	end

	slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2 - slot3)
end

function slot0.refreshBonus(slot0)
	if not Activity181Model.instance:getActivityInfo(slot0._actId) then
		return
	end

	slot2 = Activity181Config.instance:getBoxListByActivityId(slot0._actId)
	slot3 = #slot2
	slot5 = #slot0._bonusItemList

	for slot9, slot10 in ipairs(slot2) do
		slot11 = nil

		if slot5 < slot9 then
			slot11 = Activity181BonusItem.New()

			slot11:init(gohelper.clone(slot0._goItem, slot0._goItem.transform.parent.gameObject, tostring(slot9)))
			table.insert(slot4, slot11)
		else
			slot11 = slot4[slot9]
		end

		slot11:setEnable(true)
		slot11:onUpdateMO(slot9, slot0._actId)
	end

	if slot3 < slot5 then
		for slot9 = slot3 + 1, slot5 do
			slot0._bonusItemList[slot9]:setEnable(false)
		end
	end

	slot0:refreshBonusDesc(slot1)
	slot0:refreshSPBonus(slot1)
end

function slot0.refreshBonusDesc(slot0, slot1)
	slot2 = slot1:canGetBonus()

	gohelper.setActive(slot0._goClaimed, not slot2)
	gohelper.setActive(slot0._txtOpenTimes, slot2)

	if slot2 then
		slot0._txtOpenTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("blind_box_bouns_count"), tostring(slot1.canGetTimes))
	end

	gohelper.setActive(slot0._goTips2, slot1.canGetTimes > 0)
	gohelper.setActive(slot0._goTips1, slot1.canGetTimes <= 0 and slot2)
end

function slot0.refreshSPBonus(slot0, slot1)
	if not slot1 then
		return
	end

	gohelper.setActive(slot0._goSpClaimed, slot1.spBonusState == Activity181Enum.SPBonusState.HaveGet)
	gohelper.setActive(slot0._goCanGet, slot2 == Activity181Enum.SPBonusState.Unlock)
	gohelper.setActive(slot0._btnSpInfo, slot2 == Activity181Enum.SPBonusState.Locked)
end

function slot0.onClose(slot0)
	if Activity181Model.instance:getPopUpPauseState() then
		slot0:onBonusAnimationEnd()
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._bonusItemList) do
		slot5:onDestroy()
	end

	slot0._bonusItemList = nil
end

return slot0
