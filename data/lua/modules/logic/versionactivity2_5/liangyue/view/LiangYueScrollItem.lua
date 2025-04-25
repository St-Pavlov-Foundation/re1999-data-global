module("modules.logic.versionactivity2_5.liangyue.view.LiangYueScrollItem", package.seeall)

slot0 = class("LiangYueScrollItem", LuaCompBase)
slot1 = ZProj.UIEffectsCollection

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goTextBg = gohelper.findChild(slot1, "image_NumBG")
	slot0._txtNum = gohelper.findChildTextMesh(slot1, "image_NumBG/#txt_Num")
	slot0._simage_illustration = gohelper.findChildSingleImage(slot1, "#image_Piece")
	slot0._image_illustration = gohelper.findChildImage(slot1, "#image_Piece")
	slot0._image_illustrationBg = gohelper.findChildImage(slot1, "image_PieceBG")
	slot0._goTarget = gohelper.findChild(slot1, "TargetIcon")
	slot0._goLine = gohelper.findChild(slot1, "#go_Line")
	slot0._canvasGroup = gohelper.onceAddComponent(slot0._simage_illustration.gameObject, gohelper.Type_CanvasGroup)

	slot0:initComp()
end

function slot0.initComp(slot0)
	slot0._dragListener = SLFramework.UGUI.UIDragListener.Get(slot0._image_illustrationBg.gameObject)

	slot0._dragListener:AddDragBeginListener(slot0._onItemBeginDrag, slot0)
	slot0._dragListener:AddDragListener(slot0._onItemDrag, slot0)
	slot0._dragListener:AddDragEndListener(slot0._onItemEndDrag, slot0)

	slot0._iconHeight = recthelper.getHeight(slot0._simage_illustration.transform)
	slot0._iconWidth = recthelper.getWidth(slot0._simage_illustration.transform)
	slot1 = LiangYueAttributeItem.New()

	slot1:init(slot0._goTarget)

	slot0._attributeComp = slot1
	slot0._uiEffectComp = uv0.Get(slot0._image_illustration.gameObject)

	slot0:setEnoughState(true)

	slot0._isDrag = false
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0._go, slot1)
end

function slot0.setAlpha(slot0, slot1)
	slot0._canvasGroup.alpha = slot1
end

function slot0.setEnoughState(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._image_illustration, slot1 and LiangYueEnum.ScrollItemColor.Enough or LiangYueEnum.ScrollItemColor.NotEnought)
	slot0._uiEffectComp:SetGray(not slot1)
end

function slot0.setInfo(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.id = slot1
	slot0.index = slot2
	slot0._txtNum.text = slot3 > 0 and tostring(slot3) or LiangYueEnum.UnlimitedSign

	gohelper.setActive(slot0._goLine, slot2 % 2 ~= 0)
	slot0._simage_illustration:LoadImage(ResUrl.getV2a5LiangYueImg(string.format("v2a5_liangyue_game_piece%s", slot4)))
	slot0:setAttributeInfo(slot6, slot1)
end

function slot0.setAttributeInfo(slot0, slot1, slot2)
	slot0._attributeComp:setInfo(LiangYueConfig.instance:getIllustrationAttribute(slot1, slot2))
end

function slot0.setParentView(slot0, slot1)
	slot0.view = slot1
end

function slot0.setCount(slot0, slot1)
	slot0._txtNum.text = tostring(slot1)
end

function slot0._onItemBeginDrag(slot0, slot1, slot2)
	if slot0._isDrag or slot0.view._isDrag then
		logNormal("拖动中")

		return
	end

	slot0._isDrag = true

	slot0.view:_onItemBeginDrag(slot1, slot2, slot0.id)
end

function slot0._onItemDrag(slot0, slot1, slot2)
	slot0.view:_onItemDrag(slot1, slot2)
end

function slot0._onItemEndDrag(slot0, slot1, slot2)
	slot0._isDrag = false

	slot0.view:_onItemEndDrag(slot1, slot2)
end

function slot0.onDestroy(slot0)
	slot0._dragListener:RemoveDragBeginListener()
	slot0._dragListener:RemoveDragListener()
	slot0._dragListener:RemoveDragEndListener()
end

return slot0
