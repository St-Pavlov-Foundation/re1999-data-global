module("modules.logic.versionactivity2_7.act191.model.Act191MatchMO", package.seeall)

local var_0_0 = pureTable("Act191MatchMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.robot = arg_1_1.robot
	arg_1_0.playerUid = arg_1_1.playerUid
	arg_1_0.heroMap = arg_1_1.heroMap
	arg_1_0.subHeroMap = arg_1_1.subHeroMap
	arg_1_0.enhanceSet = arg_1_1.enhanceSet
	arg_1_0.wareHouseInfo = arg_1_1.warehouseInfo
end

function var_0_0.getRoleCo(arg_2_0, arg_2_1)
	if arg_2_0.robot then
		return Activity191Config.instance:getRoleCo(arg_2_1)
	else
		local var_2_0 = arg_2_0:getHeroInfo(arg_2_1, true)

		if var_2_0 then
			return Activity191Config.instance:getRoleCoByNativeId(arg_2_1, var_2_0.star)
		end
	end
end

function var_0_0.getHeroInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1 = tostring(arg_3_1)

	local var_3_0 = arg_3_0.wareHouseInfo.heroInfoMap[arg_3_1]

	if arg_3_2 and not var_3_0 then
		logError("enemyHeroInfo not found" .. arg_3_1)
	end

	return var_3_0
end

function var_0_0.getItemCo(arg_4_0, arg_4_1)
	local var_4_0

	if arg_4_0.robot then
		var_4_0 = arg_4_1
	else
		var_4_0 = arg_4_0:getItemInfo(arg_4_1).itemId
	end

	return Activity191Config.instance:getCollectionCo(var_4_0)
end

function var_0_0.getItemInfo(arg_5_0, arg_5_1)
	arg_5_1 = tostring(arg_5_1)

	local var_5_0 = arg_5_0.wareHouseInfo.itemInfoMap[arg_5_1]

	if var_5_0 then
		return var_5_0
	else
		logError("enemyItemInfo not found" .. arg_5_1)
	end
end

function var_0_0.getTeamFetterCntDic(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.heroMap) do
		if iter_6_1.heroId ~= 0 then
			local var_6_1 = arg_6_0:getRoleCo(iter_6_1.heroId)
			local var_6_2 = string.split(var_6_1.tag, "#")

			for iter_6_2, iter_6_3 in ipairs(var_6_2) do
				if var_6_0[iter_6_3] then
					var_6_0[iter_6_3] = var_6_0[iter_6_3] + 1
				else
					var_6_0[iter_6_3] = 1
				end
			end

			if iter_6_1.itemUid1 ~= 0 then
				local var_6_3 = arg_6_0:getItemCo(iter_6_1.itemUid1)

				if not string.nilorempty(var_6_3.tag) then
					local var_6_4 = string.split(var_6_3.tag, "#")

					for iter_6_4, iter_6_5 in ipairs(var_6_4) do
						if var_6_0[iter_6_5] then
							var_6_0[iter_6_5] = var_6_0[iter_6_5] + 1
						else
							var_6_0[iter_6_5] = 1
						end
					end
				end
			end
		end
	end

	for iter_6_6, iter_6_7 in pairs(arg_6_0.subHeroMap) do
		local var_6_5 = arg_6_0:getRoleCo(iter_6_7)
		local var_6_6 = string.split(var_6_5.tag, "#")

		for iter_6_8, iter_6_9 in ipairs(var_6_6) do
			if var_6_0[iter_6_9] then
				var_6_0[iter_6_9] = var_6_0[iter_6_9] + 1
			else
				var_6_0[iter_6_9] = 1
			end
		end
	end

	return var_6_0
end

function var_0_0.getFetterHeroList(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = lua_activity191_role.configList

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.star == 1 then
			local var_7_2 = 0
			local var_7_3 = 0

			if arg_7_0.robot and arg_7_0:isHeroInTeam(iter_7_1.id) or not arg_7_0.robot and arg_7_0:isHeroInTeam(iter_7_1.roleId) then
				var_7_3 = 2
			elseif not arg_7_0.robot and arg_7_0:getHeroInfo(iter_7_1.roleId) then
				var_7_3 = 1
			end

			local var_7_4 = string.split(iter_7_1.tag, "#")

			if tabletool.indexOf(var_7_4, arg_7_1) then
				local var_7_5 = {
					config = iter_7_1,
					inBag = var_7_3,
					transfer = var_7_2
				}

				var_7_0[#var_7_0 + 1] = var_7_5
			else
				local var_7_6 = arg_7_0:getBattleHeroInfoInTeam(iter_7_1.roleId)

				if var_7_6 and var_7_6.itemUid1 ~= 0 then
					local var_7_7 = arg_7_0:getItemCo(var_7_6.itemUid1)

					if not string.nilorempty(var_7_7.tag) then
						local var_7_8 = string.split(var_7_7.tag, "#")

						if tabletool.indexOf(var_7_8, arg_7_1) then
							local var_7_9 = {
								inBag = 2,
								transfer = 1,
								config = iter_7_1
							}

							var_7_0[#var_7_0 + 1] = var_7_9
						end
					end
				end
			end
		end
	end

	table.sort(var_7_0, Activity191Helper.sortFetterHeroList)

	return var_7_0
end

function var_0_0.isHeroInTeam(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.heroMap) do
		if iter_8_1.heroId == arg_8_1 then
			return true
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0.subHeroMap) do
		if iter_8_3 == arg_8_1 then
			return true
		end
	end
end

function var_0_0.getBattleHeroInfoInTeam(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.heroMap) do
		if iter_9_1.heroId == arg_9_1 then
			return iter_9_1
		end
	end
end

return var_0_0
