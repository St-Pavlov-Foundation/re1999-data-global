module("modules.logic.versionactivity2_5.challenge.model.Act183HeroMO", package.seeall)

slot0 = pureTable("Act183HeroMO")

function slot0.init(slot0, slot1)
	slot0._heroId = tonumber(slot1.heroId)
	slot0._trialId = tonumber(slot1.trialId)

	if slot0._heroId and slot0._heroId ~= 0 then
		slot0._heroType = Act183Enum.HeroType.Normal
		slot0._heroMo = HeroModel.instance:getByHeroId(slot0._heroId)
	elseif slot0._trialId and slot0._trialId ~= 0 then
		slot0._heroType = Act183Enum.HeroType.Trial
		slot0._heroMo = HeroMo.New()

		slot0._heroMo:initFromTrial(slot0._trialId)
	else
		logError("角色唯一id和试用id都为0")
	end

	if not slot0._heroMo then
		logError(string.format("角色数据不存在 heroId = %s, trialId = %s", slot0._heroId, slot0._trialId))
	end

	slot0._config = slot0._heroMo and slot0._heroMo.config
end

function slot0.getHeroMo(slot0)
	return slot0._heroMo
end

function slot0.getHeroType(slot0)
	return slot0._heroType
end

function slot0.getHeroIconUrl(slot0)
	if slot0._heroType == Act183Enum.HeroType.Normal then
		return ResUrl.getHeadIconSmall(slot0._heroMo.skin)
	elseif slot0._heroType == Act183Enum.HeroType.Trial then
		return ResUrl.getHeadIconSmall(slot0._heroMo.skin)
	else
		logError("GetHeroIconUrl error")
	end
end

function slot0.getHeroCarrer(slot0)
	return slot0._config.career
end

function slot0.getHeroId(slot0)
	return slot0._heroMo and slot0._heroMo.heroId
end

return slot0
