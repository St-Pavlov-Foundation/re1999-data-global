module("modules.logic.versionactivity2_5.liangyue.view.LiangYueAttributeDescItem", package.seeall)

slot0 = class("LiangYueAttributeDescItem")

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txt_Num = gohelper.findChildText(slot1, "#txt_Num")
	slot0._txt_NumChanged = gohelper.findChildText(slot1, "#txt_Num1")
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.setInfo(slot0, slot1, slot2)
	slot0._txt_Num.text = string.format("%s%s", LiangYueEnum.CalculateSymbol[slot1], slot2)

	if slot0._txt_NumChanged then
		slot0._txt_NumChanged.text = slot3
	end
end

function slot0.setTargetInfo(slot0, slot1, slot2, slot3)
	slot0._txt_Num.text = string.format("%s/%s", slot1, slot2)

	if slot0._txt_NumChanged then
		slot0._txt_NumChanged.text = slot4
	end

	slot0:setTxtColor(slot3)
end

function slot0.setTxtColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txt_Num, slot1)

	if slot0._txt_NumChanged then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txt_NumChanged, slot1)
	end
end

return slot0
