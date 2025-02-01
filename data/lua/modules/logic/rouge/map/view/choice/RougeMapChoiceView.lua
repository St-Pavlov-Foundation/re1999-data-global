module("modules.logic.rouge.map.view.choice.RougeMapChoiceView", package.seeall)

slot0 = class("RougeMapChoiceView", RougeMapChoiceBaseView)

function slot0._editableInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "all_bg/#simage_FullBG")
	slot0._simageEpisodeBG = gohelper.findChildSingleImage(slot0.viewGO, "all_bg/#simage_EpisodeBG")
	slot0._simageFrameBG = gohelper.findChildSingleImage(slot0.viewGO, "all_bg/#simage_FrameBG")

	slot0._simageFullBG:LoadImage("singlebg/rouge/episode/rouge_episode_fullbg.png")
	slot0._simageFrameBG:LoadImage("singlebg/rouge/rouge_illustration_framebg.png")
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChoiceEventChange, slot0.onChoiceEventChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onClearInteract, slot0.onClearInteract, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onPopViewDone, slot0.onPopViewDone, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onReceiveChoiceEvent, slot0.onReceiveChoiceEvent, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onBeforeActorMoveToEnd, slot0.onBeforeActorMoveToEnd, slot0)
	uv0.super._editableInitView(slot0)
end

function slot0.onBeforeActorMoveToEnd(slot0)
	slot0.beforeChangeMap = true
end

function slot0.onReceiveChoiceEvent(slot0)
	if RougeMapModel.instance:isInteractiving() then
		logNormal("wait interact")

		slot0.waitInteract = true

		return
	end

	if RougePopController.instance:hadPopView() then
		logNormal("wait pop view")

		slot0.waitInteract = true
	end

	slot0.waitInteract = nil

	slot0:playSelectedDialogue()
end

function slot0.onClearInteract(slot0)
	if not slot0.waitInteract then
		return
	end

	slot0:playSelectedDialogue()
end

function slot0.onPopViewDone(slot0)
	if not slot0.waitInteract then
		return
	end

	slot0:playSelectedDialogue()
end

function slot0.playSelectedDialogue(slot0)
	slot0:playChoiceHideAnim()

	slot2 = RougeMapModel.instance:getCurChoiceId() and lua_rouge_choice.configDict[slot1]

	if string.nilorempty(slot2 and slot2.selectedDesc) then
		slot0:triggerEventHandle()
	else
		slot0:startPlayDialogue(slot3, slot0.onSelectedDescPlayDone, slot0)
	end
end

function slot0.onSelectedDescPlayDone(slot0)
	slot0:changeState(RougeMapEnum.ChoiceViewState.Finish)
end

function slot0.triggerEventHandle(slot0)
	RougeMapChoiceEventHelper.triggerEventHandleOnChoiceView(RougeMapModel.instance:getCurNode())
end

function slot0.onClickBlockOnFinishState(slot0)
	slot0:triggerEventHandle()
end

function slot0.onChoiceEventChange(slot0, slot1)
	if slot0.beforeChangeMap then
		slot0:closeThis()

		return
	end

	if slot1.nodeId ~= slot0.nodeMo.nodeId then
		return
	end

	if slot1.eventId == slot0.curEventId then
		return
	end

	slot0.curEventId = slot2
	slot0.eventCo = RougeMapConfig.instance:getRougeEvent(slot0.curEventId)
	slot0.choiceEventCo = lua_rouge_choice_event.configDict[slot0.curEventId]

	slot0:refreshUI()
	slot0:startPlayDialogue(slot0.choiceEventCo.desc, slot0.onChangeDialogueDone, slot0)
end

function slot0.onChangeDialogueDone(slot0)
	slot0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	slot0:refreshChoice()
	slot0:playChoiceShowAnim()
end

function slot0.initViewData(slot0)
	slot0.nodeMo = slot0.viewParam
	slot0.curEventId = slot0.nodeMo.eventId
	slot0.eventCo = RougeMapConfig.instance:getRougeEvent(slot0.curEventId)
	slot0.choiceEventCo = lua_rouge_choice_event.configDict[slot0.curEventId]
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:initViewData()
	slot0:refreshUI()
	slot0:startPlayDialogue(slot0.choiceEventCo.desc, slot0.onEnterDialogueDone, slot0)
end

function slot0.refreshUI(slot0)
	slot0._simageEpisodeBG:LoadImage(string.format("singlebg/rouge/episode/%s.png", slot0.choiceEventCo.image))

	slot0._txtName.text = slot0.choiceEventCo.title
	slot0._txtNameEn.text = ""
end

function slot0.onEnterDialogueDone(slot0)
	slot0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	slot0:refreshChoice()
	slot0:playChoiceShowAnim()
end

function slot0.refreshChoice(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	gohelper.setActive(slot0.goRight, true)
	gohelper.setActive(slot0.goLeft, true)

	if not slot0.nodeMo.eventMo:getChoiceIdList() then
		logError("choiceIdList is nil, curNode : " .. tostring(slot0.nodeMo))

		return
	end

	slot0.posList = RougeMapEnum.ChoiceItemPos[#slot1]

	RougeMapHelper.loadItemWithCustomUpdateFunc(slot0.goChoiceItem, RougeMapNodeChoiceItem, slot1, slot0.choiceItemList, slot0.updateItem, slot0)
end

function slot0.updateItem(slot0, slot1, slot2, slot3)
	slot1:update(slot3, slot0.posList[slot2], slot0.nodeMo)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageEpisodeBG:UnLoadImage()
	slot0._simageFrameBG:UnLoadImage()
	uv0.super.onDestroyView(slot0)
end

return slot0
