module("modules.logic.herogroup.model.HeroSingleGroupModel", package.seeall)

local var_0_0 = class("HeroSingleGroupModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_buildMOList()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_buildMOList()
end

function var_0_0._buildMOList(arg_3_0)
	arg_3_0:setMaxHeroCount()
end

function var_0_0.isTemp(arg_4_0)
	return arg_4_0.temp
end

function var_0_0.setMaxHeroCount(arg_5_0, arg_5_1)
	local var_5_0 = {}

	arg_5_1 = arg_5_1 or ModuleEnum.MaxHeroCountInGroup

	for iter_5_0 = 1, arg_5_1 do
		table.insert(var_5_0, HeroSingleGroupMO.New())
	end

	arg_5_0:clear()
	arg_5_0:setList(var_5_0)
end

function var_0_0.setSingleGroup(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getList()

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = arg_6_1 and arg_6_1.heroList[iter_6_0]

		var_6_0[iter_6_0]:init(iter_6_0, var_6_1)
	end

	arg_6_0.temp = arg_6_1 and arg_6_1.temp

	arg_6_0:setList(var_6_0)

	if arg_6_2 and arg_6_1 then
		local var_6_2 = arg_6_0:getList()

		for iter_6_1 = 1, #var_6_2 do
			var_6_2[iter_6_1]:setAid(arg_6_1.aidDict and arg_6_1.aidDict[iter_6_1])

			if arg_6_1.trialDict and arg_6_1.trialDict[iter_6_1] then
				var_6_2[iter_6_1]:setTrial(unpack(arg_6_1.trialDict[iter_6_1]))
			else
				var_6_2[iter_6_1]:setTrial()
			end
		end
	end
end

function var_0_0.addToEmpty(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1:isEmpty() then
			iter_7_1:setHeroUid(arg_7_1)

			break
		end
	end
end

function var_0_0.addTo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getById(arg_8_2)

	if var_8_0 then
		var_8_0:setHeroUid(arg_8_1)
	end
end

function var_0_0.remove(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1:isEqual(arg_9_1) then
			iter_9_1:setEmpty()

			break
		end
	end
end

function var_0_0.removeFrom(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getById(arg_10_1)

	if var_10_0 then
		var_10_0:setEmpty()
	end
end

function var_0_0.swap(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getById(arg_11_1)
	local var_11_1 = arg_11_0:getById(arg_11_2)

	if var_11_0 and var_11_1 then
		if var_11_0.aid == -1 or var_11_1.aid == -1 then
			return
		end

		local var_11_2 = var_11_0.heroUid

		var_11_0:setHeroUid(var_11_1.heroUid)
		var_11_1:setHeroUid(var_11_2)

		local var_11_3 = var_11_0.aid

		var_11_0:setAid(var_11_1.aid)
		var_11_1:setAid(var_11_3)

		local var_11_4 = var_11_0.trial
		local var_11_5 = var_11_0.trialTemplate
		local var_11_6 = var_11_0.trialPos

		var_11_0:setTrial(var_11_1.trial, var_11_1.trialTemplate, var_11_1.trialPos, true)
		var_11_1:setTrial(var_11_4, var_11_5, var_11_6, true)
	end
end

function var_0_0.move(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getList()
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_2 = iter_12_0

		if iter_12_0 ~= arg_12_1 then
			if iter_12_0 < arg_12_1 and arg_12_2 <= iter_12_0 then
				var_12_2 = iter_12_0 + 1
			elseif arg_12_1 < iter_12_0 and iter_12_0 <= arg_12_2 then
				var_12_2 = iter_12_0 - 1
			end
		else
			var_12_2 = arg_12_2
		end

		var_12_1[var_12_2] = iter_12_1
		iter_12_1.id = var_12_2
	end

	arg_12_0:setList(var_12_1)
end

function var_0_0.isInGroup(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getList()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1:isEqual(arg_13_1) then
			return true
		end
	end
end

function var_0_0.isEmptyById(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getById(arg_14_1)

	return var_14_0 and var_14_0:isEmpty()
end

function var_0_0.isEmptyExcept(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getList()

	for iter_15_0 = 1, ModuleEnum.HeroCountInGroup do
		if iter_15_0 ~= arg_15_1 and not var_15_0[iter_15_0]:isEmpty() then
			return false
		end
	end

	return true
end

function var_0_0.isFull(arg_16_0)
	local var_16_0 = arg_16_0:getList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1:canAddHero() and HeroGroupModel.instance:isPositionOpen(iter_16_1.id) then
			return false
		end
	end

	return true
end

function var_0_0.getHeroUids(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = arg_17_0:getList()

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		table.insert(var_17_0, iter_17_1.heroUid)
	end

	return var_17_0
end

function var_0_0.getHeroUid(arg_18_0, arg_18_1)
	local var_18_0 = "0"
	local var_18_1 = arg_18_0:getById(arg_18_1)

	if var_18_1 then
		var_18_0 = var_18_1.heroUid
	end

	return var_18_0
end

function var_0_0.hasHeroUids(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == "0" then
		return false
	end

	local var_19_0 = arg_19_0:getList()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.heroUid == arg_19_1 and iter_19_1.id ~= arg_19_2 then
			return true, iter_19_0
		end
	end

	return false
end

function var_0_0.hasHero(arg_20_0)
	local var_20_0 = HeroModel.instance:getList()

	if var_20_0 and #var_20_0 > 0 then
		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			if not arg_20_0:hasHeroUids(iter_20_1.uid) then
				return true
			end
		end
	end

	return false
end

function var_0_0.isAidConflict(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getList()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1:isAidConflict(arg_21_1) then
			return true
		end
	end

	return false
end

function var_0_0.getTeamLevel(arg_22_0)
	local var_22_0 = arg_22_0:getList()
	local var_22_1 = 0
	local var_22_2 = 0

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if tonumber(iter_22_1.heroUid) < 0 and iter_22_1.trial > 0 then
			var_22_1 = var_22_1 + (lua_hero_trial.configDict[iter_22_1.trial] and lua_hero_trial.configDict[iter_22_1.trial][0]).level
			var_22_2 = var_22_2 + 1
		else
			local var_22_3 = HeroModel.instance:getById(iter_22_1.heroUid)

			if var_22_3 then
				var_22_1 = var_22_1 + var_22_3.level
				var_22_2 = var_22_2 + 1
			end
		end
	end

	local var_22_4 = 0

	if var_22_2 ~= 0 then
		var_22_4 = math.floor(var_22_1 / var_22_2)
	end

	return var_22_4
end

var_0_0.instance = var_0_0.New()

return var_0_0
