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
end

function var_0_0.updateThemeId(arg_3_0, arg_3_1)
	arg_3_0.themeId = arg_3_1
end

function var_0_0.updateProgressSetting(arg_4_0, arg_4_1)
	arg_4_0.progressSettings = arg_4_1
	arg_4_0.progressSettingsDict = GameUtil.splitString2(arg_4_1, true)

	arg_4_0:setEmptyPosList()
end

function var_0_0.updateBaseInfoSetting(arg_5_0, arg_5_1)
	arg_5_0.baseInfoSettings = arg_5_1
	arg_5_0.baseInfoSettingsDict = GameUtil.splitString2(arg_5_1, true)

	arg_5_0:setEmptyBaseInfoPosList()
end

function var_0_0.updateCritter(arg_6_0, arg_6_1)
	local var_6_0 = string.splitToNumber(arg_6_1, "#")
	local var_6_1 = var_6_0[1]
	local var_6_2 = var_6_0[2]
	local var_6_3 = var_6_0[3]

	arg_6_0.critterUid = var_6_1
	arg_6_0.critterId = var_6_2

	if not arg_6_0.critterId then
		return
	end

	if var_6_3 == 1 then
		arg_6_0.critterSkinId = CritterConfig.instance:getCritterMutateSkin(tonumber(arg_6_0.critterId))
	else
		arg_6_0.critterSkinId = CritterConfig.instance:getCritterNormalSkin(tonumber(arg_6_0.critterId))
	end
end

function var_0_0.updateAchievement(arg_7_0, arg_7_1)
	arg_7_0.showAchievement = arg_7_1
end

function var_0_0.getShowAchievement(arg_8_0)
	return arg_8_0.showAchievement
end

function var_0_0.getSelectCritterUid(arg_9_0)
	return arg_9_0.critterUid
end

function var_0_0.setSelectCritterUid(arg_10_0, arg_10_1)
	arg_10_0.critterUid = arg_10_1
end

function var_0_0.updateHeroCover(arg_11_0, arg_11_1)
	arg_11_0.heroCover = arg_11_1
end

function var_0_0.getPlayerInfo(arg_12_0)
	local var_12_0 = arg_12_0.playerInfo

	if not var_12_0 and arg_12_0:isSelf() then
		var_12_0 = PlayerModel.instance:getPlayinfo()
	end

	return var_12_0
end

function var_0_0.isSelf(arg_13_0)
	return PlayerModel.instance:isPlayerSelf(arg_13_0.userId)
end

function var_0_0.setSetting(arg_14_0, arg_14_1)
	return (string.splitToNumber(arg_14_1, "#"))
end

function var_0_0.getProgressSetting(arg_15_0)
	return arg_15_0.progressSettingsDict
end

function var_0_0.setEmptyBaseInfoPosList(arg_16_0)
	arg_16_0.emptyBaseInfoPosList = {
		false,
		true,
		true,
		true
	}

	if arg_16_0.baseInfoSettingsDict and #arg_16_0.baseInfoSettingsDict > 0 then
		for iter_16_0 = 1, 4 do
			for iter_16_1, iter_16_2 in ipairs(arg_16_0.baseInfoSettingsDict) do
				if iter_16_2[1] == iter_16_0 then
					arg_16_0.emptyBaseInfoPosList[iter_16_0] = false
				end
			end
		end
	end
end

function var_0_0.getEmptyBaseInfoPosList(arg_17_0)
	return arg_17_0.emptyBaseInfoPosList
end

function var_0_0.setEmptyPosList(arg_18_0)
	arg_18_0.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if arg_18_0.progressSettingsDict and #arg_18_0.progressSettingsDict > 0 then
		for iter_18_0 = 1, 5 do
			for iter_18_1, iter_18_2 in ipairs(arg_18_0.progressSettingsDict) do
				if iter_18_2[1] == iter_18_0 then
					arg_18_0.emptyPosList[iter_18_0] = false
				end
			end
		end
	end
end

function var_0_0.getEmptyPosList(arg_19_0)
	return arg_19_0.emptyPosList
end

function var_0_0.setEmptyPosList(arg_20_0)
	arg_20_0.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if arg_20_0.progressSettingsDict and #arg_20_0.progressSettingsDict > 0 then
		for iter_20_0 = 1, 5 do
			for iter_20_1, iter_20_2 in ipairs(arg_20_0.progressSettingsDict) do
				if iter_20_2[1] == iter_20_0 then
					arg_20_0.emptyPosList[iter_20_0] = false
				end
			end
		end
	end
end

function var_0_0.getEmptyPosList(arg_21_0)
	return arg_21_0.emptyPosList
end

function var_0_0.getBaseInfoSetting(arg_22_0)
	return arg_22_0.baseInfoSettingsDict
end

function var_0_0.getCritter(arg_23_0)
	return arg_23_0.critterId, arg_23_0.critterSkinId
end

function var_0_0.getMainHero(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.heroCover
	local var_24_1 = string.splitToNumber(var_24_0, "#")
	local var_24_2 = var_24_1[1]
	local var_24_3 = var_24_1[2]
	local var_24_4 = var_24_1[3] ~= 0
	local var_24_5 = var_24_2 == -1

	if var_24_5 then
		if arg_24_1 or not arg_24_0._tempHeroId or not arg_24_0._tempSkinId then
			local var_24_6 = HeroModel.instance:getList()
			local var_24_7 = var_24_6[math.random(#var_24_6)]

			if var_24_7 then
				local var_24_8 = {
					var_24_7.config.skinId
				}

				for iter_24_0, iter_24_1 in ipairs(var_24_7.skinInfoList) do
					table.insert(var_24_8, iter_24_1.skin)
				end

				arg_24_0._tempHeroId = var_24_7.heroId
				arg_24_0._tempSkinId = var_24_8[math.random(#var_24_8)]
			end
		end

		return arg_24_0._tempHeroId, arg_24_0._tempSkinId, true, var_24_4
	else
		if not var_24_2 or var_24_2 == 0 or not HeroConfig.instance:getHeroCO(var_24_2) then
			var_24_2 = arg_24_0:getDefaultHeroId()
			var_24_3 = nil
		end

		if (not var_24_3 or var_24_3 == 0) and var_24_2 and var_24_2 ~= 0 then
			local var_24_9 = HeroConfig.instance:getHeroCO(var_24_2)

			var_24_3 = var_24_9 and var_24_9.skinId
		end

		arg_24_0._tempHeroId = var_24_2
		arg_24_0._tempSkinId = var_24_3
	end

	return var_24_2, var_24_3, var_24_5, var_24_4
end

function var_0_0.getDefaultHeroId(arg_25_0)
	if arg_25_0:isSelf() then
		return CharacterSwitchListModel.instance:getMainHero()
	else
		return 3028
	end
end

function var_0_0.getThemeId(arg_26_0)
	return arg_26_0.themeId
end

function var_0_0.getProgressByIndex(arg_27_0, arg_27_1)
	if arg_27_1 == PlayerCardEnum.LeftContent.RougeDifficulty then
		if arg_27_0.rougeDifficulty > 0 then
			return RougeConfig1.instance:getDifficultyCOTitle(arg_27_0.rougeDifficulty)
		else
			return -1
		end
	elseif arg_27_1 == PlayerCardEnum.LeftContent.WeekWalkDeep then
		if arg_27_0.weekwalkDeepLayerId > 0 then
			local var_27_0 = WeekWalkConfig.instance:getMapConfig(arg_27_0.weekwalkDeepLayerId)

			if var_27_0 and var_27_0.sceneId then
				local var_27_1 = lua_weekwalk_scene.configDict[var_27_0.sceneId]

				if var_27_1 and var_27_1.typeName and var_27_1.name then
					return var_27_1.typeName .. var_27_1.name
				end
			end
		end

		return -1
	elseif arg_27_1 == PlayerCardEnum.LeftContent.RoomCollection then
		return arg_27_0.roomCollection
	elseif arg_27_1 == PlayerCardEnum.LeftContent.ExploreCollection then
		return arg_27_0.exploreCollection
	elseif arg_27_1 == PlayerCardEnum.LeftContent.Act148SSSCount then
		if arg_27_0.act128SSSCount > 0 then
			return luaLang("playercard_act128SSSCount") .. arg_27_0.act128SSSCount
		else
			return -1
		end
	elseif arg_27_1 == PlayerCardEnum.LeftContent.TowerLayer then
		if arg_27_0.towerLayer > 0 then
			local var_27_2 = TowerConfig.instance:getPermanentEpisodeCo(arg_27_0.towerLayer)
			local var_27_3 = string.splitToNumber(var_27_2.episodeIds, "|")
			local var_27_4 = var_27_3[#var_27_3]

			return DungeonConfig.instance:getEpisodeCO(var_27_4).name
		end

		return -1
	elseif arg_27_1 == PlayerCardEnum.LeftContent.TowerBossPassCount then
		if arg_27_0.towerBossPassCount > 0 then
			return luaLang("playercard_towerbosspasscount") .. arg_27_0.towerBossPassCount
		else
			return -1
		end
	elseif arg_27_1 == PlayerCardEnum.LeftContent.WeekwalkVer2PlatinumCup then
		if arg_27_0.weekwalkVer2PlatinumCup >= 0 then
			return luaLang("playercard_weekwalkVer2PlatinumCup") .. arg_27_0.weekwalkVer2PlatinumCup
		else
			return -1
		end
	end
end

function var_0_0.getBaseInfoByIndex(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getPlayerInfo()

	if not var_28_0 then
		return
	end

	if arg_28_1 == PlayerCardEnum.RightContent.LoginDay then
		if arg_28_2 then
			return var_28_0.totalLoginDays, luaLang("time_day")
		else
			return var_28_0.totalLoginDays .. luaLang("time_day")
		end
	elseif arg_28_1 == PlayerCardEnum.RightContent.HeroCount then
		return arg_28_0:getHeroCount()
	elseif arg_28_1 == PlayerCardEnum.RightContent.CreatTime then
		return (TimeUtil.timestampToString3(ServerTime.timeInLocal(var_28_0.registerTime / 1000)))
	elseif arg_28_1 == PlayerCardEnum.RightContent.AssitCount then
		return arg_28_0.assistTimes or 0
	elseif arg_28_1 == PlayerCardEnum.RightContent.CompleteConfidence then
		return arg_28_0.maxFaithHeroCount or 0
	elseif arg_28_1 == PlayerCardEnum.RightContent.MaxLevelHero then
		return arg_28_0.maxLevelHero or 0
	elseif arg_28_1 == PlayerCardEnum.RightContent.SkinCount then
		return arg_28_0.skinCount or 0
	elseif arg_28_1 == PlayerCardEnum.RightContent.TotalCostPower then
		local var_28_1 = arg_28_0.totalCostPower or 0

		if arg_28_2 then
			return var_28_1, luaLang("NewPlayerCardView_activity_only")
		else
			return string.format(luaLang("NewPlayerCardView_activity"), var_28_1)
		end
	elseif arg_28_1 == PlayerCardEnum.RightContent.HeroCoverTimes then
		local var_28_2 = arg_28_0.heroCoverTimes or 0

		if arg_28_2 then
			return var_28_2, luaLang("NewPlayerCardView_times_only")
		else
			return string.format(luaLang("NewPlayerCardView_times"), var_28_2)
		end
	end
end

function var_0_0.getHeroCount(arg_29_0)
	local var_29_0 = arg_29_0:getPlayerInfo()

	if not var_29_0 then
		return
	end

	return var_29_0.heroRareNNCount + var_29_0.heroRareNCount + var_29_0.heroRareRCount + var_29_0.heroRareSRCount + var_29_0.heroRareSSRCount
end

function var_0_0.getHeroRarePercent(arg_30_0)
	local var_30_0 = arg_30_0:getPlayerInfo()

	if not var_30_0 then
		return nil
	end

	local var_30_1 = HeroConfig.instance:getAnyOnlineRareCharacterCount(1)
	local var_30_2 = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	local var_30_3 = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	local var_30_4 = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	local var_30_5 = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)
	local var_30_6 = math.min(var_30_1 > 0 and var_30_0.heroRareNNCount / var_30_1 or 1, 1)
	local var_30_7 = math.min(var_30_2 > 0 and var_30_0.heroRareNCount / var_30_2 or 1, 1)
	local var_30_8 = math.min(var_30_3 > 0 and var_30_0.heroRareRCount / var_30_3 or 1, 1)
	local var_30_9 = math.min(var_30_4 > 0 and var_30_0.heroRareSRCount / var_30_4 or 1, 1)
	local var_30_10 = math.min(var_30_5 > 0 and var_30_0.heroRareSSRCount / var_30_5 or 1, 1)

	return var_30_6, var_30_7, var_30_8, var_30_9, var_30_10
end

return var_0_0
