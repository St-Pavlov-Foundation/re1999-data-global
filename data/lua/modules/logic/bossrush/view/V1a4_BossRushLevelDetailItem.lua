module("modules.logic.bossrush.view.V1a4_BossRushLevelDetailItem", package.seeall)

slot0 = class("V1a4_BossRushLevelDetailItem", LuaCompBase)
slot1 = {
	UnSelectd = 1,
	Locked = 0,
	Selected = 2
}
slot2 = BossRushEnum.AnimEvtLevelDetailItem

function slot0.init(slot0, slot1)
	slot2 = slot1.transform
	slot0._lockedGo = slot2:GetChild(uv0.Locked).gameObject
	slot0._unSelectedGo = slot2:GetChild(uv0.UnSelectd).gameObject
	slot0._selectedGo = slot2:GetChild(uv0.Selected).gameObject
	slot0._animSelf = slot1:GetComponent(gohelper.Type_Animator)
	slot0._animEvent = slot1:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0.go = slot1

	slot0._animEvent:AddEventListener(uv1.onPlayUnlockSound, slot0._onPlayUnlockSound, slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayUnlockCallBack, slot0)
	slot0._animEvent:RemoveEventListener(uv0.onPlayUnlockSound)
end

function slot0.onDestroyView(slot0)
	slot0:onDestroy()
end

function slot0.setSelect(slot0, slot1)
	gohelper.setActive(slot0._unSelectedGo, not slot1)
	gohelper.setActive(slot0._selectedGo, slot1)
end

function slot0.setData(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._stageLayerInfo = slot2
	slot3 = slot2.isOpen
	slot0._isOpen = slot3

	slot0:setIsLocked(not slot3)

	if not slot3 then
		gohelper.setActive(slot0._unSelectedGo, false)
		gohelper.setActive(slot0._selectedGo, false)
	end
end

function slot0.setIsLocked(slot0, slot1)
	gohelper.setActive(slot0._lockedGo, slot1)
	slot0:playIdle(slot1)
end

function slot0.plaAnim(slot0, slot1, ...)
	slot0._animSelf:Play(slot1, ...)
end

function slot0.playIdle(slot0, slot1)
	slot2 = slot0._isOpen

	if slot1 ~= nil then
		slot2 = not slot1
	end

	if slot2 then
		slot0._animSelf:Play(BossRushEnum.AnimLevelDetailBtn.UnlockedIdle, 0, 1)
	else
		slot0._animSelf:Play(BossRushEnum.AnimLevelDetailBtn.LockedIdle, 0, 1)
	end
end

function slot0.setTrigger(slot0, slot1)
	slot0._animSelf:SetTrigger(slot1)
end

function slot0._delayUnlockCallBack(slot0)
	slot0:setTrigger(BossRushEnum.AnimTriggerLevelDetailBtn.PlayUnlock)
end

function slot0.playUnlock(slot0)
	TaskDispatcher.cancelTask(slot0._delayUnlockCallBack, slot0)
	TaskDispatcher.runDelay(slot0._delayUnlockCallBack, slot0, 0.5)
	slot0:playIdle(true)
end

function slot0._onPlayUnlockSound(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_checkpoint.play_ui_checkpoint_light_up)
end

return slot0
