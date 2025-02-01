module("modules.ugui.textmeshpro.TMPDynamicSizeTextMgr", package.seeall)

slot0 = class("TMPDynamicSizeTextMgr")

function slot0.ctor(slot0)
end

function slot0.init(slot0)
	slot0.csharpInst = ZProj.LangTextDynamicSizeMgr.Instance

	slot0.csharpInst:SetChangeSizeFunc(slot0._changeSize, slot0)
	slot0.csharpInst:SetFilterRichTextFunc(slot0._filterRichText, slot0)
end

function slot0._changeSize(slot0, slot1, slot2, slot3)
	for slot8, slot9 in string.gmatch(slot3, "<size=(%d+)>(.+)</size>"), nil,  do
		slot3 = string.gsub(slot3, string.format("<size=%d>%s</size>", slot8, slot9), string.format("<size=%d>%s</size>", slot8 * slot2, slot9))
	end

	slot1:SetText(slot3)
end

function slot0._filterRichText(slot0, slot1, slot2)
	slot1:FilterRichTextCb(slot2)
end

slot0.instance = slot0.New()

return slot0
