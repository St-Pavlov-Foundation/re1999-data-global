module("modules.logic.sp01.assassin2.controller.VersionActivity2_9DungeonHelper", package.seeall)

local var_0_0 = _M

function var_0_0.setEpisodeProgressIcon(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.getEpisodeMode(arg_1_0)
	local var_1_1 = VersionActivity2_9DungeonEnum.EpisodeMode2Icon[var_1_0]

	UISpriteSetMgr.instance:setV2a9DungeonSprite(arg_1_1, var_1_1, true)
end

function var_0_0.setEpisodeProgressBg(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.getEpisodeMode(arg_2_0)
	local var_2_1 = VersionActivity2_9DungeonEnum.EpisodeMode2Bg[var_2_0]

	UISpriteSetMgr.instance:setV2a9DungeonSprite(arg_2_1, var_2_1)
end

function var_0_0.getEpisodeMode(arg_3_0)
	local var_3_0 = DungeonConfig.instance:getEpisodeCO(arg_3_0)

	return (ActivityConfig.instance:getChapterIdMode(var_3_0.chapterId))
end

function var_0_0.formatEpisodeProgress(arg_4_0)
	return string.format("%s%%", arg_4_0 * 100)
end

function var_0_0.setEpisodeTargetProgress(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_0.getEpisodeConditionCount(arg_5_0)
	local var_5_1 = VersionActivity2_9DungeonEnum.EpisodeMaxProgress / var_5_0 * arg_5_1

	arg_5_2.text = var_0_0.formatEpisodeProgress(var_5_1)
end

function var_0_0.calcEpisodeProgress(arg_6_0)
	local var_6_0 = DungeonModel.instance:getEpisodeInfo(arg_6_0)
	local var_6_1 = var_6_0 and var_6_0.star or 0
	local var_6_2 = var_0_0.getEpisodeConditionCount(arg_6_0)

	return VersionActivity2_9DungeonEnum.EpisodeMaxProgress / var_6_2 * var_6_1
end

function var_0_0.getEpisodeConditionCount(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = DungeonConfig.instance:getEpisodeWinConditionTextList(arg_7_0)
	local var_7_2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_7_0)
	local var_7_3 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(arg_7_0)

	if not string.nilorempty(var_7_2) then
		var_7_0 = var_7_0 + 1
	end

	if not string.nilorempty(var_7_3) then
		var_7_0 = var_7_0 + 1
	end

	return var_7_0 + (var_7_1 and #var_7_1 or 0)
end

function var_0_0.getEpisdoeLittleGameType(arg_8_0)
	var_0_0._buildLittleGameEpisodeMap()

	return var_0_0._initLittleGameMap and var_0_0._initLittleGameMap[arg_8_0]
end

function var_0_0._buildLittleGameEpisodeMap()
	if not var_0_0._initLittleGameMap then
		local function var_9_0(arg_10_0)
			local var_10_0 = VersionActivity2_9DungeonEnum.LittleGameType2EpisdoeConstId[arg_10_0]
			local var_10_1 = AssassinConfig.instance:getAssassinConst(var_10_0, true)

			var_0_0._initLittleGameMap = var_0_0._initLittleGameMap or {}
			var_0_0._initLittleGameMap[var_10_1] = arg_10_0
		end

		var_9_0(VersionActivity2_9DungeonEnum.LittleGameType.Eye)
		var_9_0(VersionActivity2_9DungeonEnum.LittleGameType.Line)
		var_9_0(VersionActivity2_9DungeonEnum.LittleGameType.Point)
	end
end

function var_0_0.getLittleGameDialogIds(arg_11_0)
	local var_11_0 = AssassinConfig.instance:getAssassinConst(arg_11_0)

	return string.splitToNumber(var_11_0, "#")
end

function var_0_0.loadFightCondition(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_0._checkIsUseCustomFunc2LoadCondition(arg_12_1)

	if not var_12_0 then
		return
	end

	var_0_0._startLoadFightCondition(arg_12_0, arg_12_1, arg_12_2)

	return var_12_0
end

function var_0_0._checkIsUseCustomFunc2LoadCondition(arg_13_0)
	local var_13_0 = DungeonConfig.instance:getEpisodeCO(arg_13_0)
	local var_13_1 = DungeonConfig.instance:getChapterCO(var_13_0.chapterId)

	return var_13_1 and var_13_1.actId == VersionActivity2_9Enum.ActivityId.Dungeon
end

function var_0_0._startLoadFightCondition(arg_14_0, arg_14_1, arg_14_2)
	gohelper.setActive(arg_14_0._goconditionitem, false)

	arg_14_0._v2a9ConditionList = arg_14_0._v2a9ConditionList or arg_14_0:getUserDataTb_()

	local var_14_0 = PrefabInstantiate.Create(arg_14_2)
	local var_14_1 = var_14_0:getPath()

	if string.nilorempty(var_14_1) then
		var_14_0:startLoad(VersionActivity2_9DungeonEnum.FightGoalItemResUrl, var_0_0._onLoadFightGoalItemDone, arg_14_0)

		return
	end

	local var_14_2 = var_14_0:getInstGO()

	if gohelper.isNil(var_14_2) then
		return
	end

	var_0_0._refreshFightConditionList(arg_14_0, var_14_2)
end

function var_0_0._onLoadFightGoalItemDone(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:getInstGO()

	gohelper.setActive(var_15_0, false)
	var_0_0._refreshFightConditionList(arg_15_0, var_15_0)
end

function var_0_0._refreshFightConditionList(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0 and arg_16_0._v2a9ConditionList
	local var_16_1 = DungeonModel.instance.curSendEpisodeId
	local var_16_2 = {}
	local var_16_3 = DungeonConfig.instance:getEpisodeWinConditionTextList(var_16_1)

	tabletool.addValues(var_16_2, var_16_3)
	table.insert(var_16_2, DungeonConfig.instance:getEpisodeAdvancedConditionText(var_16_1))
	table.insert(var_16_2, DungeonConfig.instance:getEpisodeAdvancedCondition2Text(var_16_1))

	local var_16_4 = var_16_3 and #var_16_3 or 0
	local var_16_5 = 0

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		if not string.nilorempty(iter_16_1) then
			var_16_5 = var_16_5 + 1

			local var_16_6 = var_16_0[var_16_5]

			if not var_16_6 then
				var_16_6 = gohelper.cloneInPlace(arg_16_1, "condition_" .. var_16_5)
				var_16_0[var_16_5] = var_16_6
			end

			local var_16_7 = false
			local var_16_8 = DungeonEnum.StarType.Normal

			if var_16_4 < var_16_5 then
				local var_16_9 = DungeonConfig.instance:getEpisodeAdvancedCondition2(var_16_1, var_16_5 - var_16_4)

				var_16_7 = arg_16_0:checkPlatCondition(var_16_9)
				var_16_8 = DungeonEnum.StarType.Advanced
			end

			var_0_0._refreshSingleFightCondition(var_16_1, var_16_8, var_16_6, iter_16_1, var_16_7)
		end
	end

	for iter_16_2 = var_16_5 + 1, #var_16_0 do
		gohelper.setActive(var_16_0[iter_16_2], false)
	end
end

function var_0_0._refreshSingleFightCondition(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	gohelper.setActive(arg_17_2, true)

	local var_17_0 = gohelper.findChildImage(arg_17_2, "star")
	local var_17_1 = gohelper.findChildText(arg_17_2, "condition")
	local var_17_2 = gohelper.findChildText(arg_17_2, "progress")
	local var_17_3 = gohelper.findChild(arg_17_2, "condition/image_gou")

	var_17_1.text = arg_17_3

	gohelper.setActive(var_17_3, arg_17_4)
	var_0_0.setEpisodeProgressIcon(arg_17_0, var_17_0)
	var_0_0.setEpisodeTargetProgress(arg_17_0, arg_17_1, var_17_2)
end

function var_0_0.isTargetActEpisode(arg_18_0, arg_18_1)
	if not arg_18_0 or not arg_18_1 then
		return
	end

	local var_18_0 = DungeonConfig.instance:getEpisodeCO(arg_18_0)

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0.chapterId
	local var_18_2 = DungeonConfig.instance:getChapterCO(var_18_1)

	if not var_18_2 then
		return
	end

	return var_18_2.actId == arg_18_1
end

function var_0_0.getEpisodeAfterStoryId(arg_19_0)
	local var_19_0 = DungeonConfig.instance:getEpisodeCO(arg_19_0)

	if not var_19_0 then
		return
	end

	if var_19_0.afterStory ~= 0 then
		return var_19_0.afterStory
	end

	local var_19_1 = var_0_0.getEpisdoeLittleGameType(arg_19_0)

	if not var_19_1 then
		return
	end

	local var_19_2 = VersionActivity2_9DungeonEnum.LittleGameType2AfterStoryConstId[var_19_1]

	if not var_19_2 then
		return
	end

	return AssassinConfig.instance:getAssassinConst(var_19_2, true)
end

function var_0_0.isAttachedEpisode(arg_20_0)
	if not arg_20_0 then
		return
	end

	if not var_0_0._attachedEpisodeIdMap then
		local var_20_0 = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.AttachedEpisodeIds)
		local var_20_1 = string.splitToNumber(var_20_0, "#")

		var_0_0._attachedEpisodeIdMap = {}

		for iter_20_0, iter_20_1 in ipairs(var_20_1 or {}) do
			var_0_0._attachedEpisodeIdMap[iter_20_1] = true
		end
	end

	return var_0_0._attachedEpisodeIdMap and var_0_0._attachedEpisodeIdMap[arg_20_0]
end

function var_0_0.isAllEpisodeAdvacePass(arg_21_0)
	local var_21_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_21_0)

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		local var_21_1 = iter_21_1.id

		if not DungeonModel.instance:hasPassLevelAndStory(var_21_1) then
			return
		end

		local var_21_2 = DungeonConfig.instance:getEpisodeAdvancedCondition(var_21_1)

		if not string.nilorempty(var_21_2) then
			local var_21_3 = DungeonModel.instance:getEpisodeInfo(var_21_1)

			if not var_21_3 or var_21_3.star < DungeonEnum.StarType.Advanced then
				return
			end
		end
	end

	return true
end

return var_0_0
