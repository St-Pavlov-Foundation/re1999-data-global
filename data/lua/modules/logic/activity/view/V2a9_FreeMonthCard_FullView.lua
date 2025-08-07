module("modules.logic.activity.view.V2a9_FreeMonthCard_FullView", package.seeall)

local var_0_0 = class("V2a9_FreeMonthCard_FullView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_time/#txt_time")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_check")
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
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncheck:RemoveClickListener()
	arg_3_0._btncanget:RemoveClickListener()
end

function var_0_0._btncheckOnClick(arg_4_0)
	local var_4_0 = CommonConfig.instance:getConstStr(ConstEnum.FreeMonthCardTitle)
	local var_4_1 = CommonConfig.instance:getConstStr(ConstEnum.FreeMonthCardDesc)

	HelpController.instance:openStoreTipView(var_4_1, var_4_0)
end

function var_0_0._btncangetOnClick(arg_5_0)
	arg_5_0:_setRewardGet()
end

function var_0_0._onCloseViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.CommonPropView then
		arg_6_0:_refreshUI()
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._rewardItems = {}
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum2_9.VersionActivity2_9FreeMonthCard.play_ui_cikeshang_yueka_unfold)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0._onCloseViewFinish, arg_8_0)
	gohelper.addChild(arg_8_0.viewParam.parent, arg_8_0.viewGO)

	arg_8_0._actId = ActivityEnum.Activity.V2a9_FreeMonthCard

	gohelper.setActive(arg_8_0._gorewarditem, false)
	arg_8_0:_refreshTimeTick()
	arg_8_0:_refreshUI()
	TaskDispatcher.runRepeat(arg_8_0._refreshTimeTick, arg_8_0, 1)
end

function var_0_0._setRewardGet(arg_9_0)
	if V2a9FreeMonthCardModel.instance:isCurDayCouldGet() then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._rewardItems) do
			gohelper.setActive(iter_9_1.gocanget, false)
			gohelper.setActive(iter_9_1.goreceive, true)
			iter_9_1.getAnim:Play("go_hasget_in", 0, 0)
		end

		UIBlockMgr.instance:startBlock("waitShowMonthCardReward")
		TaskDispatcher.runDelay(arg_9_0._startGetBonus, arg_9_0, 1)
	end
end

function var_0_0._startGetBonus(arg_10_0)
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")

	local var_10_0 = V2a9FreeMonthCardModel.instance:getCurDay()

	if var_10_0 > 0 then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_10_0._actId, var_10_0)
	end

	local var_10_1 = ActivityType101Model.instance:getType101LoginCount(arg_10_0._actId)

	if var_10_1 > V2a9FreeMonthCardModel.LoginMaxDay then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_10_0._actId, var_10_1)
	end
end

function var_0_0._refreshTimeTick(arg_11_0)
	arg_11_0._txttime.text = arg_11_0:getRemainTimeStr()
end

function var_0_0.getRemainTimeStr(arg_12_0)
	local var_12_0 = ActivityModel.instance:getRemainTimeSec(arg_12_0._actId) or 0

	if var_12_0 <= 0 then
		return luaLang("turnback_end")
	end

	local var_12_1, var_12_2, var_12_3, var_12_4 = TimeUtil.secondsToDDHHMMSS(var_12_0)

	if var_12_1 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_12_1,
			var_12_2
		})
	elseif var_12_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_12_2,
			var_12_3
		})
	elseif var_12_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			var_12_3
		})
	elseif var_12_4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function var_0_0._refreshUI(arg_13_0)
	local var_13_0 = V2a9FreeMonthCardModel.instance:getRewardTotalDay()
	local var_13_1 = ActivityType101Model.instance:getType101LoginCount(arg_13_0._actId)
	local var_13_2 = ActivityType101Model.instance:isType101RewardGet(arg_13_0._actId, var_13_1)
	local var_13_3 = V2a9FreeMonthCardModel.instance:getCurDay()
	local var_13_4 = ActivityType101Model.instance:isType101RewardCouldGet(arg_13_0._actId, var_13_3)

	arg_13_0._txthasget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("freemonthcard_hasget_day"), {
		var_13_0
	})
	arg_13_0._txtcanget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("freemonthcard_canget_day"), {
		V2a9FreeMonthCardModel.LoginMaxDay - var_13_0
	})

	gohelper.setActive(arg_13_0._btncanget.gameObject, not var_13_2 and var_13_0 < V2a9FreeMonthCardModel.LoginMaxDay)
	gohelper.setActive(arg_13_0._gohasget, var_13_2 and var_13_0 < V2a9FreeMonthCardModel.LoginMaxDay)
	gohelper.setActive(arg_13_0._godoneget, var_13_0 >= V2a9FreeMonthCardModel.LoginMaxDay)

	local var_13_5 = var_13_3 > 0 and var_13_3 or 1
	local var_13_6 = ActivityConfig.instance:getNorSignActivityCo(arg_13_0._actId, var_13_5)
	local var_13_7 = string.split(var_13_6.bonus, "|")

	for iter_13_0, iter_13_1 in ipairs(var_13_7) do
		if not arg_13_0._rewardItems[iter_13_0] then
			local var_13_8 = {}
			local var_13_9 = gohelper.cloneInPlace(arg_13_0._gorewarditem)

			var_13_8.goRoot = var_13_9
			var_13_8.goIcon = gohelper.findChild(var_13_9, "go_icon")
			var_13_8.gocanget = gohelper.findChild(var_13_9, "go_canget")
			var_13_8.goreceive = gohelper.findChild(var_13_9, "go_receive")
			var_13_8.gohasget = gohelper.findChild(var_13_9, "go_receive/go_hasget")
			var_13_8.getAnim = var_13_8.gohasget:GetComponent(typeof(UnityEngine.Animator))
			var_13_8.btn = gohelper.getClickWithAudio(var_13_8.gocanget)

			var_13_8.btn:AddClickListener(arg_13_0._btncangetOnClick, arg_13_0)
			table.insert(arg_13_0._rewardItems, var_13_8)
		end

		gohelper.setActive(arg_13_0._rewardItems[iter_13_0].goRoot, true)
		gohelper.destroyAllChildren(arg_13_0._rewardItems[iter_13_0].goIcon)

		arg_13_0._rewardItems[iter_13_0].item = nil

		if not arg_13_0._rewardItems[iter_13_0].item then
			arg_13_0._rewardItems[iter_13_0].item = IconMgr.instance:getCommonItemIcon(arg_13_0._rewardItems[iter_13_0].goIcon)
		end

		local var_13_10 = string.splitToNumber(iter_13_1, "#")

		arg_13_0._rewardItems[iter_13_0].item:setMOValue(var_13_10[1], var_13_10[2], var_13_10[3], nil, true)
		arg_13_0._rewardItems[iter_13_0].item:isShowName(false)
		gohelper.setActive(arg_13_0._rewardItems[iter_13_0].gocanget, var_13_4)
		gohelper.setActive(arg_13_0._rewardItems[iter_13_0].goreceive, not var_13_4)
	end
end

function var_0_0.onClose(arg_14_0)
	UIBlockMgr.instance:endBlock("waitShowMonthCardReward")
	TaskDispatcher.cancelTask(arg_14_0._refreshTimeTick, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._startGetBonus, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._setRewardGet, arg_14_0)
	arg_14_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_14_0._onCloseViewFinish, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._rewardItems then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._rewardItems) do
			iter_15_1.btn:RemoveClickListener()
		end

		arg_15_0._rewardItems = nil
	end
end

return var_0_0
