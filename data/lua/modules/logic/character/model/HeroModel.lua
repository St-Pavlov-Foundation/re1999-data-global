module("modules.logic.character.model.HeroModel", package.seeall)

local var_0_0 = class("HeroModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._heroId2MODict = {}
	arg_1_0._skinIdDict = {}
	arg_1_0._touchHeadNumber = 0
	arg_1_0._hookGetHeroId = {}
	arg_1_0._hookGetHeroUid = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._heroId2MODict = {}
	arg_2_0._skinIdDict = {}
	arg_2_0._touchHeadNumber = 0
	arg_2_0._hookGetHeroId = {}
	arg_2_0._hookGetHeroUid = {}
end

function var_0_0.setTouchHeadNumber(arg_3_0, arg_3_1)
	arg_3_0._touchHeadNumber = arg_3_1
end

function var_0_0.getTouchHeadNumber(arg_4_0)
	return arg_4_0._touchHeadNumber
end

function var_0_0.addGuideHero(arg_5_0, arg_5_1)
	if arg_5_0._heroId2MODict[arg_5_1] then
		return
	end

	local var_5_0 = HeroConfig.instance:getHeroCO(arg_5_1)
	local var_5_1 = HeroMo.New()

	var_5_1:init({
		heroId = arg_5_1,
		skin = var_5_0.skinId
	}, var_5_0)

	var_5_1.isGuideAdd = true
	arg_5_0._heroId2MODict[arg_5_1] = var_5_1
end

function var_0_0.removeGuideHero(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._heroId2MODict[arg_6_1]

	if var_6_0 and var_6_0.isGuideAdd then
		arg_6_0._heroId2MODict[arg_6_1] = nil
	end
end

function var_0_0.onGetHeroList(arg_7_0, arg_7_1)
	local var_7_0 = {}

	arg_7_0._heroId2MODict = {}

	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			local var_7_1 = HeroConfig.instance:getHeroCO(iter_7_1.heroId)
			local var_7_2 = HeroMo.New()

			var_7_2:init(iter_7_1, var_7_1)
			table.insert(var_7_0, var_7_2)

			arg_7_0._heroId2MODict[var_7_2.heroId] = var_7_2
		end
	end

	arg_7_0:setList(var_7_0)
end

function var_0_0.onGetSkinList(arg_8_0, arg_8_1)
	arg_8_0._skinIdDict = {}

	if arg_8_1 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			arg_8_0._skinIdDict[iter_8_1] = true
		end
	end
end

function var_0_0.onGainSkinList(arg_9_0, arg_9_1)
	arg_9_0._skinIdDict[arg_9_1] = true

	CharacterController.instance:dispatchEvent(CharacterEvent.GainSkin, arg_9_1)
end

function var_0_0.setHeroFavorState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:getByHeroId(arg_10_1).isFavor = arg_10_2
end

function var_0_0.setHeroLevel(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:getByHeroId(arg_11_1).level = arg_11_2
end

function var_0_0.setHeroRank(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:getByHeroId(arg_12_1).rank = arg_12_2
end

function var_0_0.onSetHeroChange(arg_13_0, arg_13_1)
	if arg_13_1 then
		local var_13_0

		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			local var_13_1 = arg_13_0:getById(iter_13_1.uid)

			if not var_13_1 then
				local var_13_2 = HeroConfig.instance:getHeroCO(iter_13_1.heroId)
				local var_13_3 = HeroMo.New()

				var_13_3:init(iter_13_1, var_13_2)

				var_13_0 = var_13_0 or {}

				table.insert(var_13_0, var_13_3)

				arg_13_0._heroId2MODict[var_13_3.heroId] = var_13_3

				if SDKMediaEventEnum.HeroGetEvent[iter_13_1.heroId] then
					SDKDataTrackMgr.instance:trackMediaEvent(SDKMediaEventEnum.HeroGetEvent[iter_13_1.heroId])
				end

				if iter_13_1.heroId == 3023 then
					SDKChannelEventModel.instance:firstSummon()
				end

				if var_13_2.rare == CharacterEnum.MaxRare then
					SDKChannelEventModel.instance:getMaxRareHero()
				end
			else
				var_13_1:update(iter_13_1)
			end
		end

		if var_13_0 then
			arg_13_0:addList(var_13_0)
		end
	end
end

function var_0_0._sortSpecialTouch(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		if iter_14_1.type == arg_14_2 then
			table.insert(var_14_0, iter_14_1)
		end
	end

	if not arg_14_0._specialSortRule then
		arg_14_0._specialSortRule = {
			2,
			1,
			3
		}
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_14_0._specialSortRule[tonumber(arg_15_0.param)] > arg_14_0._specialSortRule[tonumber(arg_15_1.param)]
	end)

	return var_14_0
end

function var_0_0.getVoiceConfig(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if not arg_16_0:getByHeroId(arg_16_1) then
		print("======not hero:", arg_16_1)

		return
	end

	local var_16_0 = arg_16_0:getHeroAllVoice(arg_16_1, arg_16_4)

	if not var_16_0 or not next(var_16_0) then
		return {}
	end

	if arg_16_2 == CharacterEnum.VoiceType.MainViewSpecialTouch then
		var_16_0 = arg_16_0:_sortSpecialTouch(var_16_0, arg_16_2)
	end

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if iter_16_1.type == arg_16_2 and (not arg_16_3 or arg_16_3(iter_16_1)) then
			table.insert(var_16_1, iter_16_1)
		end
	end

	return var_16_1
end

function var_0_0.getHeroAllVoice(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = CharacterDataConfig.instance:getCharacterVoicesCo(arg_17_1)
	local var_17_2 = arg_17_0:getByHeroId(arg_17_1)

	if not var_17_1 then
		return var_17_0
	end

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		if arg_17_0:_checkSkin(var_17_2, iter_17_1, arg_17_2) then
			local var_17_3 = iter_17_1.audio

			if iter_17_1.type == CharacterEnum.VoiceType.GetSkin and string.nilorempty(iter_17_1.unlockCondition) and not string.nilorempty(iter_17_1.param) then
				local var_17_4 = tonumber(iter_17_1.param)

				for iter_17_2, iter_17_3 in ipairs(var_17_2.skinInfoList) do
					if iter_17_3.skin == var_17_4 then
						var_17_0[var_17_3] = iter_17_1

						break
					end
				end
			elseif iter_17_1.type == CharacterEnum.VoiceType.BreakThrough and string.nilorempty(iter_17_1.unlockCondition) then
				if var_17_2.rank >= 2 then
					var_17_0[var_17_3] = iter_17_1
				end
			elseif arg_17_0:_cleckCondition(iter_17_1.unlockCondition, arg_17_1) then
				var_17_0[var_17_3] = iter_17_1
			end
		end
	end

	local var_17_5 = var_17_2.voice

	for iter_17_4, iter_17_5 in pairs(var_17_5) do
		if not var_17_0[iter_17_5] then
			local var_17_6 = CharacterDataConfig.instance:getCharacterVoiceCO(arg_17_1, iter_17_5)

			if arg_17_0:_checkSkin(var_17_2, var_17_6, arg_17_2) then
				var_17_0[iter_17_5] = var_17_6
			end
		end
	end

	return var_17_0
end

function var_0_0._checkSkin(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_2 then
		return false
	end

	if arg_18_2.stateCondition ~= 0 then
		local var_18_0 = CharacterVoiceController.instance:getDefaultValue(arg_18_1.heroId)
		local var_18_1 = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, arg_18_1.heroId, var_18_0)

		if arg_18_2.stateCondition ~= var_18_1 then
			return false
		end
	end

	if string.nilorempty(arg_18_2.skins) then
		return true
	end

	return string.find(arg_18_2.skins, arg_18_3 or arg_18_1.skin)
end

function var_0_0._cleckCondition(arg_19_0, arg_19_1, arg_19_2)
	if string.nilorempty(arg_19_1) then
		return true
	end

	local var_19_0 = arg_19_0:getByHeroId(arg_19_2).faith
	local var_19_1 = HeroConfig.instance:getFaithPercent(var_19_0)[1]
	local var_19_2 = string.split(arg_19_1, "#")

	if tonumber(var_19_2[1]) == 1 then
		return tonumber(var_19_2[2]) <= var_19_1 * 100
	end

	return true
end

function var_0_0.addHookGetHeroId(arg_20_0, arg_20_1)
	arg_20_0._hookGetHeroId[arg_20_1] = arg_20_1
end

function var_0_0.removeHookGetHeroId(arg_21_0, arg_21_1)
	arg_21_0._hookGetHeroId[arg_21_1] = nil
end

function var_0_0.addHookGetHeroUid(arg_22_0, arg_22_1)
	arg_22_0._hookGetHeroUid[arg_22_1] = arg_22_1
end

function var_0_0.removeHookGetHeroUid(arg_23_0, arg_23_1)
	arg_23_0._hookGetHeroUid[arg_23_1] = nil
end

function var_0_0.getById(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in pairs(arg_24_0._hookGetHeroUid) do
		local var_24_0 = iter_24_0(arg_24_1)

		if var_24_0 then
			return var_24_0
		end
	end

	return var_0_0.super.getById(arg_24_0, arg_24_1)
end

function var_0_0.getByHeroId(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._hookGetHeroId) do
		local var_25_0 = iter_25_0(arg_25_1)

		if var_25_0 then
			return var_25_0
		end
	end

	return arg_25_0._heroId2MODict[arg_25_1]
end

function var_0_0.getAllHero(arg_26_0)
	return arg_26_0._heroId2MODict
end

function var_0_0.getAllFavorHeros(arg_27_0)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(arg_27_0._heroId2MODict) do
		if iter_27_1.isFavor then
			table.insert(var_27_0, iter_27_1.heroId)
		end
	end

	return var_27_0
end

function var_0_0.checkHasSkin(arg_28_0, arg_28_1)
	if arg_28_0._skinIdDict[arg_28_1] then
		return true
	end

	local var_28_0 = SkinConfig.instance:getSkinCo(arg_28_1)
	local var_28_1 = arg_28_0:getByHeroId(var_28_0.characterId)

	if var_28_1 then
		if var_28_1.config.skinId == arg_28_1 then
			return true
		end

		for iter_28_0, iter_28_1 in ipairs(var_28_1.skinInfoList) do
			if iter_28_1.skin == arg_28_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getAllHeroGroup(arg_29_0)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0._heroId2MODict) do
		local var_29_1 = string.byte(iter_29_1.config.initials)

		if var_29_0[var_29_1] == nil then
			var_29_0[var_29_1] = {}
		end

		table.insert(var_29_0[var_29_1], iter_29_1.heroId)
		table.sort(var_29_0[var_29_1], function(arg_30_0, arg_30_1)
			local var_30_0 = arg_29_0:getByHeroId(arg_30_0).config.rare
			local var_30_1 = arg_29_0:getByHeroId(arg_30_1).config.rare

			if var_30_0 == var_30_1 then
				return arg_30_0 < arg_30_1
			else
				return var_30_1 < var_30_0
			end
		end)
	end

	return var_29_0
end

function var_0_0.checkGetRewards(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0._heroId2MODict[arg_31_1].itemUnlock

	for iter_31_0 = 1, #var_31_0 do
		if var_31_0[iter_31_0] == arg_31_2 then
			return true
		end
	end

	return false
end

function var_0_0.getCurrentSkinConfig(arg_32_0, arg_32_1)
	local var_32_0 = SkinConfig.instance:getSkinCo(arg_32_0:getCurrentSkinId(arg_32_1))

	if var_32_0 then
		return var_32_0
	else
		logError("获取当前角色的皮肤配置失败， heroId : " .. tonumber(arg_32_1))
	end
end

function var_0_0.getCurrentSkinId(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0._heroId2MODict[arg_33_1].skin

	if not var_33_0 then
		logError("获取当前角色的皮肤Id失败， heroId : " .. tonumber(arg_33_1))
	end

	return var_33_0
end

function var_0_0.getHighestLevel(arg_34_0)
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in pairs(arg_34_0._heroId2MODict) do
		if var_34_0 < iter_34_1.level then
			var_34_0 = iter_34_1.level
		end
	end

	return var_34_0
end

function var_0_0.takeoffAllTalentCube(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getByHeroId(arg_35_1)

	if not var_35_0 then
		logError("找不到英雄!!!  id:", arg_35_1)

		return
	end

	var_35_0:clearCubeData()
end

function var_0_0.getCurTemplateId(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getByHeroId(arg_36_1)

	return var_36_0 and var_36_0.useTalentTemplateId or 1
end

function var_0_0.isMaxExSkill(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = false
	local var_37_1 = var_0_0.instance:getByHeroId(arg_37_1)

	if not var_37_1 then
		return var_37_0
	end

	local var_37_2 = var_37_1.exSkillLevel

	if arg_37_2 then
		local var_37_3 = 0
		local var_37_4 = var_37_1.config.duplicateItem

		if not string.nilorempty(var_37_4) then
			local var_37_5 = string.split(var_37_4, "|")[1]

			if var_37_5 then
				local var_37_6 = string.splitToNumber(var_37_5, "#")

				var_37_3 = ItemModel.instance:getItemQuantity(var_37_6[1], var_37_6[2])
			end
		end

		var_37_2 = var_37_2 + var_37_3
	end

	return var_37_2 >= CharacterEnum.MaxSkillExLevel
end

var_0_0.instance = var_0_0.New()

return var_0_0
