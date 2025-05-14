module("modules.logic.open.model.OpenModel", package.seeall)

local var_0_0 = class("OpenModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._unlocks = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._unlocks = {}
end

function var_0_0.setOpenInfo(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = tonumber(iter_3_1.id)
		local var_3_1 = iter_3_1.isOpen

		if VersionValidator.instance:isInReviewing() then
			local var_3_2 = OpenConfig.instance:getOpenCo(var_3_0)

			var_3_1 = var_3_1 and var_3_2.verifingHide == 0
		end

		arg_3_0._unlocks[var_3_0] = var_3_1
	end
end

function var_0_0.updateOpenInfo(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = tonumber(iter_4_1.id)
		local var_4_1 = iter_4_1.isOpen

		if VersionValidator.instance:isInReviewing() then
			local var_4_2 = OpenConfig.instance:getOpenCo(var_4_0)

			var_4_1 = var_4_1 and var_4_2.verifingHide == 0
		end

		arg_4_0._unlocks[var_4_0] = var_4_1
	end
end

function var_0_0.isFunctionUnlock(arg_5_0, arg_5_1)
	return arg_5_0._unlocks[tonumber(arg_5_1)]
end

function var_0_0.isFuncBtnShow(arg_6_0, arg_6_1)
	local var_6_0 = OpenConfig.instance:getOpenCo(arg_6_1)

	if VersionValidator.instance:isInReviewing() and var_6_0.verifingHide == 1 then
		return false
	end

	if tonumber(var_6_0.isOnline) == 0 then
		return false
	end

	return tonumber(var_6_0.isAlwaysShowBtn) > 0 or arg_6_0._unlocks[arg_6_1]
end

function var_0_0.getFuncUnlockDesc(arg_7_0, arg_7_1)
	local var_7_0 = OpenConfig.instance:getOpenCo(arg_7_1)
	local var_7_1 = var_7_0.dec

	if var_7_1 == 2003 then
		local var_7_2 = VersionValidator.instance:isInReviewing() and var_7_0.verifingEpisodeId or var_7_0.episodeId

		if not var_7_2 or var_7_2 == 0 then
			return var_7_1
		end

		local var_7_3 = DungeonConfig.instance:getEpisodeDisplay(var_7_2)

		return var_7_1, var_7_3
	end

	return var_7_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
