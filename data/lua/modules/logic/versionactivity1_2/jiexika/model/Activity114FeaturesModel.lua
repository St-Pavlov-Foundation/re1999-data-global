module("modules.logic.versionactivity1_2.jiexika.model.Activity114FeaturesModel", package.seeall)

slot0 = class("Activity114FeaturesModel", ListScrollModel)

function slot0.onFeatureListUpdate(slot0, slot1)
	for slot6 = 1, #slot1 do
	end

	slot0:setList({
		[slot6] = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, slot1[slot6])
	})
end

function slot0.getAllMaxLength(slot0, slot1)
	for slot7, slot8 in pairs(Activity114Config.instance:getFeatureName(Activity114Model.instance.id)) do
		slot3 = math.max(0, SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot1, slot8))
	end

	return Mathf.Clamp(slot3 + 20, 276, 420)
end

function slot0.getFeaturePreferredLength(slot0, slot1, slot2, slot3)
	return Mathf.Clamp(slot0:getFeatureMaxLength(slot1) + 20, slot2, slot3)
end

function slot0.getFeatureMaxLength(slot0, slot1)
	for slot7, slot8 in pairs(slot0:getList()) do
		slot3 = math.max(0, SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot1, slot8.features))
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
