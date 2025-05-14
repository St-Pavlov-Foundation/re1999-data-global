module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzleBase", package.seeall)

local var_0_0 = class("FairyLandPuzzleBase", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.config = arg_1_1.config
	arg_1_0.viewGO = arg_1_1.viewGO

	arg_1_0:onInitView()
	arg_1_0:start()

	if FairyLandModel.instance:isPassPuzzle(arg_1_0.config.id) then
		if not FairyLandModel.instance:isFinishDialog(arg_1_0.config.successTalkId) then
			arg_1_0:playSuccessTalk()
		elseif not FairyLandModel.instance:isFinishDialog(arg_1_0.config.storyTalkId) then
			arg_1_0:playStoryTalk()
		end
	elseif not FairyLandModel.instance:isFinishDialog(arg_1_0.config.afterTalkId) then
		arg_1_0:playAfterTalk()
	end
end

function var_0_0.start(arg_2_0)
	arg_2_0:onStart()
end

function var_0_0.refresh(arg_3_0, arg_3_1)
	arg_3_0.config = arg_3_1

	arg_3_0:onRefreshView()
end

function var_0_0.destory(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.playTipsAnim, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.playTipsTalk, arg_4_0)
	arg_4_0:onDestroyView()
	arg_4_0:__onDispose()
end

function var_0_0.stopCheckTips(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.playTipsAnim, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.playTipsTalk, arg_5_0)
end

function var_0_0.startCheckTips(arg_6_0)
	arg_6_0:startCheckAnim()
	arg_6_0:startCheckTalk()
end

function var_0_0.startCheckAnim(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.playTipsAnim, arg_7_0)

	if not FairyLandModel.instance:isFinishDialog(arg_7_0.config.afterTalkId) then
		return
	end

	if FairyLandModel.instance:isPassPuzzle(arg_7_0.config.id) then
		return
	end

	TaskDispatcher.runDelay(arg_7_0.playTipsAnim, arg_7_0, 4)
end

function var_0_0.startCheckTalk(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.playTipsTalk, arg_8_0)

	if not FairyLandModel.instance:isFinishDialog(arg_8_0.config.afterTalkId) then
		return
	end

	if FairyLandModel.instance:isPassPuzzle(arg_8_0.config.id) then
		return
	end

	TaskDispatcher.runDelay(arg_8_0.playTipsTalk, arg_8_0, 5)
end

function var_0_0.playAfterTalk(arg_9_0)
	arg_9_0:playTalk(arg_9_0.config.afterTalkId, arg_9_0.startCheckTips, arg_9_0)
end

function var_0_0.playSuccessTalk(arg_10_0)
	arg_10_0:stopCheckTips()

	if not FairyLandModel.instance:isPassPuzzle(arg_10_0.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(arg_10_0.config.id, arg_10_0.config.answer)
	end

	arg_10_0:playTalk(arg_10_0.config.successTalkId, arg_10_0.openCompleteView, arg_10_0)
end

function var_0_0.playErrorTalk(arg_11_0)
	arg_11_0:stopCheckTips()
	arg_11_0:playTalk(arg_11_0.config.errorTalkId, arg_11_0.startCheckTips, arg_11_0, true)
end

function var_0_0.playTipsTalk(arg_12_0)
	arg_12_0:playTalk(arg_12_0.config.tipsTalkId, arg_12_0.startCheckTalk, arg_12_0, true)
end

function var_0_0.playTipsAnim(arg_13_0)
	if not arg_13_0.tipAnim then
		return
	end

	arg_13_0.tipAnim:Stop()

	if not arg_13_0.tipAnim.isActiveAndEnabled then
		return
	end

	arg_13_0.tipAnim:Play("open", arg_13_0.startCheckAnim, arg_13_0)
end

function var_0_0.playStoryTalk(arg_14_0)
	if FairyLandModel.instance:isPassPuzzle(arg_14_0.config.id) then
		if arg_14_0.config.storyTalkId == 0 then
			return
		end

		if not FairyLandModel.instance:isFinishDialog(arg_14_0.config.storyTalkId) then
			local var_14_0 = {
				dialogId = arg_14_0.config.storyTalkId,
				dialogType = FairyLandEnum.DialogType.Option
			}

			FairyLandController.instance:openDialogView(var_14_0)
		end
	end
end

function var_0_0.openCompleteView(arg_15_0)
	local var_15_0 = FairyLandModel.instance:getDialogElement(arg_15_0.config.elementId)

	if var_15_0 then
		var_15_0:setFinish()
	end

	FairyLandController.instance:openCompleteView(arg_15_0.config.id, arg_15_0.playStoryTalk, arg_15_0)
end

function var_0_0.playTalk(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	if ViewMgr.instance:isOpen(ViewName.FairyLandCompleteView) then
		return
	end

	if arg_16_1 > 0 and (arg_16_4 or not FairyLandModel.instance:isFinishDialog(arg_16_1)) then
		local var_16_0 = {
			dialogId = arg_16_1,
			dialogType = FairyLandEnum.DialogType.Bubble,
			leftElement = FairyLandModel.instance:getDialogElement(),
			rightElement = FairyLandModel.instance:getDialogElement(arg_16_0.config.elementId),
			callback = arg_16_2,
			callbackObj = arg_16_3,
			noTween = arg_16_5
		}

		FairyLandController.instance:openDialogView(var_16_0)
	elseif arg_16_2 then
		arg_16_2(arg_16_3)
	end
end

function var_0_0.onInitView(arg_17_0)
	return
end

function var_0_0.onStart(arg_18_0)
	return
end

function var_0_0.onRefreshView(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
