module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueGroupInfoMO", package.seeall)

local var_0_0 = pureTable("RogueGroupInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.name = arg_1_1.name
	arg_1_0.clothId = arg_1_1.clothId
	arg_1_0.heroList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.heroList) do
		local var_1_0 = HeroModel.instance:getByHeroId(iter_1_1)

		table.insert(arg_1_0.heroList, var_1_0 and var_1_0.uid or "0")
	end

	arg_1_0.equips = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.equips) do
		local var_1_1 = HeroGroupEquipMO.New()

		var_1_1:init(iter_1_3)
		table.insert(arg_1_0.equips, var_1_1)
	end
end

function var_0_0.getFirstEquipMo(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.equips[arg_2_1]

	if not var_2_0 then
		return nil
	end

	local var_2_1 = var_2_0.equipUid[1]

	return EquipModel.instance:getEquip(var_2_1)
end

return var_0_0
