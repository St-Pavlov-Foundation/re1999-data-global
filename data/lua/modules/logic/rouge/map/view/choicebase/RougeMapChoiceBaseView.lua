module("modules.logic.rouge.map.view.choicebase.RougeMapChoiceBaseView", package.seeall)

slot0 = class("RougeMapChoiceBaseView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "Bottom/#txt_Name")
	slot0._txtNameEn = gohelper.findChildText(slot0.viewGO, "Bottom/#txt_Name/#txt_NameEn")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "Bottom/Scroll View/Viewport/Content/#txt_Desc")
	slot0._godescarrow = gohelper.findChild(slot0.viewGO, "Bottom/#go_descarrow")
	slot0._gochoicecontainer = gohelper.findChild(slot0.viewGO, "Right/#go_choicecontainer")
	slot0._gorougeherogroup = gohelper.findChild(slot0.viewGO, "Left/#go_rougeherogroup")
	slot0._goroucollection = gohelper.findChild(slot0.viewGO, "Left/#go_rougecollection")
	slot0._gorougelv = gohelper.findChild(slot0.viewGO, "Left/#go_rougelv")
	slot0._godialogueblock = gohelper.findChild(slot0.viewGO, "#go_dialogueblock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.rectTrBottom = gohelper.findChildComponent(slot0.viewGO, "Bottom", gohelper.Type_RectTransform)
	slot0.goRight = gohelper.findChild(slot0.viewGO, "Right")
	slot0.goLeft = gohelper.findChild(slot0.viewGO, "Left")
	slot0.dialogueScrollRect = gohelper.findChildScrollRect(slot0.viewGO, "Bottom/Scroll View")

	gohelper.setActive(slot0._godescarrow, false)
	gohelper.setActive(slot0.goRight, false)
	gohelper.setActive(slot0.goLeft, false)
	slot0.dialogueScrollRect:AddOnValueChanged(slot0.onScrollValueChange, slot0)

	slot0.scrollClick = gohelper.getClickWithDefaultAudio(slot0.dialogueScrollRect.gameObject)

	slot0.scrollClick:AddClickListener(slot0.onClickDialogueBlock, slot0)

	slot0.dialogueBlockClick = gohelper.getClickWithDefaultAudio(slot0._godialogueblock)

	slot0.dialogueBlockClick:AddClickListener(slot0.onClickDialogueBlock, slot0)

	slot0.choiceItemList = {}
	slot0.choiceItemResPath = slot0.viewContainer:getSetting().otherRes[1]
	slot0.goChoiceItem = slot0.viewContainer:getResInst(slot0.choiceItemResPath, slot0._gochoicecontainer)

	gohelper.setActive(slot0.goChoiceItem, false)

	slot0.goHeroGroup = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonHeroGroupItem, slot0._gorougeherogroup)
	slot0.goCollection = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, slot0._goroucollection)
	slot0.goLv = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonLvItem, slot0._gorougelv)
	slot0.groupComp = RougeHeroGroupComp.Get(slot0.goHeroGroup)
	slot0.collectionComp = RougeCollectionComp.Get(slot0.goCollection)
	slot0.lvComp = RougeLvComp.Get(slot0.goLv)
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.rightAnimator = slot0.goRight:GetComponent(gohelper.Type_Animator)
	slot0.leftAnimator = slot0.goLeft:GetComponent(gohelper.Type_Animator)

	slot0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
end

function slot0.onChangeMapInfo(slot0)
	slot0:closeThis()
end

function slot0.onClickDialogueBlock(slot0)
	slot0:_initStateHandle()

	if slot0._stateHandleDict[slot0.state] then
		slot1(slot0)
	end
end

function slot0._initStateHandle(slot0)
	if slot0._stateHandleDict then
		return
	end

	slot0._stateHandleDict = {
		[RougeMapEnum.ChoiceViewState.PlayingDialogue] = slot0.onPlayDialogueDone,
		[RougeMapEnum.ChoiceViewState.Finish] = slot0.onClickBlockOnFinishState
	}
end

function slot0.onClickBlockOnFinishState(slot0)
end

function slot0.changeState(slot0, slot1)
	slot0.state = slot1

	gohelper.setActive(slot0._godialogueblock, slot0.state ~= RougeMapEnum.ChoiceViewState.WaitSelect)
end

function slot0.onScrollValueChange(slot0, slot1, slot2)
	gohelper.setActive(slot0._godescarrow, slot2 >= 1)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewOpen)
	slot0.groupComp:onOpen()
	slot0.collectionComp:onOpen()
	slot0.lvComp:onOpen()
end

function slot0.startPlayDialogue(slot0, slot1, slot2, slot3)
	if slot0.closeed then
		logError("start dialogue after close view !!! desc : " .. tostring(slot1))

		return
	end

	if string.nilorempty(slot1) then
		slot0.callback = nil
		slot0.callbackObj = nil

		if slot2 then
			slot2(slot3)
		end

		return
	end

	slot0:changeState(RougeMapEnum.ChoiceViewState.PlayingDialogue)

	slot0.callback = slot2
	slot0.callbackObj = slot3
	slot0.desc = slot1
	slot0.preEndIndex = 0

	RougeMapModel.instance:setPlayingDialogue(true)
	slot0:_playNext()
	TaskDispatcher.runRepeat(slot0._playNext, slot0, RougeMapEnum.DialogueInterval)
end

function slot0._playNext(slot0)
	if not slot0.preEndIndex then
		slot0:onPlayDialogueDone()

		return
	end

	slot0:updateText()
end

function slot0.onPlayDialogueDone(slot0)
	slot0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)

	slot0._txtDesc.text = slot0.desc

	ZProj.UGUIHelper.RebuildLayout(slot0.dialogueScrollRect.transform)

	slot0.dialogueScrollRect.verticalNormalizedPosition = RougeMapEnum.ScrollPosition.Bottom

	TaskDispatcher.cancelTask(slot0._playNext, slot0)
	RougeMapModel.instance:setPlayingDialogue(false)

	if slot0.callback then
		slot0.callback = nil
		slot0.callbackObj = nil

		slot0.callback(slot0.callbackObj)
	end
end

function slot0.updateText(slot0)
	slot0._txtDesc.text = slot0:getCurDesc()
	slot0.dialogueScrollRect.verticalNormalizedPosition = RougeMapEnum.ScrollPosition.Bottom
end

function slot0.getCurDesc(slot0)
	slot1 = slot0.preEndIndex + 1
	slot2 = false
	slot3 = 0

	while slot3 < 1000 do
		if not utf8.next(slot0.desc, slot1) then
			slot0.preEndIndex = nil

			return slot0.desc
		end

		if slot0.desc:sub(slot1, slot4 - 1) == "<" then
			slot2 = true
		elseif slot5 == ">" then
			slot2 = false
		elseif not slot2 then
			slot0.preEndIndex = slot4 - 1

			return slot0.desc:sub(1, slot0.preEndIndex)
		end

		slot3 = slot3 + 1
		slot1 = slot4
	end

	logError("endless loop !!!")

	slot0.preEndIndex = nil

	return slot0.desc
end

function slot0.playChoiceShowAnim(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	slot0.animator:Play("right", 0, 0)
	slot0.rightAnimator:Play("open", 0, 0)
	slot0.leftAnimator:Play("open", 0, 0)
end

function slot0.playChoiceHideAnim(slot0)
	slot0.animator:Play("left", 0, 0)
	slot0.rightAnimator:Play("close", 0, 0)
	slot0.leftAnimator:Play("close", 0, 0)
end

function slot0.onClose(slot0)
	slot0.closeed = true

	TaskDispatcher.cancelTask(slot0._playNext, slot0)
	slot0.groupComp:onClose()
	slot0.collectionComp:onClose()
	slot0.lvComp:onClose()
end

function slot0.onDestroyView(slot0)
	slot0.groupComp:destroy()
	slot0.collectionComp:destroy()
	slot0.lvComp:destroy()
	slot0.dialogueScrollRect:RemoveOnValueChanged()
	slot0.scrollClick:RemoveClickListener()
	slot0.dialogueBlockClick:RemoveClickListener()

	if slot0.choiceItemList then
		for slot4, slot5 in ipairs(slot0.choiceItemList) do
			slot5:destroy()
		end
	end

	slot0.choiceItemList = nil
end

return slot0
