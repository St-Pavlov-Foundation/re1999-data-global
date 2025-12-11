module("modules.logic.herogrouppreset.model.HeroGroupPresetTabListModel", package.seeall)

local var_0_0 = class("HeroGroupPresetTabListModel", ListScrollModel)

function var_0_0.initTabList(arg_1_0)
	local var_1_0 = HeroGroupPresetConfig.instance:getHeroTeamList()
	local var_1_1 = arg_1_0:_getTargetList(var_1_0)
	local var_1_2 = arg_1_0:_getOnlineList(var_1_1)

	arg_1_0:setList(var_1_2)
	arg_1_0:setSelectedCell(1, true)
end

function var_0_0._getOnlineList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if arg_2_0:_isUnlock(iter_2_1.unlockId) then
			if iter_2_1.actType == 0 then
				table.insert(var_2_0, iter_2_1)
			elseif ActivityModel.instance:tryGetFirstOpenedActCOByTypeId(iter_2_1.actType) then
				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	return var_2_0
end

function var_0_0._isUnlock(arg_3_0, arg_3_1)
	if arg_3_1 == 0 then
		return true
	end

	return OpenModel.instance:isFunctionUnlock(arg_3_1)
end

function var_0_0._getTargetList(arg_4_0, arg_4_1)
	local var_4_0 = HeroGroupPresetController.instance:getHeroGroupTypeList()

	if var_4_0 then
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			if tabletool.indexOf(var_4_0, iter_4_1.id) then
				table.insert(var_4_1, iter_4_1)
			end
		end

		return var_4_1
	end

	return arg_4_1
end

function var_0_0.setSelectedCell(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:selectCell(arg_5_1, arg_5_2)

	local var_5_0 = arg_5_0:getByIndex(arg_5_1)

	HeroGroupPresetItemListModel.instance:initList(var_5_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
