module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameSkillEffectMo", package.seeall)

slot0 = pureTable("YaXianGameSkillEffectMo")

function slot0.init(slot0, slot1, slot2)
	slot0.actId = slot1

	slot0:updateMO(slot2)
end

function slot0.updateMO(slot0, slot1)
	slot0.effectType = slot1.effectType
	slot0.effectUid = slot1.effectUid
	slot0.remainRound = slot1.remainRound
	slot0.skillId = slot1.skillId
	slot0.skillMo = YaXianGameModel.instance:getSkillMo(slot0.skillId)
end

return slot0
