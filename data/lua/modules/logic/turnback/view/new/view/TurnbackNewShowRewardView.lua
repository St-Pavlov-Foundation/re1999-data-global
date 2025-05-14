module("modules.logic.turnback.view.new.view.TurnbackNewShowRewardView", package.seeall)

local var_0_0 = class("TurnbackNewShowRewardView", BaseView)

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
	arg_7_0.bonus = arg_7_0.viewParam.bonus

	arg_7_0:_refreshReward()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
end

function var_0_0._refreshReward(arg_8_0)
	local var_8_0 = GameUtil.splitString2(arg_8_0.bonus, true)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = arg_8_0:getUserDataTb_()

		var_8_1.go = gohelper.cloneInPlace(arg_8_0._gorewarditem, "item" .. iter_8_0)

		gohelper.setActive(var_8_1.go, true)

		local var_8_2 = iter_8_1[1]
		local var_8_3 = iter_8_1[2]
		local var_8_4 = iter_8_1[3]

		if not var_8_1.itemIcon then
			var_8_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_8_1.go)
		end

		var_8_1.itemIcon:setMOValue(var_8_2, var_8_3, var_8_4, nil, true)
		var_8_1.itemIcon:isShowQuality(true)
		var_8_1.itemIcon:isShowCount(true)
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
