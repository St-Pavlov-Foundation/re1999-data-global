module("modules.versionactivitybase.fixed.dungeon.model.VersionActivityFixedDungeonModel", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:init()
end

function var_0_0.init(arg_3_0)
	arg_3_0:setLastEpisodeId()
	arg_3_0:setShowInteractView()
end

function var_0_0.setLastEpisodeId(arg_4_0, arg_4_1)
	arg_4_0.lastEpisodeId = arg_4_1
end

function var_0_0.getLastEpisodeId(arg_5_0)
	return arg_5_0.lastEpisodeId
end

function var_0_0.setShowInteractView(arg_6_0, arg_6_1)
	arg_6_0.isShowInteractView = arg_6_1
end

function var_0_0.checkIsShowInteractView(arg_7_0)
	return arg_7_0.isShowInteractView
end

function var_0_0.setIsNotShowNewElement(arg_8_0, arg_8_1)
	arg_8_0.notShowNewElement = arg_8_1
end

function var_0_0.isNotShowNewElement(arg_9_0)
	return arg_9_0.notShowNewElement
end

function var_0_0.setMapNeedTweenState(arg_10_0, arg_10_1)
	arg_10_0.isMapNeedTween = arg_10_1
end

function var_0_0.getMapNeedTweenState(arg_11_0)
	return arg_11_0.isMapNeedTween
end

function var_0_0.getElementCoList(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = DungeonMapModel.instance:getAllElements()

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		local var_12_2 = DungeonConfig.instance:getChapterMapElement(iter_12_1)
		local var_12_3 = var_12_2 and lua_chapter_map.configDict[var_12_2.mapId]

		if var_12_3 and var_12_3.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story and arg_12_1 == var_12_2.mapId then
			table.insert(var_12_0, var_12_2)
		end
	end

	return var_12_0
end

function var_0_0.getElementCoListWithFinish(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = arg_13_0:getAllNormalElementCoList(arg_13_1)

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		local var_13_2 = iter_13_1.id
		local var_13_3 = lua_chapter_map.configDict[iter_13_1.mapId]

		if var_13_3 and var_13_3.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story then
			local var_13_4 = DungeonMapModel.instance:elementIsFinished(var_13_2)
			local var_13_5 = DungeonMapModel.instance:getElementById(var_13_2)

			if arg_13_1 == iter_13_1.mapId and var_13_4 and not var_13_5 then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	return var_13_0, var_13_1
end

function var_0_0.getAllNormalElementCoList(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = DungeonConfig.instance:getMapElements(arg_14_1)

	if var_14_1 then
		for iter_14_0, iter_14_1 in pairs(var_14_1) do
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.setDungeonBaseMo(arg_15_0, arg_15_1)
	arg_15_0.actDungeonBaseMo = arg_15_1
end

function var_0_0.getDungeonBaseMo(arg_16_0)
	return arg_16_0.actDungeonBaseMo
end

function var_0_0.getInitEpisodeId(arg_17_0)
	local var_17_0 = VersionActivityFixedHelper.getVersionActivityDungeonEnum()
	local var_17_1 = DungeonConfig.instance:getChapterEpisodeCOList(var_17_0.DungeonChapterId.Story)
	local var_17_2 = 0
	local var_17_3 = 0

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_4 = DungeonModel.instance:isUnlock(iter_17_1)

		if DungeonModel.instance.isBattleEpisode(iter_17_1) then
			var_17_3 = var_17_3 > iter_17_1.id and var_17_3 or iter_17_1.id
		end

		if var_17_4 and var_17_2 < iter_17_1.id then
			var_17_2 = iter_17_1.id
		end
	end

	if DungeonModel.instance:chapterIsPass(var_17_0.DungeonChapterId.Story) then
		var_17_2 = var_17_3
	end

	return var_17_2
end

local var_0_1 = 1
local var_0_2 = 0

function var_0_0.isNeedPlayHardModeUnlockAnimation(arg_18_0, arg_18_1)
	local var_18_0 = VersionActivityFixedHelper.getVersionActivityDungeonEnum().PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim

	if VersionActivityFixedHelper.getVersionActivityDungeonController().instance:getPlayerPrefs(var_18_0, var_0_2) ~= var_0_1 then
		local var_18_1 = arg_18_1 or VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon

		return (VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_18_1))
	end
end

function var_0_0.savePlayerPrefsPlayHardModeUnlockAnimation(arg_19_0)
	local var_19_0 = VersionActivityFixedHelper.getVersionActivityDungeonEnum().PlayerPrefsKey.HasPlayedUnlockHardModeBtnAnim

	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:savePlayerPrefs(var_19_0, var_0_1)
end

function var_0_0.isTipHardModeUnlockOpen(arg_20_0, arg_20_1)
	if arg_20_1 ~= VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon then
		return
	end

	local var_20_0 = VersionActivityFixedHelper.getVersionActivityDungeonEnum().PlayerPrefsKey.OpenHardModeUnlockTip

	if VersionActivityFixedHelper.getVersionActivityDungeonController().instance:getPlayerPrefs(var_20_0, var_0_2) ~= var_0_1 then
		return (VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(arg_20_1))
	end
end

function var_0_0.setTipHardModeUnlockOpen(arg_21_0)
	local var_21_0 = VersionActivityFixedHelper.getVersionActivityDungeonEnum().PlayerPrefsKey.OpenHardModeUnlockTip

	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:savePlayerPrefs(var_21_0, var_0_1)
	arg_21_0:refreshVersionActivityEnterRedDot()
end

function var_0_0.refreshVersionActivityEnterRedDot(arg_22_0)
	local var_22_0 = {
		[RedDotEnum.DotNode.VersionActivityEnterRedDot] = true
	}

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, var_22_0)
end

function var_0_0.getHardModeCurrenyNum(arg_23_0, arg_23_1)
	local var_23_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_23_1)
	local var_23_1 = 0
	local var_23_2 = 0

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_3 = DungeonModel.instance:getEpisodeInfo(iter_23_1.id)
		local var_23_4 = DungeonModel.instance:getEpisodeFirstBonus(iter_23_1.id)

		if var_23_4 then
			for iter_23_2, iter_23_3 in ipairs(var_23_4) do
				if tonumber(iter_23_3[1]) == MaterialEnum.MaterialType.Currency and tonumber(iter_23_3[2]) == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
					if var_23_3 and var_23_3.star ~= DungeonEnum.StarType.None then
						var_23_1 = var_23_1 + tonumber(iter_23_3[3])
					end

					var_23_2 = var_23_2 + tonumber(iter_23_3[3])
				end
			end
		end
	end

	return var_23_1, var_23_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
