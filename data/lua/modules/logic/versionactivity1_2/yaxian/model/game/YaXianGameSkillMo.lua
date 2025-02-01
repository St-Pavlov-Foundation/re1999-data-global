module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameSkillMo", package.seeall)

slot0 = pureTable("YaXianGameSkillMo")

function slot0.init(slot0, slot1, slot2)
	slot0.actId = slot1

	slot0:updateMO(slot2)
end

function slot0.updateMO(slot0, slot1)
	slot0.id = slot1.skillId
	slot0.canUseCount = slot1.canUseCount
	slot0.config = YaXianConfig.instance:getSkillConfig(slot0.actId, slot0.id)
end

return slot0
