module("modules.logic.summon.controller.SummonLuckyBagController", package.seeall)

local var_0_0 = class("SummonLuckyBagController", BaseController)

function var_0_0.skipOpenGetChar(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_3 then
		return
	end

	local var_1_0 = SummonConfig.instance:getSummonPool(arg_1_3)
	local var_1_1 = {
		heroId = arg_1_1,
		duplicateCount = arg_1_2
	}

	var_1_1.isSummon = true
	var_1_1.skipVideo = true

	local var_1_2 = SummonController.instance:getMvSkinIdByHeroId(arg_1_1)

	if var_1_2 then
		var_1_1.mvSkinId = var_1_2
	end

	if var_1_0 and var_1_0.ticketId ~= 0 then
		var_1_1.summonTicketId = var_1_0.ticketId
	end

	CharacterController.instance:openCharacterGetView(var_1_1)
end

function var_0_0.skipOpenGetLuckyBag(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_2 then
		return
	end

	local var_2_0 = {
		luckyBagId = arg_2_1,
		poolId = arg_2_2
	}
	local var_2_1 = SummonConfig.instance:getSummonPool(arg_2_2)

	if var_2_1 and var_2_1.ticketId ~= 0 then
		var_2_0.summonTicketId = var_2_1.ticketId
	end

	ViewMgr.instance:openView(ViewName.SummonGetLuckyBag, var_2_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
