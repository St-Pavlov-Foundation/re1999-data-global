module("modules.logic.resonance.controller.HeroResonanceController", package.seeall)

slot0 = class("HeroResonanceController", BaseController)

function slot0.ctor(slot0)
end

function slot0.statShareCode(slot0, slot1, slot2, slot3)
	slot4 = {}

	if slot1 and slot1.talentCubeInfos and slot1.talentCubeInfos.data_list then
		for slot8, slot9 in ipairs(slot1.talentCubeInfos.data_list) do
			slot10 = slot9.cubeId

			if slot9.cubeId == slot1.talentCubeInfos.own_main_cube_id then
				slot10 = slot1:getHeroUseStyleCubeId()
			end

			table.insert(slot4, slot10)
		end
	end

	StatController.instance:track(slot2 and StatEnum.EventName.TalentUseRuenCode or StatEnum.EventName.TalentCopyRuenCode, {
		[StatEnum.EventProperties.TalentShareCode] = slot3 or HeroResonaceModel.instance:getShareCode() or "",
		[StatEnum.EventProperties.HeroId] = slot1.heroId,
		[StatEnum.EventProperties.HeroName] = slot1.config.name,
		[StatEnum.EventProperties.TalentRuensStateGroup] = slot4
	})
end

slot0.instance = slot0.New()

return slot0
