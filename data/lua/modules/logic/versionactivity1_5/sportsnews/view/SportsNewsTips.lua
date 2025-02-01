module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTips", package.seeall)

slot0 = class("SportsNewsTips", ActivityWarmUpTips)

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	SportsNewsModel.instance:onReadEnd(slot0.viewParam.actId, slot0.viewParam.orderId)
end

return slot0
