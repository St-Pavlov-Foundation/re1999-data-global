module("modules.logic.activity.view.show.ActivityWeekWalkHeartShowView", package.seeall)

local var_0_0 = class("ActivityWeekWalkHeartShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "reset/#txt_time")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_progress/#txt_progress")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_detail")
	arg_1_0._gonewrule = gohelper.findChild(arg_1_0.viewGO, "#btn_detail/#go_newrule")
	arg_1_0._btnbuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_buff")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnbuff:AddClickListener(arg_2_0._btnbuffOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnbuff:RemoveClickListener()
end

function var_0_0._btnbuffOnClick(arg_4_0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView()
end

function var_0_0._btnjumpOnClick(arg_5_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return
	end

	WeekWalk_2Controller.instance:jumpWeekWalkHeartLayerView(arg_5_0._jumpCallback, arg_5_0)
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

	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
	gohelper.setActive(arg_8_0._gonewrule, false)
	arg_8_0:_setIsClickRuleBtnData(var_0_0.HasClickRuleBtn)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._animView = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._rewardItems = arg_9_0:getUserDataTb_()

	gohelper.setActive(arg_9_0._gorewarditem, false)
	arg_9_0:_refreshNewRuleIcon()
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		ActivityEnum.Activity.WeekWalkHeartShow
	})
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._animView:Play(UIAnimationName.Open, 0, 0)

	arg_11_0._actId = arg_11_0.viewContainer.activityId

	arg_11_0:refreshUI()
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

function var_0_0._isWeekWalkDeepOpen(arg_13_0)
	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) and WeekWalk_2Model.instance:getInfo():isOpen()
end

var_0_0.ShowCount = 1

function var_0_0._refreshRewards(arg_14_0)
	local var_14_0 = WeekWalk_2DeepLayerNoticeView._getRewardList()
	local var_14_1

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = iter_14_1[1]
		local var_14_3 = iter_14_1[2]
		local var_14_4 = iter_14_1[3]

		if var_14_2 == 2 and var_14_3 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			var_14_1 = string.format("%s#%s#%s#1", var_14_2, var_14_3, var_14_4)

			break
		end
	end

	local var_14_5 = arg_14_0._config.showBonus

	if var_14_1 then
		var_14_5 = string.format("%s|%s", var_14_1, var_14_5)
	end

	local var_14_6 = string.split(var_14_5, "|")

	for iter_14_2 = 1, #var_14_6 do
		if not arg_14_0._rewardItems[iter_14_2] then
			local var_14_7 = arg_14_0:getUserDataTb_()

			var_14_7.go = gohelper.clone(arg_14_0._gorewarditem, arg_14_0._gorewardContent, "rewarditem" .. iter_14_2)
			var_14_7.item = IconMgr.instance:getCommonPropItemIcon(var_14_7.go)

			table.insert(arg_14_0._rewardItems, var_14_7)
		end

		gohelper.setActive(arg_14_0._rewardItems[iter_14_2].go, true)

		local var_14_8 = string.splitToNumber(var_14_6[iter_14_2], "#")

		arg_14_0._rewardItems[iter_14_2].item:setMOValue(var_14_8[1], var_14_8[2], var_14_8[3])
		arg_14_0._rewardItems[iter_14_2].item:isShowCount(var_14_8[4] == var_0_0.ShowCount)
		arg_14_0._rewardItems[iter_14_2].item:setCountFontSize(35)
		arg_14_0._rewardItems[iter_14_2].item:setHideLvAndBreakFlag(true)
		arg_14_0._rewardItems[iter_14_2].item:hideEquipLvAndBreak(true)
	end

	for iter_14_3 = #var_14_6 + 1, #arg_14_0._rewardItems do
		gohelper.setActive(arg_14_0._rewardItems[iter_14_3].go, false)
	end
end

function var_0_0._refreshProgress(arg_15_0)
	local var_15_0 = WeekWalkModel.instance:getInfo():getNotFinishedMap()
	local var_15_1 = WeekWalkModel.isShallowMap(var_15_0.sceneId)
	local var_15_2

	if var_15_1 or not WeekWalk_2Model.instance:getInfo():isOpen() then
		var_15_2 = luaLang("activityweekwalkdeepview_empty")
	else
		gohelper.setActive(arg_15_0._goprogress, true)

		local var_15_3 = WeekWalk_2Model.instance:getInfo():getNotFinishedMap().sceneConfig

		var_15_2 = string.format("%s%s", var_15_3.name, var_15_3.battleName)
	end

	arg_15_0._txtprogress.text = var_15_2
end

function var_0_0._showDeadline(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._onRefreshDeadline, arg_16_0)

	if not WeekWalk_2Model.instance:getInfo():isOpen() then
		arg_16_0._txttime.text = luaLang("activityweekwalkdeepview_lcok")

		return
	end

	arg_16_0._endTime = WeekWalk_2Model.instance:getInfo().endTime

	TaskDispatcher.runRepeat(arg_16_0._onRefreshDeadline, arg_16_0, 1)
	arg_16_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_17_0)
	local var_17_0 = arg_17_0._endTime - ServerTime.now()

	if var_17_0 <= 0 then
		TaskDispatcher.cancelTask(arg_17_0._onRefreshDeadline, arg_17_0)
	end

	local var_17_1, var_17_2 = TimeUtil.secondToRoughTime2(math.floor(var_17_0))

	arg_17_0._txttime.text = formatLuaLang("activityweekwalkdeepview_resetremaintime", var_17_1 .. var_17_2)
end

function var_0_0._refreshNewRuleIcon(arg_18_0)
	local var_18_0 = ActivityModel.instance:getActMO(ActivityEnum.Activity.WeekWalkHeartShow).isNewStage
	local var_18_1 = arg_18_0:_isWeekWalkDeepOpen()
	local var_18_2 = false

	if var_18_1 then
		var_18_2 = var_18_0 or not arg_18_0:_checkIsClickRuleBtn()
	end

	if var_18_0 then
		arg_18_0:_setIsClickRuleBtnData(var_0_0.UnClickRuleBtn)
	end

	gohelper.setActive(arg_18_0._gonewrule, var_18_2)
end

local var_0_1 = PlayerPrefsKey.EnteredActKey .. "#" .. tostring(ActivityEnum.Activity.WeekWalkHeartShow) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

function var_0_0._checkIsClickRuleBtn(arg_19_0)
	local var_19_0 = PlayerPrefsHelper.getNumber(var_0_1, var_0_0.UnClickRuleBtn)

	return tonumber(var_19_0) ~= var_0_0.UnClickRuleBtn
end

var_0_0.HasClickRuleBtn = 1
var_0_0.UnClickRuleBtn = 0

function var_0_0._setIsClickRuleBtnData(arg_20_0, arg_20_1)
	PlayerPrefsHelper.setNumber(var_0_1, tonumber(arg_20_1) or var_0_0.UnClickRuleBtn)
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._onRefreshDeadline, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._closeBeginnerView, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0._simagebg:UnLoadImage()
end

return var_0_0
