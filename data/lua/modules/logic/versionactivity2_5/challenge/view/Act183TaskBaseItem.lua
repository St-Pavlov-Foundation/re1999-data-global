module("modules.logic.versionactivity2_5.challenge.view.Act183TaskBaseItem", package.seeall)

slot0 = class("Act183TaskBaseItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.go)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0._mo = slot1

	slot0:playAnim()
end

function slot0.playAnim(slot0)
	slot1 = UnityEngine.Time.frameCount - Act183TaskListModel.instance.startFrameCount < 10
	slot0._animName = slot1 and UIAnimationName.Open or UIAnimationName.Idle

	gohelper.setActive(slot0.go, false)
	TaskDispatcher.cancelTask(slot0._playAnimByName, slot0)

	if slot1 then
		TaskDispatcher.runDelay(slot0._playAnimByName, slot0, (slot0._index - 1) * 0.03)

		return
	end

	slot0:_playAnimByName()
end

function slot0._playAnimByName(slot0)
	gohelper.setActive(slot0.go, true)

	if not slot0._animName or not slot0.go.activeInHierarchy then
		return
	end

	slot0._animatorPlayer:Play(slot0._animName, slot0._onPlayAnimDone, slot0)
end

function slot0._onPlayAnimDone(slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._playAnimByName, slot0)
	slot0:setBlock(false)
end

function slot0.setBlock(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act183TaskBaseItem_ReceiveReward")
	else
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock("Act183TaskBaseItem_ReceiveReward")
	end
end

return slot0
