module("modules.logic.fight.entity.comp.skill.FightTLEventPlayAudio", package.seeall)

local var_0_0 = class("FightTLEventPlayAudio", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill and arg_1_3[2] == "1" then
		if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill <= 0 then
			return
		end

		FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill - 1
	end

	local var_1_0 = tonumber(arg_1_3[1])
	local var_1_1 = FightHelper.getEntity(arg_1_1.fromId)

	if not var_1_1 then
		return
	end

	local var_1_2 = var_1_1:getMO()
	local var_1_3 = arg_1_1.supportHeroId ~= 0 and arg_1_1.supportHeroId or var_1_2 and var_1_2.modelId
	local var_1_4 = var_1_1:isMySide()
	local var_1_5

	if var_1_3 then
		if var_1_4 then
			local var_1_6, var_1_7, var_1_8 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_1_3)

			if var_1_8 then
				FightAudioMgr.instance:playAudio(var_1_0)
			else
				local var_1_9 = LangSettings.shortcutTab[var_1_6]

				if not string.nilorempty(var_1_9) then
					var_1_5 = var_1_9
				end

				FightAudioMgr.instance:playAudioWithLang(var_1_0, var_1_5)
			end
		else
			local var_1_10 = GameConfig:GetCurVoiceShortcut()

			FightAudioMgr.instance:playAudioWithLang(var_1_0, var_1_10)
		end
	else
		FightAudioMgr.instance:playAudio(var_1_0)
	end

	arg_1_1.atkAudioId = var_1_0
	arg_1_0._audioId = var_1_0
end

function var_0_0.skipSkill(arg_2_0)
	FightAudioMgr.instance:stopAudio(arg_2_0._audioId)
end

return var_0_0
