module("modules.logic.guide.controller.invalidcondition.GuideInvalidCondition", package.seeall)

slot0 = _M

function slot0.checkSetEquip()
	if not HeroGroupModel.instance:getCustomHeroGroupMo(ModuleEnum.HeroGroupServerType.Equip) then
		return false
	end

	for slot5, slot6 in pairs(slot0:getAllPosEquips()) do
		if slot6 and slot6.equipUid and slot6.equipUid[1] ~= "0" then
			return true
		end
	end

	return false
end

function slot0.checkAllGroupSetEquip()
	for slot4, slot5 in ipairs(HeroGroupModel.instance:getList()) do
		for slot10, slot11 in pairs(slot5:getAllPosEquips()) do
			if slot11 and slot11.equipUid and slot11.equipUid[1] ~= "0" then
				return true
			end
		end
	end

	return false
end

function slot0.checkSummon()
	return HeroModel.instance:getList() and #slot0 > 1
end

function slot0.checkMainSceneSkin()
	return MainSceneSwitchModel.instance:getCurSceneId() ~= MainSceneSwitchConfig.instance:getDefaultSceneId()
end

function slot0.checkFinishElement4_6()
	return DungeonMapModel.instance:elementIsFinished(1040601)
end

function slot0.checkFinishGuide(slot0, slot1)
	return GuideModel.instance:isGuideFinish(tonumber(slot1[3]))
end

return slot0
