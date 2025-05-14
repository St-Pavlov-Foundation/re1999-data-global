module("modules.logic.seasonver.act123.model.Season123PickHeroModel", package.seeall)

local var_0_0 = class("Season123PickHeroModel", ListScrollModel)

function var_0_0.release(arg_1_0)
	arg_1_0:clear()

	arg_1_0._lastSelectedMap = nil
	arg_1_0._curSelectMap = nil
	arg_1_0._curSelectList = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.activityId = arg_2_1
	arg_2_0.stage = arg_2_2
	arg_2_0._curSelectMap = {}
	arg_2_0._curSelectList = {}

	arg_2_0:initSelectedList(arg_2_3)
	arg_2_0:initHeroList(arg_2_0._lastSelectedMap, arg_2_4)
end

function var_0_0.initHeroList(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local var_3_2 = 0

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		var_3_2 = var_3_2 + 1

		local var_3_3 = Season123PickHeroMO.New()

		var_3_3:init(iter_3_1.uid, iter_3_1.heroId, iter_3_1.skin, var_3_2)
		table.insert(var_3_0, var_3_3)

		if arg_3_1 and arg_3_1[iter_3_1.heroId] and not arg_3_0._curSelectMap[iter_3_1.uid] then
			arg_3_0._curSelectMap[iter_3_1.uid] = true

			table.insert(arg_3_0._curSelectList, iter_3_1.uid)
		end

		if arg_3_2 and arg_3_2 == iter_3_1.uid then
			arg_3_0._lastSelectedHeroUid = arg_3_2
		end
	end

	logNormal("hero list count : " .. tostring(#var_3_0))
	table.sort(var_3_0, var_0_0.sortList)
	arg_3_0:setList(var_3_0)

	arg_3_0.heroMOList = arg_3_0:getHeroMOList()
end

function var_0_0.initSelectedList(arg_4_0, arg_4_1)
	arg_4_0._maxLimit = Activity123Enum.PickHeroCount
	arg_4_0._lastSelectedMap = {}

	if not arg_4_1 then
		return
	end

	for iter_4_0 = 1, Activity123Enum.PickHeroCount do
		local var_4_0 = arg_4_1[iter_4_0]

		if not var_4_0.isSupport and not var_4_0:getIsEmpty() then
			arg_4_0._lastSelectedMap[var_4_0.heroId] = true
		end

		if var_4_0.isSupport then
			arg_4_0._maxLimit = arg_4_0._maxLimit - 1
		end
	end
end

function var_0_0.sortList(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.instance._curSelectMap[arg_5_0.uid]

	if var_5_0 ~= var_0_0.instance._curSelectMap[arg_5_1.uid] then
		return var_5_0
	end

	return arg_5_0.index < arg_5_1.index
end

function var_0_0.getHeroMOList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = HeroModel.instance:getById(iter_6_1.uid)

		if var_6_2 then
			table.insert(var_6_0, var_6_2)
		end
	end

	return var_6_0
end

function var_0_0.refreshList(arg_7_0)
	arg_7_0:initHeroList(nil)
end

function var_0_0.cleanSelected(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._curSelectMap) do
		arg_8_0._curSelectMap[iter_8_0] = nil
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0._curSelectList) do
		arg_8_0._curSelectList[iter_8_2] = nil
	end
end

function var_0_0.setHeroSelect(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getById(arg_9_1)

	if var_9_0 then
		if arg_9_2 then
			if not arg_9_0._curSelectMap[arg_9_1] then
				arg_9_0._curSelectMap[arg_9_1] = true

				table.insert(arg_9_0._curSelectList, arg_9_1)
			end
		elseif arg_9_0._curSelectMap[arg_9_1] then
			arg_9_0._curSelectMap[arg_9_1] = nil

			tabletool.removeValue(arg_9_0._curSelectList, arg_9_1)
		end

		var_9_0.isSelect = arg_9_2
	end

	arg_9_0._lastSelectedHeroUid = arg_9_1
end

function var_0_0.getSelectCount(arg_10_0)
	return #arg_10_0._curSelectList
end

function var_0_0.getSelectedHeroMO(arg_11_0)
	if arg_11_0._lastSelectedHeroUid then
		return (HeroModel.instance:getById(arg_11_0._lastSelectedHeroUid))
	end
end

function var_0_0.isHeroSelected(arg_12_0, arg_12_1)
	return arg_12_0._curSelectMap[arg_12_1]
end

function var_0_0.getSelectedIndex(arg_13_0, arg_13_1)
	return tabletool.indexOf(arg_13_0._curSelectList, arg_13_1)
end

function var_0_0.getLimitCount(arg_14_0)
	return arg_14_0._maxLimit
end

function var_0_0.getSelectMOList(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._curSelectList) do
		local var_15_1 = arg_15_0:getById(iter_15_1)

		if var_15_1 == nil and iter_15_1 ~= 0 and iter_15_1 ~= Activity123Enum.EmptyUid then
			var_15_1 = Season123PickHeroMO.New()

			local var_15_2 = HeroModel.instance:getById(iter_15_1)

			if var_15_2 then
				var_15_1:init(var_15_2.uid, var_15_2.heroId, var_15_2.skin, 0)
			end
		end

		table.insert(var_15_0, var_15_1)
	end

	return var_15_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
