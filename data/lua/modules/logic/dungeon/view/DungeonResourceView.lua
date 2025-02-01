module("modules.logic.dungeon.view.DungeonResourceView", package.seeall)

slot0 = class("DungeonResourceView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageresourcebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_resource/#simage_resourcebg")
	slot0._simagerebottommaskbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_resource/#simage_bottommaskbg")
	slot0._simagedrawbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_resource/#simage_drawbg")
	slot0._gorescontent = gohelper.findChild(slot0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent")
	slot0._scrollchapterresource = gohelper.findChildScrollRect(slot0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._itemList = slot0:getUserDataTb_()
	slot0._width = 777
	slot0._space = 35

	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnShowResourceView, slot0._OnShowResourceView, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._OnActStateChange, slot0)
end

function slot0.onOpen(slot0)
end

function slot0._OnActStateChange(slot0)
	slot0._index = 1

	slot0:addChapterItem(DungeonChapterListModel.instance:getFbList())

	for slot5, slot6 in ipairs(slot0._itemList) do
		if slot0._index <= slot5 then
			gohelper.setActive(slot6.viewGO, false)
		end
	end
end

function slot0._OnShowResourceView(slot0)
	slot0._index = 1

	slot0._simageresourcebg:LoadImage(ResUrl.getDungeonIcon("full/bg123"))
	slot0._simagerebottommaskbg:LoadImage(ResUrl.getDungeonIcon("bg_down"))
	slot0._simagedrawbg:LoadImage(ResUrl.getDungeonIcon("qianbihua"))
	slot0:addChapterItem(DungeonChapterListModel.instance:getFbList())

	for slot5, slot6 in ipairs(slot0._itemList) do
		if slot0._index <= slot5 then
			gohelper.setActive(slot6.viewGO, false)
		end
	end
end

function slot0.addChapterItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:getChapterItem(slot0._index):updateParam(slot6)

		slot0._index = slot0._index + 1
	end

	slot3 = #slot1 >= 3

	recthelper.setWidth(slot0._gorescontent.transform, (slot3 and slot2 or 0) * (slot0._width + slot0._space))

	if slot3 then
		slot0._scrollchapterresource.movementType = 1
	else
		slot0._scrollchapterresource.movementType = 2
	end
end

function slot0.getChapterItem(slot0, slot1)
	if not slot0._itemList[slot1] then
		slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gorescontent, "chapteritem" .. slot1)

		recthelper.setAnchor(slot4.transform, 391 + (slot1 - 1) * (slot0._width + slot0._space), -237.5)

		slot2 = DungeonResChapterItem.New()

		slot2:initView(slot4)

		slot0._itemList[slot1] = slot2
	end

	gohelper.setActive(slot2.viewGO, true)

	if gohelper.findChild(slot2.viewGO, "anim") and slot3:GetComponent(typeof(UnityEngine.Animation)) then
		slot4:Play()
	end

	return slot2
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._itemList) do
		slot5:destroyView()
	end

	slot0._simageresourcebg:UnLoadImage()
	slot0._simagerebottommaskbg:UnLoadImage()
	slot0._simagedrawbg:UnLoadImage()
end

return slot0
