module("modules.logic.versionactivity1_4.act132.controller.Activity132Controller", package.seeall)

slot0 = class("Activity132Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.initAct(slot0, slot1)
	Activity132Rpc.instance:sendGet132InfosRequest(slot1)
end

function slot0.openCollectView(slot0, slot1)
	Activity132Rpc.instance:sendGet132InfosRequest(slot1, function ()
		ViewMgr.instance:openView(ViewName.Activity132CollectView, {
			actId = uv0
		})
	end)
end

slot0.instance = slot0.New()

return slot0
