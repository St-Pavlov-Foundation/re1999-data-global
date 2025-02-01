module("modules.logic.scene.cachot.entity.CachotDoorEffect", package.seeall)

slot0 = class("CachotDoorEffect", LuaCompBase)
slot1 = {
	enter = UnityEngine.Animator.StringToHash("enter"),
	active = UnityEngine.Animator.StringToHash("active"),
	exit = UnityEngine.Animator.StringToHash("exit")
}
slot2 = 0.5

function slot0.Create(slot0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot1, false)

	slot0._isInDoor = false
end

function slot0.setIsInDoor(slot0, slot1)
	if slot0._isInDoor == slot1 then
		return
	end

	slot0._isInDoor = slot1

	gohelper.setActive(slot0.go, true)
	TaskDispatcher.cancelTask(slot0.hideEffect, slot0)

	slot2 = slot0._animator:GetCurrentAnimatorStateInfo(0)
	slot3 = 0

	if slot1 then
		if slot2.shortNameHash == uv0.exit then
			slot3 = 1 - slot2.normalizedTime
		end

		slot0._animator:Play(uv0.enter, 0, slot3)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_entrance_light)
	else
		if slot2.shortNameHash == uv0.enter then
			slot3 = 1 - slot2.normalizedTime
		end

		slot0._animator:Play(uv0.exit, 0, slot3)
		TaskDispatcher.runDelay(slot0.hideEffect, slot0, (1 - slot3) * uv1)
	end
end

function slot0.hideEffect(slot0)
	slot0._isInDoor = false

	TaskDispatcher.cancelTask(slot0.hideEffect, slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.dispose(slot0)
	gohelper.destroy(slot0.go)
	TaskDispatcher.cancelTask(slot0.hideEffect, slot0)
end

return slot0
