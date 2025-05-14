module("modules.logic.versionactivity2_5.liangyue.view.LiangYueScrollItem", package.seeall)

local var_0_0 = class("LiangYueScrollItem", LuaCompBase)
local var_0_1 = ZProj.UIEffectsCollection

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goTextBg = gohelper.findChild(arg_1_1, "image_NumBG")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_1, "image_NumBG/#txt_Num")
	arg_1_0._simage_illustration = gohelper.findChildSingleImage(arg_1_1, "#image_Piece")
	arg_1_0._image_illustration = gohelper.findChildImage(arg_1_1, "#image_Piece")
	arg_1_0._image_illustrationBg = gohelper.findChildImage(arg_1_1, "image_PieceBG")
	arg_1_0._goTarget = gohelper.findChild(arg_1_1, "TargetIcon")
	arg_1_0._goLine = gohelper.findChild(arg_1_1, "#go_Line")
	arg_1_0._canvasGroup = gohelper.onceAddComponent(arg_1_0._simage_illustration.gameObject, gohelper.Type_CanvasGroup)

	arg_1_0:initComp()
end

function var_0_0.initComp(arg_2_0)
	arg_2_0._dragListener = SLFramework.UGUI.UIDragListener.Get(arg_2_0._image_illustrationBg.gameObject)

	arg_2_0._dragListener:AddDragBeginListener(arg_2_0._onItemBeginDrag, arg_2_0)
	arg_2_0._dragListener:AddDragListener(arg_2_0._onItemDrag, arg_2_0)
	arg_2_0._dragListener:AddDragEndListener(arg_2_0._onItemEndDrag, arg_2_0)

	arg_2_0._iconHeight = recthelper.getHeight(arg_2_0._simage_illustration.transform)
	arg_2_0._iconWidth = recthelper.getWidth(arg_2_0._simage_illustration.transform)

	local var_2_0 = LiangYueAttributeItem.New()

	var_2_0:init(arg_2_0._goTarget)

	arg_2_0._attributeComp = var_2_0
	arg_2_0._uiEffectComp = var_0_1.Get(arg_2_0._image_illustration.gameObject)

	arg_2_0:setEnoughState(true)

	arg_2_0._isDrag = false
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0._go, arg_3_1)
end

function var_0_0.setAlpha(arg_4_0, arg_4_1)
	arg_4_0._canvasGroup.alpha = arg_4_1
end

function var_0_0.setEnoughState(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 and LiangYueEnum.ScrollItemColor.Enough or LiangYueEnum.ScrollItemColor.NotEnought

	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._image_illustration, var_5_0)
	arg_5_0._uiEffectComp:SetGray(not arg_5_1)
end

function var_0_0.setInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	arg_6_0.id = arg_6_1
	arg_6_0.index = arg_6_2
	arg_6_0._txtNum.text = arg_6_3 > 0 and tostring(arg_6_3) or LiangYueEnum.UnlimitedSign

	gohelper.setActive(arg_6_0._goLine, arg_6_2 % 2 ~= 0)

	local var_6_0 = string.format("v2a5_liangyue_game_piece%s", arg_6_4)

	arg_6_0._simage_illustration:LoadImage(ResUrl.getV2a5LiangYueImg(var_6_0))
	arg_6_0:setAttributeInfo(arg_6_6, arg_6_1)
end

function var_0_0.setAttributeInfo(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = LiangYueConfig.instance:getIllustrationAttribute(arg_7_1, arg_7_2)

	arg_7_0._attributeComp:setInfo(var_7_0)
end

function var_0_0.setParentView(arg_8_0, arg_8_1)
	arg_8_0.view = arg_8_1
end

function var_0_0.setCount(arg_9_0, arg_9_1)
	arg_9_0._txtNum.text = tostring(arg_9_1)
end

function var_0_0._onItemBeginDrag(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._isDrag or arg_10_0.view._isDrag then
		logNormal("拖动中")

		return
	end

	arg_10_0._isDrag = true

	arg_10_0.view:_onItemBeginDrag(arg_10_1, arg_10_2, arg_10_0.id)
end

function var_0_0._onItemDrag(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.view:_onItemDrag(arg_11_1, arg_11_2)
end

function var_0_0._onItemEndDrag(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._isDrag = false

	arg_12_0.view:_onItemEndDrag(arg_12_1, arg_12_2)
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._dragListener:RemoveDragBeginListener()
	arg_13_0._dragListener:RemoveDragListener()
	arg_13_0._dragListener:RemoveDragEndListener()
end

return var_0_0
