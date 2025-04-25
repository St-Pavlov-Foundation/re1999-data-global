module("modules.logic.help.controller.HelpController", package.seeall)

slot0 = class("HelpController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.canShowFirstHelp(slot0, slot1)
	if ViewMgr.instance._openViewNameSet[ViewName.SkinOffsetAdjustView] then
		return
	end

	if GuideModel.instance:isDoingClickGuide() then
		return
	end

	if not GuideController.instance:isForbidGuides() then
		if GuideModel.instance:getDoingGuideId() then
			return
		end

		if slot1 == HelpEnum.HelpId.Dungeon and DungeonModel.instance:hasPassLevel(10115) then
			return
		end
	end

	if HelpModel.instance:isShowedHelp(slot1) then
		return
	end

	if not slot0:checkGuideStepLock(slot1) then
		return
	end

	return true
end

function slot0.tryShowFirstHelp(slot0, slot1, slot2)
	if not slot0:canShowFirstHelp(slot1) then
		return
	end

	slot0:showHelp(slot1, true)
end

function slot0.showHelp(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.HelpView, {
		id = slot1,
		auto = slot2
	})
end

function slot0.checkGuideStepLock(slot0, slot1)
	if not slot1 then
		return false
	end

	if not HelpConfig.instance:getHelpCO(slot1) then
		logError("please check help config, not found help Config!, help id is " .. slot1)
	end

	slot4 = false

	for slot8, slot9 in ipairs(string.splitToNumber(slot2.page, "#")) do
		if slot0:canShowPage(HelpConfig.instance:getHelpPageCo(slot9)) then
			slot4 = true

			break
		end
	end

	return slot4
end

function slot0.canShowPage(slot0, slot1)
	return slot1.unlockGuideId == 0 or GuideModel.instance:isGuideFinish(slot1.unlockGuideId)
end

function slot0.canShowVideo(slot0, slot1)
	return slot1.unlockGuideId == 0 or GuideModel.instance:isGuideFinish(slot1.unlockGuideId)
end

function slot0.openStoreTipView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.StoreTipView, {
		desc = slot1,
		title = slot2
	})
end

function slot0.openBpRuleTipsView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.BpRuleTipsView, {
		title = slot1,
		titleEn = slot2,
		ruleDesc = slot3
	})
end

slot0.instance = slot0.New()

return slot0
