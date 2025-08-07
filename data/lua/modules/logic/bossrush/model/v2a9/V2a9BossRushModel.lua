module("modules.logic.bossrush.model.v2a9.V2a9BossRushModel", package.seeall)

local var_0_0 = class("V2a9BossRushModel", BaseModel)

function var_0_0.isV2a9BossRush(arg_1_0)
	return BossRushConfig.instance:getActivityId() == VersionActivity2_9Enum.ActivityId.BossRush
end

function var_0_0.onRefresh128InfosReply(arg_2_0, arg_2_1)
	arg_2_0._equipMos = {}

	if not arg_2_0._spHighestPoint then
		arg_2_0._spHighestPoint = {}
	end

	for iter_2_0 = 1, #arg_2_1.bossDetail do
		local var_2_0 = arg_2_1.bossDetail[iter_2_0]
		local var_2_1 = var_2_0.bossId

		if not arg_2_0._equipMos[var_2_1] then
			arg_2_0._equipMos[var_2_1] = {}
		end

		if not arg_2_0._spHighestPoint[var_2_1] then
			arg_2_0._spHighestPoint[var_2_1] = {}
		end

		local var_2_2 = var_2_0.spItemTypeIds or {}
		local var_2_3 = arg_2_0:getMaxEquipCount()

		for iter_2_1 = 1, BossRushEnum.V2a9FightEquipSkillMaxCount do
			local var_2_4 = var_2_2[iter_2_1]
			local var_2_5 = V2a9BossRushAssassinEquipMO.New()
			local var_2_6 = var_2_3 < iter_2_1

			var_2_5:init(iter_2_1, var_2_4, var_2_6)
			table.insert(arg_2_0._equipMos[var_2_1], var_2_5)
		end

		arg_2_0._spHighestPoint[var_2_1] = var_2_0.spHighestPoint
	end
end

function var_0_0.getHighestPoint(arg_3_0, arg_3_1)
	return arg_3_0._spHighestPoint[arg_3_1] or 0
end

function var_0_0.isV2a9BossRushSecondStageSpecialLayer(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == DungeonEnum.EpisodeType.BossRush then
		local var_4_0 = BossRushConfig.instance:getEpisodeCoByEpisodeId(arg_4_2)

		if var_4_0 and arg_4_0:isV2a9SecondStageSpecialLayer(var_4_0.stage, var_4_0.layer) then
			return true
		end
	end
end

function var_0_0.isV2a9SecondStageSpecialLayer(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_1 == BossRushEnum.V2a9StageEnum.Second and arg_5_2 == BossRushEnum.LayerEnum.V2a9
end

function var_0_0.getMaxEquipCount(arg_6_0)
	local var_6_0 = lua_activity128_const.configDict[BossRushEnum.V2a9FightCanEquipSkillCountConst]

	return var_6_0 and var_6_0.value1 or 4
end

function var_0_0.getAllEquipMos(arg_7_0, arg_7_1)
	return arg_7_0._equipMos and arg_7_0._equipMos[arg_7_1]
end

function var_0_0.selectSpItemId(arg_8_0, arg_8_1)
	arg_8_0._selectItemId = arg_8_1
end

function var_0_0.getSelectedItemId(arg_9_0)
	return arg_9_0._selectItemId
end

function var_0_0.getItemIdByItemType(arg_10_0, arg_10_1)
	if not arg_10_0._itemTypeDict then
		arg_10_0._itemTypeDict = {}
	end

	local var_10_0 = arg_10_0._itemTypeDict[arg_10_1]

	if var_10_0 then
		return var_10_0
	end

	return (AssassinConfig.instance:getAssassinItemId(arg_10_1, 2))
end

function var_0_0.isEquip(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0:getEquipIndex(arg_11_1, arg_11_2) ~= nil
end

function var_0_0.getEquipIndex(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getAllEquipMos(arg_12_1)

	if not var_12_0 then
		return
	end

	local var_12_1 = AssassinConfig.instance:getAssassinItemType(arg_12_2)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1:getItemType() == var_12_1 then
			return iter_12_1:getIndex()
		end
	end
end

function var_0_0.isFullEquip(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getAllEquipMos(arg_13_1)

	if not var_13_0 then
		return
	end

	for iter_13_0 = 1, arg_13_0:getMaxEquipCount() do
		local var_13_1 = var_13_0[iter_13_0]

		if var_13_1 and not var_13_1:isEquip() then
			return false
		end
	end

	return true
end

function var_0_0.changeEquippedSelectItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:getAllEquipMos(arg_14_1)

	if not var_14_0 then
		return
	end

	local var_14_1 = arg_14_0:getSelectedItemId()
	local var_14_2 = AssassinConfig.instance:getAssassinItemType(var_14_1)
	local var_14_3 = {}
	local var_14_4 = arg_14_0:getEquipIndex(arg_14_1, var_14_1)

	if var_14_4 then
		local var_14_5 = var_14_0[var_14_4]

		if var_14_5 then
			var_14_5:setEquipItemType()
		end
	else
		local var_14_6 = arg_14_0:_getNullIndex(var_14_0)

		if var_14_6 then
			local var_14_7 = var_14_0[var_14_6]

			if var_14_7 then
				var_14_7:setEquipItemType(var_14_2)
			end
		else
			logError("没位置了，应该改变按钮状态")
		end
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_8 = iter_14_1:getItemType()

		if iter_14_1:isEquip() then
			table.insert(var_14_3, var_14_8)
		end
	end

	local var_14_9 = BossRushConfig.instance:getActivityId()

	Activity128Rpc.instance:sendAct128SpFirstHalfSelectItemRequest(var_14_9, arg_14_1, var_14_3, arg_14_2, arg_14_3)
end

function var_0_0._getNullIndex(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if not iter_15_1:isEquip() then
			return iter_15_0
		end
	end
end

function var_0_0.onReceiveAct128SpFirstHalfSelectItemReply(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.itemTypeIds or {}
	local var_16_1 = arg_16_1.bossId

	if arg_16_0._equipMos and arg_16_0._equipMos[var_16_1] then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._equipMos[var_16_1]) do
			local var_16_2 = var_16_0[iter_16_0]

			iter_16_1:setEquipItemType(var_16_2)
		end
	end
end

function var_0_0.getUnlockEpisodeDisplay(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = DungeonConfig.instance:getEpisodeCO(arg_17_2)
	local var_17_1 = var_17_0 and var_17_0.chapterId
	local var_17_2 = DungeonConfig.instance:getChapterCO(var_17_1)
	local var_17_3 = ActivityConfig.instance:getActivityCo(var_17_2 and var_17_2.actId)
	local var_17_4

	if arg_17_1 == 1 then
		var_17_4 = DungeonConfig.instance:getEpisodeDisplay(arg_17_2)
	else
		local var_17_5 = DungeonConfig.instance:getChapterEpisodeCOList(var_17_1)

		table.sort(var_17_5, function(arg_18_0, arg_18_1)
			return arg_18_0.id < arg_18_1.id
		end)

		local var_17_6 = arg_17_0:_getEpisodeIndex(var_17_1, arg_17_2)

		if var_17_6 then
			local var_17_7 = var_17_2.chapterIndex

			var_17_4 = string.format(luaLang("V2a9BossRushModel_getUnlockEpisodeDisplay"), var_17_7, var_17_6, var_17_0.name)
		end
	end

	return var_17_3 and var_17_3.name, var_17_4
end

function var_0_0._getEpisodeIndex(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_19_1)

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		local var_20_0 = SLFramework.FrameworkSettings.IsEditor and {}
		local var_20_1 = SLFramework.FrameworkSettings.IsEditor and {}
		local var_20_2 = DungeonConfig.instance:_getEpisodeIndex(arg_20_0, var_20_0)
		local var_20_3 = DungeonConfig.instance:_getEpisodeIndex(arg_20_1, var_20_1)

		if var_20_2 ~= var_20_3 then
			return var_20_2 < var_20_3
		end

		return arg_20_0.id < arg_20_1.id
	end)

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.id == arg_19_2 then
			return iter_19_0
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
