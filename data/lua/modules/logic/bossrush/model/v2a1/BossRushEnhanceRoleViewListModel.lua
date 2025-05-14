module("modules.logic.bossrush.model.v2a1.BossRushEnhanceRoleViewListModel", package.seeall)

local var_0_0 = class("BossRushEnhanceRoleViewListModel", ListScrollModel)

function var_0_0.setListData(arg_1_0)
	local var_1_0 = BossRushConfig.instance:getActRoleEnhance()

	if var_1_0 then
		local var_1_1 = {}
		local var_1_2 = 0

		for iter_1_0, iter_1_1 in pairs(var_1_0) do
			local var_1_3 = {
				characterId = iter_1_1.characterId,
				sort = iter_1_1.sort
			}

			if iter_1_1.sort == 1 then
				var_1_2 = iter_1_1.characterId
			end

			table.insert(var_1_1, var_1_3)
		end

		table.sort(var_1_1, arg_1_0.sort)
		arg_1_0:setList(var_1_1)

		if var_1_2 ~= 0 then
			arg_1_0:setSelect(var_1_2)
		end
	end
end

function var_0_0.sort(arg_2_0, arg_2_1)
	return arg_2_0.sort < arg_2_1.sort
end

function var_0_0.clearSelect(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._scrollViews) do
		iter_3_1:setSelect(nil)
	end

	arg_3_0._selectHeroId = nil
end

function var_0_0._refreshSelect(arg_4_0)
	local var_4_0
	local var_4_1 = arg_4_0:getList()

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if iter_4_1.characterId == arg_4_0._selectHeroId then
			var_4_0 = iter_4_1
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._scrollViews) do
		iter_4_3:setSelect(var_4_0)
	end
end

function var_0_0.setSelect(arg_5_0, arg_5_1)
	arg_5_0._selectHeroId = arg_5_1

	arg_5_0:_refreshSelect()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnSelectEnhanceRole, arg_5_1)
end

function var_0_0.getSelectHeroId(arg_6_0)
	return arg_6_0._selectHeroId
end

var_0_0.instance = var_0_0.New()

return var_0_0
