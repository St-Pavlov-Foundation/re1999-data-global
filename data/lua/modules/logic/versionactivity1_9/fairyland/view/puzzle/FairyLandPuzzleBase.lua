module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzleBase", package.seeall)

slot0 = class("FairyLandPuzzleBase", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.config = slot1.config
	slot0.viewGO = slot1.viewGO

	slot0:onInitView()
	slot0:start()

	if FairyLandModel.instance:isPassPuzzle(slot0.config.id) then
		if not FairyLandModel.instance:isFinishDialog(slot0.config.successTalkId) then
			slot0:playSuccessTalk()
		elseif not FairyLandModel.instance:isFinishDialog(slot0.config.storyTalkId) then
			slot0:playStoryTalk()
		end
	elseif not FairyLandModel.instance:isFinishDialog(slot0.config.afterTalkId) then
		slot0:playAfterTalk()
	end
end

function slot0.start(slot0)
	slot0:onStart()
end

function slot0.refresh(slot0, slot1)
	slot0.config = slot1

	slot0:onRefreshView()
end

function slot0.destory(slot0)
	TaskDispatcher.cancelTask(slot0.playTipsAnim, slot0)
	TaskDispatcher.cancelTask(slot0.playTipsTalk, slot0)
	slot0:onDestroyView()
	slot0:__onDispose()
end

function slot0.stopCheckTips(slot0)
	TaskDispatcher.cancelTask(slot0.playTipsAnim, slot0)
	TaskDispatcher.cancelTask(slot0.playTipsTalk, slot0)
end

function slot0.startCheckTips(slot0)
	slot0:startCheckAnim()
	slot0:startCheckTalk()
end

function slot0.startCheckAnim(slot0)
	TaskDispatcher.cancelTask(slot0.playTipsAnim, slot0)

	if not FairyLandModel.instance:isFinishDialog(slot0.config.afterTalkId) then
		return
	end

	if FairyLandModel.instance:isPassPuzzle(slot0.config.id) then
		return
	end

	TaskDispatcher.runDelay(slot0.playTipsAnim, slot0, 4)
end

function slot0.startCheckTalk(slot0)
	TaskDispatcher.cancelTask(slot0.playTipsTalk, slot0)

	if not FairyLandModel.instance:isFinishDialog(slot0.config.afterTalkId) then
		return
	end

	if FairyLandModel.instance:isPassPuzzle(slot0.config.id) then
		return
	end

	TaskDispatcher.runDelay(slot0.playTipsTalk, slot0, 5)
end

function slot0.playAfterTalk(slot0)
	slot0:playTalk(slot0.config.afterTalkId, slot0.startCheckTips, slot0)
end

function slot0.playSuccessTalk(slot0)
	slot0:stopCheckTips()

	if not FairyLandModel.instance:isPassPuzzle(slot0.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(slot0.config.id, slot0.config.answer)
	end

	slot0:playTalk(slot0.config.successTalkId, slot0.openCompleteView, slot0)
end

function slot0.playErrorTalk(slot0)
	slot0:stopCheckTips()
	slot0:playTalk(slot0.config.errorTalkId, slot0.startCheckTips, slot0, true)
end

function slot0.playTipsTalk(slot0)
	slot0:playTalk(slot0.config.tipsTalkId, slot0.startCheckTalk, slot0, true)
end

function slot0.playTipsAnim(slot0)
	if not slot0.tipAnim then
		return
	end

	slot0.tipAnim:Stop()

	if not slot0.tipAnim.isActiveAndEnabled then
		return
	end

	slot0.tipAnim:Play("open", slot0.startCheckAnim, slot0)
end

function slot0.playStoryTalk(slot0)
	if FairyLandModel.instance:isPassPuzzle(slot0.config.id) then
		if slot0.config.storyTalkId == 0 then
			return
		end

		if not FairyLandModel.instance:isFinishDialog(slot0.config.storyTalkId) then
			FairyLandController.instance:openDialogView({
				dialogId = slot0.config.storyTalkId,
				dialogType = FairyLandEnum.DialogType.Option
			})
		end
	end
end

function slot0.openCompleteView(slot0)
	if FairyLandModel.instance:getDialogElement(slot0.config.elementId) then
		slot1:setFinish()
	end

	FairyLandController.instance:openCompleteView(slot0.config.id, slot0.playStoryTalk, slot0)
end

function slot0.playTalk(slot0, slot1, slot2, slot3, slot4, slot5)
	if ViewMgr.instance:isOpen(ViewName.FairyLandCompleteView) then
		return
	end

	if slot1 > 0 and (slot4 or not FairyLandModel.instance:isFinishDialog(slot1)) then
		FairyLandController.instance:openDialogView({
			dialogId = slot1,
			dialogType = FairyLandEnum.DialogType.Bubble,
			leftElement = FairyLandModel.instance:getDialogElement(),
			rightElement = FairyLandModel.instance:getDialogElement(slot0.config.elementId),
			callback = slot2,
			callbackObj = slot3,
			noTween = slot5
		})
	elseif slot2 then
		slot2(slot3)
	end
end

function slot0.onInitView(slot0)
end

function slot0.onStart(slot0)
end

function slot0.onRefreshView(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
