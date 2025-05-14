module("modules.logic.rouge.model.RougeTeamListModel", package.seeall)

local var_0_0 = class("RougeTeamListModel", ListScrollModel)

function var_0_0.getHp(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.heroId
	local var_1_1 = arg_1_0._heroLifeMap[var_1_0]

	return var_1_1 and var_1_1.life or 0
end

function var_0_0.isInTeam(arg_2_0, arg_2_1)
	return arg_2_0._teamInfo:inTeam(arg_2_1.heroId)
end

function var_0_0.isAssit(arg_3_0, arg_3_1)
	return arg_3_0._teamInfo:inTeamAssist(arg_3_1.heroId)
end

function var_0_0.getTeamType(arg_4_0)
	return arg_4_0._teamType
end

function var_0_0.getSelectedHeroMap(arg_5_0)
	return arg_5_0._selectedHeroMap
end

function var_0_0.getSelectedHeroList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0._selectedHeroMap) do
		table.insert(var_6_0, iter_6_0)
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_6_0._selectedHeroMap[arg_7_0] < arg_6_0._selectedHeroMap[arg_7_1]
	end)

	for iter_6_2, iter_6_3 in ipairs(var_6_0) do
		var_6_0[iter_6_2] = iter_6_3.heroId
	end

	return var_6_0
end

function var_0_0.isHeroSelected(arg_8_0, arg_8_1)
	return arg_8_0._selectedHeroMap[arg_8_1] ~= nil
end

function var_0_0.selectHero(arg_9_0, arg_9_1)
	if arg_9_0._selectedHeroMap[arg_9_1] then
		arg_9_0._selectedHeroMap[arg_9_1] = nil

		return
	end

	if tabletool.len(arg_9_0._selectedHeroMap) >= arg_9_0._heroNum then
		GameFacade.showToast(ToastEnum.RougeTeamSelectedFull)

		return
	end

	arg_9_0._selectedHeroMap[arg_9_1] = UnityEngine.Time.frameCount
end

function var_0_0.initList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = RougeModel.instance:getTeamInfo()
	local var_10_1 = var_10_0.heroLifeList

	arg_10_0._heroLifeMap = var_10_0.heroLifeMap
	arg_10_0._teamInfo = var_10_0
	arg_10_0._teamType = arg_10_1
	arg_10_0._heroNum = arg_10_2
	arg_10_0._selectedHeroMap = {}

	local var_10_2 = {}

	if arg_10_1 == RougeEnum.TeamType.View then
		arg_10_0:_getViewList(var_10_1, var_10_2)
	elseif arg_10_1 == RougeEnum.TeamType.Treat then
		arg_10_0:_getTreatList(var_10_1, var_10_2)
	elseif arg_10_1 == RougeEnum.TeamType.Revive then
		arg_10_0:_getReviveList(var_10_1, var_10_2)
	elseif arg_10_1 == RougeEnum.TeamType.Assignment then
		arg_10_0:_getAssignmentList(var_10_1, var_10_2)
	end

	arg_10_0:setList(var_10_2)
end

function var_0_0._getViewList(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = #arg_11_1, 1, -1 do
		local var_11_0 = arg_11_1[iter_11_0]
		local var_11_1 = arg_11_0:getByHeroId(var_11_0.heroId)

		if var_11_0.life > 0 then
			table.insert(arg_11_2, 1, var_11_1)
		else
			table.insert(arg_11_2, var_11_1)
		end
	end
end

function var_0_0._getTreatList(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		if iter_12_1.life > 0 then
			local var_12_0 = arg_12_0:getByHeroId(iter_12_1.heroId)

			table.insert(arg_12_2, var_12_0)
		end
	end
end

function var_0_0._getReviveList(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if iter_13_1.life <= 0 then
			local var_13_0 = arg_13_0:getByHeroId(iter_13_1.heroId)

			table.insert(arg_13_2, var_13_0)
		end
	end
end

function var_0_0._getAssignmentList(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if iter_14_1.life > 0 then
			local var_14_0 = arg_14_0:getByHeroId(iter_14_1.heroId)

			table.insert(arg_14_2, var_14_0)
		end
	end
end

function var_0_0.getByHeroId(arg_15_0, arg_15_1)
	return HeroModel.instance:getByHeroId(arg_15_1)
end

function var_0_0.addAssistHook()
	HeroModel.instance:addHookGetHeroId(var_0_0.addHookGetHeroId)
	HeroModel.instance:addHookGetHeroUid(var_0_0.addHookGetHeroUid)
end

function var_0_0.removeAssistHook()
	HeroModel.instance:removeHookGetHeroId(var_0_0.addHookGetHeroId)
	HeroModel.instance:removeHookGetHeroUid(var_0_0.addHookGetHeroUid)
end

function var_0_0.addHookGetHeroId(arg_18_0)
	return (RougeModel.instance:getTeamInfo():getAssistHeroMo(arg_18_0))
end

function var_0_0.addHookGetHeroUid(arg_19_0)
	return (RougeModel.instance:getTeamInfo():getAssistHeroMoByUid(arg_19_0))
end

var_0_0.instance = var_0_0.New()

return var_0_0
