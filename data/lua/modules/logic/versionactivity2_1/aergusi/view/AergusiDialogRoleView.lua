module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleView", package.seeall)

local var_0_0 = class("AergusiDialogRoleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochesscontainer = gohelper.findChild(arg_1_0.viewGO, "#go_chesscontainer")
	arg_1_0._goleftchessitem = gohelper.findChild(arg_1_0.viewGO, "#go_chesscontainer/#go_leftchessitem")
	arg_1_0._gorightchessitem = gohelper.findChild(arg_1_0.viewGO, "#go_chesscontainer/#go_rightchessitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:_addEvents()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_initRoleItem()
end

function var_0_0._initRoleItem(arg_6_0)
	gohelper.setActive(arg_6_0._goleftchessitem, false)
	gohelper.setActive(arg_6_0._gorightchessitem, false)

	arg_6_0._episodeConfig = AergusiConfig.instance:getEpisodeConfig(nil, arg_6_0.viewParam.episodeId)

	if arg_6_0._episodeConfig.playerPieces ~= "" then
		arg_6_0._rightRoleItem = AergusiDialogRoleRightItem.New()

		arg_6_0._rightRoleItem:init(arg_6_0._gorightchessitem, arg_6_0._episodeConfig.playerPieces)
	end

	if arg_6_0._episodeConfig.opponentPieces ~= "" then
		arg_6_0._leftRoleItem = AergusiDialogRoleLeftItem.New()

		arg_6_0._leftRoleItem:init(arg_6_0._goleftchessitem, arg_6_0._episodeConfig.opponentPieces)
	end
end

function var_0_0._addEvents(arg_7_0)
	arg_7_0:addEventCb(AergusiController.instance, AergusiEvent.OnStartDialogNextStep, arg_7_0._onEnterNextStep, arg_7_0)
	arg_7_0:addEventCb(AergusiController.instance, AergusiEvent.OnStartAutoBubbleDialog, arg_7_0._onStartAutoBubbleDialog, arg_7_0)
	arg_7_0:addEventCb(AergusiController.instance, AergusiEvent.OnDialogAskFail, arg_7_0._onDialogAskFail, arg_7_0)
	arg_7_0:addEventCb(AergusiController.instance, AergusiEvent.OnStartErrorBubbleDialog, arg_7_0._onDialogStartErrorBubble, arg_7_0)
	arg_7_0:addEventCb(AergusiController.instance, AergusiEvent.OnDialogNotKeyAsk, arg_7_0._onDialogNotKeyAsk, arg_7_0)
end

function var_0_0._removeEvents(arg_8_0)
	arg_8_0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartDialogNextStep, arg_8_0._onEnterNextStep, arg_8_0)
	arg_8_0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartAutoBubbleDialog, arg_8_0._onStartAutoBubbleDialog, arg_8_0)
	arg_8_0:removeEventCb(AergusiController.instance, AergusiEvent.OnDialogAskFail, arg_8_0._onDialogAskFail, arg_8_0)
	arg_8_0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartErrorBubbleDialog, arg_8_0._onDialogStartErrorBubble, arg_8_0)
	arg_8_0:removeEventCb(AergusiController.instance, AergusiEvent.OnDialogNotKeyAsk, arg_8_0._onDialogNotKeyAsk, arg_8_0)
end

function var_0_0._onEnterNextStep(arg_9_0, arg_9_1)
	arg_9_0._stepCo = arg_9_1

	if arg_9_0._rightRoleItem then
		arg_9_0._rightRoleItem:hideTalking()
	end

	if arg_9_0._leftRoleItem then
		arg_9_0._leftRoleItem:hideTalking()
	end

	if arg_9_0._stepCo.pos == AergusiEnum.DialogType.NormalLeft then
		if arg_9_0._leftRoleItem then
			arg_9_0._leftRoleItem:showTalking()
		end
	elseif arg_9_0._stepCo.pos == AergusiEnum.DialogType.NormalRight and arg_9_0._rightRoleItem then
		arg_9_0._rightRoleItem:showTalking()
	end
end

function var_0_0._onStartAutoBubbleDialog(arg_10_0, arg_10_1)
	TaskDispatcher.cancelTask(arg_10_0._playNextAutoBubble, arg_10_0)

	arg_10_0._autoCallback = arg_10_1.callback
	arg_10_0._autoCallbackObj = arg_10_1.callbackObj
	arg_10_0._stepCo = arg_10_1.stepCo

	if arg_10_0._stepCo.condition ~= "" then
		local var_10_0 = string.splitToNumber(arg_10_0._stepCo.condition, "#")

		if var_10_0[1] == AergusiEnum.OperationType.AutoBubble then
			arg_10_0:_playBubbleGroup(var_10_0[2])

			return
		end
	end

	arg_10_0:_autoFinishCallback()
end

function var_0_0._onDialogAskFail(arg_11_0, arg_11_1)
	TaskDispatcher.cancelTask(arg_11_0._playNextAutoBubble, arg_11_0)

	arg_11_0._stepCo = arg_11_1

	local var_11_0 = AergusiConfig.instance:getEvidenceConfig(arg_11_0._stepCo.id).tips

	arg_11_0:_playBubbleGroup(var_11_0)
end

function var_0_0._onDialogStartErrorBubble(arg_12_0, arg_12_1)
	TaskDispatcher.cancelTask(arg_12_0._playNextAutoBubble, arg_12_0)

	arg_12_0._autoCallback = arg_12_1.callback
	arg_12_0._autoCallbackObj = arg_12_1.callbackObj

	arg_12_0:_playBubbleGroup(arg_12_1.bubbleId)
end

function var_0_0._onDialogNotKeyAsk(arg_13_0, arg_13_1)
	arg_13_0:_playBubbleGroup(arg_13_1)
end

function var_0_0._playBubbleGroup(arg_14_0, arg_14_1)
	UIBlockMgrExtend.setNeedCircleMv(false)

	arg_14_0._playIndex = 1
	arg_14_0._bubbleId = arg_14_1

	arg_14_0:_playNextAutoBubble()
end

function var_0_0._playNextAutoBubble(arg_15_0)
	if arg_15_0._rightRoleItem then
		arg_15_0._rightRoleItem:hideBubble()
		arg_15_0._rightRoleItem:hideTalking()
	end

	if arg_15_0._leftRoleItem then
		arg_15_0._leftRoleItem:hideBubble()
		arg_15_0._leftRoleItem:hideTalking()
	end

	local var_15_0 = AergusiDialogModel.instance:getBubbleStepList(arg_15_0._bubbleId)

	if arg_15_0._playIndex > #var_15_0 then
		arg_15_0:_autoFinishCallback()

		return
	else
		local var_15_1 = AergusiConfig.instance:getBubbleConfig(arg_15_0._bubbleId, var_15_0[arg_15_0._playIndex].stepId)

		if var_15_1.direction == AergusiEnum.DialogBubblePos.Left then
			if arg_15_0._leftRoleItem then
				arg_15_0._leftRoleItem:showBubble(var_15_0[arg_15_0._playIndex])
			end
		elseif arg_15_0._rightRoleItem then
			arg_15_0._rightRoleItem:showBubble(var_15_0[arg_15_0._playIndex])
		end

		local var_15_2 = 0.05 * LuaUtil.getStrLen(var_15_1.content) + 1

		TaskDispatcher.runDelay(arg_15_0._playNextAutoBubble, arg_15_0, var_15_2)
	end

	arg_15_0._playIndex = arg_15_0._playIndex + 1
end

function var_0_0._autoFinishCallback(arg_16_0)
	if arg_16_0._autoCallback then
		arg_16_0._autoCallback(arg_16_0._autoCallbackObj)

		arg_16_0._autoCallback = nil
		arg_16_0._autoCallbackObj = nil
	end
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._playNextAutoBubble, arg_18_0)

	if arg_18_0._rightRoleItem then
		arg_18_0._rightRoleItem:destroy()

		arg_18_0._rightRoleItem = nil
	end

	if arg_18_0._leftRoleItem then
		arg_18_0._leftRoleItem:destroy()

		arg_18_0._leftRoleItem = nil
	end

	arg_18_0:_removeEvents()
end

return var_0_0
