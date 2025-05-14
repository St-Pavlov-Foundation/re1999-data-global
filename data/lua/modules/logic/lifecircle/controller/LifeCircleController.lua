module("modules.logic.lifecircle.controller.LifeCircleController", package.seeall)

local var_0_0 = class("LifeCircleController", BaseController)
local var_0_1 = table.insert

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._stageid = nil
	arg_2_0._materialDataMOList = nil
	arg_2_0._onReceiveHeroGainPushMsg = nil
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	SignInController.instance:registerCallback(SignInEvent.OnSignInTotalRewardReply, arg_4_0._onSignInTotalRewardReply, arg_4_0)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, arg_4_0._onReceiveSignInTotalRewardAllReply, arg_4_0)
end

function var_0_0.sendSignInTotalRewardRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	SignInRpc.instance:sendSignInTotalRewardRequest(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.sendSignInTotalRewardAllRequest(arg_6_0, arg_6_1, arg_6_2)
	return SignInRpc.instance:sendSignInTotalRewardAllRequest(arg_6_1, arg_6_2)
end

function var_0_0.sendSignInTotalRewardAllRequestIfClaimable(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0:isClaimableAccumulateReward() then
		if arg_7_1 then
			arg_7_1(arg_7_2)
		end

		return
	end

	arg_7_0:sendSignInTotalRewardAllRequest(arg_7_1, arg_7_2)
end

function var_0_0.sendSignInRequest(arg_8_0)
	arg_8_0:sendSignInTotalRewardAllRequestIfClaimable(SignInRpc.sendSignInRequest, SignInRpc.instance)
end

function var_0_0.isClaimedAccumulateReward(arg_9_0, arg_9_1)
	return SignInModel.instance:isClaimedAccumulateReward(arg_9_1)
end

function var_0_0.isClaimableAccumulateReward(arg_10_0, arg_10_1)
	return SignInModel.instance:isClaimableAccumulateReward(arg_10_1)
end

local var_0_2 = -11235

function var_0_0._onReceiveSignInTotalRewardAllReply(arg_11_0)
	arg_11_0:dispatchRedDotEventUpdateRelateDotInfo()

	arg_11_0._stageid = var_0_2

	if not arg_11_0._materialDataMOList then
		return
	end

	arg_11_0:_openLifeCircleRewardView()
end

function var_0_0._onSignInTotalRewardReply(arg_12_0, arg_12_1)
	arg_12_0:dispatchRedDotEventUpdateRelateDotInfo()

	arg_12_0._stageid = arg_12_1

	if not arg_12_0._materialDataMOList then
		return
	end

	arg_12_0:_openLifeCircleRewardView()
end

function var_0_0.openLifeCircleRewardView(arg_13_0, arg_13_1)
	if not arg_13_1 or #arg_13_1 == 0 then
		return
	end

	arg_13_0._materialDataMOList = arg_13_1

	if not arg_13_0._stageid then
		return
	end

	arg_13_0:_openLifeCircleRewardView()
end

function var_0_0._openLifeCircleRewardView(arg_14_0)
	if not arg_14_0._stageid then
		return
	end

	if not arg_14_0._materialDataMOList then
		return
	end

	local var_14_0 = arg_14_0._materialDataMOList
	local var_14_1 = arg_14_0._stageid
	local var_14_2 = 0

	if var_0_2 == var_14_1 then
		var_14_2 = PlayerModel.instance:getPlayinfo().totalLoginDays or 0
	else
		var_14_2 = SignInConfig.instance:getSignInLifeTimeBonusCO(var_14_1).logindaysid
	end

	arg_14_0._materialDataMOList = nil
	arg_14_0._stageid = nil

	RoomController.instance:popUpRoomBlockPackageView(var_14_0)

	local var_14_3 = {
		materialDataMOList = var_14_0,
		loginDayCount = var_14_2
	}

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.LifeCircleRewardView, var_14_3)
end

function var_0_0.onReceiveHeroGainPush(arg_15_0, arg_15_1)
	arg_15_0._onReceiveHeroGainPushMsg = arg_15_1
end

function var_0_0.onReceiveMaterialChangePush(arg_16_0, arg_16_1)
	local var_16_0, var_16_1, var_16_2, var_16_3 = MaterialRpc.receiveMaterial(arg_16_1)

	if not var_16_0 or #var_16_0 == 0 then
		arg_16_0._onReceiveHeroGainPushMsg = nil

		return
	end

	local var_16_4 = {}
	local var_16_5 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_6 = iter_16_1.materilType
		local var_16_7 = iter_16_1.materilId

		if var_16_6 == MaterialEnum.MaterialType.Hero then
			var_0_1(var_16_4, var_16_7)
		else
			var_0_1(var_16_5, iter_16_1)
		end
	end

	if #var_16_4 == 0 then
		if arg_16_0._onReceiveHeroGainPushMsg then
			HeroRpc.instance:_onReceiveHeroGainPush(arg_16_0._onReceiveHeroGainPushMsg)
		end

		MaterialRpc.instance:_onReceiveMaterialChangePush_default(arg_16_1, var_16_0, var_16_1, var_16_2, var_16_3)
	else
		arg_16_0._onReceiveHeroGainPushMsg = nil

		arg_16_0:_doVirtualSummonBehavior(var_16_4, var_16_5)
	end
end

function var_0_0._doVirtualSummonBehavior(arg_17_0, arg_17_1, arg_17_2)
	ViewMgr.instance:closeView(ViewName.BackpackView)
	SummonController.instance:simpleEnterSummonScene(arg_17_1, function()
		if ViewMgr.instance:isOpen(ViewName.BackpackView) then
			return
		end

		BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.UseType)
		MaterialRpc.instance:simpleShowView(arg_17_2)
	end)
end

function var_0_0.isShowRed(arg_19_0)
	if arg_19_0:isExistsNewConfig() then
		return true
	end

	if arg_19_0:isClaimableAccumulateReward() then
		return true
	end

	return false
end

local var_0_3 = "LifeCircleController|"

function var_0_0.getPrefsKeyPrefix(arg_20_0)
	return var_0_3
end

function var_0_0.saveInt(arg_21_0, arg_21_1, arg_21_2)
	GameUtil.playerPrefsSetNumberByUserId(arg_21_1, arg_21_2)
end

function var_0_0.getInt(arg_22_0, arg_22_1, arg_22_2)
	return GameUtil.playerPrefsGetNumberByUserId(arg_22_1, arg_22_2)
end

local var_0_4 = "NewConfig"

function var_0_0.setLatestConfigCount(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getPrefsKeyPrefix() .. var_0_4

	arg_23_0:saveInt(var_23_0, arg_23_1)
end

function var_0_0.getLatestConfigCount(arg_24_0)
	local var_24_0 = arg_24_0:getPrefsKeyPrefix() .. var_0_4

	return arg_24_0:getInt(var_24_0, 0)
end

function var_0_0.isExistsNewConfig(arg_25_0)
	local var_25_0 = SignInConfig.instance:getSignInLifeTimeBonusCount()

	return arg_25_0:getLatestConfigCount() ~= var_25_0
end

function var_0_0.markLatestConfigCount(arg_26_0)
	local var_26_0 = SignInConfig.instance:getSignInLifeTimeBonusCount()

	if arg_26_0:getLatestConfigCount() ~= var_26_0 then
		arg_26_0:setLatestConfigCount(var_26_0)
		arg_26_0:dispatchRedDotEventUpdateRelateDotInfo()
	end
end

function var_0_0.dispatchRedDotEventUpdateRelateDotInfo(arg_27_0)
	local var_27_0 = RedDotEnum.DotNode.LifeCircleNewConfig
	local var_27_1 = RedDotConfig.instance:getParentRedDotId(var_27_0)

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(var_27_1)] = true,
		[var_27_0] = true
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
