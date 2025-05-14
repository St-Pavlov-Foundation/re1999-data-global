module("modules.logic.activity.view.LinkageActivity_Page2RewardBase", package.seeall)

local var_0_0 = class("LinkageActivity_Page2RewardBase", RougeSimpleItemBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0.onDestroyView(arg_2_0)
	var_0_0.super.onDestroyView(arg_2_0)
	arg_2_0:__onDispose()
end

function var_0_0.actId(arg_3_0)
	return arg_3_0:_assetGetParent():actId()
end

function var_0_0.isType101RewardCouldGetAnyOne(arg_4_0)
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(arg_4_0:actId())
end

function var_0_0.isType101RewardGet(arg_5_0)
	return ActivityType101Model.instance:isType101RewardGet(arg_5_0:actId(), arg_5_0._index)
end

function var_0_0.isType101RewardCouldGet(arg_6_0)
	return ActivityType101Model.instance:isType101RewardCouldGet(arg_6_0:actId(), arg_6_0._index)
end

function var_0_0.getType101LoginCount(arg_7_0)
	return ActivityType101Model.instance:getType101LoginCount(arg_7_0:actId())
end

function var_0_0.getNorSignActivityCo(arg_8_0)
	return ActivityConfig.instance:getNorSignActivityCo(arg_8_0:actId(), arg_8_0._index)
end

function var_0_0.sendGet101BonusRequest(arg_9_0, arg_9_1, arg_9_2)
	return Activity101Rpc.instance:sendGet101BonusRequest(arg_9_0:actId(), arg_9_0._index, arg_9_1, arg_9_2)
end

function var_0_0.claimAll(arg_10_0, arg_10_1, arg_10_2)
	return ActivityType101Model.instance:claimAll(arg_10_0:actId(), arg_10_1, arg_10_2)
end

function var_0_0.isActOnLine(arg_11_0)
	return ActivityModel.instance:isActOnLine(arg_11_0:actId())
end

function var_0_0.refreshRewardItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1:setMOValue(arg_12_2[1], arg_12_2[2], arg_12_2[3])
	arg_12_1:setCountFontSize(46)
	arg_12_1:setHideLvAndBreakFlag(true)
	arg_12_1:hideEquipLvAndBreak(true)
	arg_12_1:isShowQuality(false)
	arg_12_1:customOnClickCallback(function()
		if not arg_12_0:isActOnLine() then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		if arg_12_0:isType101RewardCouldGet() then
			arg_12_0:claimAll(arg_12_0._onClaimAllCb, arg_12_0)

			return
		end

		MaterialTipController.instance:showMaterialInfo(arg_12_2[1], arg_12_2[2])
	end)
end

return var_0_0
