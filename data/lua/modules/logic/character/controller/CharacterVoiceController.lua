module("modules.logic.character.controller.CharacterVoiceController", package.seeall)

slot0 = class("CharacterVoiceController", BaseController)

function slot0.onInit(slot0)
	slot0._defaultValueMap = {
		[CharacterVoiceEnum.Hero.Luxi] = CharacterVoiceEnum.LuxiState.MetalFace
	}
	slot0._changeValueMap = {
		[CharacterVoiceEnum.Hero.Luxi] = slot0._getLuxiChangeValue
	}
end

function slot0.getDefaultValue(slot0, slot1)
	return slot0._defaultValueMap[slot1]
end

function slot0.getChangeValue(slot0, slot1)
	return slot0._changeValueMap[slot1.heroId] and slot2(slot0, slot1)
end

function slot0._getLuxiChangeValue(slot0, slot1)
	if slot1.stateCondition == CharacterVoiceEnum.LuxiState.MetalFace then
		return CharacterVoiceEnum.LuxiState.HumanFace
	else
		return CharacterVoiceEnum.LuxiState.MetalFace
	end
end

function slot0.getIdle(slot0, slot1)
	if slot1 == CharacterVoiceEnum.Hero.Luxi then
		if PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, slot1, slot0:getDefaultValue(slot1)) == CharacterVoiceEnum.LuxiState.HumanFace then
			return StoryAnimName.B_IDLE1
		else
			return StoryAnimName.B_IDLE
		end
	end

	return StoryAnimName.B_IDLE
end

function slot0.setSpecialInteractionPlayType(slot0, slot1)
	slot0._playType = slot1
end

function slot0.getSpecialInteractionPlayType(slot0)
	return slot0._playType
end

function slot0.trackSpecialInteraction(slot0, slot1, slot2, slot3)
	if not HeroConfig.instance:getHeroCO(slot1) then
		return
	end

	StatController.instance:track(StatEnum.EventName.Interactive_special_action, {
		[StatEnum.EventProperties.HeroId] = tonumber(slot1),
		[StatEnum.EventProperties.HeroName] = slot4.name,
		[StatEnum.EventProperties.VoiceId] = tostring(slot2),
		[StatEnum.EventProperties.trigger_type] = tostring(slot3 == CharacterVoiceEnum.PlayType.Click and "主动触发" or "被动触发")
	})
end

slot0.instance = slot0.New()

return slot0
