module("modules.logic.versionactivity1_5.act142.view.Activity142CollectionItem", package.seeall)

slot0 = class("Activity142CollectionItem", LuaCompBase)
slot1 = 0.25

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._go)
	slot0._goUnlock = gohelper.findChild(slot0._go, "go_unlocked")
	slot0._collectionIcon = gohelper.findChildImage(slot0._go, "go_unlocked/icon_bg/collection_icon")
	slot0._txtName = gohelper.findChildText(slot0._go, "go_unlocked/middle/#txt_name")
	slot0._txtNameEn = gohelper.findChildText(slot0._go, "go_unlocked/middle/#txt_en")
	slot0._scrollDesc = gohelper.findChild(slot0._go, "go_unlocked/#scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._txtDesc = gohelper.findChildText(slot0._go, "go_unlocked/#scroll_desc/Viewport/Content/#txt_desc")
	slot0._txtUnlockIndex = gohelper.findChildText(slot0._go, "go_unlocked/#txt_index")
	slot0._goLock = gohelper.findChild(slot0._go, "go_locked")
	slot0._txtLockIndex = gohelper.findChildText(slot0._go, "go_locked/#txt_index")
	slot0._goRightLine = gohelper.findChild(slot0._go, "line")
	slot0._index = nil
	slot0._collectionId = nil
	slot0._isLast = false
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4)
	slot0._index = slot1
	slot0._collectionId = slot2
	slot0._isLast = slot3
	slot0._parentScrollGO = slot4

	slot0:refresh()
	gohelper.setActive(slot0._go, slot0._collectionId)
end

function slot0.onStart(slot0)
	if not slot0._collectionId then
		return
	end

	slot0:refresh()
end

function slot0.refresh(slot0)
	if not slot0._collectionId or gohelper.isNil(slot0._go) then
		return
	end

	if slot0._parentScrollGO then
		slot0._scrollDesc.parentGameObject = slot0._parentScrollGO
	end

	slot0._scrollDesc.horizontalNormalizedPosition = 0

	if not Activity142Config.instance:getCollectionCfg(Activity142Model.instance:getActivityId(), slot0._collectionId, true) then
		return
	end

	if Activity142Model.instance:isHasCollection(slot0._collectionId) then
		slot0._txtDesc.text = slot2.desc
		slot0._txtName.text = slot2.name
		slot0._txtNameEn.text = slot2.nameen

		slot0:loadIcon(slot2.icon)
	end

	if slot0._animatorPlayer and slot0._animatorPlayer.isActiveAndEnabled then
		slot0._animatorPlayer:Play(Activity142Enum.COLLECTION_IDLE_ANIM)
	end

	if not Activity142Controller.instance:havePlayedUnlockAni(string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, slot0._collectionId)) and slot4 and slot3 then
		Activity142Helper.setAct142UIBlock(true, Activity142Enum.COLLECTION_UNLOCK)
		gohelper.setActive(slot0._goLock, true)
		gohelper.setActive(slot0._goUnlock, true)
		TaskDispatcher.runDelay(slot0.playUnlockAudio, slot0, uv0)
		slot0._animatorPlayer:Play(Activity142Enum.COLLECTION_UNLOCK_ANIM, slot0._finishUnlockAnim, slot0)
	else
		gohelper.setActive(slot0._goUnlock, slot3)
		gohelper.setActive(slot0._goLock, not slot3)
	end

	slot7 = string.format("%02d", slot0._collectionId)
	slot0._txtUnlockIndex.text = slot7
	slot0._txtLockIndex.text = slot7

	gohelper.setActive(slot0._goRightLine, slot0._isLast)
end

function slot0.playUnlockAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
end

function slot0._finishUnlockAnim(slot0)
	Activity142Controller.instance:setPlayedUnlockAni(string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, slot0._collectionId))
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.COLLECTION_UNLOCK)
end

function slot0.loadIcon(slot0, slot1)
	if not slot1 then
		return
	end

	UISpriteSetMgr.instance:setV1a5ChessSprite(slot0._collectionIcon, slot1)
end

function slot0.onDestroy(slot0)
	slot0._index = nil
	slot0._collectionId = nil
	slot0._isLast = false

	TaskDispatcher.cancelTask(slot0.playUnlockAudio, slot0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.COLLECTION_UNLOCK)
end

return slot0
