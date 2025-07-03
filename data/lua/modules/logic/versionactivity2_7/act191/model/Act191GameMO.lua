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
	arg_2_0.rank = arg_2_1.rank
end

function var_0_0.updateWareHouseInfo(arg_3_0, arg_3_1)
	if not arg_3_0.destinyHeroMap or arg_3_0.warehouseInfo and #arg_3_0.warehouseInfo.enhanceId ~= #arg_3_1.enhanceId then
		arg_3_0.destinyHeroMap = {}
		arg_3_0.enhanceItemList = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_1.enhanceId) do
			local var_3_0 = Activity191Config.instance:getEnhanceCo(arg_3_0.actId, iter_3_1)
			local var_3_1 = string.splitToNumber(var_3_0.effects, "|")[1]
			local var_3_2 = lua_activity191_effect.configDict[var_3_1]
			local var_3_3 = string.splitToNumber(var_3_2.typeParam, "#")

			if var_3_2.type == Activity191Enum.EffectType.EnhanceHero then
				arg_3_0.destinyHeroMap[var_3_3[1]] = var_3_3[2]
			elseif var_3_2.type == Activity191Enum.EffectType.EnhanceItem then
				arg_3_0.enhanceItemList[#arg_3_0.enhanceItemList + 1] = var_3_3[1]
			end
		end
	end

	arg_3_0.warehouseInfo = arg_3_1
end

function var_0_0.updateTeamInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.curTeamIndex = arg_4_1

	local var_4_0 = false

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.teamInfo) do
		if iter_4_1.index == arg_4_1 then
			arg_4_0.teamInfo[iter_4_0] = arg_4_2
			var_4_0 = true

			break
		end
	end

	if not var_4_0 then
		table.insert(arg_4_0.teamInfo, arg_4_2)
	end
end

function var_0_0.updateCurNodeInfo(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_0.nodeInfo do
		if arg_5_0.nodeInfo[iter_5_0].nodeId == arg_5_0.curNode then
			arg_5_0.nodeInfo[iter_5_0] = arg_5_1
		end
	end
end

function var_0_0.getStageNodeInfoList(arg_6_0, arg_6_1)
	local var_6_0 = {}

	arg_6_1 = arg_6_1 or arg_6_0.curStage

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.nodeInfo) do
		if iter_6_1.stage == arg_6_1 then
			var_6_0[#var_6_0 + 1] = iter_6_1
		end
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.nodeId < arg_7_1.nodeId
	end)

	return var_6_0
end

function var_0_0.getNodeInfoById(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.nodeInfo) do
		if iter_8_1.nodeId == arg_8_1 then
			return iter_8_1
		end
	end
end

function var_0_0.getNodeDetailMo(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1 = arg_9_1 or arg_9_0.curNode

	local var_9_0 = Activity191Helper.matchKeyInArray(arg_9_0.nodeInfo, arg_9_1, "nodeId")

	if not var_9_0 or string.nilorempty(var_9_0.nodeStr) then
		if arg_9_2 then
			return
		end

		logError("check select node" .. arg_9_1)

		return
	end

	local var_9_1 = Act191NodeDetailMO.New()

	var_9_1:init(var_9_0.nodeStr)

	return var_9_1
end

function var_0_0.getTeamInfo(arg_10_0)
	local var_10_0 = Activity191Helper.matchKeyInArray(arg_10_0.teamInfo, arg_10_0.curTeamIndex)

	if not var_10_0 then
		var_10_0 = Activity191Module_pb.Act191BattleTeamInfo()
		var_10_0.index = arg_10_0.curTeamIndex
		var_10_0.auto = false

		table.insert(arg_10_0.teamInfo, var_10_0)
	end

	return var_10_0
end

function var_0_0.getPreviewFetterCntDic(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = arg_11_0:getTeamInfo()

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_2 = arg_11_0:getHeroInfoInWarehouse(iter_11_1)
		local var_11_3 = Activity191Config.instance:getRoleCoByNativeId(iter_11_1, var_11_2.star)
		local var_11_4 = string.split(var_11_3.tag, "#")

		for iter_11_2, iter_11_3 in ipairs(var_11_4) do
			if not var_11_0[iter_11_3] then
				var_11_0[iter_11_3] = 1
			else
				var_11_0[iter_11_3] = var_11_0[iter_11_3] + 1
			end
		end

		if iter_11_0 <= 4 then
			local var_11_5 = Activity191Helper.matchKeyInArray(var_11_1.battleHeroInfo, iter_11_0)

			if var_11_5 then
				local var_11_6 = var_11_5.itemUid1

				if var_11_6 ~= 0 then
					local var_11_7 = arg_11_0:getItemInfoInWarehouse(var_11_6)
					local var_11_8 = Activity191Config.instance:getCollectionCo(var_11_7.itemId)

					if not string.nilorempty(var_11_8.tag) then
						local var_11_9 = string.split(var_11_8.tag, "#")

						for iter_11_4, iter_11_5 in ipairs(var_11_9) do
							if not var_11_0[iter_11_5] then
								var_11_0[iter_11_5] = 1
							else
								var_11_0[iter_11_5] = var_11_0[iter_11_5] + 1
							end
						end
					end
				end
			end
		end
	end

	return var_11_0
end

function var_0_0.getTeamFetterCntDic(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = arg_12_0:getTeamInfo()

	for iter_12_0, iter_12_1 in ipairs(var_12_1.battleHeroInfo) do
		if iter_12_1.heroId ~= 0 then
			local var_12_2 = arg_12_0:getHeroInfoInWarehouse(iter_12_1.heroId)
			local var_12_3 = Activity191Config.instance:getRoleCoByNativeId(iter_12_1.heroId, var_12_2.star)
			local var_12_4 = string.split(var_12_3.tag, "#")

			for iter_12_2, iter_12_3 in ipairs(var_12_4) do
				if var_12_0[iter_12_3] then
					var_12_0[iter_12_3] = var_12_0[iter_12_3] + 1
				else
					var_12_0[iter_12_3] = 1
				end
			end

			if iter_12_1.itemUid1 ~= 0 then
				local var_12_5 = arg_12_0:getItemInfoInWarehouse(iter_12_1.itemUid1)
				local var_12_6 = Activity191Config.instance:getCollectionCo(var_12_5.itemId)

				if not string.nilorempty(var_12_6.tag) then
					local var_12_7 = string.split(var_12_6.tag, "#")

					for iter_12_4, iter_12_5 in ipairs(var_12_7) do
						if var_12_0[iter_12_5] then
							var_12_0[iter_12_5] = var_12_0[iter_12_5] + 1
						else
							var_12_0[iter_12_5] = 1
						end
					end
				end
			end
		end
	end

	for iter_12_6, iter_12_7 in ipairs(var_12_1.subHeroInfo) do
		local var_12_8 = arg_12_0:getHeroInfoInWarehouse(iter_12_7.heroId)
		local var_12_9 = Activity191Config.instance:getRoleCoByNativeId(iter_12_7.heroId, var_12_8.star)
		local var_12_10 = string.split(var_12_9.tag, "#")

		for iter_12_8, iter_12_9 in ipairs(var_12_10) do
			if var_12_0[iter_12_9] then
				var_12_0[iter_12_9] = var_12_0[iter_12_9] + 1
			else
				var_12_0[iter_12_9] = 1
			end
		end
	end

	return var_12_0
end

function var_0_0.getFetterHeroList(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = lua_activity191_role.configList

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if iter_13_1.star == 1 then
			local var_13_2 = 0
			local var_13_3 = 0

			if arg_13_0:isHeroInTeam(iter_13_1.roleId) then
				var_13_3 = 2
			elseif arg_13_0:getHeroInfoInWarehouse(iter_13_1.roleId, true) then
				var_13_3 = 1
			end

			local var_13_4 = string.split(iter_13_1.tag, "#")

			if tabletool.indexOf(var_13_4, arg_13_1) then
				local var_13_5 = {
					config = iter_13_1,
					inBag = var_13_3,
					transfer = var_13_2
				}

				var_13_0[#var_13_0 + 1] = var_13_5
			else
				local var_13_6 = arg_13_0:getBattleHeroInfoInTeam(iter_13_1.roleId)

				if var_13_6 and var_13_6.itemUid1 ~= 0 then
					local var_13_7 = arg_13_0:getItemInfoInWarehouse(var_13_6.itemUid1)
					local var_13_8 = Activity191Config.instance:getCollectionCo(var_13_7.itemId)

					if not string.nilorempty(var_13_8.tag) then
						local var_13_9 = string.split(var_13_8.tag, "#")

						if tabletool.indexOf(var_13_9, arg_13_1) then
							local var_13_10 = {
								inBag = 2,
								transfer = 1,
								config = iter_13_1
							}

							var_13_0[#var_13_0 + 1] = var_13_10
						end
					end
				end
			end
		end
	end

	table.sort(var_13_0, Activity191Helper.sortFetterHeroList)

	return var_13_0
end

function var_0_0.setAutoFight(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getTeamInfo()

	var_14_0.auto = arg_14_1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_14_0.actId, arg_14_0.curTeamIndex, var_14_0)
end

function var_0_0.getHeroInfoInWarehouse(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.warehouseInfo.hero) do
		if arg_15_1 == iter_15_1.heroId then
			var_15_0 = iter_15_1

			break
		end
	end

	if not arg_15_2 and not var_15_0 then
		logError(string.format("heroId : %s, heroInfo not found", arg_15_1))
	end

	return var_15_0
end

function var_0_0.getBattleHeroInfoInTeam(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getTeamInfo()

	for iter_16_0, iter_16_1 in ipairs(var_16_0.battleHeroInfo) do
		if iter_16_1.heroId == arg_16_1 then
			return iter_16_1
		end
	end
end

function var_0_0.getSubHeroInfoInTeam(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getTeamInfo()

	for iter_17_0, iter_17_1 in ipairs(var_17_0.subHeroInfo) do
		if iter_17_1.heroId == arg_17_1 then
			return iter_17_1
		end
	end
end

function var_0_0.isHeroInTeam(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getTeamInfo()

	for iter_18_0, iter_18_1 in ipairs(var_18_0.battleHeroInfo) do
		if iter_18_1.heroId == arg_18_1 then
			if arg_18_2 then
				iter_18_1.heroId = 0
			end

			return true
		end
	end

	for iter_18_2, iter_18_3 in ipairs(var_18_0.subHeroInfo) do
		if iter_18_3.heroId == arg_18_1 then
			if arg_18_2 then
				iter_18_3.heroId = 0
			end

			return true
		end
	end
end

function var_0_0.teamHasMainHero(arg_19_0)
	local var_19_0 = arg_19_0:getTeamInfo()

	for iter_19_0, iter_19_1 in ipairs(var_19_0.battleHeroInfo) do
		if iter_19_1.heroId ~= 0 then
			return true
		end
	end

	return false
end

function var_0_0.saveQuickGroupInfo(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getTeamInfo()

	for iter_20_0 = 1, 4 do
		Activity191Helper.getWithBuildBattleHeroInfo(var_20_0.battleHeroInfo, iter_20_0).heroId = arg_20_1[iter_20_0] or 0
		Activity191Helper.getWithBuildSubHeroInfo(var_20_0.subHeroInfo, iter_20_0).heroId = arg_20_1[iter_20_0 + 4] or 0
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_20_0.actId, arg_20_0.curTeamIndex, var_20_0)
end

function var_0_0.replaceHeroInTeam(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:isHeroInTeam(arg_21_1, true)

	local var_21_0 = arg_21_0:getTeamInfo()

	if arg_21_2 <= 4 then
		Activity191Helper.getWithBuildBattleHeroInfo(var_21_0.battleHeroInfo, arg_21_2).heroId = arg_21_1
	else
		Activity191Helper.getWithBuildSubHeroInfo(var_21_0.subHeroInfo, arg_21_2 - 4).heroId = arg_21_1
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_21_0.actId, arg_21_0.curTeamIndex, var_21_0)
end

function var_0_0.removeHeroInTeam(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getTeamInfo()

	for iter_22_0, iter_22_1 in ipairs(var_22_0.battleHeroInfo) do
		if iter_22_1.heroId == arg_22_1 then
			iter_22_1.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_22_0.actId, arg_22_0.curTeamIndex, var_22_0)

			return
		end
	end

	for iter_22_2, iter_22_3 in ipairs(var_22_0.subHeroInfo) do
		if iter_22_3.heroId == arg_22_1 then
			iter_22_3.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_22_0.actId, arg_22_0.curTeamIndex, var_22_0)

			return
		end
	end
end

function var_0_0.exchangeHero(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getTeamInfo()
	local var_23_1
	local var_23_2

	if arg_23_1 <= 4 then
		var_23_1 = Activity191Helper.getWithBuildBattleHeroInfo(var_23_0.battleHeroInfo, arg_23_1)
	else
		var_23_1 = Activity191Helper.getWithBuildSubHeroInfo(var_23_0.subHeroInfo, arg_23_1 - 4)
	end

	if arg_23_2 <= 4 then
		var_23_2 = Activity191Helper.getWithBuildBattleHeroInfo(var_23_0.battleHeroInfo, arg_23_2)
	else
		var_23_2 = Activity191Helper.getWithBuildSubHeroInfo(var_23_0.subHeroInfo, arg_23_2 - 4)
	end

	var_23_2.heroId, var_23_1.heroId = var_23_1.heroId, var_23_2.heroId

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_23_0.actId, arg_23_0.curTeamIndex, var_23_0)
end

function var_0_0.getItemInfoInWarehouse(arg_24_0, arg_24_1)
	local var_24_0

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.warehouseInfo.item) do
		if iter_24_1.uid == arg_24_1 then
			var_24_0 = iter_24_1

			break
		end
	end

	if not var_24_0 then
		logError(string.format("itemUid : %s, itemInfo not found", arg_24_1))
	end

	return var_24_0
end

function var_0_0.isItemInTeam(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:getTeamInfo()

	for iter_25_0, iter_25_1 in ipairs(var_25_0.battleHeroInfo) do
		if iter_25_1.itemUid1 == arg_25_1 then
			if arg_25_2 then
				iter_25_1.itemUid1 = 0
			end

			return true, iter_25_1.heroId
		end
	end
end

function var_0_0.replaceItemInTeam(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:isItemInTeam(arg_26_1, true)

	local var_26_0 = arg_26_0:getTeamInfo()

	Activity191Helper.getWithBuildBattleHeroInfo(var_26_0.battleHeroInfo, arg_26_2).itemUid1 = arg_26_1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_26_0.actId, arg_26_0.curTeamIndex, var_26_0)
end

function var_0_0.removeItemInTeam(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getTeamInfo()

	for iter_27_0, iter_27_1 in ipairs(var_27_0.battleHeroInfo) do
		if iter_27_1.itemUid1 == arg_27_1 then
			iter_27_1.itemUid1 = 0
		end
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_27_0.actId, arg_27_0.curTeamIndex, var_27_0)
end

function var_0_0.exchangeItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getTeamInfo()
	local var_28_1
	local var_28_2
	local var_28_3 = Activity191Helper.getWithBuildBattleHeroInfo(var_28_0.battleHeroInfo, arg_28_1)
	local var_28_4 = Activity191Helper.getWithBuildBattleHeroInfo(var_28_0.battleHeroInfo, arg_28_2)

	var_28_4.itemUid1, var_28_3.itemUid1 = var_28_3.itemUid1, var_28_4.itemUid1

	Activity191Rpc.instance:sendChangeAct191TeamRequest(arg_28_0.actId, arg_28_0.curTeamIndex, var_28_0)
end

function var_0_0.isHeroDestinyUnlock(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.destinyHeroMap[arg_29_1]

	if var_29_0 then
		return true, var_29_0
	end

	return false
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

return var_0_0
