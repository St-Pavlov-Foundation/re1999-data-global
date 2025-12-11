module("modules.logic.playercard.model.PlayerCardMO", package.seeall)

local var_0_0 = pureTable("PlayerCardMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.userId = arg_1_1
end

function var_0_0.updateInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.playerInfo = arg_2_2

	arg_2_0:updateProgressSetting(arg_2_1.progressSetting)
	arg_2_0:updateBaseInfoSetting(arg_2_1.baseSetting)
	arg_2_0:updateHeroCover(arg_2_1.heroCover)
	arg_2_0:updateThemeId(arg_2_1.themeId)
	arg_2_0:updateCritter(arg_2_1.critter)

	arg_2_0.showAchievement = arg_2_1.showAchievement
	arg_2_0.roomCollection = arg_2_1.roomCollection
	arg_2_0.layerId = arg_2_1.layerId
	arg_2_0.weekwalkDeepLayerId = arg_2_1.weekwalkDeepLayerId
	arg_2_0.exploreCollection = arg_2_1.exploreCollection
	arg_2_0.rougeDifficulty = arg_2_1.rougeDifficulty
	arg_2_0.act128SSSCount = arg_2_1.act128SSSCount
	arg_2_0.achievementCount = arg_2_1.achievementCount
	arg_2_0.assistTimes = arg_2_1.assistTimes
	arg_2_0.heroCoverTimes = arg_2_1.heroCoverTimes
	arg_2_0.maxFaithHeroCount = arg_2_1.maxFaithHeroCount
	arg_2_0.totalCostPower = arg_2_1.totalCostPower
	arg_2_0.skinCount = arg_2_1.skinCount
	arg_2_0.towerLayer = arg_2_1.towerLayer
	arg_2_0.towerBossPassCount = arg_2_1.towerBossPassCount
	arg_2_0.maxLevelHero = arg_2_1.heroMaxLevelCount
	arg_2_0.weekwalkVer2PlatinumCup = arg_2_1.weekwalkVer2PlatinumCup
	arg_2_0.towerLayerMetre = arg_2_1.towerLayerMetre

	arg_2_0:setHeroCount(arg_2_1.heroCount)
end

function var_0_0.setHeroCount(arg_3_0, arg_3_1)
	arg_3_0._allHeroCount = arg_3_1
end

function var_0_0.updateThemeId(arg_4_0, arg_4_1)
	arg_4_0.themeId = arg_4_1
end

function var_0_0.updateProgressSetting(arg_5_0, arg_5_1)
	arg_5_0.progressSettings = arg_5_1
	arg_5_0.progressSettingsDict = GameUtil.splitString2(arg_5_1, true)

	arg_5_0:setEmptyPosList()
end

function var_0_0.updateBaseInfoSetting(arg_6_0, arg_6_1)
	arg_6_0.baseInfoSettings = arg_6_1
	arg_6_0.baseInfoSettingsDict = GameUtil.splitString2(arg_6_1, true)

	arg_6_0:setEmptyBaseInfoPosList()
end

function var_0_0.updateCritter(arg_7_0, arg_7_1)
	local var_7_0 = string.splitToNumber(arg_7_1, "#")
	local var_7_1 = var_7_0[1]
	local var_7_2 = var_7_0[2]
	local var_7_3 = var_7_0[3]

	arg_7_0.critterUid = var_7_1
	arg_7_0.critterId = var_7_2

	if not arg_7_0.critterId then
		return
	end

	if var_7_3 == 1 then
		arg_7_0.critterSkinId = CritterConfig.instance:getCritterMutateSkin(tonumber(arg_7_0.critterId))
	else
		arg_7_0.critterSkinId = CritterConfig.instance:getCritterNormalSkin(tonumber(arg_7_0.critterId))
	end
end

function var_0_0.updateAchievement(arg_8_0, arg_8_1)
	arg_8_0.showAchievement = arg_8_1
end

function var_0_0.getShowAchievement(arg_9_0)
	return arg_9_0.showAchievement
end

function var_0_0.getSelectCritterUid(arg_10_0)
	return arg_10_0.critterUid
end

function var_0_0.setSelectCritterUid(arg_11_0, arg_11_1)
	arg_11_0.critterUid = arg_11_1
end

function var_0_0.updateHeroCover(arg_12_0, arg_12_1)
	arg_12_0.heroCover = arg_12_1
end

function var_0_0.getPlayerInfo(arg_13_0)
	local var_13_0 = arg_13_0.playerInfo

	if not var_13_0 and arg_13_0:isSelf() then
		var_13_0 = PlayerModel.instance:getPlayinfo()
	end

	return var_13_0
end

function var_0_0.isSelf(arg_14_0)
	return PlayerModel.instance:isPlayerSelf(arg_14_0.userId)
end

function var_0_0.setSetting(arg_15_0, arg_15_1)
	return (string.splitToNumber(arg_15_1, "#"))
end

function var_0_0.getProgressSetting(arg_16_0)
	return arg_16_0.progressSettingsDict
end

function var_0_0.setEmptyBaseInfoPosList(arg_17_0)
	arg_17_0.emptyBaseInfoPosList = {
		false,
		true,
		true,
		true
	}

	if arg_17_0.baseInfoSettingsDict and #arg_17_0.baseInfoSettingsDict > 0 then
		for iter_17_0 = 1, 4 do
			for iter_17_1, iter_17_2 in ipairs(arg_17_0.baseInfoSettingsDict) do
				if iter_17_2[1] == iter_17_0 then
					arg_17_0.emptyBaseInfoPosList[iter_17_0] = false
				end
			end
		end
	end
end

function var_0_0.getEmptyBaseInfoPosList(arg_18_0)
	return arg_18_0.emptyBaseInfoPosList
end

function var_0_0.setEmptyPosList(arg_19_0)
	arg_19_0.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if arg_19_0.progressSettingsDict and #arg_19_0.progressSettingsDict > 0 then
		for iter_19_0 = 1, 5 do
			for iter_19_1, iter_19_2 in ipairs(arg_19_0.progressSettingsDict) do
				if iter_19_2[1] == iter_19_0 then
					arg_19_0.emptyPosList[iter_19_0] = false
				end
			end
		end
	end
end

function var_0_0.getEmptyPosList(arg_20_0)
	return arg_20_0.emptyPosList
end

function var_0_0.setEmptyPosList(arg_21_0)
	arg_21_0.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if arg_21_0.progressSettingsDict and #arg_21_0.progressSettingsDict > 0 then
		for iter_21_0 = 1, 5 do
			for iter_21_1, iter_21_2 in ipairs(arg_21_0.progressSettingsDict) do
				if iter_21_2[1] == iter_21_0 then
					arg_21_0.emptyPosList[iter_21_0] = false
				end
			end
		end
	end
end

function var_0_0.getEmptyPosList(arg_22_0)
	return arg_22_0.emptyPosList
end

function var_0_0.getBaseInfoSetting(arg_23_0)
	return arg_23_0.baseInfoSettingsDict
end

function var_0_0.getCritter(arg_24_0)
	return arg_24_0.critterId, arg_24_0.critterSkinId
end

function var_0_0.getMainHero(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.heroCover
	local var_25_1 = string.splitToNumber(var_25_0, "#")
	local var_25_2 = var_25_1[1]
	local var_25_3 = var_25_1[2]
	local var_25_4 = var_25_1[3] ~= 0
	local var_25_5 = var_25_2 == -1

	if var_25_5 then
		if arg_25_1 or not arg_25_0._tempHeroId or not arg_25_0._tempSkinId then
			local var_25_6 = HeroModel.instance:getList()
			local var_25_7 = var_25_6[math.random(#var_25_6)]

			if var_25_7 then
				local var_25_8 = {
					var_25_7.config.skinId
				}

				for iter_25_0, iter_25_1 in ipairs(var_25_7.skinInfoList) do
					table.insert(var_25_8, iter_25_1.skin)
				end

				arg_25_0._tempHeroId = var_25_7.heroId
				arg_25_0._tempSkinId = var_25_8[math.random(#var_25_8)]
			end
		end

		return arg_25_0._tempHeroId, arg_25_0._tempSkinId, true, var_25_4
	else
		if not var_25_2 or var_25_2 == 0 or not HeroConfig.instance:getHeroCO(var_25_2) then
			var_25_2 = arg_25_0:getDefaultHeroId()
			var_25_3 = nil
		end

		if (not var_25_3 or var_25_3 == 0) and var_25_2 and var_25_2 ~= 0 then
			local var_25_9 = HeroConfig.instance:getHeroCO(var_25_2)

			var_25_3 = var_25_9 and var_25_9.skinId
		end

		arg_25_0._tempHeroId = var_25_2
		arg_25_0._tempSkinId = var_25_3
	end

	return var_25_2, var_25_3, var_25_5, var_25_4
end

function var_0_0.getDefaultHeroId(arg_26_0)
	if arg_26_0:isSelf() then
		return CharacterSwitchListModel.instance:getMainHero()
	else
		return 3028
	end
end

function var_0_0.getThemeId(arg_27_0)
	return arg_27_0.themeId
end

function var_0_0.getProgressByIndex(arg_28_0, arg_28_1)
	if arg_28_1 == PlayerCardEnum.LeftContent.RougeDifficulty then
		if arg_28_0.rougeDifficulty > 0 then
			return RougeConfig1.instance:getDifficultyCOTitle(arg_28_0.rougeDifficulty)
		else
			return -1
		end
	elseif arg_28_1 == PlayerCardEnum.LeftContent.WeekWalkDeep then
		if arg_28_0.weekwalkDeepLayerId > 0 then
			local var_28_0 = WeekWalkConfig.instance:getMapConfig(arg_28_0.weekwalkDeepLayerId)

			if var_28_0 and var_28_0.sceneId then
				local var_28_1 = lua_weekwalk_scene.configDict[var_28_0.sceneId]

				if var_28_1 and var_28_1.typeName and var_28_1.name then
					return var_28_1.typeName .. var_28_1.name
				end
			end
		end

		return -1
	elseif arg_28_1 == PlayerCardEnum.LeftContent.RoomCollection then
		return arg_28_0.roomCollection
	elseif arg_28_1 == PlayerCardEnum.LeftContent.ExploreCollection then
		return arg_28_0.exploreCollection
	elseif arg_28_1 == PlayerCardEnum.LeftContent.Act148SSSCount then
		if arg_28_0.act128SSSCount > 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_act128SSSCount"), arg_28_0.act128SSSCount)
		else
			return -1
		end
	elseif arg_28_1 == PlayerCardEnum.LeftContent.TowerLayer then
		if arg_28_0.towerLayer > 0 then
			if arg_28_0.towerLayerMetre <= 500 then
				local var_28_2 = TowerConfig.instance:getPermanentEpisodeCo(arg_28_0.towerLayer)
				local var_28_3 = string.splitToNumber(var_28_2.episodeIds, "|")
				local var_28_4 = var_28_3[#var_28_3]

				return DungeonConfig.instance:getEpisodeCO(var_28_4).name
			else
				local var_28_5 = TowerConfig.instance:getTowerPermanentTimeCo(PlayerCardEnum.TowerMaxStageId)

				return (var_28_5 and var_28_5.name) .. arg_28_0.towerLayerMetre .. "M"
			end
		end

		return -1
	elseif arg_28_1 == PlayerCardEnum.LeftContent.TowerBossPassCount then
		if arg_28_0.towerBossPassCount > 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_towerbosspasscount"), arg_28_0.towerBossPassCount)
		else
			return -1
		end
	elseif arg_28_1 == PlayerCardEnum.LeftContent.WeekwalkVer2PlatinumCup then
		if arg_28_0.weekwalkVer2PlatinumCup >= 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_weekwalkVer2PlatinumCup"), arg_28_0.weekwalkVer2PlatinumCup)
		else
			return -1
		end
	end
end

function var_0_0.getBaseInfoByIndex(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:getPlayerInfo()

	if not var_29_0 then
		return
	end

	if arg_29_1 == PlayerCardEnum.RightContent.LoginDay then
		if arg_29_2 then
			return var_29_0.totalLoginDays, luaLang("time_day")
		else
			local var_29_1 = luaLang("time_day")

			return var_29_0.totalLoginDays .. var_29_1
		end
	elseif arg_29_1 == PlayerCardEnum.RightContent.HeroCount then
		return arg_29_0:getHeroCount()
	elseif arg_29_1 == PlayerCardEnum.RightContent.CreatTime then
		return (TimeUtil.timestampToString3(ServerTime.timeInLocal(var_29_0.registerTime / 1000)))
	elseif arg_29_1 == PlayerCardEnum.RightContent.AssitCount then
		return arg_29_0.assistTimes or 0
	elseif arg_29_1 == PlayerCardEnum.RightContent.CompleteConfidence then
		return arg_29_0.maxFaithHeroCount or 0
	elseif arg_29_1 == PlayerCardEnum.RightContent.MaxLevelHero then
		return arg_29_0.maxLevelHero or 0
	elseif arg_29_1 == PlayerCardEnum.RightContent.SkinCount then
		return arg_29_0.skinCount or 0
	elseif arg_29_1 == PlayerCardEnum.RightContent.TotalCostPower then
		local var_29_2 = arg_29_0.totalCostPower or 0

		if arg_29_2 then
			return var_29_2, luaLang("NewPlayerCardView_activity_only")
		else
			return string.format(luaLang("NewPlayerCardView_activity"), var_29_2)
		end
	elseif arg_29_1 == PlayerCardEnum.RightContent.HeroCoverTimes then
		local var_29_3 = arg_29_0.heroCoverTimes or 0

		if arg_29_2 then
			return var_29_3, luaLang("NewPlayerCardView_times_only")
		else
			return string.format(luaLang("NewPlayerCardView_times"), var_29_3)
		end
	end
end

function var_0_0.getHeroCount(arg_30_0)
	return arg_30_0._allHeroCount or 0
end

function var_0_0.getHeroRarePercent(arg_31_0)
	local var_31_0 = arg_31_0:getPlayerInfo()

	if not var_31_0 then
		return nil
	end

	local var_31_1 = HeroConfig.instance:getAnyOnlineRareCharacterCount(1)
	local var_31_2 = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	local var_31_3 = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	local var_31_4 = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	local var_31_5 = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)
	local var_31_6 = math.min(var_31_1 > 0 and var_31_0.heroRareNNCount / var_31_1 or 1, 1)
	local var_31_7 = math.min(var_31_2 > 0 and var_31_0.heroRareNCount / var_31_2 or 1, 1)
	local var_31_8 = math.min(var_31_3 > 0 and var_31_0.heroRareRCount / var_31_3 or 1, 1)
	local var_31_9 = math.min(var_31_4 > 0 and var_31_0.heroRareSRCount / var_31_4 or 1, 1)
	local var_31_10 = math.min(var_31_5 > 0 and var_31_0.heroRareSSRCount / var_31_5 or 1, 1)

	return var_31_6, var_31_7, var_31_8, var_31_9, var_31_10
end

return var_0_0
