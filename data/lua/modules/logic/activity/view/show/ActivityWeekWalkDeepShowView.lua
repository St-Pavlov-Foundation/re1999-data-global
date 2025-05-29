module("modules.logic.activity.view.show.ActivityWeekWalkDeepShowView", package.seeall)

local var_0_0 = class("ActivityWeekWalkDeepShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "reset/#txt_time")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_detail")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_progress/#txt_progress")
	arg_1_0._gonewrule = gohelper.findChild(arg_1_0.viewGO, "#btn_detail/#go_newrule")
	arg_1_0._animView = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_2_0._refreshNewRuleIcon, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, arg_3_0._refreshNewRuleIcon, arg_3_0, LuaEventSystem.Low)
end

function var_0_0._btnjumpOnClick(arg_4_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return
	end

	WeekWalkController.instance:jumpWeekWalkDeepLayerView(arg_4_0._jumpCallback, arg_4_0)
end

function var_0_0._jumpCallback(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._closeBeginnerView, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._closeBeginnerView, arg_5_0, 1)
end

function var_0_0._closeBeginnerView(arg_6_0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function var_0_0._btndetailOnClick(arg_7_0)
	if not arg_7_0:_isWeekWalkDeepOpen() then
		GameFacade.showToast(ToastEnum.WeekWalkDetail)

		return
	end

	WeekWalkController.instance:openWeekWalkRuleView()
	gohelper.setActive(arg_7_0._gonewrule, false)
	arg_7_0:_setIsClickRuleBtnData(var_0_0.HasClickRuleBtn)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_limbo_bg"))

	arg_8_0._rewardItems = arg_8_0:getUserDataTb_()

	gohelper.setActive(arg_8_0._gorewarditem, false)
	arg_8_0:_refreshNewRuleIcon()
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		ActivityEnum.Activity.WeekWalkDeepShow
	})
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._animView:Play(UIAnimationName.Open, 0, 0)

	arg_10_0._actId = arg_10_0.viewContainer.activityId

	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0._config = ActivityConfig.instance:getActivityShowTaskList(arg_11_0._actId, 1)
	arg_11_0._txtdesc.text = arg_11_0._config.actDesc

	arg_11_0:_refreshRewards()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		arg_11_0:_showDeadline()
		arg_11_0:_refreshProgress()
	else
		arg_11_0._txttime.text = luaLang("activityweekwalkdeepview_lcok")
		arg_11_0._txtprogress.text = luaLang("activityweekwalkdeepview_empty")
	end
end

function var_0_0._isWeekWalkDeepOpen(arg_12_0)
	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) and WeekWalkModel.instance:getInfo().isOpenDeep
end

var_0_0.ShowCount = 1

function var_0_0._refreshRewards(arg_13_0)
	local var_13_0 = WeekWalkDeepLayerNoticeView._getRewardList()
	local var_13_1

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_2 = iter_13_1[1]
		local var_13_3 = iter_13_1[2]
		local var_13_4 = iter_13_1[3]

		if var_13_2 == 2 and var_13_3 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			var_13_1 = string.format("%s#%s#%s#1", var_13_2, var_13_3, var_13_4)

			break
		end
	end

	local var_13_5 = arg_13_0._config.showBonus

	if var_13_1 then
		var_13_5 = string.format("%s|%s", var_13_1, var_13_5)
	end

	local var_13_6 = string.split(var_13_5, "|")

	for iter_13_2 = 1, #var_13_6 do
		if not arg_13_0._rewardItems[iter_13_2] then
			local var_13_7 = arg_13_0:getUserDataTb_()

			var_13_7.go = gohelper.clone(arg_13_0._gorewarditem, arg_13_0._gorewardContent, "rewarditem" .. iter_13_2)
			var_13_7.item = IconMgr.instance:getCommonPropItemIcon(var_13_7.go)

			table.insert(arg_13_0._rewardItems, var_13_7)
		end

		gohelper.setActive(arg_13_0._rewardItems[iter_13_2].go, true)

		local var_13_8 = string.splitToNumber(var_13_6[iter_13_2], "#")

		arg_13_0._rewardItems[iter_13_2].item:setMOValue(var_13_8[1], var_13_8[2], var_13_8[3])
		arg_13_0._rewardItems[iter_13_2].item:isShowCount(var_13_8[4] == var_0_0.ShowCount)
		arg_13_0._rewardItems[iter_13_2].item:setCountFontSize(35)
		arg_13_0._rewardItems[iter_13_2].item:setHideLvAndBreakFlag(true)
		arg_13_0._rewardItems[iter_13_2].item:hideEquipLvAndBreak(true)
	end

	for iter_13_3 = #var_13_6 + 1, #arg_13_0._rewardItems do
		gohelper.setActive(arg_13_0._rewardItems[iter_13_3].go, false)
	end
end

function var_0_0._refreshProgress(arg_14_0)
	local var_14_0 = WeekWalkModel.instance:getInfo()
	local var_14_1, var_14_2 = var_14_0:getNotFinishedMap()
	local var_14_3 = WeekWalkModel.isShallowMap(var_14_1.sceneId)
	local var_14_4

	if var_14_3 or not var_14_0.isOpenDeep then
		var_14_4 = luaLang("activityweekwalkdeepview_empty")
	else
		gohelper.setActive(arg_14_0._goprogress, true)

		local var_14_5 = lua_weekwalk_scene.configDict[var_14_1.sceneId]

		if LangSettings.instance:isEn() then
			var_14_4 = string.format("%s %s", var_14_5.name, var_14_5.battleName)
		else
			var_14_4 = string.format("%s%s", var_14_5.name, var_14_5.battleName)
		end
	end

	arg_14_0._txtprogress.text = var_14_4
end

function var_0_0._showDeadline(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._onRefreshDeadline, arg_15_0)

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		arg_15_0._txttime.text = luaLang("activityweekwalkdeepview_lcok")

		return
	end

	arg_15_0._endTime = WeekWalkModel.instance:getInfo().endTime

	TaskDispatcher.runRepeat(arg_15_0._onRefreshDeadline, arg_15_0, 1)
	arg_15_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_16_0)
	local var_16_0 = arg_16_0._endTime - ServerTime.now()

	if var_16_0 <= 0 then
		TaskDispatcher.cancelTask(arg_16_0._onRefreshDeadline, arg_16_0)
	end

	local var_16_1, var_16_2 = TimeUtil.secondToRoughTime2(math.floor(var_16_0))

	arg_16_0._txttime.text = formatLuaLang("activityweekwalkdeepview_resetremaintime", var_16_1 .. var_16_2)
end

function var_0_0._refreshNewRuleIcon(arg_17_0)
	local var_17_0 = ActivityModel.instance:getActMO(ActivityEnum.Activity.WeekWalkDeepShow).isNewStage
	local var_17_1 = arg_17_0:_isWeekWalkDeepOpen()
	local var_17_2 = false

	if var_17_1 then
		var_17_2 = var_17_0 or not arg_17_0:_checkIsClickRuleBtn()
	end

	if var_17_0 then
		arg_17_0:_setIsClickRuleBtnData(var_0_0.UnClickRuleBtn)
	end

	gohelper.setActive(arg_17_0._gonewrule, var_17_2)
end

local var_0_1 = PlayerPrefsKey.EnteredActKey .. "#" .. tostring(ActivityEnum.Activity.WeekWalkDeepShow) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

function var_0_0._checkIsClickRuleBtn(arg_18_0)
	local var_18_0 = PlayerPrefsHelper.getNumber(var_0_1, var_0_0.UnClickRuleBtn)

	return tonumber(var_18_0) ~= var_0_0.UnClickRuleBtn
end

var_0_0.HasClickRuleBtn = 1
var_0_0.UnClickRuleBtn = 0

function var_0_0._setIsClickRuleBtnData(arg_19_0, arg_19_1)
	PlayerPrefsHelper.setNumber(var_0_1, tonumber(arg_19_1) or var_0_0.UnClickRuleBtn)
end

function var_0_0.onClose(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._onRefreshDeadline, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._closeBeginnerView, arg_20_0)
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagebg:UnLoadImage()
end

return var_0_0
