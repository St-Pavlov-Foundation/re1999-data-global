module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandBubble", package.seeall)

slot0 = class("FairyLandBubble", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.dialogView = slot1
	slot0._go = gohelper.findChild(slot1.dialogGO, "#go_Dialog")
	slot0.btnDialogClick = gohelper.findChildButtonWithAudio(slot0._go, "#go_Click")
	slot0.goBubbleLeft = gohelper.findChild(slot0._go, "#go_BubbleLeft")
	slot0.goBubbleRight = gohelper.findChild(slot0._go, "#go_BubbleRight")

	gohelper.setActive(slot0.goBubbleLeft, false)
	gohelper.setActive(slot0.goBubbleRight, false)
	slot0:addClickCb(slot0.btnDialogClick, slot0.onClickDialog, slot0)

	slot0.bubbleItems = {}
end

function slot0.onClickDialog(slot0)
	if not slot0.dialogId then
		return
	end

	if slot0.isPlaying then
		slot0:showDialogText()
	elseif slot0.canNext then
		slot0:playNextStep()
	end
end

function slot0.startDialog(slot0, slot1)
	slot0.dialogId = slot1.dialogId
	slot0.leftElement = slot1.leftElement
	slot0.rightElement = slot1.rightElement
	slot0.noTweenText = slot1.noTween

	gohelper.setActive(slot0._go, true)
	slot0:selectOption(0)
end

function slot0.selectOption(slot0, slot1)
	slot0.sectionId = slot1
	slot0.step = 0
	slot0.sectionConfig = FairyLandConfig.instance:getDialogConfig(slot0.dialogId, slot0.sectionId)

	if slot0.sectionConfig then
		slot0:playNextStep()
	else
		slot0:finished()
	end
end

function slot0.playNextStep(slot0)
	slot0.step = slot0.step + 1

	if not slot0.sectionConfig[slot0.step] then
		slot0:finished()

		return
	end

	slot0.canNext = false

	TaskDispatcher.cancelTask(slot0._delayFlag, slot0)
	TaskDispatcher.runDelay(slot0._delayFlag, slot0, 1)
	slot0:playStep(slot1, true)
end

function slot0.playStep(slot0, slot1, slot2)
	slot3 = slot1.elementId == 1 and slot0:getLeftItem() or slot0:getRightItem()
	slot0.isPlaying = true
	slot4 = slot0.sectionConfig[slot0.step + 1] ~= nil

	if slot1.elementId == 1 and slot0.leftElement or slot0.rightElement then
		slot5:playDialog()
	end

	slot3:setTargetGO(slot5 and slot5.imgChessRoot)

	if slot2 then
		slot0:playAudio(slot1.audioId)
	end

	if slot0.noTweenText then
		slot2 = false
	end

	slot3:showBubble(slot1.content, slot2, slot4)

	if slot1.elementId == 1 and slot0:getRightItem() or slot0:getLeftItem() then
		slot6:hide()
	end
end

function slot0._delayFlag(slot0)
	slot0.canNext = true
end

function slot0.showDialogText(slot0)
	if not slot0.sectionConfig[slot0.step] then
		slot0:finished()

		return
	end

	slot0:playStep(slot1)
end

function slot0.onTextPlayFinish(slot0)
	slot0.isPlaying = false
end

function slot0.finished(slot0)
	slot0.dialogId = nil
	slot0.isPlaying = false

	slot0.dialogView:finished()
end

function slot0.getLeftItem(slot0)
	if not slot0.leftItem then
		slot0.leftItem = FairyLandBubbleTalkItem.New()

		slot0.leftItem:init(slot0.goBubbleLeft, slot0)
	end

	return slot0.leftItem
end

function slot0.getRightItem(slot0)
	if not slot0.rightItem then
		slot0.rightItem = FairyLandBubbleTalkItem.New()

		slot0.rightItem:init(slot0.goBubbleRight, slot0)
	end

	return slot0.rightItem
end

function slot0.hide(slot0)
	TaskDispatcher.cancelTask(slot0._delayFlag, slot0)
	slot0:stopAudio()
	gohelper.setActive(slot0._go, false)

	if slot0.leftItem then
		slot0.leftItem:hide()
	end

	if slot0.rightItem then
		slot0.rightItem:hide()
	end
end

function slot0.playAudio(slot0, slot1)
	slot0:stopAudio()

	if slot1 and slot1 > 0 then
		slot0.playingId = AudioMgr.instance:trigger(slot1)
	end
end

function slot0.stopAudio(slot0)
	if slot0.playingId then
		AudioMgr.instance:stopPlayingID(slot0.playingId)

		slot0.playingId = nil
	end
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0._delayFlag, slot0)
	slot0:stopAudio()

	if slot0.leftItem then
		slot0.leftItem:dispose()
	end

	if slot0.rightItem then
		slot0.rightItem:dispose()
	end

	slot0:__onDispose()
end

return slot0
