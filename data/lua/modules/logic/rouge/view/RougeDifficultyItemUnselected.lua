module("modules.logic.rouge.view.RougeDifficultyItemUnselected", package.seeall)

slot0 = class("RougeDifficultyItemUnselected", RougeDifficultyItem_Base)

function slot0.onInitView(slot0)
	slot0._goBg1 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg1")
	slot0._goBg2 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg2")
	slot0._goBg3 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg3")
	slot0._txtnum1 = gohelper.findChildText(slot0.viewGO, "num/#txt_num1")
	slot0._txtnum2 = gohelper.findChildText(slot0.viewGO, "num/#txt_num2")
	slot0._txtnum3 = gohelper.findChildText(slot0.viewGO, "num/#txt_num3")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_en")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._txtScrollDesc = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#txt_ScrollDesc")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	RougeDifficultyItem_Base._editableInitView(slot0)

	slot0._scrolldescLimitScrollRectCmp = slot0._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	slot0:_onSetScrollParentGameObject(slot0._scrolldescLimitScrollRectCmp)
end

function slot0.onDestroyView(slot0)
	RougeDifficultyItem_Base.onDestroyView(slot0)
end

function slot0.setData(slot0, slot1)
	RougeDifficultyItem_Base.setData(slot0, slot1)

	slot0._txtScrollDesc.text = slot1.difficultyCO.desc
end

return slot0
