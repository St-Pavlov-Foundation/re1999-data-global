module("modules.logic.seasonver.act123.utils.Season123HeroGroupUtils", package.seeall)

local var_0_0 = class("Season123HeroGroupUtils")

function var_0_0.buildSnapshotHeroGroups(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		local var_1_1 = HeroGroupMO.New()

		var_1_1:setSeasonCardLimit(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)

		if iter_1_1.heroList == nil or #iter_1_1.heroList <= 0 then
			if not var_0_0.checkFirstCopyHeroGroup(iter_1_1, var_1_1) then
				var_0_0.createEmptyGroup(iter_1_1, var_1_1)
			end
		else
			var_1_1:init(iter_1_1)
		end

		var_0_0.formation104Equips(var_1_1)

		var_1_0[iter_1_1.groupId] = var_1_1
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_0.groupId < arg_2_1.groupId
	end)

	return var_1_0
end

function var_0_0.checkFirstCopyHeroGroup(arg_3_0, arg_3_1)
	if arg_3_0.groupId == 1 then
		local var_3_0 = HeroGroupModel.instance:getById(1)

		if var_3_0 then
			arg_3_1.id = arg_3_0.groupId
			arg_3_1.groupId = arg_3_0.groupId
			arg_3_1.name = var_3_0.name
			arg_3_1.heroList = {
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid
			}
			arg_3_1.aidDict = LuaUtil.deepCopy(var_3_0.aidDict)
			arg_3_1.clothId = var_3_0.clothId
			arg_3_1.equips = LuaUtil.deepCopy(var_3_0.equips)
			arg_3_1.activity104Equips = LuaUtil.deepCopy(var_3_0.activity104Equips)

			var_0_0.formation104Equips(arg_3_1)

			return true
		end
	end

	return false
end

function var_0_0.formation104Equips(arg_4_0)
	if not arg_4_0.activity104Equips then
		arg_4_0.activity104Equips = {}
	end

	for iter_4_0 = 0, Activity123Enum.MainCharPos do
		if not arg_4_0.activity104Equips[iter_4_0] then
			arg_4_0:updateActivity104PosEquips({
				index = iter_4_0
			})
		end
	end

	for iter_4_1, iter_4_2 in pairs(arg_4_0.activity104Equips) do
		iter_4_2:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)

		local var_4_0 = iter_4_1 < ModuleEnum.MaxHeroCountInGroup and Activity123Enum.HeroCardNum or Activity123Enum.MainCardNum

		var_0_0.formationSingle104Equips(iter_4_2, var_4_0)
	end
end

function var_0_0.formationSingle104Equips(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.equipUid) do
		if arg_5_1 < iter_5_0 then
			arg_5_0.equipUid[iter_5_0] = nil
		end
	end

	for iter_5_2 = 1, arg_5_1 do
		if arg_5_0.equipUid[iter_5_2] == nil then
			arg_5_0.equipUid[iter_5_2] = Activity123Enum.EmptyUid
		end
	end
end

function var_0_0.createEmptyGroup(arg_6_0, arg_6_1)
	local var_6_0 = HeroGroupModel.instance:getById(1)

	arg_6_1.id = arg_6_0.groupId
	arg_6_1.groupId = arg_6_0.groupId
	arg_6_1.name = ""
	arg_6_1.heroList = {
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid
	}

	if var_6_0 then
		arg_6_1.clothId = var_6_0.clothId
	end

	arg_6_1.equips = {}

	for iter_6_0 = 0, ModuleEnum.MaxHeroCountInGroup - 1 do
		local var_6_1 = HeroGroupEquipMO.New()

		var_6_1:init({
			index = iter_6_0,
			equipUid = {
				Activity123Enum.EmptyUid
			}
		})

		arg_6_1.equips[iter_6_0] = var_6_1
	end

	arg_6_1.activity104Equips = {}

	local var_6_2 = ModuleEnum.MaxHeroCountInGroup

	for iter_6_1 = 0, var_6_2 do
		local var_6_3 = HeroGroupActivity104EquipMo.New()

		var_6_3:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)
		var_6_3:init({
			index = iter_6_1,
			equipUid = {
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid
			}
		})

		arg_6_1.activity104Equips[iter_6_1] = var_6_3
	end
end

function var_0_0.swapHeroItem(arg_7_0, arg_7_1)
	logNormal(string.format("swap hero pos %s to %s", arg_7_0, arg_7_1))

	local var_7_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_7_1 = arg_7_0 - 1
	local var_7_2 = arg_7_1 - 1
	local var_7_3 = var_7_0:getPosEquips(var_7_1).equipUid[1]
	local var_7_4 = var_7_0:getPosEquips(var_7_2).equipUid[1]

	var_7_0.equips[var_7_1].equipUid = {
		var_7_4
	}
	var_7_0.equips[var_7_2].equipUid = {
		var_7_3
	}

	local var_7_5 = var_7_0:getAct104PosEquips(var_7_1).equipUid
	local var_7_6 = var_7_0:getAct104PosEquips(var_7_2).equipUid

	var_7_0.activity104Equips[var_7_1].equipUid = var_7_6
	var_7_0.activity104Equips[var_7_2].equipUid = var_7_5

	local var_7_7 = var_7_0.heroList[var_7_1 + 1]
	local var_7_8 = var_7_0.heroList[var_7_2 + 1]

	var_7_0.heroList[var_7_1 + 1] = var_7_8
	var_7_0.heroList[var_7_2 + 1] = var_7_7
end

function var_0_0.syncHeroGroupFromFightGroup(arg_8_0, arg_8_1)
	arg_8_0.heroList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.heroList) do
		table.insert(arg_8_0.heroList, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_1.subHeroList) do
		table.insert(arg_8_0.heroList, iter_8_3)
	end

	arg_8_0.clothId = arg_8_1.clothId
	arg_8_0.equips = {}

	for iter_8_4, iter_8_5 in ipairs(arg_8_1.equips) do
		local var_8_0 = iter_8_4 - 1

		if arg_8_0.equips[var_8_0] == nil then
			arg_8_0.equips[var_8_0] = HeroGroupEquipMO.New()
		end

		arg_8_0.equips[var_8_0]:init({
			index = var_8_0,
			equipUid = iter_8_5.equipUid
		})
	end

	arg_8_0.activity104Equips = {}

	for iter_8_6, iter_8_7 in ipairs(arg_8_1.activity104Equips) do
		local var_8_1 = iter_8_6 - 1

		if arg_8_0.activity104Equips[var_8_1] == nil then
			arg_8_0.activity104Equips[var_8_1] = HeroGroupActivity104EquipMo.New()

			arg_8_0.activity104Equips[var_8_1]:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)
		end

		arg_8_0.activity104Equips[var_8_1]:init({
			index = var_8_1,
			equipUid = iter_8_7.equipUid
		})
	end
end

function var_0_0.getHeroGroupEquipCardId(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0.heroGroupSnapshot[arg_9_1]

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0.activity104Equips[arg_9_3]

	if not var_9_1 then
		return
	end

	local var_9_2 = var_9_1.equipUid[arg_9_2]
	local var_9_3 = arg_9_0:getItemIdByUid(var_9_2)

	if var_9_3 ~= nil then
		return var_9_3, var_9_2
	elseif var_9_2 ~= "0" then
		logError(string.format("can't find season123 item, itemUid = %s", var_9_2))
	end

	return 0
end

function var_0_0.processFightGroupAssistHero(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0 ~= ModuleEnum.HeroGroupType.Season123 then
		return
	end

	local var_10_0 = Season123Model.instance:getBattleContext()

	if var_10_0 then
		local var_10_1, var_10_2 = Season123Model.instance:getAssistData(var_10_0.actId, var_10_0.stage)
		local var_10_3
		local var_10_4

		if var_10_1 and var_10_2 and var_10_1.uid ~= "0" then
			var_10_3, var_10_4 = var_10_1.uid, var_10_2.userId
		end

		if var_10_3 and var_10_3 ~= "0" then
			local var_10_5 = false

			for iter_10_0 = 1, #arg_10_1.heroList do
				if var_10_3 == arg_10_1.heroList[iter_10_0] then
					arg_10_1.assistHeroUid = var_10_3
					arg_10_1.assistUserId = var_10_4
					var_10_5 = true
				end
			end

			if not var_10_5 then
				for iter_10_1 = 1, #arg_10_1.subHeroList do
					if var_10_3 == arg_10_1.subHeroList[iter_10_1] then
						arg_10_1.assistHeroUid = var_10_3
						arg_10_1.assistUserId = var_10_4

						local var_10_6 = true
					end
				end
			end
		end
	end
end

function var_0_0.cleanAllHeroGroup(arg_11_0, arg_11_1)
	local var_11_0 = Season123Model.instance:getActInfo(arg_11_0)

	if not var_11_0 then
		return
	end

	for iter_11_0, iter_11_1 in pairs(var_11_0.heroGroupSnapshot) do
		var_0_0.cleanHeroGroup(iter_11_1, arg_11_1)
	end
end

function var_0_0.cleanHeroGroup(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.heroList) do
		arg_12_0.heroList[iter_12_0] = Activity123Enum.EmptyUid
	end

	for iter_12_2 = 0, ModuleEnum.MaxHeroCountInGroup - 1 do
		local var_12_0 = arg_12_0.equips[iter_12_2]

		for iter_12_3, iter_12_4 in pairs(var_12_0.equipUid) do
			var_12_0.equipUid[iter_12_3] = Activity123Enum.EmptyUid
		end
	end

	local var_12_1 = ModuleEnum.MaxHeroCountInGroup

	for iter_12_5 = 0, var_12_1 do
		local var_12_2 = arg_12_0.activity104Equips[iter_12_5]

		for iter_12_6, iter_12_7 in pairs(var_12_2.equipUid) do
			if var_12_2.index == var_12_1 and arg_12_1 then
				var_12_2.equipUid[iter_12_6] = arg_12_1[iter_12_6] or Activity123Enum.EmptyUid
			else
				var_12_2.equipUid[iter_12_6] = Activity123Enum.EmptyUid
			end
		end
	end

	var_0_0.formation104Equips(arg_12_0)
end

function var_0_0.getAllHeroActivity123Equips(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = Season123Model.instance:getBattleContext()
	local var_13_2 = var_13_1 and var_13_1.actId
	local var_13_3 = Season123Model.instance:getActInfo(var_13_2)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.activity104Equips) do
		local var_13_4 = iter_13_0 + 1
		local var_13_5 = FightEquipMO.New()

		if var_13_4 == Season123EquipItemListModel.MainCharPos + 1 then
			var_13_5.heroUid = "-100000"
		else
			var_13_5.heroUid = arg_13_0.heroList[var_13_4] or Activity123Enum.EmptyUid
		end

		for iter_13_2, iter_13_3 in ipairs(iter_13_1.equipUid) do
			if iter_13_3 and iter_13_3 ~= Activity123Enum.EmptyUid then
				if var_13_3 then
					local var_13_6 = var_13_3:getItemIdByUid(iter_13_3)

					iter_13_1.equipUid[iter_13_2] = var_13_6 and var_13_6 > 0 and iter_13_3 or Activity123Enum.EmptyUid
				else
					iter_13_1.equipUid[iter_13_2] = Activity123Enum.EmptyUid
				end
			end
		end

		var_13_5.equipUid = iter_13_1.equipUid

		table.insert(var_13_0, var_13_5)
	end

	return var_13_0
end

function var_0_0.fiterFightCardDataList(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = {}

	if arg_14_1 then
		local var_14_2 = FightModel.instance:getBattleId()
		local var_14_3 = var_14_2 and lua_battle.configDict[var_14_2]
		local var_14_4 = var_14_3 and var_14_3.playerMax or ModuleEnum.HeroCountInGroup

		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			local var_14_5 = iter_14_1.pos

			if var_14_5 < 0 then
				var_14_5 = var_14_4 - var_14_5
			end

			var_14_1[var_14_5] = iter_14_1.trialId
		end
	end

	var_0_0.fiterFightCardData(Season123EquipItemListModel.TotalEquipPos, var_14_0, arg_14_0, nil, arg_14_2)

	for iter_14_2 = 1, Season123EquipItemListModel.TotalEquipPos - 1 do
		var_0_0.fiterFightCardData(iter_14_2, var_14_0, arg_14_0, var_14_1, arg_14_2)
	end

	return var_14_0
end

function var_0_0.fiterFightCardData(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_0 - 1
	local var_15_1 = arg_15_3 and arg_15_3[arg_15_0]
	local var_15_2 = arg_15_2 and arg_15_2[arg_15_0] and arg_15_2[arg_15_0].heroUid

	if var_15_0 == Season123EquipItemListModel.MainCharPos then
		var_15_2 = nil
	end

	if (not var_15_2 or var_15_2 == Season123EquipItemListModel.EmptyUid) and var_15_0 ~= Season123EquipItemListModel.MainCharPos then
		return
	end

	local var_15_3 = Season123EquipItemListModel.instance:getEquipMaxCount(var_15_0)
	local var_15_4 = 1
	local var_15_5 = Season123Model.instance:getActInfo(arg_15_4)

	if not var_15_5 then
		return
	end

	for iter_15_0 = 1, var_15_3 do
		local var_15_6 = arg_15_2 and arg_15_2[arg_15_0] and arg_15_2[arg_15_0].equipUid and arg_15_2[arg_15_0].equipUid[iter_15_0]
		local var_15_7

		if var_15_6 then
			var_15_7 = var_15_5:getItemIdByUid(var_15_6)
		end

		if not var_15_7 or var_15_7 == 0 then
			if var_15_1 then
				var_15_7 = HeroConfig.instance:getTrial104Equip(iter_15_0, var_15_1)
			elseif var_15_0 == Season123EquipItemListModel.MainCharPos then
				local var_15_8 = FightModel.instance:getBattleId()
				local var_15_9 = var_15_8 and lua_battle.configDict[var_15_8]

				var_15_7 = var_15_9 and var_15_9.trialMainAct104EuqipId
			end
		end

		if var_15_7 and var_15_7 > 0 then
			local var_15_10 = {
				equipId = var_15_7,
				heroUid = var_15_2,
				trialId = var_15_1,
				count = var_15_4
			}

			var_15_4 = var_15_4 + 1

			table.insert(arg_15_1, var_15_10)
		end
	end
end

function var_0_0.getUnlockIndexSlot(arg_16_0)
	if arg_16_0 >= 1 and arg_16_0 <= 4 then
		return 1
	end

	if arg_16_0 >= 5 and arg_16_0 <= 8 then
		return 2
	end

	if arg_16_0 >= 9 then
		return 3
	end

	return 0
end

function var_0_0.getUnlockSlotSet(arg_17_0)
	local var_17_0 = Season123Model.instance:getActInfo(arg_17_0)

	if not var_17_0 then
		return {}
	end

	return tabletool.copy(var_17_0.unlockIndexSet)
end

function var_0_0.setHpBar(arg_18_0, arg_18_1)
	if arg_18_1 >= 0.69 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0, "#63955C")
	elseif arg_18_1 >= 0.3 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0, "#E99B56")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0, "#BF2E11")
	end
end

return var_0_0
