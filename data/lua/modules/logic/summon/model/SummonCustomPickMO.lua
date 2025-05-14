module("modules.logic.summon.model.SummonCustomPickMO", package.seeall)

local var_0_0 = pureTable("SummonCustomPickMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.pickHeroIds = nil
	arg_1_0._haveFirstSSR = false
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.pickHeroIds = {}

	if arg_2_1.UpHeroIds then
		for iter_2_0 = 1, #arg_2_1.UpHeroIds do
			local var_2_0 = arg_2_1.UpHeroIds[iter_2_0]

			table.insert(arg_2_0.pickHeroIds, var_2_0)
		end
	end

	if SummonEnum.ChooseNeedFirstHeroIds then
		for iter_2_1, iter_2_2 in ipairs(SummonEnum.ChooseNeedFirstHeroIds) do
			for iter_2_3, iter_2_4 in ipairs(arg_2_0.pickHeroIds) do
				if iter_2_4 == iter_2_2 then
					table.remove(arg_2_0.pickHeroIds, iter_2_3)
					table.insert(arg_2_0.pickHeroIds, 1, iter_2_2)

					break
				end
			end
		end
	end

	if arg_2_1.usedFirstSSRGuarantee ~= nil then
		arg_2_0._haveFirstSSR = arg_2_1.usedFirstSSRGuarantee
	end
end

function var_0_0.isPicked(arg_3_0, arg_3_1)
	return arg_3_0.pickHeroIds ~= nil and #arg_3_0.pickHeroIds >= SummonCustomPickModel.instance:getMaxSelectCount(arg_3_1)
end

function var_0_0.isHaveFirstSSR(arg_4_0)
	return arg_4_0._haveFirstSSR
end

return var_0_0
