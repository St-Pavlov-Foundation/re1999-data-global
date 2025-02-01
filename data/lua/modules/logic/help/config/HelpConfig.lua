module("modules.logic.help.config.HelpConfig", package.seeall)

slot0 = class("HelpConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._helpConfig = nil
	slot0._pageConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"viewhelp",
		"helppage"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "viewhelp" then
		slot0._helpConfig = slot2
	elseif slot1 == "helppage" then
		slot0._pageConfig = slot2
	end
end

function slot0.getHelpCO(slot0, slot1)
	return slot0._helpConfig.configDict[slot1]
end

function slot0.getHelpPageCo(slot0, slot1)
	return slot0._pageConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
