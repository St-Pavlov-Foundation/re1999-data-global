module("modules.ugui.icon.common.CommonHeroHelper", package.seeall)

slot0 = class("CommonHeroHelper")

function slot0.setGrayState(slot0, slot1, slot2)
	slot0:_getGrayStateTab()[slot1] = slot2
end

function slot0.getGrayState(slot0, slot1)
	return slot0:_getGrayStateTab()[slot1]
end

function slot0._getGrayStateTab(slot0)
	slot0.grayTab = slot0.grayTab or {}

	return slot0.grayTab
end

function slot0.resetGrayState(slot0)
	slot0.grayTab = {}
end

slot0.instance = slot0.New()

return slot0
