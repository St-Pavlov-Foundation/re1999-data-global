module("modules.logic.versionactivity2_7.act191.model.Act191MatchMO", package.seeall)

local var_0_0 = pureTable("Act191MatchMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.robot = arg_1_1.robot
	arg_1_0.playerUid = arg_1_1.playerUid
	arg_1_0.heroMap = arg_1_1.heroMap
	arg_1_0.subHeroMap = arg_1_1.subHeroMap

	arg_1_0:updateEnhance(arg_1_1.enhanceSet)

	arg_1_0.wareHouseInfo = arg_1_1.warehouseInfo
end

function var_0_0.updateEnhance(arg_2_0, arg_2_1)
	arg_2_0.enhanceSet = arg_2_1

	local var_2_0 = Activity191Model.instance:getCurActId()

	arg_2_0.heroId2ExtraFetterMap = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.enhanceSet) do
		local var_2_1 = Activity191Config.instance:getEnhanceCo(var_2_0, iter_2_1)
		local var_2_2 = string.splitToNumber(var_2_1.effects, "|")

		for iter_2_2, iter_2_3 in ipairs(var_2_2) do
			local var_2_3 = lua_activity191_effect.configDict[iter_2_3]
			local var_2_4 = string.split(var_2_3.typeParam, "#")

			if var_2_3.type == Activity191Enum.EffectType.ExtraFetter then
				local var_2_5 = tonumber(var_2_4[1])
				local var_2_6 = arg_2_0.heroId2ExtraFetterMap[var_2_5]

				if not var_2_6 then
					var_2_6 = {}
					arg_2_0.heroId2ExtraFetterMap[var_2_5] = var_2_6
				end

				table.insert(var_2_6, var_2_4[2])
			end
		end
	end
end

function var_0_0.getRoleCo(arg_3_0, arg_3_1)
	if arg_3_0.robot then
		return Activity191Config.instance:getRoleCo(arg_3_1)
	else
		local var_3_0 = arg_3_0:getHeroInfo(arg_3_1, true)

		if var_3_0 then
			return Activity191Config.instance:getRoleCoByNativeId(arg_3_1, var_3_0.star)
		end
	end
end

function var_0_0.getHeroInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1 = tostring(arg_4_1)

	local var_4_0 = arg_4_0.wareHouseInfo.heroInfoMap[arg_4_1]

	if arg_4_2 and not var_4_0 then
		logError("enemyHeroInfo not found" .. arg_4_1)
	end

	return var_4_0
end

function var_0_0.getItemCo(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_0.robot then
		var_5_0 = arg_5_1
	else
		var_5_0 = arg_5_0:getItemInfo(arg_5_1).itemId
	end

	return Activity191Config.instance:getCollectionCo(var_5_0)
end

function var_0_0.getItemInfo(arg_6_0, arg_6_1)
	arg_6_1 = tostring(arg_6_1)

	local var_6_0 = arg_6_0.wareHouseInfo.itemInfoMap[arg_6_1]

	if var_6_0 then
		return var_6_0
	else
		logError("enemyItemInfo not found" .. arg_6_1)
	end
end

function var_0_0.getTeamFetterCntDic(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.heroMap) do
		if iter_7_1.heroId ~= 0 then
			local var_7_1 = arg_7_0:getRoleCo(iter_7_1.heroId)
			local var_7_2 = string.split(var_7_1.tag, "#")

			for iter_7_2, iter_7_3 in ipairs(var_7_2) do
				if var_7_0[iter_7_3] then
					var_7_0[iter_7_3] = var_7_0[iter_7_3] + 1
				else
					var_7_0[iter_7_3] = 1
				end
			end

			if iter_7_1.itemUid1 ~= 0 then
				local var_7_3 = arg_7_0:getItemCo(iter_7_1.itemUid1)
				local var_7_4 = not string.nilorempty(var_7_3.tag) and var_7_3.tag or var_7_3.tag2

				if not string.nilorempty(var_7_4) then
					local var_7_5 = string.split(var_7_3.tag, "#")

					for iter_7_4, iter_7_5 in ipairs(var_7_5) do
						if var_7_0[iter_7_5] then
							var_7_0[iter_7_5] = var_7_0[iter_7_5] + 1
						else
							var_7_0[iter_7_5] = 1
						end
					end
				end
			end

			local var_7_6 = arg_7_0.heroId2ExtraFetterMap[iter_7_1.heroId]

			if var_7_6 then
				for iter_7_6, iter_7_7 in ipairs(var_7_6) do
					if not var_7_0[iter_7_7] then
						var_7_0[iter_7_7] = 1
					else
						var_7_0[iter_7_7] = var_7_0[iter_7_7] + 1
					end
				end
			end
		end
	end

	for iter_7_8, iter_7_9 in pairs(arg_7_0.subHeroMap) do
		local var_7_7 = arg_7_0:getRoleCo(iter_7_9)
		local var_7_8 = string.split(var_7_7.tag, "#")

		for iter_7_10, iter_7_11 in ipairs(var_7_8) do
			if var_7_0[iter_7_11] then
				var_7_0[iter_7_11] = var_7_0[iter_7_11] + 1
			else
				var_7_0[iter_7_11] = 1
			end
		end

		local var_7_9 = arg_7_0.heroId2ExtraFetterMap[iter_7_9]

		if var_7_9 then
			for iter_7_12, iter_7_13 in ipairs(var_7_9) do
				if not var_7_0[iter_7_13] then
					var_7_0[iter_7_13] = 1
				else
					var_7_0[iter_7_13] = var_7_0[iter_7_13] + 1
				end
			end
		end
	end

	return var_7_0
end

function var_0_0.getFetterHeroList(arg_8_0, arg_8_1)
	local var_8_0 = Activity191Model.instance:getCurActId()
	local var_8_1 = {}
	local var_8_2 = lua_activity191_role.configList

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_3 = arg_8_0.robot and iter_8_1.id or iter_8_1.roleId

		if iter_8_1.activityId == var_8_0 and iter_8_1.star == 1 then
			local var_8_4 = 0
			local var_8_5 = 0

			if arg_8_0:isHeroInTeam(var_8_3) then
				var_8_5 = 2
			elseif not arg_8_0.robot and arg_8_0:getHeroInfo(var_8_3) then
				var_8_5 = 1
			end

			local var_8_6 = string.split(iter_8_1.tag, "#")

			if tabletool.indexOf(var_8_6, arg_8_1) then
				local var_8_7 = {
					config = iter_8_1,
					inBag = var_8_5,
					transfer = var_8_4
				}

				var_8_1[#var_8_1 + 1] = var_8_7
			else
				local var_8_8 = arg_8_0:getBattleHeroInfoInTeam(iter_8_1.roleId)

				if var_8_8 and var_8_8.itemUid1 ~= 0 then
					local var_8_9 = arg_8_0:getItemCo(var_8_8.itemUid1)

					if not string.nilorempty(var_8_9.tag) then
						local var_8_10 = string.split(var_8_9.tag, "#")

						if tabletool.indexOf(var_8_10, arg_8_1) then
							local var_8_11 = {
								inBag = 2,
								transfer = 1,
								config = iter_8_1
							}

							var_8_1[#var_8_1 + 1] = var_8_11
						end
					end
				end
			end

			local var_8_12 = arg_8_0.heroId2ExtraFetterMap[var_8_3]

			if var_8_12 and tabletool.indexOf(var_8_12, arg_8_1) then
				local var_8_13 = {
					transfer = 2,
					config = iter_8_1,
					inBag = var_8_5
				}

				var_8_1[#var_8_1 + 1] = var_8_13
			end
		end
	end

	table.sort(var_8_1, Activity191Helper.sortFetterHeroList)

	return var_8_1
end

function var_0_0.isHeroInTeam(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.heroMap) do
		if iter_9_1.heroId == arg_9_1 then
			return true
		end
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.subHeroMap) do
		if iter_9_3 == arg_9_1 then
			return true
		end
	end
end

function var_0_0.getBattleHeroInfoInTeam(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.heroMap) do
		if iter_10_1.heroId == arg_10_1 then
			return iter_10_1
		end
	end
end

return var_0_0
