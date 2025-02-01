module("modules.logic.ressplit.controller.ResSplitController", package.seeall)

slot0 = class("ResSplitController", BaseController)

function slot0.onInit(slot0)
	slot0._versionResSplitHandler = VersionResSplitHandler.New()

	ResSplitHelper.init()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.generateResSplitCfg(slot0)
	slot0._versionResSplitHandler:generateResSplitCfg()
end

function slot0.staticVersionResSplitAction()
	uv0.instance:generateResSplitCfg()
end

slot0.instance = slot0.New()

return slot0
