module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandBubble", package.seeall)

local var_0_0 = class("FairyLandBubble", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.dialogView = arg_1_1
	arg_1_0._go = gohelper.findChild(arg_1_1.dialogGO, "#go_Dialog")
	arg_1_0.btnDialogClick = gohelper.findChildButtonWithAudio(arg_1_0._go, "#go_Click")
	arg_1_0.goBubbleLeft = gohelper.findChild(arg_1_0._go, "#go_BubbleLeft")
	arg_1_0.goBubbleRight = gohelper.findChild(arg_1_0._go, "#go_BubbleRight")

	gohelper.setActive(arg_1_0.goBubbleLeft, false)
	gohelper.setActive(arg_1_0.goBubbleRight, false)
	arg_1_0:addClickCb(arg_1_0.btnDialogClick, arg_1_0.onClickDialog, arg_1_0)

	arg_1_0.bubbleItems = {}
end

function var_0_0.onClickDialog(arg_2_0)
	if not arg_2_0.dialogId then
		return
	end

	if arg_2_0.isPlaying then
		arg_2_0:showDialogText()
	elseif arg_2_0.canNext then
		arg_2_0:playNextStep()
	end
end

function var_0_0.startDialog(arg_3_0, arg_3_1)
	arg_3_0.dialogId = arg_3_1.dialogId
	arg_3_0.leftElement = arg_3_1.leftElement
	arg_3_0.rightElement = arg_3_1.rightElement
	arg_3_0.noTweenText = arg_3_1.noTween

	gohelper.setActive(arg_3_0._go, true)
	arg_3_0:selectOption(0)
end

function var_0_0.selectOption(arg_4_0, arg_4_1)
	arg_4_0.sectionId = arg_4_1
	arg_4_0.step = 0
	arg_4_0.sectionConfig = FairyLandConfig.instance:getDialogConfig(arg_4_0.dialogId, arg_4_0.sectionId)

	if arg_4_0.sectionConfig then
		arg_4_0:playNextStep()
	else
		arg_4_0:finished()
	end
end

function var_0_0.playNextStep(arg_5_0)
	arg_5_0.step = arg_5_0.step + 1

	local var_5_0 = arg_5_0.sectionConfig[arg_5_0.step]

	if not var_5_0 then
		arg_5_0:finished()

		return
	end

	arg_5_0.canNext = false

	TaskDispatcher.cancelTask(arg_5_0._delayFlag, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._delayFlag, arg_5_0, 1)
	arg_5_0:playStep(var_5_0, true)
end

function var_0_0.playStep(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.elementId == 1 and arg_6_0:getLeftItem() or arg_6_0:getRightItem()

	arg_6_0.isPlaying = true

	local var_6_1 = arg_6_0.sectionConfig[arg_6_0.step + 1] ~= nil
	local var_6_2 = arg_6_1.elementId == 1 and arg_6_0.leftElement or arg_6_0.rightElement

	if var_6_2 then
		var_6_2:playDialog()
	end

	var_6_0:setTargetGO(var_6_2 and var_6_2.imgChessRoot)

	if arg_6_2 then
		arg_6_0:playAudio(arg_6_1.audioId)
	end

	if arg_6_0.noTweenText then
		arg_6_2 = false
	end

	var_6_0:showBubble(arg_6_1.content, arg_6_2, var_6_1)

	local var_6_3 = arg_6_1.elementId == 1 and arg_6_0:getRightItem() or arg_6_0:getLeftItem()

	if var_6_3 then
		var_6_3:hide()
	end
end

function var_0_0._delayFlag(arg_7_0)
	arg_7_0.canNext = true
end

function var_0_0.showDialogText(arg_8_0)
	local var_8_0 = arg_8_0.sectionConfig[arg_8_0.step]

	if not var_8_0 then
		arg_8_0:finished()

		return
	end

	arg_8_0:playStep(var_8_0)
end

function var_0_0.onTextPlayFinish(arg_9_0)
	arg_9_0.isPlaying = false
end

function var_0_0.finished(arg_10_0)
	arg_10_0.dialogId = nil
	arg_10_0.isPlaying = false

	arg_10_0.dialogView:finished()
end

function var_0_0.getLeftItem(arg_11_0)
	if not arg_11_0.leftItem then
		arg_11_0.leftItem = FairyLandBubbleTalkItem.New()

		arg_11_0.leftItem:init(arg_11_0.goBubbleLeft, arg_11_0)
	end

	return arg_11_0.leftItem
end

function var_0_0.getRightItem(arg_12_0)
	if not arg_12_0.rightItem then
		arg_12_0.rightItem = FairyLandBubbleTalkItem.New()

		arg_12_0.rightItem:init(arg_12_0.goBubbleRight, arg_12_0)
	end

	return arg_12_0.rightItem
end

function var_0_0.hide(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._delayFlag, arg_13_0)
	arg_13_0:stopAudio()
	gohelper.setActive(arg_13_0._go, false)

	if arg_13_0.leftItem then
		arg_13_0.leftItem:hide()
	end

	if arg_13_0.rightItem then
		arg_13_0.rightItem:hide()
	end
end

function var_0_0.playAudio(arg_14_0, arg_14_1)
	arg_14_0:stopAudio()

	if arg_14_1 and arg_14_1 > 0 then
		arg_14_0.playingId = AudioMgr.instance:trigger(arg_14_1)
	end
end

function var_0_0.stopAudio(arg_15_0)
	if arg_15_0.playingId then
		AudioMgr.instance:stopPlayingID(arg_15_0.playingId)

		arg_15_0.playingId = nil
	end
end

function var_0_0.dispose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayFlag, arg_16_0)
	arg_16_0:stopAudio()

	if arg_16_0.leftItem then
		arg_16_0.leftItem:dispose()
	end

	if arg_16_0.rightItem then
		arg_16_0.rightItem:dispose()
	end

	arg_16_0:__onDispose()
end

return var_0_0
