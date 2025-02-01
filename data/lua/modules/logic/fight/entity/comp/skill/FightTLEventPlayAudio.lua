module("modules.logic.fight.entity.comp.skill.FightTLEventPlayAudio", package.seeall)

slot0 = class("FightTLEventPlayAudio")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill and slot3[2] == "1" then
		if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill <= 0 then
			return
		end

		FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill - 1
	end

	slot4 = tonumber(slot3[1])

	if not FightHelper.getEntity(slot1.fromId) then
		return
	end

	slot6 = slot5:getMO()
	slot9 = nil

	if slot1.supportHeroId ~= 0 and slot1.supportHeroId or slot6 and slot6.modelId then
		if slot5:isMySide() then
			slot10, slot11, slot12 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot7)

			if slot12 then
				FightAudioMgr.instance:playAudio(slot4)
			else
				if not string.nilorempty(LangSettings.shortcutTab[slot10]) then
					slot9 = slot13
				end

				FightAudioMgr.instance:playAudioWithLang(slot4, slot9)
			end
		else
			FightAudioMgr.instance:playAudioWithLang(slot4, GameConfig:GetCurVoiceShortcut())
		end
	else
		FightAudioMgr.instance:playAudio(slot4)
	end

	slot1.atkAudioId = slot4
	slot0._audioId = slot4
end

function slot0.skipSkill(slot0)
	FightAudioMgr.instance:stopAudio(slot0._audioId)
end

return slot0
