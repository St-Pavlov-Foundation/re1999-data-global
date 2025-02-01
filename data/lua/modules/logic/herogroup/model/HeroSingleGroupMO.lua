module("modules.logic.herogroup.model.HeroSingleGroupMO", package.seeall)

slot0 = pureTable("HeroSingleGroupMO")

function slot0.ctor(slot0)
	slot0.id = nil
	slot0.heroUid = nil
	slot0.aid = nil
	slot0.trial = nil
	slot0.trialTemplate = nil
	slot0.trialPos = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.heroUid = slot2 or "0"
	slot0.trial = nil
	slot0.trialTemplate = nil
	slot0.trialPos = nil
end

function slot0.setAid(slot0, slot1)
	slot0.aid = slot1
end

function slot0.setTrial(slot0, slot1, slot2, slot3, slot4)
	if slot0.trial and not slot4 and slot0:getTrialCO().equipId > 0 then
		HeroGroupModel.instance:getCurGroupMO():updatePosEquips({
			index = slot0.id - 1
		})
	end

	slot0.trial = slot1
	slot0.trialTemplate = slot2 or 0
	slot0.trialPos = slot0.trialPos or slot3

	if not slot1 then
		slot0.trialPos = nil
	end

	if slot1 and not slot4 and slot0:getTrialCO().equipId > 0 then
		slot5:updatePosEquips({
			index = slot0.id - 1
		})
	end
end

function slot0.getHeroMO(slot0)
	return slot0.heroUid and HeroModel.instance:getById(slot0.heroUid)
end

function slot0.getHeroCO(slot0)
	return slot0:getHeroMO() and lua_character.configDict[slot1.heroId]
end

function slot0.getMonsterCO(slot0)
	return slot0.aid and lua_monster.configDict[slot0.aid]
end

function slot0.getTrialCO(slot0)
	return slot0.trial and lua_hero_trial.configDict[slot0.trial][slot0.trialTemplate]
end

function slot0.setEmpty(slot0)
	slot0.heroUid = "0"

	slot0:setTrial()
end

function slot0.setHeroUid(slot0, slot1)
	slot0.heroUid = slot1
end

function slot0.isEqual(slot0, slot1)
	return not slot0:isEmpty() and slot0.heroUid == slot1
end

function slot0.isEmpty(slot0)
	if slot0.aid then
		return slot0.aid == -1
	else
		return not slot0.heroUid or slot0.heroUid == "0"
	end
end

function slot0.canAddHero(slot0)
	if slot0.aid then
		return false
	else
		return not slot0.heroUid or slot0.heroUid == "0"
	end
end

function slot0.isAidConflict(slot0, slot1)
	if not slot0.aid or slot0.aid == -1 then
		return false
	end

	if lua_monster.configDict[tonumber(slot0.aid)] and tonumber(string.sub(tostring(slot2.skinId), 1, 4)) and slot3 == tonumber(slot1) then
		return true
	end

	return false
end

return slot0
