module("modules.logic.activity.view.V2a9_FreeMonthCard_PanelView", package.seeall)

local var_0_0 = class("V2a9_FreeMonthCard_PanelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_time/#txt_time")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_check")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_Reward")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_Reward/Viewport/Content/#go_rewarditem")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_canget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "root/#btn_hasget")
	arg_1_0._godoneget = gohelper.findChild(arg_1_0.viewGO, "root/#btn_doneget")
	arg_1_0._txtcanget = gohelper.findChildText(arg_1_0.viewGO, "root/Limit/canget/#txt_canget")
	arg_1_0._txthasget = gohelper.findChildText(arg_1_0.viewGO, "root/Limit/hasget/#txt_hasget")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncheck:RemoveClickListener()
	arg_3_0._btncanget:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncheckOnClick(arg_5_0)
	local var_5_0 = CommonConfig.instance:getConstStr(ConstEnum.FreeMonthCardTitle)
	local var_5_1 = CommonConfig.instance:getConstStr(ConstEnum.FreeMonthCardDesc)

	HelpController.instance:openStoreTipView(var_5_1, var_5_0)
end

function var_0_0._btncangetOnClick(arg_6_0)
	arg_6_0:_setRewardGet()
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.CommonPropView then
		arg_7_0:_refreshUI()
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._rewardItems = {}
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum2_9.VersionActivity2_9FreeMonthCard.play_ui_cikeshang_yueka_unfold)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_9_0._onCloseViewFinish, arg_9_0)

	arg_9_0._actId = ActivityEnum.Activity.V2a9_FreeMonthCard

	gohelper.setActive(arg_9_0._gorewarditem, false)
	arg_9_0:_refreshTimeTick()
	arg_9_0:_refreshUI()
	TaskDispatcher.runRepeat(arg_9_0._refreshTimeTick, arg_9_0, 1)

	if V2a9FreeMonthCardModel.instance:isCurDayCouldGet() then
		UIBlockMgr.instance:startBlock("waitShowMonthCardIn")
		TaskDispatcher.runDelay(arg_9_0._setRewardGet, arg_9_0, 0.87)
	end
end

function var_0_0._setRewardGet(arg_10_0)
	UIBlockMgr.instance:endBlock("waitShowMonthCardIn")

	if V2a9FreeMonthCardModel.instance:isCurDayCouldGet() then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._rewardItems) do
			gohelper.setActive(iter_10_1.gocanget, false)
			gohelper.setActive(iter_10_1.goreceive, true)
			iter_10_1.getAnim:Play("go_hasget_in", 0, 0)
		end

		UIBlockMgr.instance:startBlock("waitShowMonthCardReward")
		TaskDispatcher.runDelay(arg_10_0._startGetBonus, arg_10_0, 1)
	end
end

function var_0_0._startGetBonus(arg_11_0)
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")

	local var_11_0 = V2a9FreeMonthCardModel.instance:getCurDay()

	if var_11_0 > 0 then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_11_0._actId, var_11_0)
	end

	local var_11_1 = ActivityType101Model.instance:getType101LoginCount(arg_11_0._actId)

	if var_11_1 > V2a9FreeMonthCardModel.LoginMaxDay then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_11_0._actId, var_11_1)
	end
end

function var_0_0._refreshTimeTick(arg_12_0)
	arg_12_0._txttime.text = arg_12_0:getRemainTimeStr()
end

function var_0_0.getRemainTimeStr(arg_13_0)
	local var_13_0 = ActivityModel.instance:getRemainTimeSec(arg_13_0._actId) or 0

	if var_13_0 <= 0 then
		return luaLang("turnback_end")
	end

	local var_13_1, var_13_2, var_13_3, var_13_4 = TimeUtil.secondsToDDHHMMSS(var_13_0)

	if var_13_1 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_13_1,
			var_13_2
		})
	elseif var_13_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_13_2,
			var_13_3
		})
	elseif var_13_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			var_13_3
		})
	elseif var_13_4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function var_0_0._refreshUI(arg_14_0)
	local var_14_0 = V2a9FreeMonthCardModel.instance:getRewardTotalDay()
	local var_14_1 = ActivityType101Model.instance:getType101LoginCount(arg_14_0._actId)
	local var_14_2 = ActivityType101Model.instance:isType101RewardGet(arg_14_0._actId, var_14_1)
	local var_14_3 = V2a9FreeMonthCardModel.instance:getCurDay()
	local var_14_4 = ActivityType101Model.instance:isType101RewardCouldGet(arg_14_0._actId, var_14_3)

	arg_14_0._txthasget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("freemonthcard_hasget_day"), {
		var_14_0
	})
	arg_14_0._txtcanget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("freemonthcard_canget_day"), {
		V2a9FreeMonthCardModel.LoginMaxDay - var_14_0
	})

	gohelper.setActive(arg_14_0._btncanget.gameObject, not var_14_2 and var_14_0 < V2a9FreeMonthCardModel.LoginMaxDay)
	gohelper.setActive(arg_14_0._gohasget, var_14_2 and var_14_0 < V2a9FreeMonthCardModel.LoginMaxDay)
	gohelper.setActive(arg_14_0._godoneget, var_14_0 >= V2a9FreeMonthCardModel.LoginMaxDay)

	local var_14_5 = var_14_3 > 0 and var_14_3 or 1
	local var_14_6 = ActivityConfig.instance:getNorSignActivityCo(arg_14_0._actId, var_14_5)
	local var_14_7 = string.split(var_14_6.bonus, "|")

	for iter_14_0, iter_14_1 in ipairs(var_14_7) do
		if not arg_14_0._rewardItems[iter_14_0] then
			local var_14_8 = {}
			local var_14_9 = gohelper.cloneInPlace(arg_14_0._gorewarditem)

			var_14_8.goRoot = var_14_9
			var_14_8.goIcon = gohelper.findChild(var_14_9, "go_icon")
			var_14_8.gocanget = gohelper.findChild(var_14_9, "go_canget")
			var_14_8.goreceive = gohelper.findChild(var_14_9, "go_receive")
			var_14_8.gohasget = gohelper.findChild(var_14_9, "go_receive/go_hasget")
			var_14_8.getAnim = var_14_8.gohasget:GetComponent(typeof(UnityEngine.Animator))
			var_14_8.btn = gohelper.getClickWithAudio(var_14_8.gocanget)

			var_14_8.btn:AddClickListener(arg_14_0._btncangetOnClick, arg_14_0)
			table.insert(arg_14_0._rewardItems, var_14_8)
		end

		gohelper.setActive(arg_14_0._rewardItems[iter_14_0].goRoot, true)

		arg_14_0._rewardItems[iter_14_0].item = nil

		gohelper.destroyAllChildren(arg_14_0._rewardItems[iter_14_0].goIcon)

		if not arg_14_0._rewardItems[iter_14_0].item then
			arg_14_0._rewardItems[iter_14_0].item = IconMgr.instance:getCommonItemIcon(arg_14_0._rewardItems[iter_14_0].goIcon)
		end

		local var_14_10 = string.splitToNumber(iter_14_1, "#")

		arg_14_0._rewardItems[iter_14_0].item:setMOValue(var_14_10[1], var_14_10[2], var_14_10[3], nil, true)
		arg_14_0._rewardItems[iter_14_0].item:isShowName(false)
		gohelper.setActive(arg_14_0._rewardItems[iter_14_0].gocanget, var_14_4)
		gohelper.setActive(arg_14_0._rewardItems[iter_14_0].goreceive, not var_14_4)
	end
end

function var_0_0.onClose(arg_15_0)
	UIBlockMgr.instance:endBlock("waitShowMonthCardIn")
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")
	TaskDispatcher.cancelTask(arg_15_0._refreshTimeTick, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._startGetBonus, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._setRewardGet, arg_15_0)
	arg_15_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_15_0._onCloseViewFinish, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0._rewardItems then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._rewardItems) do
			iter_16_1.btn:RemoveClickListener()
		end

		arg_16_0._rewardItems = nil
	end
end

return var_0_0
