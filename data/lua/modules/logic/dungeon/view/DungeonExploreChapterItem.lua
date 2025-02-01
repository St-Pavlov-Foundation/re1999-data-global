module("modules.logic.dungeon.view.DungeonExploreChapterItem", package.seeall)

slot0 = class("DungeonExploreChapterItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._imageselectlevel = gohelper.findChildImage(slot1, "#go_selected/image_level")
	slot0._imageunselectlevel = gohelper.findChildImage(slot1, "#go_unselected/image_level")
	slot0._goselected = gohelper.findChild(slot1, "#go_selected")
	slot0._gounselected = gohelper.findChild(slot1, "#go_unselected")
	slot0._golocked = gohelper.findChild(slot1, "#go_locked")
	slot0._btnclick = gohelper.findChildButton(slot1, "#btn_click")
	slot0._txtselectname = gohelper.findChildTextMesh(slot1, "#go_selected/txt_levelname")
	slot0._txtselectnameEn = gohelper.findChildTextMesh(slot1, "#go_selected/Text")
	slot0._txtunselectname = gohelper.findChildTextMesh(slot1, "#go_unselected/txt_levelname")
	slot0._gonew = gohelper.findChild(slot1, "#go_unselected/go_unselectednew")
	slot0._goselectStar = gohelper.findChild(slot1, "#go_selected/#simage_star")
	slot0._gounselectStar = gohelper.findChild(slot1, "#go_unselected/#simage_star")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))

	slot0._btnclick:AddClickListener(slot0._click, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, slot0.onChapterClick, slot0)
end

function slot0.setData(slot0, slot1, slot2)
	slot0._index = slot2
	slot0._config = slot1
	slot0._txtselectname.text = slot1.name
	slot0._txtunselectname.text = slot1.name
	slot0._txtselectnameEn.text = slot1.name_En

	UISpriteSetMgr.instance:setExploreSprite(slot0._imageselectlevel, "dungeon_secretroom_img_select" .. tostring(slot2))
	UISpriteSetMgr.instance:setExploreSprite(slot0._imageunselectlevel, "dungeon_secretroom_img_unselect" .. tostring(slot2))

	slot3 = ExploreSimpleModel.instance:isChapterCoinFull(slot1.id)
	slot5 = true

	if not not ExploreSimpleModel.instance:getChapterIsUnLock(slot1.id) then
		slot5 = ExploreSimpleModel.instance:getChapterIsShowUnlock(slot1.id)
	end

	gohelper.setActive(slot0._gonew, not slot3 and ExploreSimpleModel.instance:getChapterIsNew(slot1.id))
	gohelper.setActive(slot0._goselectStar, slot3)
	gohelper.setActive(slot0._gounselectStar, slot3)
	gohelper.setActive(slot0._golocked, slot4)

	if not slot5 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		ExploreSimpleModel.instance:markChapterShowUnlock(slot1.id)
		gohelper.setActive(slot0._golocked, true)
		gohelper.setActive(slot0._gounselected, true)

		slot0._showingUnlock = true

		TaskDispatcher.runDelay(slot0._unlockFinish, slot0, 1.3)
		slot0._anim:Play("unlock", 0, 0)
	else
		slot0._showingUnlock = false

		TaskDispatcher.cancelTask(slot0._unlockFinish, slot0)
		slot0._anim:Play("idle", 0, 0)
	end

	ExploreSimpleModel.instance:markChapterNew(slot0._config.id)

	slot0._isLock = slot4
end

function slot0._unlockFinish(slot0)
	slot0._showingUnlock = false

	gohelper.setActive(slot0._golocked, false)
	TaskDispatcher.cancelTask(slot0._unlockFinish, slot0)
	slot0._anim:Play("idle", 0, 0)
end

function slot0._click(slot0)
	if slot0._isLock then
		slot3 = ""
		slot4 = ""

		if DungeonConfig.instance:getChapterEpisodeCOList(slot0._config.id)[1] and lua_episode.configDict[slot1.preEpisode] then
			slot3 = lua_chapter.configDict[slot2.chapterId].name
			slot4 = slot2.name
		end

		GameFacade.showToast(ExploreConstValue.Toast.ExploreChapterLock, slot3, slot4)

		return
	end

	gohelper.setActive(slot0._gonew, false)
	ExploreSimpleModel.instance:markChapterNew(slot0._config.id)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnChapterClick, slot0._index)
end

function slot0.onChapterClick(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1 == slot0._index and not slot0._isLock)
	gohelper.setActive(slot0._gounselected, slot1 ~= slot0._index and not slot0._isLock)

	if slot1 == slot0._index then
		gohelper.setActive(slot0._gonew, false)
	end

	if slot1 == slot0._index and not slot0._isLock and slot0._showingUnlock then
		slot0:_unlockFinish()
	end
end

function slot0.destroy(slot0)
	slot0:_unlockFinish()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnChapterClick, slot0.onChapterClick, slot0)
	slot0._btnclick:RemoveClickListener()

	slot0._index = 0
	slot0._config = nil
	slot0._goselected = nil
	slot0._gounselected = nil
	slot0._btnclick = nil
	slot0._txtselectname = nil
	slot0._txtunselectname = nil
end

return slot0
