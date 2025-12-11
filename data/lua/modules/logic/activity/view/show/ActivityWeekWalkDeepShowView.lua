module("modules.logic.activity.view.show.ActivityWeekWalkDeepShowView", package.seeall)

local var_0_0 = class("ActivityWeekWalkDeepShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "reset/#txt_time")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_progress/#txt_progress")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "reward/rewardPreview/#txt_currency")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "reward/rewardPreview/#txt_currency/#txt_total")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/btn/#go_canget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/btn/#go_hasget")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "reward/rewardPreview/btn/#btn_click")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_detail")
	arg_1_0._gonewrule = gohelper.findChild(arg_1_0.viewGO, "#btn_detail/#go_newrule")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._openMapId1 then
		return
	end

	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = arg_4_0._openMapId1
	})
end

function var_0_0._btnjumpOnClick(arg_5_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return
	end

	WeekWalkController.instance:jumpWeekWalkDeepLayerView(arg_5_0._jumpCallback, arg_5_0)
end

function var_0_0._jumpCallback(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._closeBeginnerView, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._closeBeginnerView, arg_6_0, 1)
end

function var_0_0._closeBeginnerView(arg_7_0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function var_0_0._btndetailOnClick(arg_8_0)
	if not arg_8_0:_isWeekWalkDeepOpen() then
		GameFacade.showToast(ToastEnum.WeekWalkDetail)

		return
	end

	WeekWalkController.instance:openWeekWalkRuleView()
	gohelper.setActive(arg_8_0._gonewrule, false)
	arg_8_0:_setIsClickRuleBtnData(var_0_0.HasClickRuleBtn)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._animView = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_9_0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_limbo_bg"))

	arg_9_0._rewardItems = arg_9_0:getUserDataTb_()

	gohelper.setActive(arg_9_0._gorewarditem, false)
	arg_9_0:_refreshNewRuleIcon()
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		ActivityEnum.Activity.WeekWalkDeepShow
	})
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._animView:Play(UIAnimationName.Open, 0, 0)

	arg_11_0._actId = arg_11_0.viewContainer.activityId

	arg_11_0:refreshUI()
	arg_11_0:_updateTaskInfo()
	arg_11_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_11_0._onWeekwalk_2TaskUpdate, arg_11_0)
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0._config = ActivityConfig.instance:getActivityShowTaskList(arg_12_0._actId, 1)
	arg_12_0._txtdesc.text = arg_12_0._config.actDesc

	arg_12_0:_refreshRewards()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		arg_12_0:_showDeadline()
		arg_12_0:_refreshProgress()
	else
		arg_12_0._txttime.text = luaLang("activityweekwalkdeepview_lcok")
		arg_12_0._txtprogress.text = luaLang("activityweekwalkdeepview_empty")
	end
end

function var_0_0._onWeekwalk_2TaskUpdate(arg_13_0)
	arg_13_0:_updateTaskInfo()
end

function var_0_0._updateTaskInfo(arg_14_0)
	local var_14_0, var_14_1, var_14_2, var_14_3 = WeekWalkTaskListModel.instance:getAllDeepTaskInfo()

	arg_14_0._openMapId1 = var_14_3
	arg_14_0._txtcurrency.text = var_14_0
	arg_14_0._txttotal.text = var_14_1

	gohelper.setActive(arg_14_0._gocanget, #var_14_2 > 0)
	gohelper.setActive(arg_14_0._gohasget, var_14_0 == var_14_1)
end

function var_0_0._isWeekWalkDeepOpen(arg_15_0)
	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) and WeekWalkModel.instance:getInfo().isOpenDeep
end

var_0_0.ShowCount = 1

function var_0_0._refreshRewards(arg_16_0)
	local var_16_0 = WeekWalkDeepLayerNoticeView._getRewardList()
	local var_16_1

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_2 = iter_16_1[1]
		local var_16_3 = iter_16_1[2]
		local var_16_4 = iter_16_1[3]

		if var_16_2 == 2 and var_16_3 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			var_16_1 = string.format("%s#%s#%s#1", var_16_2, var_16_3, var_16_4)

			break
		end
	end

	local var_16_5 = arg_16_0._config.showBonus

	if var_16_1 then
		var_16_5 = string.format("%s|%s", var_16_1, var_16_5)
	end

	local var_16_6 = string.split(var_16_5, "|")

	for iter_16_2 = 1, #var_16_6 do
		if not arg_16_0._rewardItems[iter_16_2] then
			local var_16_7 = arg_16_0:getUserDataTb_()

			var_16_7.go = gohelper.clone(arg_16_0._gorewarditem, arg_16_0._gorewardContent, "rewarditem" .. iter_16_2)
			var_16_7.item = IconMgr.instance:getCommonPropItemIcon(var_16_7.go)

			table.insert(arg_16_0._rewardItems, var_16_7)
		end

		gohelper.setActive(arg_16_0._rewardItems[iter_16_2].go, true)

		local var_16_8 = string.splitToNumber(var_16_6[iter_16_2], "#")

		arg_16_0._rewardItems[iter_16_2].item:setMOValue(var_16_8[1], var_16_8[2], var_16_8[3])
		arg_16_0._rewardItems[iter_16_2].item:isShowCount(var_16_8[4] == var_0_0.ShowCount)
		arg_16_0._rewardItems[iter_16_2].item:setCountFontSize(35)
		arg_16_0._rewardItems[iter_16_2].item:setHideLvAndBreakFlag(true)
		arg_16_0._rewardItems[iter_16_2].item:hideEquipLvAndBreak(true)
	end

	for iter_16_3 = #var_16_6 + 1, #arg_16_0._rewardItems do
		gohelper.setActive(arg_16_0._rewardItems[iter_16_3].go, false)
	end
end

function var_0_0._refreshProgress(arg_17_0)
	local var_17_0 = WeekWalkModel.instance:getInfo()
	local var_17_1, var_17_2 = var_17_0:getNotFinishedMap()
	local var_17_3 = WeekWalkModel.isShallowMap(var_17_1.sceneId)
	local var_17_4

	if var_17_3 or not var_17_0.isOpenDeep then
		var_17_4 = luaLang("activityweekwalkdeepview_empty")
	else
		gohelper.setActive(arg_17_0._goprogress, true)

		local var_17_5 = lua_weekwalk_scene.configDict[var_17_1.sceneId]

		if LangSettings.instance:isEn() then
			var_17_4 = string.format("%s %s", var_17_5.name, var_17_5.battleName)
		else
			var_17_4 = string.format("%s%s", var_17_5.name, var_17_5.battleName)
		end
	end

	arg_17_0._txtprogress.text = var_17_4
end

function var_0_0._showDeadline(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._onRefreshDeadline, arg_18_0)

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		arg_18_0._txttime.text = luaLang("activityweekwalkdeepview_lcok")

		return
	end

	arg_18_0._endTime = WeekWalkModel.instance:getInfo().endTime

	TaskDispatcher.runRepeat(arg_18_0._onRefreshDeadline, arg_18_0, 1)
	arg_18_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_19_0)
	local var_19_0 = arg_19_0._endTime - ServerTime.now()

	if var_19_0 <= 0 then
		TaskDispatcher.cancelTask(arg_19_0._onRefreshDeadline, arg_19_0)
	end

	local var_19_1, var_19_2 = TimeUtil.secondToRoughTime2(math.floor(var_19_0))

	arg_19_0._txttime.text = formatLuaLang("activityweekwalkdeepview_resetremaintime", var_19_1 .. var_19_2)
end

function var_0_0._refreshNewRuleIcon(arg_20_0)
	local var_20_0 = ActivityModel.instance:getActMO(ActivityEnum.Activity.WeekWalkDeepShow).isNewStage
	local var_20_1 = arg_20_0:_isWeekWalkDeepOpen()
	local var_20_2 = false

	if var_20_1 then
		var_20_2 = var_20_0 or not arg_20_0:_checkIsClickRuleBtn()
	end

	if var_20_0 then
		arg_20_0:_setIsClickRuleBtnData(var_0_0.UnClickRuleBtn)
	end

	gohelper.setActive(arg_20_0._gonewrule, var_20_2)
end

local var_0_1 = PlayerPrefsKey.EnteredActKey .. "#" .. tostring(ActivityEnum.Activity.WeekWalkDeepShow) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

function var_0_0._checkIsClickRuleBtn(arg_21_0)
	local var_21_0 = PlayerPrefsHelper.getNumber(var_0_1, var_0_0.UnClickRuleBtn)

	return tonumber(var_21_0) ~= var_0_0.UnClickRuleBtn
end

var_0_0.HasClickRuleBtn = 1
var_0_0.UnClickRuleBtn = 0

function var_0_0._setIsClickRuleBtnData(arg_22_0, arg_22_1)
	PlayerPrefsHelper.setNumber(var_0_1, tonumber(arg_22_1) or var_0_0.UnClickRuleBtn)
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onRefreshDeadline, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._closeBeginnerView, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._simagebg:UnLoadImage()
end

return var_0_0
