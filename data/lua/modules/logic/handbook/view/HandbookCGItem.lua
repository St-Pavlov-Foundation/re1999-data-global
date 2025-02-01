module("modules.logic.handbook.view.HandbookCGItem", package.seeall)

slot0 = class("HandbookCGItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "#go_title")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_time")
	slot0._txtmessycodetime = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_messycodetime")
	slot0._txttitleName = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_titleName")
	slot0._txttitleNameEN = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_titleNameEN")
	slot0._gocg = gohelper.findChild(slot0.viewGO, "#go_cg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot4 = HandbookEvent.OnReadInfoChanged

	slot0:addEventCb(HandbookController.instance, slot4, slot0._onReadInfoChanged, slot0)

	slot0._cgItemList = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._gocg, "go_cg" .. slot4)
		slot5.simagecgicon = gohelper.findChildSingleImage(slot5.go, "mask/simage_cgicon")
		slot5.gonew = gohelper.findChild(slot5.go, "go_new")
		slot5.btnclick = gohelper.findChildButtonWithAudio(slot5.go, "btn_click", AudioEnum.UI.play_ui_screenplay_photo_open)

		slot5.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot4)
		table.insert(slot0._cgItemList, slot5)
	end
end

function slot0._btnclickOnClick(slot0, slot1)
	if slot0._mo.isTitle then
		return
	end

	if not slot0._mo.cgList[slot1] then
		return
	end

	HandbookController.instance:openCGDetailView({
		id = slot4.id,
		cgType = slot0._cgType
	})
	gohelper.setActive(slot0._cgItemList[slot1].gonew, false)
end

function slot0._refreshUI(slot0)
	gohelper.setActive(slot0._gotitle, slot0._mo.isTitle)
	gohelper.setActive(slot0._gocg, not slot0._mo.isTitle)

	if slot0._mo.isTitle then
		slot2 = HandbookConfig.instance:getStoryChapterConfig(slot0._mo.storyChapterId)
		slot0._txttitleName.text = slot2.name
		slot0._txttitleNameEN.text = slot2.nameEn
		slot3 = GameUtil.utf8isnum(slot2.year)

		gohelper.setActive(slot0._txttime.gameObject, slot3)
		gohelper.setActive(slot0._txtmessycodetime.gameObject, not slot3)

		slot0._txttime.text = slot3 and slot2.year or ""
		slot0._txtmessycodetime.text = slot3 and "" or slot2.year
	else
		for slot5, slot6 in ipairs(slot0._mo.cgList) do
			slot7 = slot0._cgItemList[slot5]

			slot7.simagecgicon:LoadImage(ResUrl.getStorySmallBg(slot6.image))
			gohelper.setActive(slot7.gonew, not HandbookModel.instance:isRead(HandbookEnum.Type.CG, slot6.id))
			gohelper.setActive(slot7.go, true)
		end

		for slot5 = #slot1 + 1, 3 do
			gohelper.setActive(slot0._cgItemList[slot5].go, false)
		end
	end
end

function slot0._onReadInfoChanged(slot0, slot1)
	if slot0._mo.isTitle then
		return
	end

	for slot7, slot8 in ipairs(slot0._mo.cgList) do
		if slot8.id == slot1.id and slot1.type == HandbookEnum.Type.CG then
			gohelper.setActive(slot0._cgItemList[slot7].gonew, not slot1.isRead)
		end
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._cgType = slot1.cgType

	slot0:_refreshUI()
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in ipairs(slot0._cgItemList) do
		slot5.simagecgicon:UnLoadImage()
		slot5.btnclick:RemoveClickListener()
	end
end

return slot0
