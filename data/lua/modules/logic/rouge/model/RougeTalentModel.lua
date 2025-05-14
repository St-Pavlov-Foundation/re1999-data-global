module("modules.logic.rouge.model.RougeTalentModel", package.seeall)

local var_0_0 = class("RougeTalentModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.setOutsideInfo(arg_3_0, arg_3_1)
	arg_3_0.season = arg_3_1.season
	arg_3_0.talentponint = arg_3_1.geniusPoint
	arg_3_0._isNewStage = arg_3_1.isGeniusNewStage

	if arg_3_1.geniusIds then
		arg_3_0.hadUnlockTalent = arg_3_1.geniusIds
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo)
end

function var_0_0.updateGeniusIDs(arg_4_0, arg_4_1)
	local var_4_0

	if arg_4_0.season == arg_4_1.season then
		if arg_4_1.geniusIds then
			arg_4_0.hadUnlockTalent = arg_4_1.geniusIds
		end

		if arg_4_1.geniusId then
			var_4_0 = arg_4_1.geniusId
		end
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo, var_4_0)
end

function var_0_0.calculateTalent(arg_5_0)
	if not arg_5_0.hadUnlockTalent or #arg_5_0.hadUnlockTalent == 0 then
		return
	end

	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.hadUnlockTalent) do
		local var_5_4 = RougeOutsideModel.instance:season()
		local var_5_5 = RougeTalentConfig.instance:getBranchConfigByID(var_5_4, iter_5_1)

		if var_5_5.show == 1 then
			local var_5_6 = var_5_5.talent

			if not var_5_1[var_5_6] then
				var_5_1[var_5_6] = {}
			end

			table.insert(var_5_1[var_5_6], iter_5_1)
		elseif not string.nilorempty(var_5_5.attribute) then
			local var_5_7 = string.split(var_5_5.attribute, "|")

			for iter_5_2, iter_5_3 in ipairs(var_5_7) do
				local var_5_8 = {}

				var_5_8.rate = nil

				local var_5_9 = string.split(iter_5_3, "#")
				local var_5_10 = var_5_9[1]
				local var_5_11 = HeroConfig.instance:getHeroAttributeCO(tonumber(var_5_10))

				var_5_8.id = tonumber(var_5_10)
				var_5_8.name = var_5_11.name
				var_5_8.rate = tonumber(var_5_9[2])
				var_5_8.ismul = true

				if var_5_8.id == 215 then
					var_5_8.icon = "icon_att_205"
				elseif var_5_8.id == 216 then
					var_5_8.icon = "icon_att_206"
				else
					var_5_8.icon = "icon_att_" .. var_5_10
				end

				var_5_8.isattribute = true

				if #var_5_2 > 0 then
					local var_5_12 = false

					for iter_5_4, iter_5_5 in ipairs(var_5_2) do
						if var_5_8.id == iter_5_5.id then
							iter_5_5.rate = iter_5_5.rate + var_5_8.rate
							var_5_12 = true
						end
					end

					if not var_5_12 then
						table.insert(var_5_2, var_5_8)
					end
				else
					table.insert(var_5_2, var_5_8)
				end
			end
		elseif not string.nilorempty(var_5_5.openDesc) then
			local var_5_13 = RougeTalentConfig.instance:getTalentOverConfigById(tonumber(var_5_5.openDesc))
			local var_5_14 = {
				id = var_5_13.id,
				name = var_5_13.name,
				rate = tonumber(var_5_13.value),
				ismul = var_5_13.ismul == 1,
				icon = var_5_13.icon
			}

			var_5_14.isattribute = false

			if #var_5_3 > 0 then
				local var_5_15 = false

				for iter_5_6, iter_5_7 in ipairs(var_5_3) do
					if var_5_14.id == iter_5_7.id then
						iter_5_7.rate = iter_5_7.rate + var_5_14.rate
						var_5_15 = true
					end
				end

				if not var_5_15 then
					table.insert(var_5_3, var_5_14)
				end
			else
				table.insert(var_5_3, var_5_14)
			end
		end
	end

	table.sort(var_5_2, var_0_0.sortattributeList)
	table.sort(var_5_3, var_0_0.sortattributeList)
	tabletool.addValues(var_5_0, var_5_2)
	tabletool.addValues(var_5_0, var_5_3)

	return var_5_0, var_5_1
end

function var_0_0.sortattributeList(arg_6_0, arg_6_1)
	return arg_6_0.id < arg_6_1.id
end

function var_0_0.isTalentUnlock(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.hadUnlockTalent) do
		if iter_7_1 == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.getHadConsumeTalentPoint(arg_8_0)
	if not arg_8_0.hadUnlockTalent or #arg_8_0.hadUnlockTalent == 0 then
		return 0
	end

	local var_8_0 = 0
	local var_8_1 = RougeOutsideModel.instance:season()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.hadUnlockTalent) do
		var_8_0 = var_8_0 + RougeTalentConfig.instance:getBranchConfigByID(var_8_1, iter_8_1).cost
	end

	return var_8_0
end

function var_0_0.getHadAllTalentPoint(arg_9_0)
	local var_9_0 = arg_9_0:getHadConsumeTalentPoint()
	local var_9_1 = var_9_0
	local var_9_2 = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit)
	local var_9_3 = tonumber(var_9_2)

	if arg_9_0.talentponint then
		local var_9_4 = var_9_0 + arg_9_0.talentponint

		var_9_1 = var_9_3 < var_9_4 and var_9_3 or var_9_4
	end

	return var_9_1
end

function var_0_0.getTalentPoint(arg_10_0)
	return arg_10_0.talentponint
end

function var_0_0.getUnlockNumByTalent(arg_11_0, arg_11_1)
	if not arg_11_0.hadUnlockTalent or #arg_11_0.hadUnlockTalent == 0 then
		return 0
	end

	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.hadUnlockTalent) do
		local var_11_1 = RougeOutsideModel.instance:season()

		if RougeTalentConfig.instance:getBranchConfigByID(var_11_1, iter_11_1).talent == arg_11_1 then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0.checkNodeLock(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.id

	if arg_12_1.talent == 1 and arg_12_1.isOrigin == 1 then
		return false
	end

	if not arg_12_0.hadUnlockTalent or #arg_12_0.hadUnlockTalent == 0 then
		return true
	end

	local var_12_1 = RougeOutsideModel.instance:season()
	local var_12_2 = RougeTalentConfig.instance:getBranchConfigByID(var_12_1, var_12_0)

	if var_12_2.isOrigin == 1 then
		return arg_12_0:checkBigNodeLock(var_12_2.talent)
	else
		return arg_12_0:checkBeforeNodeLock(var_12_0)
	end

	return true
end

function var_0_0.checkBeforeNodeLock(arg_13_0, arg_13_1)
	local var_13_0 = RougeOutsideModel.instance:season()
	local var_13_1 = RougeTalentConfig.instance:getBranchConfigByID(var_13_0, arg_13_1)

	if var_13_1.isOrigin == 1 then
		return false
	end

	local var_13_2 = string.split(var_13_1.before, "|")

	if var_13_2 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.hadUnlockTalent) do
			for iter_13_2, iter_13_3 in ipairs(var_13_2) do
				if iter_13_1 == tonumber(iter_13_3) then
					return false
				end
			end
		end
	end

	return true
end

function var_0_0.checkBigNodeLock(arg_14_0, arg_14_1)
	if arg_14_1 == 1 then
		return false
	end

	local var_14_0 = RougeOutsideModel.instance:season()
	local var_14_1 = RougeTalentConfig.instance:getConfigByTalent(var_14_0, arg_14_1)

	if arg_14_0:getHadConsumeTalentPoint() >= var_14_1.cost then
		return false
	end

	return true
end

function var_0_0.checkNodeCanLevelUp(arg_15_0, arg_15_1)
	if arg_15_0:checkNodeLock(arg_15_1) then
		return
	end

	local var_15_0 = arg_15_1.talent == 1 and arg_15_1.isOrigin == 1

	if arg_15_0:checkNodeLight(arg_15_1.id) then
		if var_15_0 then
			return false
		end
	elseif not arg_15_0.talentponint or arg_15_0.talentponint <= 0 then
		return false
	elseif arg_15_0.talentponint >= arg_15_1.cost then
		return true
	end
end

function var_0_0.checkBigNodeShowUp(arg_16_0, arg_16_1)
	local var_16_0 = RougeTalentConfig.instance:getBranchConfigListByTalent(arg_16_1)
	local var_16_1 = false

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_2 = arg_16_0:checkNodeCanLevelUp(iter_16_1)

		if iter_16_1.talent == 1 and arg_16_0:getUnlockNumByTalent(1) == RougeTalentConfig.instance:getBranchNumByTalent(1) then
			return false
		end

		if var_16_2 then
			return var_16_2
		end
	end
end

function var_0_0.checkAnyNodeCanUp(arg_17_0)
	local var_17_0 = RougeOutsideModel.instance:season()
	local var_17_1 = RougeTalentConfig.instance:getRougeTalentDict(var_17_0)
	local var_17_2 = false

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if arg_17_0:checkBigNodeShowUp(iter_17_1.id) then
			var_17_2 = true

			break
		end
	end

	return var_17_2
end

function var_0_0.setCurrentSelectIndex(arg_18_0, arg_18_1)
	arg_18_0._currentSelectIndex = arg_18_1
end

function var_0_0.checkIsCurrentSelectView(arg_19_0, arg_19_1)
	if not arg_19_0._currentSelectIndex or not arg_19_1 then
		return false
	end

	return arg_19_0._currentSelectIndex == arg_19_1
end

function var_0_0.setNewStage(arg_20_0, arg_20_1)
	arg_20_0._isNewStage = arg_20_1
end

function var_0_0.checkIsNewStage(arg_21_0)
	return arg_21_0._isNewStage
end

function var_0_0.checkNodeLight(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.hadUnlockTalent) do
		if iter_22_1 == arg_22_1 then
			return true
		end
	end

	return false
end

function var_0_0.getUnlockTalent(arg_23_0)
	return arg_23_0.hadUnlockTalent
end

function var_0_0.getAllUnlockPoint(arg_24_0)
	if not arg_24_0.hadUnlockTalent or #arg_24_0.hadUnlockTalent == 0 then
		return 0
	end

	return #arg_24_0.hadUnlockTalent
end

function var_0_0.getNextNeedUnlockTalent(arg_25_0)
	local var_25_0 = RougeOutsideModel.instance:season()
	local var_25_1 = RougeTalentConfig.instance:getRougeTalentDict(var_25_0)
	local var_25_2 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		if not var_25_2[iter_25_1.cost] then
			var_25_2[iter_25_1.cost] = {}
		end

		table.insert(var_25_2[iter_25_1.cost], iter_25_1.id)
	end

	local var_25_3

	for iter_25_2, iter_25_3 in ipairs(var_25_1) do
		if arg_25_0:checkBigNodeLock(iter_25_2) then
			var_25_3 = iter_25_3.cost

			break
		end
	end

	if var_25_2[var_25_3] then
		return var_25_2[var_25_3]
	end
end

function var_0_0.calcTalentUnlockIds(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.hadUnlockTalent) do
		if arg_26_1[iter_26_1] ~= nil then
			arg_26_1[iter_26_1] = true
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
