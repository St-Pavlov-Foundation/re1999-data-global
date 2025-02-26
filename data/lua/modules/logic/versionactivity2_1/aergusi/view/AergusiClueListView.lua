module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueListView", package.seeall)

slot0 = class("AergusiClueListView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollclueitems = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_clueitems")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "Left/#scroll_clueitems/viewport/content")
	slot0._btntimes = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/titlebg/titlecn/#btn_times")
	slot0._gotimegrey = gohelper.findChild(slot0.viewGO, "Left/titlebg/titlecn/#btn_times/grey")
	slot0._txttimes = gohelper.findChildText(slot0.viewGO, "Left/titlebg/titlecn/#btn_times/#txt_times")
	slot0._btnmix = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_mix")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmix:AddClickListener(slot0._btnmixOnClick, slot0)
	slot0._btntimes:AddClickListener(slot0._btntimesOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmix:RemoveClickListener()
	slot0._btntimes:RemoveClickListener()
end

function slot0._btnmixOnClick(slot0)
	AergusiModel.instance:setMergeClueOpen(true)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickStartMergeClue)
end

function slot0._btntimesOnClick(slot0)
	if not slot0.viewParam.couldPrompt then
		return
	end

	if AergusiDialogModel.instance:getLeftPromptTimes() <= 0 then
		return
	end

	if not AergusiDialogModel.instance:getNextPromptOperate(true) then
		if not AergusiDialogModel.instance:getLastPromptOperate(true) or not slot3.clueId or slot0.viewParam.stepId ~= slot3.stepId then
			GameFacade.showToast(ToastEnum.Act163HasTiped)
			AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, AergusiDialogModel.instance:getLastPromptOperate(false))
			slot0:closeThis()

			return
		end

		GameFacade.showToast(ToastEnum.Act163HasTiped)
		slot0:_showTipClue(slot3.clueId)

		return
	elseif slot0.viewParam.stepId ~= slot2.stepId and not AergusiDialogModel.instance:getNextPromptOperate(false) then
		GameFacade.showToast(ToastEnum.Act163HasTiped)
		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, AergusiDialogModel.instance:getLastPromptOperate(false))
		slot0:closeThis()

		return
	end

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, slot0.viewParam.episodeId, AergusiEnum.OperationType.Tip, "", slot0._onShowTipFinished, slot0)
end

function slot0._onShowTipFinished(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if slot0.viewParam.stepId ~= AergusiDialogModel.instance:getNextPromptOperate(true).stepId then
		slot0:closeThis()

		slot4 = AergusiDialogModel.instance:getNextPromptOperate(false)

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, slot4)
		AergusiDialogModel.instance:addPromptOperate(slot4, false)

		return
	end

	slot0:_showTipClue(slot4.clueId)
	AergusiDialogModel.instance:addPromptOperate(slot4, true)
end

function slot0._showTipClue(slot0, slot1)
	if not slot1 or slot1 <= 0 then
		return
	end

	AergusiModel.instance:setCurClueId(slot1)
	table.insert({}, slot1)

	if AergusiConfig.instance:getClueConfig(slot1).materialId ~= "" then
		for slot8, slot9 in ipairs(string.splitToNumber(slot2.materialId, "#")) do
			table.insert(slot3, slot9)
		end
	end

	for slot7, slot8 in pairs(slot0._clueItems) do
		slot9 = false

		for slot13, slot14 in pairs(slot3) do
			if slot8:getClueId() == slot14 then
				slot9 = true
			end
		end

		slot8:showTips(slot9)
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayPromptTip)
end

function slot0._editableInitView(slot0)
	slot0._drag = UIDragListenerHelper.New()

	slot0._drag:createByScrollRect(slot0._scrollclueitems.gameObject)
	slot0:_addEvents()

	slot0._clueLines = {}

	for slot4 = 1, 3 do
		slot5 = gohelper.findChild(slot0._scrollclueitems.gameObject, "viewport/content/Line" .. slot4)
		slot6 = {
			go = slot5,
			anim = slot5:GetComponent(typeof(slot10)),
			items = {}
		}
		slot10 = UnityEngine.Animator

		for slot10 = 1, 3 do
			slot6.items[slot10] = {
				root = gohelper.findChild(slot6.go, string.format("clue%s_%s", slot4, slot10))
			}
			slot6.items[slot10].go = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot6.items[slot10].root, "clueitem")
		end

		slot0._clueLines[slot4] = slot6
	end

	slot0._clueItems = {}
end

function slot0.onOpen(slot0)
	slot0._isInEpisode = slot0.viewParam and slot0.viewParam.episodeId > 0
	slot0._clueConfigs = slot0:_getClueConfigs()

	AergusiModel.instance:setCurClueId(slot0._clueConfigs[1].clueId)
	slot0:_refreshClueRoots()
	slot0:_refreshItem()
	slot0:_refreshBtn()
	slot0:_playRootsAnim("move1")

	if AergusiDialogModel.instance:getUnlockAutoShow() then
		if not AergusiDialogModel.instance:getNextPromptOperate(true) then
			GameFacade.showToast(ToastEnum.Act163HasTiped)
			slot0:_showTipClue(AergusiDialogModel.instance:getLastPromptOperate(true, slot0.viewParam.stepId).clueId)

			return
		end

		slot0:_showTipClue(slot2.clueId)
	end
end

function slot0._playRootsAnim(slot0, slot1)
	for slot5, slot6 in pairs(slot0._clueLines) do
		slot6.anim:Play(slot1, 0, 0)
	end
end

function slot0._refreshClueRoots(slot0)
	slot1 = #slot0._clueConfigs % 3 == 0 and math.floor(#slot0._clueConfigs / 3) or math.floor(#slot0._clueConfigs / 3) + 1

	for slot5, slot6 in ipairs(slot0._clueLines) do
		gohelper.setActive(slot6.go, false)
	end

	for slot5 = 1, slot1 do
		if not slot0._clueLines[slot5] then
			slot7 = gohelper.cloneInPlace(slot0._clueLines[slot5 % 3 == 0 and 3 or slot5 % 3].go, "Line" .. tostring(slot5))
			slot8 = {
				go = slot7,
				anim = slot7:GetComponent(typeof(slot12)),
				items = {}
			}
			slot12 = UnityEngine.Animator

			for slot12 = 1, 3 do
				slot8.items[slot12] = {
					root = gohelper.findChild(slot8.go, string.format("clue%s_%s", slot6, slot12))
				}
				slot8.items[slot12].go = gohelper.findChild(slot8.items[slot12].root, "clueitem")
			end

			slot0._clueLines[slot5] = slot8
		end

		gohelper.setActive(slot0._clueLines[slot5].go, true)
	end

	if #slot0._clueConfigs % 3 > 0 then
		for slot5 = #slot0._clueConfigs % 3, 3 do
			gohelper.setActive(slot0._clueLines[slot1].items[slot5].go, false)
		end
	end
end

function slot0._getClueConfigs(slot0)
	slot1 = {}

	return (not slot0._isInEpisode or AergusiModel.instance:getEpisodeClueConfigs(slot0.viewParam.episodeId, slot0._isInEpisode)) and AergusiModel.instance:getAllClues(slot0._isInEpisode)
end

function slot0._refreshItem(slot0)
	for slot4, slot5 in pairs(slot0._clueItems) do
		slot5:hide()
	end

	for slot4, slot5 in ipairs(slot0._clueConfigs) do
		if not slot0._clueItems[slot4] then
			slot6 = slot4 % 3 == 0 and math.floor(slot4 / 3) or math.floor(slot4 / 3) + 1
			slot8 = AergusiClueItem.New()

			slot8:init(slot0._clueLines[slot6].items[slot4 - 3 * (slot6 - 1)].go, slot4)

			slot0._clueItems[slot4] = slot8
		end

		slot0._clueItems[slot4]:setInEpisode(slot0._isInEpisode)
		slot0._clueItems[slot4]:refresh(slot5, slot0.viewParam and slot0.viewParam.stepId)
	end
end

function slot0._refreshBtn(slot0)
	slot1 = false

	if slot0.viewParam and slot0.viewParam.episodeId then
		slot0._txttimes.text = AergusiDialogModel.instance:getLeftPromptTimes()
		slot1 = AergusiConfig.instance:getEvidenceConfig(AergusiDialogModel.instance:getCurDialogGroup()).showFusion > 0 and #AergusiModel.instance:getCouldMergeClues(slot0._clueConfigs) > 0

		gohelper.setActive(slot0._btntimes.gameObject, true)
		gohelper.setActive(slot0._gotimegrey, not slot0.viewParam.couldPrompt or slot2 <= 0)
	else
		gohelper.setActive(slot0._btntimes.gameObject, false)
	end

	if slot1 then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideShowClueMerge)
	end

	gohelper.setActive(slot0._btnmix.gameObject, slot1)
end

function slot0._addEvents(slot0)
	AergusiController.instance:registerCallback(AergusiEvent.StartOperation, slot0._onRefreshClueList, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayMergeSuccess, slot0._onRefreshClueList, slot0)
	slot0._drag:registerCallback(slot0._drag.EventBegin, slot0._onDragBegin, slot0)
	slot0._drag:registerCallback(slot0._drag.EventEnd, slot0._onDragEnd, slot0)
end

function slot0._removeEvents(slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.StartOperation, slot0._onRefreshClueList, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayMergeSuccess, slot0._onRefreshClueList, slot0)
	slot0._drag:release()
end

function slot0._onDragBegin(slot0)
	slot0._positionX, slot0._positionY = transformhelper.getPos(slot0._goscrollcontent.transform)
end

function slot0._onDragEnd(slot0)
	slot1, slot2 = transformhelper.getPos(slot0._goscrollcontent.transform)

	if slot2 - 50 < slot0._positionY then
		slot0:_playRootsAnim("move2")
	elseif slot0._positionY < slot2 + 50 then
		slot0:_playRootsAnim("move1")
	end
end

function slot0._onRefreshClueList(slot0)
	slot0._clueConfigs = slot0:_getClueConfigs()

	slot0:_refreshClueRoots()
	slot0:_refreshItem()
	slot0:_refreshBtn()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()

	if slot0._clueItems then
		for slot4, slot5 in pairs(slot0._clueItems) do
			slot5:destroy()
		end

		slot0._clueItems = nil
	end
end

return slot0
