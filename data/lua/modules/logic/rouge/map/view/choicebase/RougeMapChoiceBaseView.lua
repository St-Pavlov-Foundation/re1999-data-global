module("modules.logic.rouge.map.view.choicebase.RougeMapChoiceBaseView", package.seeall)

local var_0_0 = class("RougeMapChoiceBaseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#txt_Name")
	arg_1_0._txtNameEn = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#txt_Name/#txt_NameEn")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "Bottom/Scroll View/Viewport/Content/#txt_Desc")
	arg_1_0._godescarrow = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_descarrow")
	arg_1_0._gochoicecontainer = gohelper.findChild(arg_1_0.viewGO, "Right/#go_choicecontainer")
	arg_1_0._gorougeherogroup = gohelper.findChild(arg_1_0.viewGO, "Left/#go_rougeherogroup")
	arg_1_0._goroucollection = gohelper.findChild(arg_1_0.viewGO, "Left/#go_rougecollection")
	arg_1_0._gorougelv = gohelper.findChild(arg_1_0.viewGO, "Left/#go_rougelv")
	arg_1_0._godialogueblock = gohelper.findChild(arg_1_0.viewGO, "#go_dialogueblock")

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
	arg_4_0.rectTrBottom = gohelper.findChildComponent(arg_4_0.viewGO, "Bottom", gohelper.Type_RectTransform)
	arg_4_0.goRight = gohelper.findChild(arg_4_0.viewGO, "Right")
	arg_4_0.goLeft = gohelper.findChild(arg_4_0.viewGO, "Left")
	arg_4_0.dialogueScrollRect = gohelper.findChildScrollRect(arg_4_0.viewGO, "Bottom/Scroll View")

	gohelper.setActive(arg_4_0._godescarrow, false)
	gohelper.setActive(arg_4_0.goRight, false)
	gohelper.setActive(arg_4_0.goLeft, false)
	arg_4_0.dialogueScrollRect:AddOnValueChanged(arg_4_0.onScrollValueChange, arg_4_0)

	arg_4_0.scrollClick = gohelper.getClickWithDefaultAudio(arg_4_0.dialogueScrollRect.gameObject)

	arg_4_0.scrollClick:AddClickListener(arg_4_0.onClickDialogueBlock, arg_4_0)

	arg_4_0.dialogueBlockClick = gohelper.getClickWithDefaultAudio(arg_4_0._godialogueblock)

	arg_4_0.dialogueBlockClick:AddClickListener(arg_4_0.onClickDialogueBlock, arg_4_0)

	arg_4_0.choiceItemList = {}
	arg_4_0.choiceItemResPath = arg_4_0.viewContainer:getSetting().otherRes[1]
	arg_4_0.goChoiceItem = arg_4_0.viewContainer:getResInst(arg_4_0.choiceItemResPath, arg_4_0._gochoicecontainer)

	gohelper.setActive(arg_4_0.goChoiceItem, false)

	arg_4_0.goHeroGroup = arg_4_0.viewContainer:getResInst(RougeEnum.ResPath.CommonHeroGroupItem, arg_4_0._gorougeherogroup)
	arg_4_0.goCollection = arg_4_0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, arg_4_0._goroucollection)
	arg_4_0.goLv = arg_4_0.viewContainer:getResInst(RougeEnum.ResPath.CommonLvItem, arg_4_0._gorougelv)
	arg_4_0.groupComp = RougeHeroGroupComp.Get(arg_4_0.goHeroGroup)
	arg_4_0.collectionComp = RougeCollectionComp.Get(arg_4_0.goCollection)
	arg_4_0.lvComp = RougeLvComp.Get(arg_4_0.goLv)
	arg_4_0.animator = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_4_0.rightAnimator = arg_4_0.goRight:GetComponent(gohelper.Type_Animator)
	arg_4_0.leftAnimator = arg_4_0.goLeft:GetComponent(gohelper.Type_Animator)

	arg_4_0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_4_0.onChangeMapInfo, arg_4_0)
end

function var_0_0.onChangeMapInfo(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickDialogueBlock(arg_6_0)
	arg_6_0:_initStateHandle()

	local var_6_0 = arg_6_0._stateHandleDict[arg_6_0.state]

	if var_6_0 then
		var_6_0(arg_6_0)
	end
end

function var_0_0._initStateHandle(arg_7_0)
	if arg_7_0._stateHandleDict then
		return
	end

	arg_7_0._stateHandleDict = {
		[RougeMapEnum.ChoiceViewState.PlayingDialogue] = arg_7_0.onPlayDialogueDone,
		[RougeMapEnum.ChoiceViewState.Finish] = arg_7_0.onClickBlockOnFinishState
	}
end

function var_0_0.onClickBlockOnFinishState(arg_8_0)
	return
end

function var_0_0.changeState(arg_9_0, arg_9_1)
	arg_9_0.state = arg_9_1

	gohelper.setActive(arg_9_0._godialogueblock, arg_9_0.state ~= RougeMapEnum.ChoiceViewState.WaitSelect)
end

function var_0_0.onScrollValueChange(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_0._godescarrow, arg_10_2 >= 1)
end

function var_0_0.onOpen(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewOpen)
	arg_11_0.groupComp:onOpen()
	arg_11_0.collectionComp:onOpen()
	arg_11_0.lvComp:onOpen()
end

function var_0_0.startPlayDialogue(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.closeed then
		logError("start dialogue after close view !!! desc : " .. tostring(arg_12_1))

		return
	end

	if string.nilorempty(arg_12_1) then
		arg_12_0.callback = nil
		arg_12_0.callbackObj = nil

		if arg_12_2 then
			arg_12_2(arg_12_3)
		end

		return
	end

	arg_12_0:changeState(RougeMapEnum.ChoiceViewState.PlayingDialogue)

	arg_12_0.callback = arg_12_2
	arg_12_0.callbackObj = arg_12_3
	arg_12_0.desc = arg_12_1
	arg_12_0.preEndIndex = 0

	RougeMapModel.instance:setPlayingDialogue(true)
	arg_12_0:_playNext()
	TaskDispatcher.runRepeat(arg_12_0._playNext, arg_12_0, RougeMapEnum.DialogueInterval)
end

function var_0_0._playNext(arg_13_0)
	if not arg_13_0.preEndIndex then
		arg_13_0:onPlayDialogueDone()

		return
	end

	arg_13_0:updateText()
end

function var_0_0.onPlayDialogueDone(arg_14_0)
	arg_14_0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)

	arg_14_0._txtDesc.text = arg_14_0.desc

	ZProj.UGUIHelper.RebuildLayout(arg_14_0.dialogueScrollRect.transform)

	arg_14_0.dialogueScrollRect.verticalNormalizedPosition = RougeMapEnum.ScrollPosition.Bottom

	TaskDispatcher.cancelTask(arg_14_0._playNext, arg_14_0)
	RougeMapModel.instance:setPlayingDialogue(false)

	if arg_14_0.callback then
		local var_14_0 = arg_14_0.callback
		local var_14_1 = arg_14_0.callbackObj

		arg_14_0.callback = nil
		arg_14_0.callbackObj = nil

		var_14_0(var_14_1)
	end
end

function var_0_0.updateText(arg_15_0)
	arg_15_0._txtDesc.text = arg_15_0:getCurDesc()
	arg_15_0.dialogueScrollRect.verticalNormalizedPosition = RougeMapEnum.ScrollPosition.Bottom
end

function var_0_0.getCurDesc(arg_16_0)
	local var_16_0 = arg_16_0.preEndIndex + 1
	local var_16_1 = false
	local var_16_2 = 0

	while var_16_2 < 1000 do
		local var_16_3 = utf8.next(arg_16_0.desc, var_16_0)

		if not var_16_3 then
			arg_16_0.preEndIndex = nil

			return arg_16_0.desc
		end

		local var_16_4 = arg_16_0.desc:sub(var_16_0, var_16_3 - 1)

		if var_16_4 == "<" then
			var_16_1 = true
		elseif var_16_4 == ">" then
			var_16_1 = false
		elseif not var_16_1 then
			arg_16_0.preEndIndex = var_16_3 - 1

			return arg_16_0.desc:sub(1, arg_16_0.preEndIndex)
		end

		var_16_2 = var_16_2 + 1
		var_16_0 = var_16_3
	end

	logError("endless loop !!!")

	arg_16_0.preEndIndex = nil

	return arg_16_0.desc
end

function var_0_0.playChoiceShowAnim(arg_17_0)
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	arg_17_0.animator:Play("right", 0, 0)
	arg_17_0.rightAnimator:Play("open", 0, 0)
	arg_17_0.leftAnimator:Play("open", 0, 0)
end

function var_0_0.playChoiceHideAnim(arg_18_0)
	arg_18_0.animator:Play("left", 0, 0)
	arg_18_0.rightAnimator:Play("close", 0, 0)
	arg_18_0.leftAnimator:Play("close", 0, 0)
end

function var_0_0.onClose(arg_19_0)
	arg_19_0.closeed = true

	TaskDispatcher.cancelTask(arg_19_0._playNext, arg_19_0)
	arg_19_0.groupComp:onClose()
	arg_19_0.collectionComp:onClose()
	arg_19_0.lvComp:onClose()
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0.groupComp:destroy()
	arg_20_0.collectionComp:destroy()
	arg_20_0.lvComp:destroy()
	arg_20_0.dialogueScrollRect:RemoveOnValueChanged()
	arg_20_0.scrollClick:RemoveClickListener()
	arg_20_0.dialogueBlockClick:RemoveClickListener()

	if arg_20_0.choiceItemList then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0.choiceItemList) do
			iter_20_1:destroy()
		end
	end

	arg_20_0.choiceItemList = nil
end

return var_0_0
