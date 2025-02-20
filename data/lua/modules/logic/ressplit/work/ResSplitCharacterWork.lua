module("modules.logic.ressplit.work.ResSplitCharacterWork", package.seeall)

slot0 = class("ResSplitCharacterWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot3 = lua_monster_skin.configList

	for slot8, slot9 in pairs(SkinConfig.instance:getAllSkinCoList()) do
		table.insert({}, slot9)
	end

	for slot8, slot9 in pairs(slot3) do
		table.insert(slot4, slot9)
	end

	for slot8, slot9 in pairs(slot4) do
		if ResSplitModel.instance:isExcludeCharacter(slot9.characterId) and ResSplitModel.instance:isExcludeSkin(slot9.id) then
			slot0:_addSkinRes(slot9, true)
		else
			slot0:_addSkinRes(slot9, false)
		end
	end

	for slot9, slot10 in pairs(HeroConfig.instance.heroConfig.configDict) do
		slot11 = ResSplitModel.instance:isExcludeCharacter(slot9)

		if ResSplitModel.instance:isExcludeCharacter(slot9) then
			if CharacterDataConfig.instance:getCharacterVoicesCo(slot9) then
				for slot16, slot17 in pairs(slot12) do
					if ResSplitModel.instance.audioDic[slot16] then
						ResSplitModel.instance:setExclude(ResSplitEnum.AudioBank, slot18.bankName, true)
					end
				end
			end
		else
			for slot16, slot17 in ipairs(FightHelper.buildSkills(slot9)) do
				ResSplitModel.instance:addIncludeSkill(slot17)
			end
		end

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getSignature(slot10.signature), slot11)
	end

	slot0:onDone(true)
end

function slot0._addSkinRes(slot0, slot1, slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadSkinSmall(slot1.id), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHandbookheroIcon(slot1.id), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconImg(slot1.drawing), slot2)
	ResSplitHelper.checkConfigEmpty(string.format("skin:%d", slot1.id), "headIcon", slot1.headIcon)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconSmall(slot1.headIcon), false)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconMiddle(slot1.retangleIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconSmall(slot1.retangleIcon), false)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconLarge(slot1.retangleIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadIconLarge(slot1.largeIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadSkinIconMiddle(slot1.skinGetIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Path, ResUrl.getHeadSkinIconLarge(slot1.skinGetBackIcon), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, ResUrl.getLightLive2dFolder(slot1.live2d), slot2)

	slot6 = ResUrl.getRolesPrefabStoryFolder(slot1.verticalDrawing)

	ResSplitModel.instance:setExclude(ResSplitEnum.Path, string.sub(slot6, 1, string.len(slot6) - 1), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, string.format("roles/%s/", string.split(slot1.spine, "/")[1]), slot2)
	ResSplitModel.instance:setExclude(ResSplitEnum.Folder, string.format("roles/%s/", string.split(slot1.alternateSpine, "/")[1]), slot2)

	if slot2 == false then
		FightConfig.instance:_checkskinSkill()

		if FightConfig.instance._skinSkillTLDict[slot1.id] then
			for slot12, slot13 in pairs(slot8) do
				ResSplitModel.instance:addIncludeTimeline(slot13)
			end
		end
	end
end

return slot0
