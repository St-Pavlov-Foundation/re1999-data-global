module("modules.logic.herogroup.model.HeroGroupEquipMO", package.seeall)

local var_0_0 = pureTable("HeroGroupEquipMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.index = arg_1_1.index
	arg_1_0.equipUid = {}

	for iter_1_0 = 1, 1 do
		table.insert(arg_1_0.equipUid, "0")
	end

	if not arg_1_1.equipUid then
		return
	end

	for iter_1_1, iter_1_2 in ipairs(arg_1_1.equipUid) do
		if iter_1_1 > 1 then
			break
		end

		arg_1_0.equipUid[iter_1_1] = iter_1_2
	end
end

return var_0_0
