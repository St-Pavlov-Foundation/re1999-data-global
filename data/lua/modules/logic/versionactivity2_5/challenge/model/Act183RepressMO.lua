module("modules.logic.versionactivity2_5.challenge.model.Act183RepressMO", package.seeall)

slot0 = pureTable("Act183RepressMO")

function slot0.init(slot0, slot1)
	slot0._ruleIndex = slot1.ruleIndex
	slot0._heroIndex = slot1.heroIndex or 0
end

function slot0.hasRepress(slot0)
	return slot0._ruleIndex ~= 0
end

function slot0.getRuleIndex(slot0)
	return slot0._ruleIndex
end

function slot0.getHeroIndex(slot0)
	return slot0._heroIndex
end

return slot0
