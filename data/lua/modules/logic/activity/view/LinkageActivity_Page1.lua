module("modules.logic.activity.view.LinkageActivity_Page1", package.seeall)

slot0 = class("LinkageActivity_Page1", LinkageActivity_PageBase)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.getDurationTimeStr(slot0)
	return StoreController.instance:getRecommendStoreTime(slot0:getLinkageActivityCO())
end

return slot0
