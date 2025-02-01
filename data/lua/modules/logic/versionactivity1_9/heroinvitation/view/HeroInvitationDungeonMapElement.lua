module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapElement", package.seeall)

slot0 = class("HeroInvitationDungeonMapElement", DungeonMapElement)

function slot0.setFinishAndDotDestroy(slot0)
	if not slot0._wenhaoGo then
		slot0._waitFinishAndDotDestroy = true

		return
	end

	UIBlockHelper.instance:startBlock("DungeonMapSceneTweenPos", 1.6, ViewName.HeroInvitationDungeonMapView)
	slot0:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
end

function slot0._wenHaoAnimDone(slot0)
	if slot0._wenhaoAnimName == "finish" then
		slot0._sceneElements:onRemoveElementFinish()

		if slot0:getElementId() == 311114 then
			TaskDispatcher.runDelay(slot0.delayFinish, slot0, 1)
		end
	end
end

function slot0.delayFinish(slot0)
	ViewMgr.instance:openView(ViewName.HeroInvitationView)
end

function slot0._onResLoaded(slot0)
	uv0.super._onResLoaded(slot0)

	if slot0._waitFinishAndDotDestroy then
		slot0._waitFinishAndDotDestroy = false

		slot0:setFinishAndDotDestroy()
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.delayFinish, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
