module("modules.logic.notice.model.NoticeMO", package.seeall)

slot0 = pureTable("NoticeMO")
slot1 = {
	jp = "ja-JP",
	kr = "ko-KR",
	zh = "zh-CN",
	tw = "zh-TW",
	thai = "thai",
	en = "en"
}

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.gameId = slot1.gameId
	slot0.order = slot1.order
	slot0.noticeTypes = slot1.noticeTypes
	slot0.noticePositionTypes = slot1.noticePositionTypes
	slot0.noticeLabelType = slot1.noticeLabelType
	slot0.beginTime = slot1.beginTime
	slot0.endTime = slot1.endTime
	slot0.noticeLabelTypeName = slot1.noticeLabelTypeName
	slot0.isTop = slot1.isTop
	slot0.contentMap = slot1.contentMap

	for slot5, slot6 in pairs(slot0.contentMap) do
		for slot10, slot11 in ipairs(slot6.imageUrl) do
			slot0:addImageUrl(slot11)
		end
	end
end

function slot0.getTitle(slot0)
	return slot0:getLangContent().title
end

function slot0.getContent(slot0)
	return slot0:getLangContent().content
end

function slot0.getLangContent(slot0)
	if slot0.contentMap[uv0[LangSettings.instance:getCurLangShortcut()] or slot1] then
		return slot3
	end

	if slot0.contentMap[uv0[LangSettings.instance:getDefaultLangShortcut()] or slot4] then
		return slot3
	end

	for slot8, slot9 in pairs(slot0.contentMap) do
		return slot9
	end
end

function slot0.setContent(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.contentMap) do
		if not slot2 or slot2 == slot6 then
			slot7.content = slot1
		end
	end
end

function slot0.addImageUrl(slot0, slot1)
	slot0.imgUrlDict = slot0.imgUrlDict or {}
	slot0.imgUrlDict[SLFramework.FileHelper.GetFileName(slot1, false)] = slot1
end

function slot0.isNormalStatus(slot0)
	return ServerTime.now() > slot0.beginTime / 1000 and slot1 < slot0.endTime / 1000
end

return slot0
