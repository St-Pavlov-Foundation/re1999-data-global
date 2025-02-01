module("modules.logic.versionactivity.model.VersionActivityLeiMiTeBeiTaskModel", package.seeall)

slot0 = class("VersionActivityLeiMiTeBeiTaskModel", BaseModel)

function slot0.onInit(slot0)
	slot0.infosDic = {}
end

function slot0.reInit(slot0)
	slot0:onInit()
end

slot0.instance = slot0.New()

return slot0
