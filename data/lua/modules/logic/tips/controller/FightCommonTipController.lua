-- chunkname: @modules/logic/tips/controller/FightCommonTipController.lua

module("modules.logic.tips.controller.FightCommonTipController", package.seeall)

local FightCommonTipController = class("FightCommonTipController", BaseController)

function FightCommonTipController:onInit()
	return
end

FightCommonTipController.Pivot = {
	TopLeft = Vector2.New(0, 1),
	TopCenter = Vector2.New(0.5, 1),
	TopRight = Vector2.New(1, 1),
	CenterLeft = Vector2.New(0, 0.5),
	Center = Vector2.New(0.5, 0.5),
	CenterRight = Vector2.New(1, 0.5),
	BottomLeft = Vector2.New(0, 0),
	BottomCenter = Vector2.New(0.5, 0),
	BottomRight = Vector2.New(1, 0)
}

function FightCommonTipController:openCommonView(title, desc, screenPos, anchorMinAndMax, pivot, offsetPosX, offsetPosY)
	ViewMgr.instance:openView(ViewName.FightCommonTipView, {
		title = title,
		desc = desc,
		screenPos = screenPos,
		anchorMinAndMax = anchorMinAndMax or FightCommonTipController.Pivot.TopLeft,
		pivot = pivot or FightCommonTipController.Pivot.TopLeft,
		offsetPosX = offsetPosX or 0,
		offsetPosY = offsetPosY or 0
	})
end

FightCommonTipController.instance = FightCommonTipController.New()

return FightCommonTipController
