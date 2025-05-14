module("modules.logic.dialogue.view.DialogueView", package.seeall)

local var_0_0 = class("DialogueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._godialoguecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer")
	arg_1_0._goArrow = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/#go_arrow")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	arg_1_0._goleftdialogueitem = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	arg_1_0._gorightdialogueitem = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	arg_1_0._gosystemmessageitem = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_systemmessageitem")
	arg_1_0._gooptionitem = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_optionitem")
	arg_1_0._gonextstep = gohelper.findChild(arg_1_0.viewGO, "#go_nextstep")
	arg_1_0._goleftblank = gohelper.findChild(arg_1_0.viewGO, "#go_leftblank")
	arg_1_0._gorightblank = gohelper.findChild(arg_1_0.viewGO, "#go_rightblank")

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
	if LangSettings.instance:isJp() then
		DialogueEnum.MessageBgOffsetWidth = 60
		DialogueEnum.MessageBgOffsetHeight = 45
	else
		DialogueEnum.MessageBgOffsetWidth = 30
		DialogueEnum.MessageBgOffsetHeight = 20
	end

	arg_4_0.itemSourceGoDict = {
		[DialogueEnum.Type.LeftMessage] = arg_4_0._goleftdialogueitem,
		[DialogueEnum.Type.RightMessage] = arg_4_0._gorightdialogueitem,
		[DialogueEnum.Type.SystemMessage] = arg_4_0._gosystemmessageitem,
		[DialogueEnum.Type.Option] = arg_4_0._gooptionitem
	}

	gohelper.setActive(arg_4_0._goArrow, false)
	arg_4_0._simagefullbg:LoadImage(ResUrl.getDialogueSingleBg("dialogue_fullbg"))

	arg_4_0.scrollContent = gohelper.findChildScrollRect(arg_4_0.viewGO, "#go_dialoguecontainer/Scroll View")
	arg_4_0.contentMinHeight = recthelper.getHeight(arg_4_0.scrollContent.transform)

	arg_4_0.scrollContent:AddOnValueChanged(arg_4_0.onScrollValueChanged, arg_4_0)

	arg_4_0.nextStepClick = gohelper.getClickWithDefaultAudio(arg_4_0._gonextstep)

	arg_4_0.nextStepClick:AddClickListener(arg_4_0.onClickNextStep, arg_4_0)

	arg_4_0.leftBlankClick = gohelper.getClickWithDefaultAudio(arg_4_0._goleftblank)

	arg_4_0.leftBlankClick:AddClickListener(arg_4_0._clickBlank, arg_4_0)

	arg_4_0.rightBlankClick = gohelper.getClickWithDefaultAudio(arg_4_0._gorightblank)

	arg_4_0.rightBlankClick:AddClickListener(arg_4_0._clickBlank, arg_4_0)

	arg_4_0.drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0.scrollContent.gameObject)

	arg_4_0.drag:AddDragBeginListener(arg_4_0.onBeginDrag, arg_4_0)
	arg_4_0.drag:AddDragEndListener(arg_4_0.onEndDrag, arg_4_0)

	arg_4_0.nextStepClick2 = gohelper.getClickWithDefaultAudio(arg_4_0.scrollContent.gameObject)

	arg_4_0.nextStepClick2:AddClickListener(arg_4_0.onClickNextStep, arg_4_0)

	arg_4_0.rectTrContent = arg_4_0._gocontent.transform

	for iter_4_0, iter_4_1 in pairs(arg_4_0.itemSourceGoDict) do
		gohelper.setActive(iter_4_1, false)
	end

	arg_4_0.dialogueItemList = {}
	arg_4_0.contentHeight = 0

	arg_4_0:addEventCb(DialogueController.instance, DialogueEvent.OnClickOption, arg_4_0.onClickOption, arg_4_0)

	arg_4_0.isFinishDialogue = false
end

function var_0_0._clickBlank(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._showBlank(arg_6_0)
	gohelper.setActive(arg_6_0._goleftblank, true)
	gohelper.setActive(arg_6_0._gorightblank, true)
end

function var_0_0.onBeginDrag(arg_7_0)
	arg_7_0.dragging = true
end

function var_0_0.onEndDrag(arg_8_0)
	arg_8_0.dragging = false
end

function var_0_0.onScrollValueChanged(arg_9_0)
	gohelper.setActive(arg_9_0._goArrow, arg_9_0.scrollContent.verticalNormalizedPosition >= 0.01)
end

function var_0_0.onClickNextStep(arg_10_0)
	if arg_10_0.dragging then
		return
	end

	arg_10_0:playNext()
end

function var_0_0.onClickOption(arg_11_0, arg_11_1)
	arg_11_0:addStepList(arg_11_1)
	arg_11_0:playNext()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0.dialogueId = arg_12_0.viewParam.dialogueId
	arg_12_0.dialogueCo = DialogueConfig.instance:getDialogueCo(arg_12_0.dialogueId)
	arg_12_0.stepCoList = {}

	arg_12_0:addStepList(arg_12_0.dialogueCo.startGroup)
	arg_12_0:playNext()
end

function var_0_0.addStepList(arg_13_0, arg_13_1)
	local var_13_0 = DialogueConfig.instance:getDialogueStepList(arg_13_1)

	for iter_13_0 = #var_13_0, 1, -1 do
		table.insert(arg_13_0.stepCoList, var_13_0[iter_13_0])
	end
end

function var_0_0.playNext(arg_14_0)
	local var_14_0 = arg_14_0:popNextStep()

	if not var_14_0 then
		arg_14_0:onDialogueDone()

		return
	end

	if var_14_0.type == DialogueEnum.Type.JumpToGroup then
		arg_14_0:addStepList(tonumber(var_14_0.content))
		arg_14_0:playNext()

		return
	end

	DialogueController.instance:dispatchEvent(DialogueEvent.BeforePlayStep, var_14_0)

	local var_14_1 = gohelper.cloneInPlace(arg_14_0.itemSourceGoDict[var_14_0.type])
	local var_14_2 = DialogueItem.CreateItem(var_14_0, var_14_1, arg_14_0.contentHeight)

	table.insert(arg_14_0.dialogueItemList, var_14_2)

	arg_14_0.contentHeight = arg_14_0.contentHeight + var_14_2:getHeight() + DialogueEnum.IntervalY

	recthelper.setHeight(arg_14_0.rectTrContent, Mathf.Max(arg_14_0.contentHeight, arg_14_0.contentMinHeight))
	arg_14_0:playUpAnimation()

	if not arg_14_0:checkIsHavdNextStepCo() then
		arg_14_0:onDialogueDone()
	end
end

function var_0_0.popNextStep(arg_15_0)
	local var_15_0 = #arg_15_0.stepCoList

	if var_15_0 <= 0 then
		return nil
	end

	local var_15_1 = arg_15_0.stepCoList[var_15_0]

	arg_15_0.stepCoList[var_15_0] = nil

	return var_15_1
end

function var_0_0.checkIsHavdNextStepCo(arg_16_0)
	if #arg_16_0.stepCoList <= 0 then
		return false
	end

	return true
end

function var_0_0.playUpAnimation(arg_17_0)
	if arg_17_0.contentHeight <= arg_17_0.contentMinHeight then
		return
	end

	arg_17_0:killTween()

	arg_17_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_17_0.scrollContent.verticalNormalizedPosition, 0, 0.5, arg_17_0.tweenFrameCallback, arg_17_0.tweenFinishCallback, arg_17_0)
end

function var_0_0.killTween(arg_18_0)
	if arg_18_0.tweenId then
		ZProj.TweenHelper.KillById(arg_18_0.tweenId)

		arg_18_0.tweenId = nil
	end
end

function var_0_0.tweenFrameCallback(arg_19_0, arg_19_1)
	arg_19_0.scrollContent.verticalNormalizedPosition = arg_19_1
end

function var_0_0.tweenFinishCallback(arg_20_0)
	gohelper.setActive(arg_20_0._goArrow, false)
end

function var_0_0.onDialogueDone(arg_21_0)
	if arg_21_0._isDone then
		return
	end

	arg_21_0._isDone = true

	arg_21_0:_showBlank()
	gohelper.setActive(arg_21_0._gonextstep, false)
	DialogueRpc.instance:sendRecordDialogInfoRequest(arg_21_0.dialogueId, arg_21_0.onReceiveInfo, arg_21_0)
end

function var_0_0.onReceiveInfo(arg_22_0)
	DialogueController.instance:dispatchEvent(DialogueEvent.OnDone, arg_22_0.dialogueId)

	arg_22_0.isFinishDialogue = true
end

function var_0_0.onClose(arg_23_0)
	arg_23_0:killTween()

	if arg_23_0.isFinishDialogue then
		DialogueController.instance:dispatchEvent(DialogueEvent.OnCloseViewWithDialogueDone)
	end

	local var_23_0 = arg_23_0.viewParam.callback
	local var_23_1 = arg_23_0.viewParam.callbackTarget

	if var_23_0 then
		var_23_0(var_23_1)
	end
end

function var_0_0.onDestroyView(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.dialogueItemList) do
		iter_24_1:destroy()
	end

	arg_24_0._simagefullbg:UnLoadImage()
	arg_24_0.nextStepClick:RemoveClickListener()
	arg_24_0.nextStepClick2:RemoveClickListener()
	arg_24_0.leftBlankClick:RemoveClickListener()
	arg_24_0.rightBlankClick:RemoveClickListener()
	arg_24_0.scrollContent:RemoveOnValueChanged()
	arg_24_0.drag:RemoveDragBeginListener()
	arg_24_0.drag:RemoveDragEndListener()
end

return var_0_0
