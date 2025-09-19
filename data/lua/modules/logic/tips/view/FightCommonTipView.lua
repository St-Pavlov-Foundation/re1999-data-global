module("modules.logic.tips.view.FightCommonTipView", package.seeall)

local var_0_0 = class("FightCommonTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.viewRect = arg_1_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.viewWidth = recthelper.getWidth(arg_1_0.viewRect)
	arg_1_0.viewHeight = recthelper.getHeight(arg_1_0.viewRect)
	arg_1_0.rootRect = gohelper.findChildComponent(arg_1_0.viewGO, "layout", gohelper.Type_RectTransform)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "layout/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "layout/#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.click = gohelper.findChildClickWithDefaultAudio(arg_4_0.viewGO, "close_block")

	arg_4_0.click:AddClickListener(arg_4_0.closeThis, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._txttitle.text = arg_5_0.viewParam.title
	arg_5_0._txtdesc.text = arg_5_0.viewParam.desc

	local var_5_0 = recthelper.getWidth(arg_5_0.rootRect)

	arg_5_0.rootRect.pivot = arg_5_0.viewParam.pivot
	arg_5_0.rootRect.offsetMin = arg_5_0.viewParam.offsetAnchor
	arg_5_0.rootRect.offsetMax = arg_5_0.viewParam.offsetAnchor
	arg_5_0.offsetPosX = arg_5_0.viewParam.offsetPosX or 0
	arg_5_0.offsetPosY = arg_5_0.viewParam.offsetPosY or 0

	recthelper.setWidth(arg_5_0.rootRect, var_5_0)
	arg_5_0:setPos()
end

function var_0_0.setPos(arg_6_0)
	local var_6_0, var_6_1 = recthelper.screenPosToAnchorPos2(arg_6_0.viewParam.screenPos, arg_6_0.viewRect)

	if arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.TopLeft then
		var_6_0 = var_6_0 + arg_6_0.viewWidth * 0.5
		var_6_1 = var_6_1 - arg_6_0.viewHeight * 0.5
	elseif arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.TopCenter then
		var_6_1 = var_6_1 - arg_6_0.viewHeight * 0.5
	elseif arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.TopRight then
		var_6_0 = var_6_0 - arg_6_0.viewWidth * 0.5
		var_6_1 = var_6_1 - arg_6_0.viewHeight * 0.5
	elseif arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.CenterLeft then
		var_6_0 = var_6_0 + arg_6_0.viewWidth * 0.5
	elseif arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.Center then
		-- block empty
	elseif arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.CenterRight then
		var_6_0 = var_6_0 - arg_6_0.viewWidth * 0.5
	elseif arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.BottomLeft then
		var_6_0 = var_6_0 + arg_6_0.viewWidth * 0.5
		var_6_1 = var_6_1 + arg_6_0.viewHeight * 0.5
	elseif arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.BottomCenter then
		var_6_1 = var_6_1 + arg_6_0.viewHeight * 0.5
	elseif arg_6_0.viewParam.pivot == FightCommonTipController.Pivot.BottomRight then
		var_6_0 = var_6_0 - arg_6_0.viewWidth * 0.5
		var_6_1 = var_6_1 + arg_6_0.viewHeight * 0.5
	end

	local var_6_2 = var_6_0 + arg_6_0.offsetPosX
	local var_6_3 = var_6_1 + arg_6_0.offsetPosY

	recthelper.setAnchor(arg_6_0.rootRect, var_6_2, var_6_3)
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0.click then
		arg_7_0.click:RemoveClickListener()

		arg_7_0.click = nil
	end
end

return var_0_0
