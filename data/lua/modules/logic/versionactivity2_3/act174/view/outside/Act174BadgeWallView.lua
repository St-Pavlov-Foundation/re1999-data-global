module("modules.logic.versionactivity2_3.act174.view.outside.Act174BadgeWallView", package.seeall)

slot0 = class("Act174BadgeWallView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:freshBadgeItem()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.badgeIconList) do
		slot5:UnLoadImage()
	end
end

function slot0.freshBadgeItem(slot0)
	slot0.badgeIconList = {}

	for slot6 = 1, 8 do
		slot7 = gohelper.findChild(slot0.viewGO, "badgeitem" .. slot6)

		if Activity174Model.instance:getActInfo():getBadgeMoList()[slot6] then
			slot9 = gohelper.findChildSingleImage(slot7, "badgeIcon/root/image_icon")
			gohelper.findChildText(slot7, "badgeIcon/root/txt_num").text = slot8.count
			gohelper.findChildText(slot7, "txt_name").text = slot8.config.name
			gohelper.findChildText(slot7, "scroll_desc/Viewport/content/txt_desc").text = slot8.config.desc

			slot9:LoadImage(ResUrl.getAct174BadgeIcon(slot8.config.icon, slot8:getState()))

			slot0.badgeIconList[slot6] = slot9
		end
	end
end

return slot0
