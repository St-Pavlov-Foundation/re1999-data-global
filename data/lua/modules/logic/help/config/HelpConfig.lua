module("modules.logic.help.config.HelpConfig", package.seeall)

slot0 = class("HelpConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._helpConfig = nil
	slot0._pageConfig = nil
	slot0._helpPageTabConfig = nil
	slot0._helpVideoConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"viewhelp",
		"helppage",
		"help_page_tab",
		"help_video"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "viewhelp" then
		slot0._helpConfig = slot2
	elseif slot1 == "helppage" then
		slot0._pageConfig = slot2
	elseif slot1 == "help_page_tab" then
		slot0._helpPageTabConfig = slot2
	elseif slot1 == "help_video" then
		slot0._helpVideoConfig = slot2
	end
end

function slot0.getHelpCO(slot0, slot1)
	return slot0._helpConfig.configDict[slot1]
end

function slot0.getHelpPageCo(slot0, slot1)
	return slot0._pageConfig.configDict[slot1]
end

function slot0.getHelpPageTabList(slot0)
	return slot0._helpPageTabConfig.configList
end

function slot0.getHelpPageTabCO(slot0, slot1)
	return slot0._helpPageTabConfig.configDict[slot1]
end

function slot0.getHelpVideoCO(slot0, slot1)
	return slot0._helpVideoConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
