local var_0_0 = class("VersionActivity2_3NewCultivationGiftRewardListModel", ListScrollModel)

function var_0_0.setRewardList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	if not string.nilorempty(arg_1_1) then
		local var_1_1 = string.split(arg_1_1, "|")

		if var_1_1 and #var_1_1 > 0 then
			for iter_1_0, iter_1_1 in ipairs(var_1_1) do
				local var_1_2 = {}
				local var_1_3 = string.splitToNumber(iter_1_1, "#")

				var_1_2.type = var_1_3[1]
				var_1_2.id = var_1_3[2]
				var_1_2.quantity = var_1_3[3]

				table.insert(var_1_0, var_1_2)
			end
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
