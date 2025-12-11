module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_TaskViewItem", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_TaskViewItem", CorvusTaskItem)

function var_0_0._getRewardList(arg_1_0)
	local var_1_0 = arg_1_0._mo.config.bonus

	if string.nilorempty(var_1_0) then
		return {}
	end

	local var_1_1 = tonumber(var_1_0)
	local var_1_2 = {}

	if tonumber(var_1_1) then
		local var_1_3 = DungeonConfig.instance:getRewardItems(tonumber(var_1_1))

		for iter_1_0, iter_1_1 in ipairs(var_1_3) do
			var_1_2[iter_1_0] = {
				iter_1_1[1],
				iter_1_1[2],
				iter_1_1[3]
			}
		end
	else
		var_1_2 = ItemModel.instance:getItemDataListByConfigStr(var_1_1)
	end

	return var_1_2
end

return var_0_0
