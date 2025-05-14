module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroSingleGroupModel", package.seeall)

local var_0_0 = class("V1a6_CachotHeroSingleGroupModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_buildMOList()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_buildMOList()
end

function var_0_0._buildMOList(arg_3_0)
	local var_3_0 = {}

	for iter_3_0 = 1, V1a6_CachotEnum.MaxHeroCountInGroup do
		table.insert(var_3_0, HeroSingleGroupMO.New())
	end

	arg_3_0:setList(var_3_0)
end

function var_0_0.isTemp(arg_4_0)
	return arg_4_0.temp
end

function var_0_0.getCurGroupMO(arg_5_0)
	return arg_5_0._heroGroupMO
end

function var_0_0.setMaxHeroCount(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = 1, arg_6_1 do
		table.insert(var_6_0, HeroSingleGroupMO.New())
	end

	arg_6_0:setList(var_6_0)
end

function var_0_0.setSingleGroup(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._heroGroupMO = arg_7_1

	local var_7_0 = arg_7_0:getList()

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = arg_7_1 and arg_7_1.heroList[iter_7_0]

		var_7_0[iter_7_0]:init(iter_7_0, var_7_1)
	end

	arg_7_0.temp = arg_7_1 and arg_7_1.temp

	arg_7_0:setList(var_7_0)

	if arg_7_2 and arg_7_1 then
		local var_7_2 = arg_7_0:getList()

		for iter_7_1 = 1, #var_7_2 do
			var_7_2[iter_7_1]:setAid(arg_7_1.aidDict and arg_7_1.aidDict[iter_7_1])

			if arg_7_1.trialDict and arg_7_1.trialDict[iter_7_1] then
				var_7_2[iter_7_1]:setTrial(unpack(arg_7_1.trialDict[iter_7_1]))
			else
				var_7_2[iter_7_1]:setTrial()
			end
		end
	end
end

function var_0_0.addToEmpty(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1:isEmpty() then
			iter_8_1:setHeroUid(arg_8_1)

			break
		end
	end
end

function var_0_0.addTo(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getById(arg_9_2)

	if var_9_0 then
		var_9_0:setHeroUid(arg_9_1)
	end
end

function var_0_0.remove(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1:isEqual(arg_10_1) then
			iter_10_1:setEmpty()

			break
		end
	end
end

function var_0_0.removeFrom(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getById(arg_11_1)

	if var_11_0 then
		var_11_0:setEmpty()
	end
end

function var_0_0.swap(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getById(arg_12_1)
	local var_12_1 = arg_12_0:getById(arg_12_2)

	if var_12_0 and var_12_1 then
		if var_12_0.aid == -1 or var_12_1.aid == -1 then
			return
		end

		local var_12_2 = var_12_0.heroUid

		var_12_0:setHeroUid(var_12_1.heroUid)
		var_12_1:setHeroUid(var_12_2)

		local var_12_3 = var_12_0.aid

		var_12_0:setAid(var_12_1.aid)
		var_12_1:setAid(var_12_3)

		local var_12_4 = var_12_0.trial
		local var_12_5 = var_12_0.trialTemplate
		local var_12_6 = var_12_0.trialPos

		var_12_0:setTrial(var_12_1.trial, var_12_1.trialTemplate, var_12_1.trialPos, true)
		var_12_1:setTrial(var_12_4, var_12_5, var_12_6, true)
	end
end

function var_0_0.move(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getList()
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_2 = iter_13_0

		if iter_13_0 ~= arg_13_1 then
			if iter_13_0 < arg_13_1 and arg_13_2 <= iter_13_0 then
				var_13_2 = iter_13_0 + 1
			elseif arg_13_1 < iter_13_0 and iter_13_0 <= arg_13_2 then
				var_13_2 = iter_13_0 - 1
			end
		else
			var_13_2 = arg_13_2
		end

		var_13_1[var_13_2] = iter_13_1
		iter_13_1.id = var_13_2
	end

	arg_13_0:setList(var_13_1)
end

function var_0_0.isInGroup(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1:isEqual(arg_14_1) then
			return true
		end
	end
end

function var_0_0.isEmptyById(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getById(arg_15_1)

	return var_15_0 and var_15_0:isEmpty()
end

function var_0_0.isEmptyExcept(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getList()

	for iter_16_0 = 1, V1a6_CachotEnum.HeroCountInGroup do
		if iter_16_0 ~= arg_16_1 and not var_16_0[iter_16_0]:isEmpty() then
			return false
		end
	end

	return true
end

function var_0_0.isFull(arg_17_0)
	local var_17_0 = arg_17_0:getList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1:canAddHero() and V1a6_CachotHeroGroupModel.instance:isPositionOpen(iter_17_1.id) then
			return false
		end
	end

	return true
end

function var_0_0.getHeroUids(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = arg_18_0:getList()

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		table.insert(var_18_0, iter_18_1.heroUid)
	end

	return var_18_0
end

function var_0_0.getHeroUid(arg_19_0, arg_19_1)
	local var_19_0 = "0"
	local var_19_1 = arg_19_0:getById(arg_19_1)

	if var_19_1 then
		var_19_0 = var_19_1.heroUid
	end

	return var_19_0
end

function var_0_0.hasHeroUids(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == "0" then
		return false
	end

	local var_20_0 = arg_20_0:getList()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1.heroUid == arg_20_1 and iter_20_1.id ~= arg_20_2 then
			return true, iter_20_0
		end
	end

	return false
end

function var_0_0.hasHero(arg_21_0)
	local var_21_0 = HeroModel.instance:getList()

	if var_21_0 and #var_21_0 > 0 then
		for iter_21_0, iter_21_1 in ipairs(var_21_0) do
			if not arg_21_0:hasHeroUids(iter_21_1.uid) then
				return true
			end
		end
	end

	return false
end

function var_0_0.isAidConflict(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getList()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1:isAidConflict(arg_22_1) then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
