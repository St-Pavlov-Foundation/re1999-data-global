module("modules.logic.character.model.HeroModel", package.seeall)

slot0 = class("HeroModel", BaseModel)

function slot0.onInit(slot0)
	slot0._heroId2MODict = {}
	slot0._skinIdDict = {}
	slot0._touchHeadNumber = 0
	slot0._hookGetHeroId = {}
	slot0._hookGetHeroUid = {}
end

function slot0.reInit(slot0)
	slot0._heroId2MODict = {}
	slot0._skinIdDict = {}
	slot0._touchHeadNumber = 0
	slot0._hookGetHeroId = {}
	slot0._hookGetHeroUid = {}
end

function slot0.setTouchHeadNumber(slot0, slot1)
	slot0._touchHeadNumber = slot1
end

function slot0.getTouchHeadNumber(slot0)
	return slot0._touchHeadNumber
end

function slot0.addGuideHero(slot0, slot1)
	if slot0._heroId2MODict[slot1] then
		return
	end

	slot2 = HeroConfig.instance:getHeroCO(slot1)
	slot3 = HeroMo.New()

	slot3:init({
		heroId = slot1,
		skin = slot2.skinId
	}, slot2)

	slot3.isGuideAdd = true
	slot0._heroId2MODict[slot1] = slot3
end

function slot0.removeGuideHero(slot0, slot1)
	if slot0._heroId2MODict[slot1] and slot2.isGuideAdd then
		slot0._heroId2MODict[slot1] = nil
	end
end

function slot0.onGetHeroList(slot0, slot1)
	slot2 = {}
	slot0._heroId2MODict = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot9 = HeroMo.New()

			slot9:init(slot7, HeroConfig.instance:getHeroCO(slot7.heroId))
			table.insert(slot2, slot9)

			slot0._heroId2MODict[slot9.heroId] = slot9
		end
	end

	slot0:setList(slot2)
end

function slot0.onGetSkinList(slot0, slot1)
	slot0._skinIdDict = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0._skinIdDict[slot6] = true
		end
	end
end

function slot0.onGainSkinList(slot0, slot1)
	slot0._skinIdDict[slot1] = true

	CharacterController.instance:dispatchEvent(CharacterEvent.GainSkin, slot1)
end

function slot0.setHeroFavorState(slot0, slot1, slot2)
	slot0:getByHeroId(slot1).isFavor = slot2
end

function slot0.setHeroLevel(slot0, slot1, slot2)
	slot0:getByHeroId(slot1).level = slot2
end

function slot0.setHeroRank(slot0, slot1, slot2)
	slot0:getByHeroId(slot1).rank = slot2
end

function slot0.onSetHeroChange(slot0, slot1)
	if slot1 then
		slot2 = nil

		for slot6, slot7 in ipairs(slot1) do
			if not slot0:getById(slot7.uid) then
				HeroMo.New():init(slot7, HeroConfig.instance:getHeroCO(slot7.heroId))
				table.insert(slot2 or {}, slot10)

				slot0._heroId2MODict[slot10.heroId] = slot10

				if SDKMediaEventEnum.HeroGetEvent[slot7.heroId] then
					SDKDataTrackMgr.instance:trackMediaEvent(SDKMediaEventEnum.HeroGetEvent[slot7.heroId])
				end

				if slot7.heroId == 3023 then
					SDKChannelEventModel.instance:firstSummon()
				end

				if slot9.rare == CharacterEnum.MaxRare then
					SDKChannelEventModel.instance:getMaxRareHero()
				end
			else
				slot8:update(slot7)
			end
		end

		if slot2 then
			slot0:addList(slot2)
		end
	end
end

function slot0._sortSpecialTouch(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot1) do
		if slot8.type == slot2 then
			table.insert({}, slot8)
		end
	end

	if not slot0._specialSortRule then
		slot0._specialSortRule = {
			2,
			1,
			3
		}
	end

	table.sort(slot3, function (slot0, slot1)
		return uv0._specialSortRule[tonumber(slot1.param)] < uv0._specialSortRule[tonumber(slot0.param)]
	end)

	return slot3
end

function slot0.getVoiceConfig(slot0, slot1, slot2, slot3, slot4)
	if not slot0:getByHeroId(slot1) then
		print("======not hero:", slot1)

		return
	end

	if not slot0:getHeroAllVoice(slot1, slot4) or not next(slot6) then
		return {}
	end

	if slot2 == CharacterEnum.VoiceType.MainViewSpecialTouch then
		slot6 = slot0:_sortSpecialTouch(slot6, slot2)
	end

	slot7 = {}

	for slot11, slot12 in pairs(slot6) do
		if slot12.type == slot2 and (not slot3 or slot3(slot12)) then
			table.insert(slot7, slot12)
		end
	end

	return slot7
end

function slot0.getHeroAllVoice(slot0, slot1, slot2)
	slot5 = slot0:getByHeroId(slot1)

	if not CharacterDataConfig.instance:getCharacterVoicesCo(slot1) then
		return {}
	end

	for slot9, slot10 in pairs(slot4) do
		if slot0:_checkSkin(slot5, slot10, slot2) then
			slot11 = slot10.audio

			if slot10.type == CharacterEnum.VoiceType.GetSkin and string.nilorempty(slot10.unlockCondition) and not string.nilorempty(slot10.param) then
				for slot16, slot17 in ipairs(slot5.skinInfoList) do
					if slot17.skin == tonumber(slot10.param) then
						slot3[slot11] = slot10

						break
					end
				end
			elseif slot10.type == CharacterEnum.VoiceType.BreakThrough and string.nilorempty(slot10.unlockCondition) then
				if slot5.rank >= 2 then
					slot3[slot11] = slot10
				end
			elseif slot0:_cleckCondition(slot10.unlockCondition, slot1) then
				slot3[slot11] = slot10
			end
		end
	end

	for slot10, slot11 in pairs(slot5.voice) do
		if not slot3[slot11] and slot0:_checkSkin(slot5, CharacterDataConfig.instance:getCharacterVoiceCO(slot1, slot11), slot2) then
			slot3[slot11] = slot12
		end
	end

	return slot3
end

function slot0._checkSkin(slot0, slot1, slot2, slot3)
	if not slot2 then
		return false
	end

	if slot2.stateCondition ~= 0 and slot2.stateCondition ~= PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, slot1.heroId, CharacterVoiceController.instance:getDefaultValue(slot1.heroId)) then
		return false
	end

	if string.nilorempty(slot2.skins) then
		return true
	end

	return string.find(slot2.skins, slot3 or slot1.skin)
end

function slot0._cleckCondition(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return true
	end

	if tonumber(string.split(slot1, "#")[1]) == 1 then
		return tonumber(slot5[2]) <= HeroConfig.instance:getFaithPercent(slot0:getByHeroId(slot2).faith)[1] * 100
	end

	return true
end

function slot0.addHookGetHeroId(slot0, slot1)
	slot0._hookGetHeroId[slot1] = slot1
end

function slot0.removeHookGetHeroId(slot0, slot1)
	slot0._hookGetHeroId[slot1] = nil
end

function slot0.addHookGetHeroUid(slot0, slot1)
	slot0._hookGetHeroUid[slot1] = slot1
end

function slot0.removeHookGetHeroUid(slot0, slot1)
	slot0._hookGetHeroUid[slot1] = nil
end

function slot0.getById(slot0, slot1)
	for slot5, slot6 in pairs(slot0._hookGetHeroUid) do
		if slot5(slot1) then
			return slot7
		end
	end

	return uv0.super.getById(slot0, slot1)
end

function slot0.getByHeroId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._hookGetHeroId) do
		if slot5(slot1) then
			return slot7
		end
	end

	return slot0._heroId2MODict[slot1]
end

function slot0.getAllHero(slot0)
	return slot0._heroId2MODict
end

function slot0.getAllFavorHeros(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._heroId2MODict) do
		if slot6.isFavor then
			table.insert(slot1, slot6.heroId)
		end
	end

	return slot1
end

function slot0.checkHasSkin(slot0, slot1)
	if slot0._skinIdDict[slot1] then
		return true
	end

	if slot0:getByHeroId(SkinConfig.instance:getSkinCo(slot1).characterId) then
		if slot3.config.skinId == slot1 then
			return true
		end

		for slot7, slot8 in ipairs(slot3.skinInfoList) do
			if slot8.skin == slot1 then
				return true
			end
		end
	end

	return false
end

function slot0.getAllHeroGroup(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._heroId2MODict) do
		if slot1[string.byte(slot6.config.initials)] == nil then
			slot1[slot7] = {}
		end

		table.insert(slot1[slot7], slot6.heroId)
		table.sort(slot1[slot7], function (slot0, slot1)
			if uv0:getByHeroId(slot0).config.rare == uv0:getByHeroId(slot1).config.rare then
				return slot0 < slot1
			else
				return slot3 < slot2
			end
		end)
	end

	return slot1
end

function slot0.checkGetRewards(slot0, slot1, slot2)
	for slot7 = 1, #slot0._heroId2MODict[slot1].itemUnlock do
		if slot3[slot7] == slot2 then
			return true
		end
	end

	return false
end

function slot0.getCurrentSkinConfig(slot0, slot1)
	if SkinConfig.instance:getSkinCo(slot0:getCurrentSkinId(slot1)) then
		return slot2
	else
		logError("获取当前角色的皮肤配置失败， heroId : " .. tonumber(slot1))
	end
end

function slot0.getCurrentSkinId(slot0, slot1)
	if not slot0._heroId2MODict[slot1].skin then
		logError("获取当前角色的皮肤Id失败， heroId : " .. tonumber(slot1))
	end

	return slot2
end

function slot0.getHighestLevel(slot0)
	for slot5, slot6 in pairs(slot0._heroId2MODict) do
		if 0 < slot6.level then
			slot1 = slot6.level
		end
	end

	return slot1
end

function slot0.takeoffAllTalentCube(slot0, slot1)
	if not slot0:getByHeroId(slot1) then
		logError("找不到英雄!!!  id:", slot1)

		return
	end

	slot2:clearCubeData()
end

function slot0.getCurTemplateId(slot0, slot1)
	return slot0:getByHeroId(slot1) and slot2.useTalentTemplateId or 1
end

function slot0.isMaxExSkill(slot0, slot1, slot2)
	if not uv0.instance:getByHeroId(slot1) then
		return false
	end

	slot5 = slot4.exSkillLevel

	if slot2 then
		slot6 = 0

		if not string.nilorempty(slot4.config.duplicateItem) and string.split(slot7, "|")[1] then
			slot10 = string.splitToNumber(slot9, "#")
			slot6 = ItemModel.instance:getItemQuantity(slot10[1], slot10[2])
		end

		slot5 = slot5 + slot6
	end

	return CharacterEnum.MaxSkillExLevel <= slot5
end

slot0.instance = slot0.New()

return slot0
