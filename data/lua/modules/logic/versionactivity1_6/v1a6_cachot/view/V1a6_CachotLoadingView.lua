module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotLoadingView", package.seeall)

slot0 = class("V1a6_CachotLoadingView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon/#simage_icon")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#simage_icon/img_en2/#txt_en")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#simage_icon/#txt_name")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not slot0._rogueInfo then
		return
	end

	if not lua_rogue_room.configDict[slot0._rogueInfo.room] then
		return
	end

	slot0._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_img_level_1"))

	slot0._txten.text = slot1.nameEn

	if GameUtil.utf8len(slot1.name) <= 1 then
		slot0._txtname.text = string.format("<size=42>%s</size>", slot2)
	else
		slot0._txtname.text = string.format("<size=42>%s</size>%s", GameUtil.utf8sub(slot2, 1, 1), GameUtil.utf8sub(slot2, 2, slot3 - 1))
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_load_open)
	TaskDispatcher.runDelay(slot0.checkViewIsOpenFinish, slot0, 2.5)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotMainView or slot1 == ViewName.V1a6_CachotRoomView then
		TaskDispatcher.runDelay(slot0.closeThis, slot0, 0.2)
	end
end

function slot0.checkViewIsOpenFinish(slot0)
	if ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotMainView) or ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotRoomView) then
		slot0:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenView, slot0)
	end
end

function slot0.onClose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenView, slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.cancelTask(slot0.checkViewIsOpenFinish, slot0)
	slot0._simageicon:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
