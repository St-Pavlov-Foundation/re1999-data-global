module("modules.logic.act189.model.ShortenActModel", package.seeall)

slot0 = class("ShortenActModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.getActivityId(slot0)
	return ShortenActConfig.instance:getActivityId()
end

function slot0.isClaimable(slot0)
	return Activity189Model.instance:isClaimable(slot0:getActivityId())
end

slot0.instance = slot0.New()

return slot0
