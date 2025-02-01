module("modules.logic.versionactivity1_9.heroinvitation.config.HeroInvitationConfig", package.seeall)

slot0 = class("HeroInvitationConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"hero_invitation"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "hero_invitation" then
		slot0._roleStoryConfig = slot2

		slot0:initHeroInvitation()
	end
end

function slot0.initHeroInvitation(slot0)
	slot0._elementDict = {}

	for slot4, slot5 in ipairs(slot0._roleStoryConfig.configList) do
		slot0._elementDict[slot5.elementId] = slot5
	end
end

function slot0.getInvitationConfig(slot0, slot1)
	return slot0._roleStoryConfig.configDict[slot1]
end

function slot0.getInvitationList(slot0)
	return slot0._roleStoryConfig.configList
end

function slot0.getInvitationConfigByElementId(slot0, slot1)
	return slot0._elementDict[slot1]
end

slot0.instance = slot0.New()

return slot0
