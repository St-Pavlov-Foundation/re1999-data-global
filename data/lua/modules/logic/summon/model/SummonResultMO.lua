module("modules.logic.summon.model.SummonResultMO", package.seeall)

local var_0_0 = pureTable("SummonResultMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.duplicateCount = arg_1_1.duplicateCount
	arg_1_0.equipId = arg_1_1.equipId
	arg_1_0.luckyBagId = arg_1_1.luckyBagId

	if arg_1_1.returnMaterials then
		arg_1_0.returnMaterials = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.returnMaterials) do
			local var_1_0 = MaterialDataMO.New()

			var_1_0:init(iter_1_1)
			table.insert(arg_1_0.returnMaterials, var_1_0)
		end
	end

	arg_1_0.soundOfLost = arg_1_1.soundOfLost
	arg_1_0.manySoundOfLost = arg_1_1.manySoundOfLost
	arg_1_0.isNew = arg_1_1.isNew
	arg_1_0._opened = false
	arg_1_0.heroConfig = HeroConfig.instance:getHeroCO(arg_1_0.heroId)
end

function var_0_0.setOpen(arg_2_0)
	arg_2_0._opened = true
end

function var_0_0.isOpened(arg_3_0)
	return arg_3_0._opened
end

function var_0_0.isLuckyBag(arg_4_0)
	return arg_4_0.luckyBagId ~= nil and arg_4_0.luckyBagId ~= 0
end

return var_0_0
