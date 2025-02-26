module("modules.logic.dialogue.view.DialogueView", package.seeall)

slot0 = class("DialogueView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._godialoguecontainer = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer")
	slot0._goArrow = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/#go_arrow")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	slot0._goleftdialogueitem = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	slot0._gorightdialogueitem = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	slot0._gosystemmessageitem = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_systemmessageitem")
	slot0._gooptionitem = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_optionitem")
	slot0._gonextstep = gohelper.findChild(slot0.viewGO, "#go_nextstep")
	slot0._goleftblank = gohelper.findChild(slot0.viewGO, "#go_leftblank")
	slot0._gorightblank = gohelper.findChild(slot0.viewGO, "#go_rightblank")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.itemSourceGoDict = {
		[DialogueEnum.Type.LeftMessage] = slot0._goleftdialogueitem,
		[DialogueEnum.Type.RightMessage] = slot0._gorightdialogueitem,
		[DialogueEnum.Type.SystemMessage] = slot0._gosystemmessageitem,
		[DialogueEnum.Type.Option] = slot0._gooptionitem
	}

	gohelper.setActive(slot0._goArrow, false)
	slot0._simagefullbg:LoadImage(ResUrl.getDialogueSingleBg("dialogue_fullbg"))

	slot0.scrollContent = gohelper.findChildScrollRect(slot0.viewGO, "#go_dialoguecontainer/Scroll View")
	slot0.contentMinHeight = recthelper.getHeight(slot0.scrollContent.transform)

	slot0.scrollContent:AddOnValueChanged(slot0.onScrollValueChanged, slot0)

	slot0.nextStepClick = gohelper.getClickWithDefaultAudio(slot0._gonextstep)

	slot0.nextStepClick:AddClickListener(slot0.onClickNextStep, slot0)

	slot0.leftBlankClick = gohelper.getClickWithDefaultAudio(slot0._goleftblank)

	slot0.leftBlankClick:AddClickListener(slot0._clickBlank, slot0)

	slot0.rightBlankClick = gohelper.getClickWithDefaultAudio(slot0._gorightblank)

	slot0.rightBlankClick:AddClickListener(slot0._clickBlank, slot0)

	slot0.drag = SLFramework.UGUI.UIDragListener.Get(slot0.scrollContent.gameObject)

	slot0.drag:AddDragBeginListener(slot0.onBeginDrag, slot0)
	slot0.drag:AddDragEndListener(slot0.onEndDrag, slot0)

	slot0.nextStepClick2 = gohelper.getClickWithDefaultAudio(slot0.scrollContent.gameObject)
	slot4 = slot0

	slot0.nextStepClick2:AddClickListener(slot0.onClickNextStep, slot4)

	slot0.rectTrContent = slot0._gocontent.transform

	for slot4, slot5 in pairs(slot0.itemSourceGoDict) do
		gohelper.setActive(slot5, false)
	end

	slot0.dialogueItemList = {}
	slot0.contentHeight = 0

	slot0:addEventCb(DialogueController.instance, DialogueEvent.OnClickOption, slot0.onClickOption, slot0)

	slot0.isFinishDialogue = false
end

function slot0._clickBlank(slot0)
	slot0:closeThis()
end

function slot0._showBlank(slot0)
	gohelper.setActive(slot0._goleftblank, true)
	gohelper.setActive(slot0._gorightblank, true)
end

function slot0.onBeginDrag(slot0)
	slot0.dragging = true
end

function slot0.onEndDrag(slot0)
	slot0.dragging = false
end

function slot0.onScrollValueChanged(slot0)
	gohelper.setActive(slot0._goArrow, slot0.scrollContent.verticalNormalizedPosition >= 0.01)
end

function slot0.onClickNextStep(slot0)
	if slot0.dragging then
		return
	end

	slot0:playNext()
end

function slot0.onClickOption(slot0, slot1)
	slot0:addStepList(slot1)
	slot0:playNext()
end

function slot0.onOpen(slot0)
	slot0.dialogueId = slot0.viewParam.dialogueId
	slot0.dialogueCo = DialogueConfig.instance:getDialogueCo(slot0.dialogueId)
	slot0.stepCoList = {}

	slot0:addStepList(slot0.dialogueCo.startGroup)
	slot0:playNext()
end

function slot0.addStepList(slot0, slot1)
	for slot6 = #DialogueConfig.instance:getDialogueStepList(slot1), 1, -1 do
		table.insert(slot0.stepCoList, slot2[slot6])
	end
end

function slot0.playNext(slot0)
	if not slot0:popNextStep() then
		slot0:onDialogueDone()

		return
	end

	if slot1.type == DialogueEnum.Type.JumpToGroup then
		slot0:addStepList(tonumber(slot1.content))
		slot0:playNext()

		return
	end

	DialogueController.instance:dispatchEvent(DialogueEvent.BeforePlayStep, slot1)

	slot3 = DialogueItem.CreateItem(slot1, gohelper.cloneInPlace(slot0.itemSourceGoDict[slot1.type]), slot0.contentHeight)

	table.insert(slot0.dialogueItemList, slot3)

	slot0.contentHeight = slot0.contentHeight + slot3:getHeight() + DialogueEnum.IntervalY

	recthelper.setHeight(slot0.rectTrContent, Mathf.Max(slot0.contentHeight, slot0.contentMinHeight))
	slot0:playUpAnimation()

	if not slot0:checkIsHavdNextStepCo() then
		slot0:onDialogueDone()
	end
end

function slot0.popNextStep(slot0)
	if #slot0.stepCoList <= 0 then
		return nil
	end

	slot0.stepCoList[slot1] = nil

	return slot0.stepCoList[slot1]
end

function slot0.checkIsHavdNextStepCo(slot0)
	if #slot0.stepCoList <= 0 then
		return false
	end

	return true
end

function slot0.playUpAnimation(slot0)
	if slot0.contentHeight <= slot0.contentMinHeight then
		return
	end

	slot0:killTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.scrollContent.verticalNormalizedPosition, 0, 0.5, slot0.tweenFrameCallback, slot0.tweenFinishCallback, slot0)
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.tweenFrameCallback(slot0, slot1)
	slot0.scrollContent.verticalNormalizedPosition = slot1
end

function slot0.tweenFinishCallback(slot0)
	gohelper.setActive(slot0._goArrow, false)
end

function slot0.onDialogueDone(slot0)
	if slot0._isDone then
		return
	end

	slot0._isDone = true

	slot0:_showBlank()
	gohelper.setActive(slot0._gonextstep, false)
	DialogueRpc.instance:sendRecordDialogInfoRequest(slot0.dialogueId, slot0.onReceiveInfo, slot0)
end

function slot0.onReceiveInfo(slot0)
	DialogueController.instance:dispatchEvent(DialogueEvent.OnDone, slot0.dialogueId)

	slot0.isFinishDialogue = true
end

function slot0.onClose(slot0)
	slot0:killTween()

	if slot0.isFinishDialogue then
		DialogueController.instance:dispatchEvent(DialogueEvent.OnCloseViewWithDialogueDone)
	end

	if slot0.viewParam.callback then
		slot1(slot0.viewParam.callbackTarget)
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.dialogueItemList) do
		slot5:destroy()
	end

	slot0._simagefullbg:UnLoadImage()
	slot0.nextStepClick:RemoveClickListener()
	slot0.nextStepClick2:RemoveClickListener()
	slot0.leftBlankClick:RemoveClickListener()
	slot0.rightBlankClick:RemoveClickListener()
	slot0.scrollContent:RemoveOnValueChanged()
	slot0.drag:RemoveDragBeginListener()
	slot0.drag:RemoveDragEndListener()
end

return slot0
