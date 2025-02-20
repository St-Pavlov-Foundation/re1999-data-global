module("modules.logic.notice.model.NoticeContentListModel", package.seeall)

slot0 = class("NoticeContentListModel", MixScrollModel)

function slot0.setNoticeMO(slot0, slot1)
	slot0.noticeMO = slot1

	if slot0.noticeMO then
		slot0:setList(not string.nilorempty(slot0:_convertContentUrl(slot0.noticeMO:getContent())) and cjson.decode(slot2) or {})
	else
		slot0:clear()
	end
end

function slot0._convertContentUrl(slot0, slot1)
	slot3 = string.split(string.gsub(slot1, "[<>]", "|"), "|")

	function slot8(slot0, slot1)
		return #slot0 > #slot1
	end

	table.sort(slot3, slot8)

	for slot8, slot9 in ipairs(slot3) do
		if string.find(slot9, "link=2#") then
			slot10 = string.urldecode(string.gsub(slot9, "link=2#", ""))
			slot11 = NoticeModel.instance:getNextUrlId()
			slot4 = string.gsub(slot1, slot10, tostring(slot11))

			NoticeModel.instance:setNoticeUrl(slot11, slot10)
		end
	end

	return slot4
end

function slot0.convertUrl(slot0, slot1)
	return string.gsub(string.gsub(slot1, "?", "@"), "-", "!")
end

function slot0.decodeUrl(slot0, slot1)
	return string.gsub(string.gsub(slot1, "@", "?"), "!", "-")
end

function slot0.decodeToJson(slot0)
	if slot0.noticeMO then
		slot0.noticeMO:setContent(cjson.encode(slot0:getList()))
	end
end

function slot0.hasTitle(slot0)
	if slot0.noticeMO then
		slot5 = slot0

		for slot4, slot5 in ipairs(slot0.getList(slot5)) do
			if slot5.type == NoticeContentType.TxtTopTitle then
				return true
			end
		end
	end

	return false
end

function slot0.getCurSelectNoticeTitle(slot0)
	return slot0.noticeMO and slot0.noticeMO:getTitle() or ""
end

function slot0.getCurSelectNoticeTypeStr(slot0)
	return slot0.noticeMO and NoticeController.instance:getNoticeTypeStr(slot0.noticeMO) or ""
end

slot0.ContentTileHeight = 97
slot0.TxtSpaceVertical = 7
slot0.ImgSpaceVertical = 0
slot0.ImgTitleSpaceVertical = 21

function slot0.getInfoList(slot0, slot1)
	if not slot0:getList() or #slot2 <= 0 then
		return {}
	end

	slot9 = TMPro.TextMeshProUGUI
	slot3 = gohelper.findChildComponent(slot1, "#txt_content", typeof(slot9))
	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		if not slot9.type then
			logError("notice content type is nil, noticeId = " .. slot0.noticeMO.id)

			return
		end

		if slot9.type == NoticeContentType.TxtTopTitle then
			slot10 = nil

			table.insert(slot4, (slot9.content and not string.nilorempty(string.gsub(slot9.content, "<.->", "")) or SLFramework.UGUI.MixCellInfo.New(slot9.type, 0, nil)) and SLFramework.UGUI.MixCellInfo.New(slot9.type, uv0.ContentTileHeight, nil))
		elseif slot9.type == NoticeContentType.TxtContent then
			table.insert(slot4, SLFramework.UGUI.MixCellInfo.New(slot9.type, GameUtil.getPreferredHeight(slot3, slot9.content) + uv0.TxtSpaceVertical, nil))
		elseif slot9.type == NoticeContentType.ImgInner then
			if not slot9.height then
				slot9.width, slot9.height = NoticeModel.instance:getSpriteCacheDefaultSize(SLFramework.FileHelper.GetFileName(string.gsub(slot0:decodeUrl(slot9.content), "?.*", ""), true))
			end

			table.insert(slot4, SLFramework.UGUI.MixCellInfo.New(slot9.type, (slot9.height or 100) + uv0.ImgSpaceVertical, nil))
		elseif slot9.type == NoticeContentType.ImgTitle then
			if not slot9.height then
				slot9.width, slot9.height = NoticeModel.instance:getSpriteCacheDefaultSize(SLFramework.FileHelper.GetFileName(string.gsub(slot0:decodeUrl(slot9.content), "?.*", ""), true))
			end

			table.insert(slot4, SLFramework.UGUI.MixCellInfo.New(slot9.type, (slot9.height or 100) + uv0.ImgTitleSpaceVertical, nil))
		else
			logError("notice content type not implement: " .. slot9.type)
		end
	end

	return slot4
end

slot0.instance = slot0.New()

return slot0
