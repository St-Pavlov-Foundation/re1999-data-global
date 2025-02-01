module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleView", package.seeall)

slot0 = class("AergusiDialogRoleView", BaseView)

function slot0.onInitView(slot0)
	slot0._gochesscontainer = gohelper.findChild(slot0.viewGO, "#go_chesscontainer")
	slot0._goleftchessitem = gohelper.findChild(slot0.viewGO, "#go_chesscontainer/#go_leftchessitem")
	slot0._gorightchessitem = gohelper.findChild(slot0.viewGO, "#go_chesscontainer/#go_rightchessitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:_addEvents()
end

function slot0.onOpen(slot0)
	slot0:_initRoleItem()
end

function slot0._initRoleItem(slot0)
	gohelper.setActive(slot0._goleftchessitem, false)
	gohelper.setActive(slot0._gorightchessitem, false)

	slot0._episodeConfig = AergusiConfig.instance:getEpisodeConfig(nil, slot0.viewParam.episodeId)

	if slot0._episodeConfig.playerPieces ~= "" then
		slot0._rightRoleItem = AergusiDialogRoleRightItem.New()

		slot0._rightRoleItem:init(slot0._gorightchessitem, slot0._episodeConfig.playerPieces)
	end

	if slot0._episodeConfig.opponentPieces ~= "" then
		slot0._leftRoleItem = AergusiDialogRoleLeftItem.New()

		slot0._leftRoleItem:init(slot0._goleftchessitem, slot0._episodeConfig.opponentPieces)
	end
end

function slot0._addEvents(slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnStartDialogNextStep, slot0._onEnterNextStep, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnStartAutoBubbleDialog, slot0._onStartAutoBubbleDialog, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnDialogAskFail, slot0._onDialogAskFail, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnStartErrorBubbleDialog, slot0._onDialogStartErrorBubble, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnDialogNotKeyAsk, slot0._onDialogNotKeyAsk, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartDialogNextStep, slot0._onEnterNextStep, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartAutoBubbleDialog, slot0._onStartAutoBubbleDialog, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnDialogAskFail, slot0._onDialogAskFail, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartErrorBubbleDialog, slot0._onDialogStartErrorBubble, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnDialogNotKeyAsk, slot0._onDialogNotKeyAsk, slot0)
end

function slot0._onEnterNextStep(slot0, slot1)
	slot0._stepCo = slot1

	if slot0._rightRoleItem then
		slot0._rightRoleItem:hideTalking()
	end

	if slot0._leftRoleItem then
		slot0._leftRoleItem:hideTalking()
	end

	if slot0._stepCo.pos == AergusiEnum.DialogType.NormalLeft then
		if slot0._leftRoleItem then
			slot0._leftRoleItem:showTalking()
		end
	elseif slot0._stepCo.pos == AergusiEnum.DialogType.NormalRight and slot0._rightRoleItem then
		slot0._rightRoleItem:showTalking()
	end
end

function slot0._onStartAutoBubbleDialog(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._playNextAutoBubble, slot0)

	slot0._autoCallback = slot1.callback
	slot0._autoCallbackObj = slot1.callbackObj
	slot0._stepCo = slot1.stepCo

	if slot0._stepCo.condition ~= "" and string.splitToNumber(slot0._stepCo.condition, "#")[1] == AergusiEnum.OperationType.AutoBubble then
		slot0:_playBubbleGroup(slot2[2])

		return
	end

	slot0:_autoFinishCallback()
end

function slot0._onDialogAskFail(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._playNextAutoBubble, slot0)

	slot0._stepCo = slot1

	slot0:_playBubbleGroup(AergusiConfig.instance:getEvidenceConfig(slot0._stepCo.id).tips)
end

function slot0._onDialogStartErrorBubble(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._playNextAutoBubble, slot0)

	slot0._autoCallback = slot1.callback
	slot0._autoCallbackObj = slot1.callbackObj

	slot0:_playBubbleGroup(slot1.bubbleId)
end

function slot0._onDialogNotKeyAsk(slot0, slot1)
	slot0:_playBubbleGroup(slot1)
end

function slot0._playBubbleGroup(slot0, slot1)
	UIBlockMgrExtend.setNeedCircleMv(false)

	slot0._playIndex = 1
	slot0._bubbleId = slot1

	slot0:_playNextAutoBubble()
end

function slot0._playNextAutoBubble(slot0)
	if slot0._rightRoleItem then
		slot0._rightRoleItem:hideBubble()
		slot0._rightRoleItem:hideTalking()
	end

	if slot0._leftRoleItem then
		slot0._leftRoleItem:hideBubble()
		slot0._leftRoleItem:hideTalking()
	end

	if slot0._playIndex > #AergusiDialogModel.instance:getBubbleStepList(slot0._bubbleId) then
		slot0:_autoFinishCallback()

		return
	else
		if AergusiConfig.instance:getBubbleConfig(slot0._bubbleId, slot1[slot0._playIndex].stepId).direction == AergusiEnum.DialogBubblePos.Left then
			if slot0._leftRoleItem then
				slot0._leftRoleItem:showBubble(slot1[slot0._playIndex])
			end
		elseif slot0._rightRoleItem then
			slot0._rightRoleItem:showBubble(slot1[slot0._playIndex])
		end

		TaskDispatcher.runDelay(slot0._playNextAutoBubble, slot0, 0.05 * LuaUtil.getStrLen(slot2.content) + 1)
	end

	slot0._playIndex = slot0._playIndex + 1
end

function slot0._autoFinishCallback(slot0)
	if slot0._autoCallback then
		slot0._autoCallback(slot0._autoCallbackObj)

		slot0._autoCallback = nil
		slot0._autoCallbackObj = nil
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._playNextAutoBubble, slot0)

	if slot0._rightRoleItem then
		slot0._rightRoleItem:destroy()

		slot0._rightRoleItem = nil
	end

	if slot0._leftRoleItem then
		slot0._leftRoleItem:destroy()

		slot0._leftRoleItem = nil
	end

	slot0:_removeEvents()
end

return slot0
