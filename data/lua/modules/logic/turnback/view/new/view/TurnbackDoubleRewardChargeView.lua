module("modules.logic.turnback.view.new.view.TurnbackDoubleRewardChargeView", package.seeall)

local var_0_0 = class("TurnbackDoubleRewardChargeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnbgclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "close")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/#btn_buy")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "content/#btn_buy/#txt_cost")
	arg_1_0._golockreward = gohelper.findChild(arg_1_0.viewGO, "content/lockreward/reward")
	arg_1_0._gounlockreward1 = gohelper.findChild(arg_1_0.viewGO, "content/unlockreward/reward1")
	arg_1_0._gounlockreward2 = gohelper.findChild(arg_1_0.viewGO, "content/unlockreward/reward2")
	arg_1_0._contentanim = gohelper.findChild(arg_1_0.viewGO, "content"):GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btnclsoeOnClick, arg_2_0)
	arg_2_0._btnbgclose:AddClickListener(arg_2_0._btnclsoeOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, arg_2_0.succbuydoublereward, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnbgclose:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, arg_3_0.succbuydoublereward, arg_3_0)
end

function var_0_0._btnbuyOnClick(arg_4_0)
	local var_4_0 = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendBuyDoubleBonusRequest(var_4_0)
end

function var_0_0.succbuydoublereward(arg_5_0)
	arg_5_0._contentanim:Play("unlock")
	TaskDispatcher.runDelay(arg_5_0.afterAnim, arg_5_0, 0.8)
end

function var_0_0.afterAnim(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnclsoeOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.rewardList = {}

	arg_8_0:getRewardIcon(arg_8_0._golockreward)
	arg_8_0:getRewardIcon(arg_8_0._gounlockreward1)
	arg_8_0:getRewardIcon(arg_8_0._gounlockreward2)
end

function var_0_0.getRewardIcon(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0 = 1, 4 do
		local var_9_1 = gohelper.findChild(arg_9_1, "icon" .. iter_9_0)

		table.insert(var_9_0, var_9_1)
	end

	table.insert(arg_9_0.rewardList, var_9_0)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = TurnbackModel.instance:getAllBonus()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.rewardList) do
		for iter_11_2, iter_11_3 in ipairs(var_11_0) do
			local var_11_1 = arg_11_0:getUserDataTb_()

			if not var_11_1.itemIcon then
				var_11_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(iter_11_1[iter_11_2])
			end

			var_11_1.itemIcon:setMOValue(iter_11_3[1], iter_11_3[2], iter_11_3[3], nil, true)
			var_11_1.itemIcon:setCountFontSize(30)
		end
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
