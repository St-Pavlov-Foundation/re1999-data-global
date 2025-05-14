local var_0_0 = pureTable("Activity104RetailMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.state = 0
	arg_1_0.advancedId = 0
	arg_1_0.star = 0
	arg_1_0.showActivity104EquipIds = {}
	arg_1_0.position = 0
	arg_1_0.advancedRare = 0
	arg_1_0.tag = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.state = arg_2_1.state
	arg_2_0.advancedId = arg_2_1.advancedId
	arg_2_0.star = arg_2_1.star
	arg_2_0.showActivity104EquipIds = arg_2_0:_buildEquipList(arg_2_1.showActivity104EquipIds)
	arg_2_0.position = arg_2_1.position
	arg_2_0.advancedRare = arg_2_1.advancedRare
	arg_2_0.tag = arg_2_1.tag
end

function var_0_0._buildEquipList(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(var_3_0, iter_3_1)
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		local var_4_0 = SeasonConfig.instance:getSeasonEquipCo(arg_4_0)
		local var_4_1 = SeasonConfig.instance:getSeasonEquipCo(arg_4_1)

		if var_4_0.isOptional ~= var_4_1.isOptional then
			return var_4_0.isOptional > var_4_1.isOptional
		else
			return var_4_0.rare > var_4_1.rare
		end
	end)

	return var_3_0
end

return var_0_0
