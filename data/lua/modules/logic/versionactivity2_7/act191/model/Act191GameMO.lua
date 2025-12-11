module("modules.logic.versionactivity2_7.act191.model.Act191GameMO", package.seeall)

local var_0_0 = pureTable("Act191GameMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.actId = Activity191Model.instance:getCurActId()
	arg_1_0.coin = arg_1_1.coin
	arg_1_0.curStage = arg_1_1.curStage
	arg_1_0.curNode = arg_1_1.curNode
	arg_1_0.nodeInfo = arg_1_1.nodeInfo
	arg_1_0.curTeamIndex = 1
	arg_1_0.teamInfo = arg_1_1.teamInfo

	arg_1_0:updateWareHouseInfo(arg_1_1.warehouseInfo)

	arg_1_0.score = arg_1_1.score
	arg_1_0.state = arg_1_1.state
	arg_1_0.rank = arg_1_1.rank
	arg_1_0.rankMark = 0
	arg_1_0.recordInfo = arg_1_1.recordInfo
	arg_1_0.initBuildInfo = arg_1_1.initBuildInfo
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_0.curNode ~= arg_2_1.curNode then
		arg_2_0.nodeChange = true
	end

	arg_2_0.coin = arg_2_1.coin
	arg_2_0.curStage = arg_2_1.curStage
	arg_2_0.curNode = arg_2_1.curNode
	arg_2_0.nodeInfo = arg_2_1.nodeInfo
	arg_2_0.teamInfo = arg_2_1.teamInfo

	arg_2_0:updateWareHouseInfo(arg_2_1.warehouseInfo)

	arg_2_0.score = arg_2_1.score
	arg_2_0.state = arg_2_1.state

	arg_2_0:updateRank(arg_2_1.rank)

	arg_2_0.recordInfo = arg_2_1.recordInfo
	arg_2_0.initBuildInfo = arg_2_1.initBuildInfo
end

function var_0_0.updateRank(arg_3_0, arg_3_1)
	arg_3_0.rankMark = arg_3_1 > arg_3_0.rank and 1 or arg_3_1 < arg_3_0.rank and -1 or 0
	arg_3_0.rank = arg_3_1
end

function var_0_0.updateWareHouseInfo(arg_4_0, arg_4_1)
	arg_4_0.warehouseInfo = arg_4_1
	arg_4_0.heroId2ExtraFetterMap = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.enhanceId) do
		local var_4_0 = Activity191Config.instance:getEnhanceCo(arg_4_0.actId, iter_4_1)
		local var_4_1 = string.splitToNumber(var_4_0.effects, "|")

		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			local var_4_2 = lua_activity191_effect.configDict[iter_4_3]
			local var_4_3 = string.split(var_4_2.typeParam, "#")

			if var_4_2.type == Activity191Enum.EffectType.ExtraFetter then
				local var_4_4 = tonumber(var_4_3[1])
				local var_4_5 = arg_4_0.heroId2ExtraFetterMap[var_4_4]

				if not var_4_5 then
					var_4_5 = {}
					arg_4_0.heroId2ExtraFetterMap[var_4_4] = var_4_5
				end

				table.insert(var_4_5, var_4_3[2])
			end
		end
	end
end

function var_0_0.updateTeamInfo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.curTeamIndex = arg_5_1

	local var_5_0 = false

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.teamInfo) do
		if iter_5_1.index == arg_5_1 then
			arg_5_0.teamInfo[iter_5_0] = arg_5_2
			var_5_0 = true

			break
		end
	end

	if not var_5_0 then
		table.insert(arg_5_0.teamInfo, arg_5_2)
	end
end

function var_0_0.updateCurNodeInfo(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0.nodeInfo do
		if arg_6_0.nodeInfo[iter_6_0].nodeId == arg_6_0.curNode then
			arg_6_0.nodeInfo[iter_6_0] = arg_6_1
		end
	end
end

function var_0_0.getStageNodeInfoList(arg_7_0, arg_7_1)
	local var_7_0 = {}

	arg_7_1 = arg_7_1 or arg_7_0.curStage

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.nodeInfo) do
		if iter_7_1.stage == arg_7_1 then
			var_7_0[#var_7_0 + 1] = iter_7_1
		end
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0.nodeId < arg_8_1.nodeId
	end)

	return var_7_0
end

function var_0_0.getNodeInfoById(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.nodeInfo) do
		if iter_9_1.nodeId == arg_9_1 then
			return iter_9_1
		end
	end
end

function var_0_0.getNodeDetailMo(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or arg_10_0.curNode

	local var_10_0 = arg_10_0:getNodeInfoById(arg_10_1)

	if not var_10_0 or string.nilorempty(var_10_0.nodeStr) then
		if not arg_10_2 then
			logError("check select node" .. arg_10_1)
		end

		return
	end

	local var_10_1 = Act191NodeDetailMO.New()

	var_10_1:init(var_10_0.nodeStr)

	return var_10_1
end

function var_0_0.getTeamInfo(arg_11_0)
	local var_11_0 = Activity191Helper.matchKeyInArray(arg_11_0.teamInfo, arg_11_0.curTeamIndex)

	if not var_11_0 then
		var_11_0 = Activity191Module_pb.Act191BattleTeamInfo()
		var_11_0.index = arg_11_0.curTeamIndex
		var_11_0.auto = false

		table.insert(arg_11_0.teamInfo, var_11_0)
	end

	return var_11_0
end

function var_0_0.getPreviewFetterCntDic(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = arg_12_0:getTeamInfo()

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		local var_12_2 = arg_12_0:getHeroInfoInWarehouse(iter_12_1)
		local var_12_3 = Activity191Config.instance:getRoleCoByNativeId(iter_12_1, var_12_2.star)
		local var_12_4 = string.split(var_12_3.tag, "#")

		for iter_12_2, iter_12_3 in ipairs(var_12_4) do
			if not var_12_0[iter_12_3] then
				var_12_0[iter_12_3] = 1
			else
				var_12_0[iter_12_3] = var_12_0[iter_12_3] + 1
			end
		end

		if iter_12_0 <= 4 then
			local var_12_5 = Activity191Helper.matchKeyInArray(var_12_1.battleHeroInfo, iter_12_0)

			if var_12_5 then
				local var_12_6 = var_12_5.itemUid1

				if var_12_6 ~= 0 then
					local var_12_7 = arg_12_0:getItemInfoInWarehouse(var_12_6)
					local var_12_8 = Activity191Config.instance:getCollectionCo(var_12_7.itemId)
					local var_12_9 = not string.nilorempty(var_12_8.tag) and var_12_8.tag or var_12_8.tag2

					if not string.nilorempty(var_12_9) then
						local var_12_10 = string.split(var_12_9, "#")

						for iter_12_4, iter_12_5 in ipairs(var_12_10) do
							if not var_12_0[iter_12_5] then
								var_12_0[iter_12_5] = 1
							else
								var_12_0[iter_12_5] = var_12_0[iter_12_5] + 1
							end
						end
					end
				end
			end
		end

		local var_12_11 = arg_12_0.heroId2ExtraFetterMap[iter_12_1]

		if var_12_11 then
			for iter_12_6, iter_12_7 in ipairs(var_12_11) do
				if not var_12_0[iter_12_7] then
					var_12_0[iter_12_7] = 1
				else
					var_12_0[iter_12_7] = var_12_0[iter_12_7] + 1
				end
			end
		end
	end

	return var_12_0
end

function var_0_0.getTeamFetterCntDic(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = arg_13_0:getTeamInfo()

	for iter_13_0, iter_13_1 in ipairs(var_13_1.battleHeroInfo) do
		if iter_13_1.heroId ~= 0 then
			local var_13_2 = arg_13_0:getHeroInfoInWarehouse(iter_13_1.heroId)
			local var_13_3 = Activity191Config.instance:getRoleCoByNativeId(iter_13_1.heroId, var_13_2.star)
			local var_13_4 = string.split(var_13_3.tag, "#")

			for iter_13_2, iter_13_3 in ipairs(var_13_4) do
				if var_13_0[iter_13_3] then
					var_13_0[iter_13_3] = var_13_0[iter_13_3] + 1
				else
					var_13_0[iter_13_3] = 1
				end
			end

			if iter_13_1.itemUid1 ~= 0 then
				local var_13_5 = arg_13_0:getItemInfoInWarehouse(iter_13_1.itemUid1)
				local var_13_6 = Activity191Config.instance:getCollectionCo(var_13_5.itemId)
				local var_13_7 = not string.nilorempty(var_13_6.tag) and var_13_6.tag or var_13_6.tag2

				if not string.nilorempty(var_13_7) then
					local var_13_8 = string.split(var_13_7, "#")

					for iter_13_4, iter_13_5 in ipairs(var_13_8) do
						if var_13_0[iter_13_5] then
							var_13_0[iter_13_5] = var_13_0[iter_13_5] + 1
						else
							var_13_0[iter_13_5] = 1
						end
					end
				end
			end

			local var_13_9 = arg_13_0.heroId2ExtraFetterMap[iter_13_1.heroId]

			if var_13_9 then
				for iter_13_6, iter_13_7 in ipairs(var_13_9) do
					if not var_13_0[iter_13_7] then
						var_13_0[iter_13_7] = 1
					else
						var_13_0[iter_13_7] = var_13_0[iter_13_7] + 1
					end
				end
			end
		end
	end

	for iter_13_8, iter_13_9 in ipairs(var_13_1.subHeroInfo) do
		local var_13_10 = arg_13_0:getHeroInfoInWarehouse(iter_13_9.heroId)
		local var_13_11 = Activity191Config.instance:getRoleCoByNativeId(iter_13_9.heroId, var_13_10.star)
		local var_13_12 = string.split(var_13_11.tag, "#")

		for iter_13_10, iter_13_11 in ipairs(var_13_12) do
			if var_13_0[iter_13_11] then
				var_13_0[iter_13_11] = var_13_0[iter_13_11] + 1
			else
				var_13_0[iter_13_11] = 1
			end
		end

		local var_13_13 = arg_13_0.heroId2ExtraFetterMap[iter_13_9.heroId]

		if var_13_13 then
			for iter_13_12, iter_13_13 in ipairs(var_13_13) do
				if not var_13_0[iter_13_13] then
					var_13_0[iter_13_13] = 1
				else
					var_13_0[iter_13_13] = var_13_0[iter_13_13] + 1
				end
			end
		end
	end

	return var_13_0
end

function var_0_0.getFetterHeroList(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = lua_activity191_role.configList

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = iter_14_1.roleId

		if iter_14_1.activityId == arg_14_0.actId and iter_14_1.star == 1 then
			local var_14_3 = 0
			local var_14_4 = 0

			if arg_14_0:isHeroInTeam(var_14_2) then
				var_14_4 = 2
			elseif arg_14_0:getHeroInfoInWarehouse(var_14_2, true) then
				var_14_4 = 1
			end

			local var_14_5 = string.split(iter_14_1.tag, "#")

			if tabletool.indexOf(var_14_5, arg_14_1) then
				local var_14_6 = {
					config = iter_14_1,
					inBag = var_14_4,
					transfer = var_14_3
				}

				var_14_0[#var_14_0 + 1] = var_14_6
			else
				local var_14_7 = arg_14_0:getBattleHeroInfoInTeam(var_14_2)

				if var_14_7 and var_14_7.itemUid1 ~= 0 then
					local var_14_8 = arg_14_0:getItemInfoInWarehouse(var_14_7.itemUid1)
					local var_14_9 = Activity191Config.instance:getCollectionCo(var_14_8.itemId)

					if not string.nilorempty(var_14_9.tag) then
						local var_14_10 = string.split(var_14_9.tag, "#")

						if tabletool.indexOf(var_14_10, arg_14_1) then
							local var_14_11 = {
								inBag = 2,
								transfer = 1,
								config = iter_14_1
							}

							var_14_0[#var_14_0 + 1] = var_14_11
						end
					end
				end
			end

			local var_14_12 = arg_14_0.heroId2ExtraFetterMap[var_14_2]

			if var_14_12 and tabletool.indexOf(var_14_12, arg_14_1) then
				local var_14_13 = {
					transfer = 2,
					config = iter_14_1,
					inBag = var_14_4
				}

				var_14_0[#var_14_0 + 1] = var_14_13
			end
		end
	end

	table.sort(var_14_0, Activity191Helper.sortFetterHeroList)

	return var_14_0
end

function var_0_0.setAutoFight(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getTeamInfo()

	var_15_0.auto = arg_15_1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_15_0.actId, arg_15_0.curTeamIndex, var_15_0)
end

function var_0_0.getHeroInfoInWarehouse(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.warehouseInfo.hero) do
		if arg_16_1 == iter_16_1.heroId then
			var_16_0 = iter_16_1

			break
		end
	end

	if not arg_16_2 and not var_16_0 then
		logError(string.format("heroId : %s, heroInfo not found", arg_16_1))
	end

	return var_16_0
end

function var_0_0.getBattleHeroInfoInTeam(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getTeamInfo()

	for iter_17_0, iter_17_1 in ipairs(var_17_0.battleHeroInfo) do
		if iter_17_1.heroId == arg_17_1 then
			return iter_17_1
		end
	end
end

function var_0_0.getSubHeroInfoInTeam(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getTeamInfo()

	for iter_18_0, iter_18_1 in ipairs(var_18_0.subHeroInfo) do
		if iter_18_1.heroId == arg_18_1 then
			return iter_18_1
		end
	end
end

function var_0_0.isHeroInTeam(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getTeamInfo()

	for iter_19_0, iter_19_1 in ipairs(var_19_0.battleHeroInfo) do
		if iter_19_1.heroId == arg_19_1 then
			if arg_19_2 then
				iter_19_1.heroId = 0
			end

			return true
		end
	end

	for iter_19_2, iter_19_3 in ipairs(var_19_0.subHeroInfo) do
		if iter_19_3.heroId == arg_19_1 then
			if arg_19_2 then
				iter_19_3.heroId = 0
			end

			return true
		end
	end
end

function var_0_0.teamHasMainHero(arg_20_0)
	local var_20_0 = arg_20_0:getTeamInfo()

	for iter_20_0, iter_20_1 in ipairs(var_20_0.battleHeroInfo) do
		if iter_20_1.heroId ~= 0 then
			return true
		end
	end

	return false
end

function var_0_0.saveQuickGroupInfo(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getTeamInfo()

	for iter_21_0 = 1, 4 do
		Activity191Helper.getWithBuildBattleHeroInfo(var_21_0.battleHeroInfo, iter_21_0).heroId = arg_21_1[iter_21_0] or 0
		Activity191Helper.getWithBuildSubHeroInfo(var_21_0.subHeroInfo, iter_21_0).heroId = arg_21_1[iter_21_0 + 4] or 0
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_21_0.actId, arg_21_0.curTeamIndex, var_21_0)
end

function var_0_0.replaceHeroInTeam(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:isHeroInTeam(arg_22_1, true)

	local var_22_0 = arg_22_0:getTeamInfo()

	if arg_22_2 <= 4 then
		Activity191Helper.getWithBuildBattleHeroInfo(var_22_0.battleHeroInfo, arg_22_2).heroId = arg_22_1
	else
		Activity191Helper.getWithBuildSubHeroInfo(var_22_0.subHeroInfo, arg_22_2 - 4).heroId = arg_22_1
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_22_0.actId, arg_22_0.curTeamIndex, var_22_0)
end

function var_0_0.removeHeroInTeam(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getTeamInfo()

	for iter_23_0, iter_23_1 in ipairs(var_23_0.battleHeroInfo) do
		if iter_23_1.heroId == arg_23_1 then
			iter_23_1.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_23_0.actId, arg_23_0.curTeamIndex, var_23_0)

			return
		end
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_0.subHeroInfo) do
		if iter_23_3.heroId == arg_23_1 then
			iter_23_3.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_23_0.actId, arg_23_0.curTeamIndex, var_23_0)

			return
		end
	end
end

function var_0_0.exchangeHero(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:getTeamInfo()
	local var_24_1
	local var_24_2

	if arg_24_1 <= 4 then
		var_24_1 = Activity191Helper.getWithBuildBattleHeroInfo(var_24_0.battleHeroInfo, arg_24_1)
	else
		var_24_1 = Activity191Helper.getWithBuildSubHeroInfo(var_24_0.subHeroInfo, arg_24_1 - 4)
	end

	if arg_24_2 <= 4 then
		var_24_2 = Activity191Helper.getWithBuildBattleHeroInfo(var_24_0.battleHeroInfo, arg_24_2)
	else
		var_24_2 = Activity191Helper.getWithBuildSubHeroInfo(var_24_0.subHeroInfo, arg_24_2 - 4)
	end

	var_24_2.heroId, var_24_1.heroId = var_24_1.heroId, var_24_2.heroId

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_24_0.actId, arg_24_0.curTeamIndex, var_24_0)
end

function var_0_0.getItemInfoInWarehouse(arg_25_0, arg_25_1)
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.warehouseInfo.item) do
		if iter_25_1.uid == arg_25_1 then
			var_25_0 = iter_25_1

			break
		end
	end

	if not var_25_0 then
		logError(string.format("itemUid : %s, itemInfo not found", arg_25_1))
	end

	return var_25_0
end

function var_0_0.isItemInTeam(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getTeamInfo()

	for iter_26_0, iter_26_1 in ipairs(var_26_0.battleHeroInfo) do
		if iter_26_1.itemUid1 == arg_26_1 then
			return true
		end
	end
end

function var_0_0.replaceItemInTeam(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0:removeItemInTeam(arg_27_1)

	local var_27_0 = arg_27_0:getTeamInfo()

	Activity191Helper.getWithBuildBattleHeroInfo(var_27_0.battleHeroInfo, arg_27_2).itemUid1 = arg_27_1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_27_0.actId, arg_27_0.curTeamIndex, var_27_0)
end

function var_0_0.removeItemInTeam(arg_28_0, arg_28_1)
	local var_28_0 = false
	local var_28_1 = arg_28_0:getTeamInfo()

	for iter_28_0, iter_28_1 in ipairs(var_28_1.battleHeroInfo) do
		if iter_28_1.itemUid1 == arg_28_1 then
			iter_28_1.itemUid1 = 0
			var_28_0 = true
		end
	end

	if var_28_0 then
		Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_28_0.actId, arg_28_0.curTeamIndex, var_28_1)
	end
end

function var_0_0.exchangeItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:getTeamInfo()
	local var_29_1
	local var_29_2
	local var_29_3 = Activity191Helper.getWithBuildBattleHeroInfo(var_29_0.battleHeroInfo, arg_29_1)
	local var_29_4 = Activity191Helper.getWithBuildBattleHeroInfo(var_29_0.battleHeroInfo, arg_29_2)

	var_29_4.itemUid1, var_29_3.itemUid1 = var_29_3.itemUid1, var_29_4.itemUid1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_29_0.actId, arg_29_0.curTeamIndex, var_29_0)
end

function var_0_0.isItemEnhance(arg_30_0, arg_30_1)
	if tabletool.indexOf(arg_30_0.enhanceItemList, arg_30_1) then
		return true
	end

	return false
end

function var_0_0.autoFill(arg_31_0)
	local var_31_0 = arg_31_0:getTeamInfo()
	local var_31_1 = arg_31_0.warehouseInfo.item

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.warehouseInfo.hero) do
		if iter_31_0 <= 4 then
			local var_31_2 = Activity191Helper.getWithBuildBattleHeroInfo(var_31_0.battleHeroInfo, iter_31_0)

			var_31_2.heroId = iter_31_1.heroId

			if var_31_1[iter_31_0] then
				var_31_2.itemUid1 = var_31_1[iter_31_0].uid
			end
		elseif iter_31_0 <= 8 then
			Activity191Helper.getWithBuildSubHeroInfo(var_31_0.subHeroInfo, iter_31_0 - 4).heroId = iter_31_1.heroId
		end
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_31_0.actId, 1, var_31_0)
end

function var_0_0.getAct191Effect(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.warehouseInfo.effect) do
		if iter_32_1.id == arg_32_1 then
			return iter_32_1
		end
	end
end

function var_0_0.getBestFetterTag(arg_33_0)
	local var_33_0 = arg_33_0:getTeamFetterCntDic()
	local var_33_1 = Activity191Helper.getActiveFetterInfoList(var_33_0)

	if next(var_33_1) then
		return var_33_1[1].config.tag
	end
end

function var_0_0.clearRankMark(arg_34_0)
	arg_34_0.rankMark = 0
end

function var_0_0.getFetterActiveLevel(arg_35_0, arg_35_1)
	local var_35_0 = 0
	local var_35_1 = arg_35_0:getTeamFetterCntDic()[arg_35_1]

	if var_35_1 then
		local var_35_2 = Activity191Config.instance:getRelationCo(arg_35_1, 1)

		if var_35_1 >= var_35_2.activeNum and var_35_0 < var_35_2.level then
			var_35_0 = var_35_2.level
		end
	end

	return var_35_0
end

function var_0_0.getActiveBossId(arg_36_0)
	local var_36_0 = "remodeling"
	local var_36_1
	local var_36_2 = arg_36_0:getFetterActiveLevel(var_36_0)
	local var_36_3 = arg_36_0.recordInfo.remodelingValue
	local var_36_4 = Activity191Config.instance:getBossCfgListByTag(var_36_0)

	for iter_36_0, iter_36_1 in ipairs(var_36_4) do
		local var_36_5 = string.splitToNumber(iter_36_1.condition, "#")

		if var_36_2 >= var_36_5[1] and var_36_3 >= var_36_5[2] then
			var_36_1 = iter_36_1.bossId

			break
		end
	end

	return var_36_1
end

function var_0_0.getActiveSummonIdList(arg_37_0)
	local var_37_0 = {}
	local var_37_1 = arg_37_0:getActiveBossId()

	if var_37_1 then
		var_37_0[#var_37_0 + 1] = var_37_1
	end

	local var_37_2 = arg_37_0:getTeamFetterCntDic()
	local var_37_3 = Activity191Helper.getActiveFetterInfoList(var_37_2)

	for iter_37_0, iter_37_1 in ipairs(var_37_3) do
		local var_37_4 = iter_37_1.config

		if var_37_4.summon ~= 0 then
			var_37_0[#var_37_0 + 1] = var_37_4.summon
		end
	end

	return var_37_0
end

function var_0_0.getAttrUpDicByRoleId(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.warehouseInfo.effect) do
		if iter_38_1.type == Activity191Enum.EffectType.AttrEffect then
			local var_38_2 = string.splitToNumber(iter_38_1.param, "#")

			if tabletool.indexOf(var_38_2, arg_38_1) then
				local var_38_3 = lua_activity191_effect.configDict[iter_38_1.id]
				local var_38_4 = var_38_3.tag

				if not string.nilorempty(var_38_4) and not tabletool.indexOf(var_38_1, var_38_4) then
					var_38_1[#var_38_1 + 1] = var_38_4
				end

				local var_38_5 = string.split(var_38_3.typeParam, "#")[2]
				local var_38_6 = GameUtil.splitString2(var_38_5, true, "|", ",")

				for iter_38_2 = 1, #var_38_6 do
					local var_38_7 = var_38_6[iter_38_2][1]
					local var_38_8 = var_38_6[iter_38_2][2]

					if not var_38_0[var_38_7] then
						var_38_0[var_38_7] = 0
					end

					var_38_0[var_38_7] = var_38_0[var_38_7] + var_38_8
				end
			end
		end
	end

	return var_38_0, var_38_1
end

function var_0_0.getBossAttr(arg_39_0)
	local var_39_0 = 0
	local var_39_1 = 0
	local var_39_2 = 0
	local var_39_3 = arg_39_0:getTeamInfo()

	for iter_39_0, iter_39_1 in ipairs(var_39_3.battleHeroInfo) do
		if iter_39_1.heroId and iter_39_1.heroId ~= 0 then
			var_39_2 = var_39_2 + 1

			local var_39_4 = Activity191Config.instance:getRoleCoByNativeId(iter_39_1.heroId, 1)
			local var_39_5 = lua_activity191_template.configDict[var_39_4.id]
			local var_39_6 = arg_39_0:getAttrUpDicByRoleId(iter_39_1.heroId)
			local var_39_7 = var_39_6[Activity191Enum.AttrIdList[1]] or 0
			local var_39_8 = var_39_6[Activity191Enum.AttrIdList[3]] or 0

			var_39_0 = var_39_0 + var_39_5.attack * (1 + var_39_7 / 1000)
			var_39_1 = var_39_1 + var_39_5.technic * (1 + var_39_8 / 1000)
		end
	end

	local var_39_9 = Mathf.Round(var_39_0 / var_39_2)
	local var_39_10 = Mathf.Round(var_39_1 / var_39_2)

	return var_39_9, var_39_10
end

function var_0_0.getRelationDesc(arg_40_0, arg_40_1)
	if arg_40_1.tag == "remodeling" then
		local var_40_0 = arg_40_0:getActiveBossId()

		if var_40_0 then
			local var_40_1 = lua_activity191_assist_boss.configDict[var_40_0]

			return GameUtil.getSubPlaceholderLuaLangTwoParam(arg_40_1.desc, arg_40_0.recordInfo.remodelingValue, var_40_1.name)
		else
			local var_40_2 = 0
			local var_40_3 = string.gsub(arg_40_1.desc, "%b()", function(arg_41_0)
				var_40_2 = var_40_2 + 1

				return var_40_2 == 2 and "" or arg_41_0
			end)

			return GameUtil.getSubPlaceholderLuaLangOneParam(var_40_3, arg_40_0.recordInfo.remodelingValue)
		end
	end

	local var_40_4 = arg_40_1.effects

	if not string.nilorempty(var_40_4) then
		local var_40_5 = string.splitToNumber(var_40_4, "|")

		for iter_40_0, iter_40_1 in ipairs(var_40_5) do
			local var_40_6 = arg_40_0:getAct191Effect(iter_40_1)

			if var_40_6 and (not var_40_6["end"] or iter_40_0 == #var_40_5) then
				return GameUtil.getSubPlaceholderLuaLangOneParam(arg_40_1.desc, string.format("%d/%d", var_40_6.count, var_40_6.needCount))
			end
		end
	end

	return string.gsub(arg_40_1.desc, "（(.-)）", "")
end

function var_0_0.getStoneId(arg_42_0, arg_42_1)
	for iter_42_0, iter_42_1 in ipairs(arg_42_0.recordInfo.heroFacets) do
		if iter_42_1.roleId == arg_42_1.roleId then
			return iter_42_1.facetsId
		end
	end

	if not string.nilorempty(arg_42_1.facetsId) then
		return string.splitToNumber(arg_42_1.facetsId, "#")[1]
	end
end

function var_0_0.updateStoneId(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0

	for iter_43_0, iter_43_1 in ipairs(arg_43_0.recordInfo.heroFacets) do
		if iter_43_1.roleId == arg_43_1 then
			var_43_0 = iter_43_1

			break
		end
	end

	if not var_43_0 then
		var_43_0 = Activity191Module_pb.Act191HeroFacetsIdInfo()
		var_43_0.roleId = arg_43_1

		table.insert(arg_43_0.recordInfo.heroFacets, var_43_0)
	end

	var_43_0.facetsId = arg_43_2
end

return var_0_0
