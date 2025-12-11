module("modules.logic.activity.view.show.ActivityWeekWalkHeartShowView", package.seeall)

local var_0_0 = class("ActivityWeekWalkHeartShowView", BaseView)

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
	arg_1_0._btnbuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_buff")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnbuff:AddClickListener(arg_2_0._btnbuffOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnbuff:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._openMapId2 then
		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = arg_4_0._openMapId2
	})
end

function var_0_0._btnbuffOnClick(arg_5_0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView()
end

function var_0_0._btnjumpOnClick(arg_6_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return
	end

	WeekWalk_2Controller.instance:jumpWeekWalkHeartLayerView(arg_6_0._jumpCallback, arg_6_0)
end

function var_0_0._jumpCallback(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._closeBeginnerView, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._closeBeginnerView, arg_7_0, 1)
end

function var_0_0._closeBeginnerView(arg_8_0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function var_0_0._btndetailOnClick(arg_9_0)
	if not arg_9_0:_isWeekWalkDeepOpen() then
		GameFacade.showToast(ToastEnum.WeekWalkDetail)

		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
	gohelper.setActive(arg_9_0._gonewrule, false)
	arg_9_0:_setIsClickRuleBtnData(var_0_0.HasClickRuleBtn)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._animView = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._rewardItems = arg_10_0:getUserDataTb_()

	gohelper.setActive(arg_10_0._gorewarditem, false)
	arg_10_0:_refreshNewRuleIcon()
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		ActivityEnum.Activity.WeekWalkHeartShow
	})
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._animView:Play(UIAnimationName.Open, 0, 0)

	arg_12_0._actId = arg_12_0.viewContainer.activityId

	arg_12_0:refreshUI()
	arg_12_0:_updateTaskInfo()
	arg_12_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_12_0._onWeekwalk_2TaskUpdate, arg_12_0)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0._config = ActivityConfig.instance:getActivityShowTaskList(arg_13_0._actId, 1)
	arg_13_0._txtdesc.text = arg_13_0._config.actDesc

	arg_13_0:_refreshRewards()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		arg_13_0:_showDeadline()
		arg_13_0:_refreshProgress()
	else
		arg_13_0._txttime.text = luaLang("activityweekwalkdeepview_lcok")
		arg_13_0._txtprogress.text = luaLang("activityweekwalkdeepview_empty")
	end
end

function var_0_0._onWeekwalk_2TaskUpdate(arg_14_0)
	arg_14_0:_updateTaskInfo()
end

function var_0_0._updateTaskInfo(arg_15_0)
	local var_15_0, var_15_1, var_15_2, var_15_3 = WeekWalk_2TaskListModel.instance:getAllTaskInfo()

	arg_15_0._openMapId2 = var_15_3
	arg_15_0._txtcurrency.text = var_15_0
	arg_15_0._txttotal.text = var_15_1

	gohelper.setActive(arg_15_0._gocanget, #var_15_2 > 0)
	gohelper.setActive(arg_15_0._gohasget, var_15_0 == var_15_1)
end

function var_0_0._isWeekWalkDeepOpen(arg_16_0)
	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) and WeekWalk_2Model.instance:getInfo():isOpen()
end

var_0_0.ShowCount = 1

function var_0_0._refreshRewards(arg_17_0)
	local var_17_0 = WeekWalk_2DeepLayerNoticeView._getRewardList()
	local var_17_1

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_2 = iter_17_1[1]
		local var_17_3 = iter_17_1[2]
		local var_17_4 = iter_17_1[3]

		if var_17_2 == 2 and var_17_3 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			var_17_1 = string.format("%s#%s#%s#1", var_17_2, var_17_3, var_17_4)

			break
		end
	end

	local var_17_5 = arg_17_0._config.showBonus

	if var_17_1 then
		var_17_5 = string.format("%s|%s", var_17_1, var_17_5)
	end

	local var_17_6 = string.split(var_17_5, "|")

	for iter_17_2 = 1, #var_17_6 do
		if not arg_17_0._rewardItems[iter_17_2] then
			local var_17_7 = arg_17_0:getUserDataTb_()

			var_17_7.go = gohelper.clone(arg_17_0._gorewarditem, arg_17_0._gorewardContent, "rewarditem" .. iter_17_2)
			var_17_7.item = IconMgr.instance:getCommonPropItemIcon(var_17_7.go)

			table.insert(arg_17_0._rewardItems, var_17_7)
		end

		gohelper.setActive(arg_17_0._rewardItems[iter_17_2].go, true)

		local var_17_8 = string.splitToNumber(var_17_6[iter_17_2], "#")

		arg_17_0._rewardItems[iter_17_2].item:setMOValue(var_17_8[1], var_17_8[2], var_17_8[3])
		arg_17_0._rewardItems[iter_17_2].item:isShowCount(var_17_8[4] == var_0_0.ShowCount)
		arg_17_0._rewardItems[iter_17_2].item:setCountFontSize(35)
		arg_17_0._rewardItems[iter_17_2].item:setHideLvAndBreakFlag(true)
		arg_17_0._rewardItems[iter_17_2].item:hideEquipLvAndBreak(true)
	end

	for iter_17_3 = #var_17_6 + 1, #arg_17_0._rewardItems do
		gohelper.setActive(arg_17_0._rewardItems[iter_17_3].go, false)
	end
end

function var_0_0._refreshProgress(arg_18_0)
	local var_18_0 = WeekWalkModel.instance:getInfo():getNotFinishedMap()
	local var_18_1 = WeekWalkModel.isShallowMap(var_18_0.sceneId)
	local var_18_2

	if var_18_1 or not WeekWalk_2Model.instance:getInfo():isOpen() then
		var_18_2 = luaLang("activityweekwalkdeepview_empty")
	else
		gohelper.setActive(arg_18_0._goprogress, true)

		local var_18_3 = WeekWalk_2Model.instance:getInfo():getNotFinishedMap().sceneConfig

		var_18_2 = string.format("%s%s", var_18_3.name, var_18_3.battleName)
	end

	arg_18_0._txtprogress.text = var_18_2
end

function var_0_0._showDeadline(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._onRefreshDeadline, arg_19_0)

	if not WeekWalk_2Model.instance:getInfo():isOpen() then
		arg_19_0._txttime.text = luaLang("activityweekwalkdeepview_lcok")

		return
	end

	arg_19_0._endTime = WeekWalk_2Model.instance:getInfo().endTime

	TaskDispatcher.runRepeat(arg_19_0._onRefreshDeadline, arg_19_0, 1)
	arg_19_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_20_0)
	local var_20_0 = arg_20_0._endTime - ServerTime.now()

	if var_20_0 <= 0 then
		TaskDispatcher.cancelTask(arg_20_0._onRefreshDeadline, arg_20_0)
	end

	local var_20_1, var_20_2 = TimeUtil.secondToRoughTime2(math.floor(var_20_0))

	arg_20_0._txttime.text = formatLuaLang("activityweekwalkdeepview_resetremaintime", var_20_1 .. var_20_2)
end

function var_0_0._refreshNewRuleIcon(arg_21_0)
	local var_21_0 = ActivityModel.instance:getActMO(ActivityEnum.Activity.WeekWalkHeartShow).isNewStage
	local var_21_1 = arg_21_0:_isWeekWalkDeepOpen()
	local var_21_2 = false

	if var_21_1 then
		var_21_2 = var_21_0 or not arg_21_0:_checkIsClickRuleBtn()
	end

	if var_21_0 then
		arg_21_0:_setIsClickRuleBtnData(var_0_0.UnClickRuleBtn)
	end

	gohelper.setActive(arg_21_0._gonewrule, var_21_2)
end

local var_0_1 = PlayerPrefsKey.EnteredActKey .. "#" .. tostring(ActivityEnum.Activity.WeekWalkHeartShow) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

function var_0_0._checkIsClickRuleBtn(arg_22_0)
	local var_22_0 = PlayerPrefsHelper.getNumber(var_0_1, var_0_0.UnClickRuleBtn)

	return tonumber(var_22_0) ~= var_0_0.UnClickRuleBtn
end

var_0_0.HasClickRuleBtn = 1
var_0_0.UnClickRuleBtn = 0

function var_0_0._setIsClickRuleBtnData(arg_23_0, arg_23_1)
	PlayerPrefsHelper.setNumber(var_0_1, tonumber(arg_23_1) or var_0_0.UnClickRuleBtn)
end

function var_0_0.onClose(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._onRefreshDeadline, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._closeBeginnerView, arg_24_0)
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0._simagebg:UnLoadImage()
end

return var_0_0
