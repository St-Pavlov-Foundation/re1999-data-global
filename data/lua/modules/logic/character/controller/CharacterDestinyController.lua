module("modules.logic.character.controller.CharacterDestinyController", package.seeall)

local var_0_0 = class("CharacterDestinyController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openCharacterDestinySlotView(arg_5_0, arg_5_1)
	local var_5_0 = {
		heroMo = arg_5_1
	}

	ViewMgr.instance:openView(ViewName.CharacterDestinySlotView, var_5_0)
end

function var_0_0.openCharacterDestinyStoneView(arg_6_0, arg_6_1)
	local var_6_0 = {
		heroMo = arg_6_1
	}

	ViewMgr.instance:openView(ViewName.CharacterDestinyStoneView, var_6_0)
end

function var_0_0.onRankUp(arg_7_0, arg_7_1)
	HeroRpc.instance:setDestinyRankUpRequest(arg_7_1)
end

function var_0_0.onRankUpReply(arg_8_0, arg_8_1)
	arg_8_0:dispatchEvent(CharacterDestinyEvent.OnRankUpReply, arg_8_1)
end

function var_0_0.onLevelUp(arg_9_0, arg_9_1, arg_9_2)
	HeroRpc.instance:setDestinyLevelUpRequest(arg_9_1, arg_9_2)
end

function var_0_0.onLevelUpReply(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:dispatchEvent(CharacterDestinyEvent.OnLevelUpReply, arg_10_1, arg_10_2)
end

function var_0_0.onUnlockStone(arg_11_0, arg_11_1, arg_11_2)
	HeroRpc.instance:setDestinyStoneUnlockRequest(arg_11_1, arg_11_2)
end

function var_0_0.onUnlockStoneReply(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:dispatchEvent(CharacterDestinyEvent.OnUnlockStoneReply, arg_12_1, arg_12_2)
end

function var_0_0.onUseStone(arg_13_0, arg_13_1, arg_13_2)
	HeroRpc.instance:setDestinyStoneUseRequest(arg_13_1, arg_13_2)
end

function var_0_0.onUseStoneReply(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:dispatchEvent(CharacterDestinyEvent.OnUseStoneReply, arg_14_1, arg_14_2)
end

function var_0_0.onHeroRedDotReadReply(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:dispatchEvent(CharacterDestinyEvent.OnHeroRedDotReadReply, arg_15_1, arg_15_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
