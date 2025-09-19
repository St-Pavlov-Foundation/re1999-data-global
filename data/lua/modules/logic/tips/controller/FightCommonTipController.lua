module("modules.logic.tips.controller.FightCommonTipController", package.seeall)

local var_0_0 = class("FightCommonTipController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

var_0_0.Pivot = {
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
var_0_0.OffsetAnchor = {
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

function var_0_0.openCommonView(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	ViewMgr.instance:openView(ViewName.FightCommonTipView, {
		title = arg_2_1,
		desc = arg_2_2,
		screenPos = arg_2_3,
		pivot = arg_2_4 or var_0_0.Pivot.TopLeft,
		offsetAnchor = arg_2_5 or var_0_0.OffsetAnchor.TopLeft,
		offsetPosX = arg_2_6,
		offsetPosY = arg_2_7
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
