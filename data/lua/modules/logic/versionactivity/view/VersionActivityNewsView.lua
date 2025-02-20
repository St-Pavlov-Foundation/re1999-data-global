module("modules.logic.versionactivity.view.VersionActivityNewsView", package.seeall)

slot0 = class("VersionActivityNewsView", BaseView)

function slot0.onInitView(slot0)
	slot0._goclose = gohelper.findChild(slot0.viewGO, "#go_close")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._goinfoitem = gohelper.findChild(slot0.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.ParagraphDelimiter = "{p}"
slot0.ImageString = "{img}"
slot0.ImageStringLen = #slot0.ImageString
slot0.Anchor = {
	Left = Vector2.New(0, 1),
	Center = Vector2.New(0.5, 1),
	Right = Vector2.New(1, 1)
}
slot0.Align = {
	Right = 3,
	Left = 1,
	Center = 2
}

function slot0.closeViewOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goinfoitem, false)

	slot0.closeViewClick = gohelper.getClick(slot0._goclose)

	slot0.closeViewClick:AddClickListener(slot0.closeViewOnClick, slot0)

	slot0.contentItemList = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.fragmentCo = lua_chapter_map_fragment.configDict[slot0.viewParam.fragmentId]

	if not slot0.fragmentCo then
		logError("not found fragment : " .. slot1)
		slot0:closeThis()

		return
	end

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._txttitle.text = slot0.fragmentCo.title
	slot2 = 0
	slot3, slot4 = nil

	for slot8, slot9 in ipairs(string.split(slot0.fragmentCo.content, uv0.ParagraphDelimiter)) do
		if not string.nilorempty(slot9) then
			slot3 = slot0.contentItemList[slot2 + 1] or slot0:createContentItem()

			gohelper.setActive(slot3.go, true)

			slot4 = string.find(string.trim(slot9), uv0.ImageString) and true or false

			gohelper.setActive(slot3.goPlainText, not slot4)
			gohelper.setActive(slot3.goImgText, slot4)

			if slot4 then
				slot3.txtImgText.text = string.gsub(slot9, uv0.ImageString, "")

				slot3.simageIcon:LoadImage(ResUrl.getVersionActivityIcon(slot0.fragmentCo.res))

				if slot0:getImageAlign(slot9) == uv0.Align.Left then
					slot3.iconRectTr.anchorMin = uv0.Anchor.Left
					slot3.iconRectTr.anchorMax = uv0.Anchor.Left

					recthelper.setAnchor(slot3.iconRectTr, recthelper.getWidth(slot3.iconRectTr) / 2, 0)
				elseif slot10 == uv0.Align.Center then
					slot3.iconRectTr.anchorMin = uv0.Anchor.Center
					slot3.iconRectTr.anchorMax = uv0.Anchor.Center

					recthelper.setAnchor(slot3.iconRectTr, 0, 0)
				elseif slot10 == uv0.Align.Right then
					slot3.iconRectTr.anchorMin = uv0.Anchor.Right
					slot3.iconRectTr.anchorMax = uv0.Anchor.Right

					recthelper.setAnchor(slot3.iconRectTr, -slot11 / 2, 0)
				end
			else
				slot3.txtPlainText.text = slot9
			end
		end
	end

	for slot8 = slot2 + 1, #slot0.contentItemList do
		gohelper.setActive(slot0.contentItemList[slot8].go, false)
	end
end

function slot0.checkIsImageType(slot0, slot1)
	return string.find(slot1, uv0.ImageString)
end

function slot0.getImageAlign(slot0, slot1)
	slot2, slot3 = string.find(slot1, uv0.ImageString)

	if not slot2 then
		return uv0.Align.Right
	end

	if slot2 ~= 1 then
		return uv0.Align.Right
	end

	if string.nilorempty(string.sub(slot1, slot3 + 1, slot3 + 1)) then
		return uv0.Align.Center
	end

	return uv0.Align.Left
end

function slot0.createContentItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goinfoitem)
	slot1.goPlainText = gohelper.findChild(slot1.go, "type1")
	slot1.txtPlainText = gohelper.findChildText(slot1.go, "type1")
	slot1.goImgText = gohelper.findChild(slot1.go, "type2")
	slot1.txtImgText = gohelper.findChildText(slot1.go, "type2/info")
	slot1.simageIcon = gohelper.findChildSingleImage(slot1.go, "type2/icon")
	slot1.iconRectTr = slot1.simageIcon.gameObject.transform

	return slot1
end

function slot0.onClose(slot0)
	slot4 = AudioEnum.UI.UI_Common_Click

	AudioMgr.instance:trigger(slot4)

	for slot4, slot5 in ipairs(slot0.contentItemList) do
		slot5.simageIcon:UnLoadImage()
	end
end

function slot0.onDestroyView(slot0)
	slot0.closeViewClick:RemoveClickListener()
end

return slot0
