module("modules.logic.activity.view.show.ActivityWeekWalkDeepShowView", package.seeall)

slot0 = class("ActivityWeekWalkDeepShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "reset/#txt_time")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "reward/rewardPreview/#scroll_reward")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "#go_progress/#txt_progress")
	slot0._gonewrule = gohelper.findChild(slot0.viewGO, "#btn_detail/#go_newrule")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._refreshNewRuleIcon, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, slot0._refreshNewRuleIcon, slot0, LuaEventSystem.Low)
end

function slot0._btnjumpOnClick(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return
	end

	WeekWalkController.instance:jumpWeekWalkDeepLayerView(slot0._jumpCallback, slot0)
end

function slot0._jumpCallback(slot0)
	TaskDispatcher.cancelTask(slot0._closeBeginnerView, slot0)
	TaskDispatcher.runDelay(slot0._closeBeginnerView, slot0, 1)
end

function slot0._closeBeginnerView(slot0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function slot0._btndetailOnClick(slot0)
	if not slot0:_isWeekWalkDeepOpen() then
		GameFacade.showToast(ToastEnum.WeekWalkDetail)

		return
	end

	WeekWalkController.instance:openWeekWalkRuleView()
	gohelper.setActive(slot0._gonewrule, false)
	slot0:_setIsClickRuleBtnData(uv0.HasClickRuleBtn)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_limbo_bg"))

	slot0._rewardItems = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gorewarditem, false)
	slot0:_refreshNewRuleIcon()
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		ActivityEnum.Activity.WeekWalkDeepShow
	})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._actId = slot0.viewContainer.activityId

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._config = ActivityConfig.instance:getActivityShowTaskList(slot0._actId, 1)
	slot0._txtdesc.text = slot0._config.actDesc

	slot0:_refreshRewards()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		slot0:_showDeadline()
		slot0:_refreshProgress()
	else
		slot0._txttime.text = luaLang("activityweekwalkdeepview_lcok")
		slot0._txtprogress.text = luaLang("activityweekwalkdeepview_empty")
	end
end

function slot0._isWeekWalkDeepOpen(slot0)
	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) and WeekWalkModel.instance:getInfo().isOpenDeep
end

slot0.ShowCount = 1

function slot0._refreshRewards(slot0)
	for slot5 = 1, #string.split(slot0._config.showBonus, "|") do
		if not slot0._rewardItems[slot5] then
			slot6 = slot0:getUserDataTb_()
			slot6.go = gohelper.clone(slot0._gorewarditem, slot0._gorewardContent, "rewarditem" .. slot5)
			slot6.item = IconMgr.instance:getCommonPropItemIcon(slot6.go)

			table.insert(slot0._rewardItems, slot6)
		end

		gohelper.setActive(slot0._rewardItems[slot5].go, true)

		slot7 = string.splitToNumber(slot1[slot5], "#")

		slot0._rewardItems[slot5].item:setMOValue(slot7[1], slot7[2], slot7[3])
		slot0._rewardItems[slot5].item:isShowCount(slot7[4] == uv0.ShowCount)
		slot0._rewardItems[slot5].item:setCountFontSize(35)
		slot0._rewardItems[slot5].item:setHideLvAndBreakFlag(true)
		slot0._rewardItems[slot5].item:hideEquipLvAndBreak(true)
	end

	for slot5 = #slot1 + 1, #slot0._rewardItems do
		gohelper.setActive(slot0._rewardItems[slot5].go, false)
	end
end

function slot0._refreshProgress(slot0)
	slot2, slot3 = WeekWalkModel.instance:getInfo():getNotFinishedMap()
	slot5 = nil

	if WeekWalkModel.isShallowMap(slot2.sceneId) or not slot1.isOpenDeep then
		slot5 = luaLang("activityweekwalkdeepview_empty")
	else
		gohelper.setActive(slot0._goprogress, true)

		slot6 = lua_weekwalk_scene.configDict[slot2.sceneId]
		slot5 = (not LangSettings.instance:isEn() or string.format("%s %s", slot6.name, slot6.battleName)) and string.format("%s%s", slot6.name, slot6.battleName)
	end

	slot0._txtprogress.text = slot5
end

function slot0._showDeadline(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		slot0._txttime.text = luaLang("activityweekwalkdeepview_lcok")

		return
	end

	slot0._endTime = WeekWalkModel.instance:getInfo().endTime

	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	slot0:_onRefreshDeadline()
end

function slot0._onRefreshDeadline(slot0)
	if slot0._endTime - ServerTime.now() <= 0 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end

	slot2, slot3 = TimeUtil.secondToRoughTime2(math.floor(slot1))
	slot0._txttime.text = formatLuaLang("activityweekwalkdeepview_resetremaintime", slot2 .. slot3)
end

function slot0._refreshNewRuleIcon(slot0)
	slot1 = ActivityModel.instance:getActMO(ActivityEnum.Activity.WeekWalkDeepShow).isNewStage
	slot3 = false

	if slot0:_isWeekWalkDeepOpen() then
		slot3 = slot1 or not slot0:_checkIsClickRuleBtn()
	end

	if slot1 then
		slot0:_setIsClickRuleBtnData(uv0.UnClickRuleBtn)
	end

	gohelper.setActive(slot0._gonewrule, slot3)
end

slot1 = PlayerPrefsKey.EnteredActKey .. "#" .. tostring(ActivityEnum.Activity.WeekWalkDeepShow) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

function slot0._checkIsClickRuleBtn(slot0)
	return tonumber(PlayerPrefsHelper.getNumber(uv0, uv1.UnClickRuleBtn)) ~= uv1.UnClickRuleBtn
end

slot0.HasClickRuleBtn = 1
slot0.UnClickRuleBtn = 0

function slot0._setIsClickRuleBtnData(slot0, slot1)
	PlayerPrefsHelper.setNumber(uv0, tonumber(slot1) or uv1.UnClickRuleBtn)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._closeBeginnerView, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
