module("modules.logic.notice.view.NoticeContentItemWrap", package.seeall)

slot0 = class("NoticeContentItemWrap", MixScrollCell)
slot0.Comp2TypeDict = {
	[NoticeTxtTopTitleItem] = {
		NoticeContentType.TxtTopTitle
	},
	[NoticeTxtContentItem] = {
		NoticeContentType.TxtContent
	},
	[NoticeImgItem] = {
		NoticeContentType.ImgInner,
		NoticeContentType.ImgTitle
	}
}

function slot0.init(slot0, slot1)
	slot0.compList = {}

	for slot5, slot6 in pairs(uv0.Comp2TypeDict) do
		slot7 = slot5.New()

		slot7:init(slot1, slot6)
		table.insert(slot0.compList, slot7)
	end
end

function slot0.addEventListeners(slot0)
	for slot4, slot5 in ipairs(slot0.compList) do
		slot5:addEventListeners()
	end
end

function slot0.removeEventListeners(slot0)
	for slot4, slot5 in ipairs(slot0.compList) do
		slot5:removeEventListeners()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.compList) do
		slot6:onUpdateMO(slot1)
	end
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in ipairs(slot0.compList) do
		slot5:onDestroy()
	end

	slot0.compList = nil
end

return slot0
