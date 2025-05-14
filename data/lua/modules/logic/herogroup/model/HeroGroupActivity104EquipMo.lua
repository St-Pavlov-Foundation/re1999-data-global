module("modules.logic.herogroup.model.HeroGroupActivity104EquipMo", package.seeall)

local var_0_0 = pureTable("HeroGroupActivity104EquipMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.index = arg_1_1.index

	if arg_1_0.index == 4 then
		if not arg_1_0._mainCardNum then
			local var_1_0 = arg_1_1.equipUid and arg_1_1.equipUid[1] or "0"

			arg_1_0.equipUid = {
				var_1_0
			}
		else
			arg_1_0.equipUid = {}

			for iter_1_0 = 1, arg_1_0._mainCardNum do
				local var_1_1 = arg_1_1.equipUid and arg_1_1.equipUid[iter_1_0] or "0"

				table.insert(arg_1_0.equipUid, var_1_1)
			end
		end
	else
		arg_1_0.equipUid = {}

		if not arg_1_0._normalCardNum then
			for iter_1_1 = 1, 2 do
				local var_1_2 = arg_1_1.equipUid and arg_1_1.equipUid[iter_1_1] or "0"

				table.insert(arg_1_0.equipUid, var_1_2)
			end
		else
			for iter_1_2 = 1, arg_1_0._normalCardNum do
				local var_1_3 = arg_1_1.equipUid and arg_1_1.equipUid[iter_1_2] or "0"

				table.insert(arg_1_0.equipUid, var_1_3)
			end
		end
	end
end

function var_0_0.setLimitNum(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._mainCardNum, arg_2_0._normalCardNum = arg_2_1, arg_2_2
end

function var_0_0.getEquipUID(arg_3_0, arg_3_1)
	if not arg_3_0.equipUid then
		return
	end

	return arg_3_0.equipUid[arg_3_1]
end

return var_0_0
