module("modules.logic.versionactivity2_4.act181.view.Activity181RewardView", package.seeall)

local var_0_0 = class("Activity181RewardView", BaseView)

var_0_0.DISPLAY_TYPE = {
	Reward = 2,
	Effect = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "reward/#scroll_reward")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "reward/#scroll_reward/Viewport/#go_content")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._rewardItemList = {}
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._actId = arg_7_0.viewParam.actId

	arg_7_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:_refreshReward()
end

function var_0_0._refreshReward(arg_9_0)
	local var_9_0 = arg_9_0._actId
	local var_9_1 = Activity181Config.instance:getBoxListByActivityId(var_9_0)

	if not var_9_1 then
		return
	end

	local var_9_2 = {}
	local var_9_3 = {}
	local var_9_4 = Activity181Model.instance:getActivityInfo(var_9_0)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		table.insert(var_9_2, iter_9_1)

		var_9_3[iter_9_1] = var_9_4:getBonusStateById(iter_9_1) == Activity181Enum.BonusState.HaveGet
	end

	table.sort(var_9_2, function(arg_10_0, arg_10_1)
		if var_9_3[arg_10_0] == var_9_3[arg_10_1] then
			return arg_10_0 < arg_10_1
		end

		return var_9_3[arg_10_1]
	end)

	local var_9_5 = #var_9_2
	local var_9_6 = #arg_9_0._rewardItemList

	for iter_9_2 = 1, var_9_5 do
		local var_9_7

		if iter_9_2 <= var_9_6 then
			var_9_7 = arg_9_0._rewardItemList[iter_9_2]
		else
			local var_9_8 = gohelper.clone(arg_9_0._gorewarditem, arg_9_0._gocontent)

			var_9_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_8, Activity181RewardItem)

			table.insert(arg_9_0._rewardItemList, var_9_7)
		end

		local var_9_9 = var_9_2[iter_9_2]
		local var_9_10 = Activity181Config.instance:getBoxListConfig(var_9_0, var_9_9)
		local var_9_11 = string.splitToNumber(var_9_10.bonus, "#")

		var_9_7:setEnable(true)

		local var_9_12 = var_9_3[var_9_9]

		var_9_7:onUpdateMO(var_9_11[1], var_9_11[2], var_9_11[3], var_9_12)
	end

	if var_9_5 < var_9_6 then
		for iter_9_3 = var_9_5 + 1, var_9_6 do
			arg_9_0._rewardItemList[iter_9_3]:setEnable(true)
		end
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
