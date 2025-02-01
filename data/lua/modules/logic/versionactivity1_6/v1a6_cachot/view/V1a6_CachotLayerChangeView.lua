module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotLayerChangeView", package.seeall)

slot0 = class("V1a6_CachotLayerChangeView", BaseView)

function slot0.onOpen(slot0)
	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not slot0._rogueInfo then
		return
	end

	if not lua_rogue_room.configDict[slot0._rogueInfo.room] then
		return
	end

	slot0._gotabs = {}
	slot0._difficulty = slot0._rogueInfo.difficulty

	for slot5 = 1, 2 do
		slot6 = slot0._gotabs[slot5]

		if slot5 == 1 then
			slot7 = slot1.layer - 1
		end

		if not slot6 then
			slot6 = slot0:getUserDataTb_()
			slot6.simagelevel = gohelper.findChildSingleImage(slot0.viewGO, slot5 .. "/#simage_level" .. slot5)
			slot6.gohard = gohelper.findChild(slot0.viewGO, slot5 .. "/#go_hard")
			slot6.txtlevel = gohelper.findChildText(slot0.viewGO, slot5 .. "/#txt_level")

			table.insert(slot0._gotabs, slot6)
			slot6.simagelevel:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_layerchange_level_" .. slot7))

			if slot7 >= 3 then
				gohelper.setActive(slot6.gohard, true)
			else
				gohelper.setActive(slot6.gohard, false)
			end

			slot6.txtlevel.text = V1a6_CachotRoomConfig.instance:getLayerName(slot7, slot0._difficulty)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_floor_load)
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
end

return slot0
