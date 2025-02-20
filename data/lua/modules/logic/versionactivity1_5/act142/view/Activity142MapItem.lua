module("modules.logic.versionactivity1_5.act142.view.Activity142MapItem", package.seeall)

slot0 = class("Activity142MapItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._clickCb = slot1.clickCb
	slot0._clickCbObj = slot1.clickCbObj
	slot0._starItemList = {}
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._go)
	slot0._golock = gohelper.findChild(slot0._go, "#go_lock")
	slot0._simagemaplock = gohelper.findChildImage(slot0._go, "#go_lock/mask/#simage_maplock")
	slot0._gonormal = gohelper.findChild(slot0._go, "#go_normal")
	slot0._gonormalbg = gohelper.findChild(slot0._go, "#go_normal/#simage_normalbg")
	slot0._gosinglebg = gohelper.findChild(slot0._go, "#go_normal/#simage_singlebg")
	slot0._simagemap = gohelper.findChildImage(slot0._go, "#go_normal/mask/#simage_map")
	slot0._characternum = gohelper.findChildText(slot0._go, "#txt_characternum")
	slot0._txtmap = gohelper.findChildText(slot0._go, "#txt_map")
	slot0._gostarts = gohelper.findChild(slot0._go, "#go_starts")
	slot0._gostartitem = gohelper.findChild(slot0._go, "#go_starts/#go_startitem")

	gohelper.setActive(slot0._gostartitem, false)

	slot0._btnclickarea = gohelper.findChildButtonWithAudio(slot0._go, "#btn_clickarea")
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0._go, "#btn_replay")

	slot0:setEpisodeId()
	slot0:setBg(false)
end

function slot0.addEventListeners(slot0)
	slot0._btnreplay:AddClickListener(slot0._btnreplayOnClick, slot0)
	slot0._btnclickarea:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnreplay:RemoveClickListener()
	slot0._btnclickarea:RemoveClickListener()
end

function slot0._btnreplayOnClick(slot0)
	if not slot0._episodeId then
		return
	end

	Activity142Controller.instance:openStoryView(slot0._episodeId)
end

function slot0._onClick(slot0)
	if not slot0._episodeId or not slot0._clickCb then
		return
	end

	slot0._clickCb(slot0._clickCbObj, slot0._episodeId)
end

function slot0.setEpisodeId(slot0, slot1, slot2)
	slot0:cancelAllTaskDispatcher()

	slot0._episodeId = slot1

	if not slot0._episodeId then
		gohelper.setActive(slot0._go, false)

		return
	end

	gohelper.setActive(slot0._go, true)

	slot0._characternum.text = Activity142Config.instance:getEpisodeOrder(Activity142Model.instance:getActivityId(), slot0._episodeId) or ""
	slot0._txtmap.text = Activity142Config.instance:getEpisodeName(slot3, slot0._episodeId) or ""

	if Activity142Config.instance:getEpisodeNormalSP(slot3, slot0._episodeId) then
		UISpriteSetMgr.instance:setV1a5ChessSprite(slot0._simagemap, slot6)
	end

	if Activity142Config.instance:getEpisodeLockSP(slot3, slot0._episodeId) then
		UISpriteSetMgr.instance:setV1a5ChessSprite(slot0._simagemaplock, slot7)
	end

	for slot11, slot12 in ipairs(slot0._starItemList) do
		gohelper.setActive(slot12.go, false)
	end

	slot12 = slot0._episodeId

	for slot12 = 1, Activity142Config.instance:getEpisodeMaxStar(slot3, slot12) do
		slot13 = slot0._starItemList[slot12] or slot0:_addStarItem()

		gohelper.setActive(slot13.go, true)
		gohelper.setActive(slot13.grayGO, true)
		gohelper.setActive(slot13.lightGO, false)
		gohelper.setActive(slot13.lightEffectGO, false)
	end

	slot0:refresh(slot2)
end

function slot0._addStarItem(slot0)
	slot1 = #slot0._starItemList + 1
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.clone(slot0._gostartitem, slot0._gostarts, "star" .. slot1)
	slot2.grayGO = gohelper.findChild(slot2.go, "#go_gray")
	slot2.lightGO = gohelper.findChild(slot2.go, "#go_light")
	slot2.lightAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot2.lightGO)
	slot2.lightEffectGO = gohelper.findChild(slot2.go, "#go_light/xing")
	slot0._starItemList[slot1] = slot2

	ZProj.UGUIHelper.RebuildLayout(slot0._gostarts.transform)

	return slot2
end

function slot0.setParent(slot0, slot1)
	if gohelper.isNil(slot0._go) or gohelper.isNil(slot1) then
		return
	end

	slot0._go.transform:SetParent(slot1.transform, false)
end

function slot0.setBg(slot0, slot1)
	gohelper.setActive(slot0._gosinglebg, slot1)
	gohelper.setActive(slot0._gonormalbg, not slot1)
end

function slot0.refresh(slot0, slot1)
	if not slot0._episodeId then
		return
	end

	slot0:_refreshUnlock(slot1)
	slot0:_refreshStar()
	slot0:_refreshReplayBtn()
end

function slot0._refreshUnlock(slot0, slot1)
	if slot0._animatorPlayer and slot0._animatorPlayer.isActiveAndEnabled then
		slot0._animatorPlayer:Play(Activity142Enum.MAP_ITEM_IDLE_ANIM)
	end

	if slot0._episodeId ~= Activity142Enum.AUTO_ENTER_EPISODE_ID and not Activity142Controller.instance:havePlayedUnlockAni(string.format("%s_%s", Activity142Enum.MAP_ITEM_CACHE_KEY, slot0._episodeId)) and slot2 and Activity142Model.instance:isEpisodeOpen(Activity142Model.instance:getActivityId(), slot0._episodeId) then
		slot0:playMapItemUnlockAnim(slot1)
	else
		gohelper.setActive(slot0._gonormal, slot4)
		gohelper.setActive(slot0._golock, not slot4)
	end
end

function slot0._refreshStar(slot0)
	if not Activity142Model.instance:getEpisodeData(slot0._episodeId) then
		return
	end

	for slot5, slot6 in ipairs(slot0._starItemList) do
		if slot6.lightAnimatorPlayer then
			slot6.lightAnimatorPlayer:Play(Activity142Enum.MAP_STAR_IDLE_ANIM)
		end

		if not Activity142Controller.instance:havePlayedUnlockAni(string.format("%s_%s_%s", Activity142Enum.MAP_STAR_CACHE_KEY, slot0._episodeId, slot5)) and slot6.lightAnimatorPlayer and slot5 <= slot1.star then
			Activity142Helper.setAct142UIBlock(true, Activity142Enum.EPISODE_STAR_UNLOCK)
			UIBlockMgrExtend.setNeedCircleMv(false)
			gohelper.setActive(slot6.grayGO, true)
			gohelper.setActive(slot6.lightGO, true)
			slot6.lightAnimatorPlayer:Play(Activity142Enum.MAP_STAR_OPEN_ANIM, slot0._finishStarItemUnlockAnim, {
				self = slot0,
				index = slot5
			})
		else
			gohelper.setActive(slot6.grayGO, not slot9)
			gohelper.setActive(slot6.lightGO, slot9)
		end
	end
end

function slot0._finishStarItemUnlockAnim(slot0)
	if not slot0 or not slot0.self or not slot0.self._episodeId or not slot0.index then
		return
	end

	slot1 = slot0.self

	Activity142Controller.instance:setPlayedUnlockAni(string.format("%s_%s_%s", Activity142Enum.MAP_STAR_CACHE_KEY, slot1._episodeId, slot0.index))
	slot1:_endBlock(true)
end

function slot0._refreshReplayBtn(slot0)
	slot1 = Activity142Model.instance:getActivityId()

	gohelper.setActive(slot0._btnreplay.gameObject, Activity142Model.instance:isEpisodeClear(slot0._episodeId) and not Va3ChessConfig.instance:isStoryEpisode(slot1, slot0._episodeId) and #Activity142Config.instance:getEpisodeStoryList(slot1, slot0._episodeId) > 0)
end

function slot0.playMapItemUnlockAnim(slot0, slot1)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.MAP_ITEM_UNLOCK)
	gohelper.setActive(slot0._golock, true)
	gohelper.setActive(slot0._gonormal, false)

	if slot1 and slot1 > 0 then
		TaskDispatcher.runDelay(slot0._delayPlayMapItemUnlockAnim, slot0, slot1)
	else
		slot0:_delayPlayMapItemUnlockAnim()
	end
end

function slot0._delayPlayMapItemUnlockAnim(slot0)
	gohelper.setActive(slot0._gonormal, true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
	slot0._animatorPlayer:Play(Activity142Enum.CATEGORY_UNLOCK_ANIM, slot0._finishMapItemUnlockAnim, slot0)
end

function slot0._finishMapItemUnlockAnim(slot0)
	Activity142Controller.instance:setPlayedUnlockAni(string.format("%s_%s", Activity142Enum.MAP_ITEM_CACHE_KEY, slot0._episodeId))
	slot0:_endBlock()
end

function slot0._endBlock(slot0, slot1)
	slot2 = Activity142Enum.MAP_ITEM_UNLOCK

	if slot1 then
		slot2 = Activity142Enum.EPISODE_STAR_UNLOCK
	end

	Activity142Helper.setAct142UIBlock(false, slot2)
end

function slot0.onDestroy(slot0)
	slot0._episodeId = nil
	slot0.clickCb = nil
	slot0.clickCbObj = nil
	slot0._starItemList = {}

	slot0:cancelAllTaskDispatcher()
	slot0:_endBlock()
	slot0:_endBlock(true)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.cancelAllTaskDispatcher(slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayMapItemUnlockAnim, slot0)
end

return slot0
