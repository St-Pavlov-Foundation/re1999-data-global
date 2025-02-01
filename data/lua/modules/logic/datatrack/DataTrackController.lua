module("modules.logic.datatrack.DataTrackController", package.seeall)

slot0 = class("DataTrackController", BaseController)

function slot0.onInit(slot0)
	SDKDataTrackExt.activateExtend()
end

slot0.instance = slot0.New()

return slot0
