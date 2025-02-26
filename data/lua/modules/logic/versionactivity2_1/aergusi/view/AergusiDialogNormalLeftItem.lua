module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogNormalLeftItem", package.seeall)

slot0 = class("AergusiDialogNormalLeftItem", AergusiDialogItem)

function slot0.initView(slot0)
	slot0._gorolebg = gohelper.findChild(slot0.go, "rolebg")
	slot0._simageAvatar = gohelper.findChildSingleImage(slot0.go, "rolebg/image_avatar")
	slot0._gorolebggrey = gohelper.findChild(slot0.go, "rolebg_grey")
	slot0._simageAvatarGrey = gohelper.findChildSingleImage(slot0.go, "rolebg_grey/image_avatar")
	slot0._txtName = gohelper.findChildText(slot0.go, "name")
	slot0._txtNameGrey = gohelper.findChildText(slot0.go, "name_grey")
	slot0._goselectframe = gohelper.findChild(slot0.go, "content_bg/selectframe")
	slot0._txtContent = gohelper.findChildText(slot0.go, "content_bg/txt_content")
	slot0._contentRt = slot0._txtContent:GetComponent(gohelper.Type_RectTransform)
	slot0._btndoubted = gohelper.findChildButtonWithAudio(slot0.go, "content_bg/#btn_doubted")
	slot0._godoubted = gohelper.findChild(slot0.go, "content_bg/#go_doubted")
	slot0._btnobjection = gohelper.findChildButtonWithAudio(slot0.go, "content_bg/#go_doubted/#btn_objection")
	slot0._goobjectionmask = gohelper.findChild(slot0.go, "content_bg/#go_doubted/#btn_objection/mask")
	slot0._goobjectionselectframe = gohelper.findChild(slot0.go, "content_bg/#go_doubted/#btn_objection/selectframe")

	gohelper.setActive(slot0._goobjectionselectframe, false)

	slot0._btnask = gohelper.findChildButtonWithAudio(slot0.go, "content_bg/#go_doubted/#btn_ask")
	slot0._goaskmask = gohelper.findChild(slot0.go, "content_bg/#go_doubted/#btn_ask/mask")
	slot0._goaskselectframe = gohelper.findChild(slot0.go, "content_bg/#go_doubted/#btn_ask/selectframe")

	gohelper.setActive(slot0._goaskselectframe, false)

	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.go, "content_bg/#go_doubted/#btn_close")
	slot0._gomaskgrey = gohelper.findChild(slot0.go, "content_bg/mask_grey")
	slot0._contentBgRt = gohelper.findChildComponent(slot0.go, "content_bg", gohelper.Type_RectTransform)
	slot0._doubting = false
	slot0.go.name = string.format("normalleftitem_%s_%s", slot0.stepCo.id, slot0.stepCo.stepId)

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
	slot0:_addEvents()

	slot0._txtContentMarkTopIndex = slot0:createMarktopCmp(slot0._txtContent)

	slot0:setTopOffset(slot0._txtContentMarkTopIndex, 0, -6.151)
end

function slot0.refresh(slot0)
	gohelper.setActive(slot0._gorolebg, AergusiDialogModel.instance:getCurDialogGroup() == slot0.stepCo.id)
	gohelper.setActive(slot0._gorolebggrey, slot1 ~= slot0.stepCo.id)
	gohelper.setActive(slot0._txtName.gameObject, slot1 == slot0.stepCo.id)
	gohelper.setActive(slot0._txtNameGrey.gameObject, slot1 ~= slot0.stepCo.id)
	gohelper.setActive(slot0._gomaskgrey, slot1 ~= slot0.stepCo.id)

	slot2 = AergusiDialogModel.instance:getShowingGroupState()
	slot3 = AergusiConfig.instance:getEvidenceConfig(slot0.stepCo.id).dialogGroupType == AergusiEnum.DialogGroupType.Interact

	gohelper.setActive(slot0._btndoubted.gameObject, slot3 and not slot0._doubting and not slot2 and slot1 == slot0.stepCo.id)
	gohelper.setActive(slot0._godoubted, slot3 and slot0._doubting and not slot2 and slot1 == slot0.stepCo.id)

	if slot1 ~= slot0.stepCo.id then
		gohelper.setActive(slot0._goselectframe, false)
	end

	slot0._simageAvatar:LoadImage(ResUrl.getHeadIconSmall(slot0.stepCo.speakerIcon))
	slot0._simageAvatarGrey:LoadImage(ResUrl.getHeadIconSmall(slot0.stepCo.speakerIcon))

	slot0._txtName.text = slot0.stepCo.speaker
	slot0._txtNameGrey.text = slot0.stepCo.speaker

	slot0:setTextWithMarktopByIndex(slot0._txtContentMarkTopIndex, slot0.stepCo.content)
	gohelper.setActive(slot0._goaskmask, AergusiDialogModel.instance:isOperateHasError({
		groupId = slot0.stepCo.id,
		stepId = slot0.stepCo.stepId,
		type = AergusiEnum.OperationType.Probe
	}))

	slot7 = AergusiDialogModel.instance:isOperateHasError({
		groupId = slot0.stepCo.id,
		stepId = slot0.stepCo.stepId,
		type = AergusiEnum.OperationType.Refutation
	})
	slot8 = false

	if slot0.stepCo.condition ~= "" and string.splitToNumber(slot0.stepCo.condition, "#")[1] == AergusiEnum.OperationType.Refutation then
		slot8 = true
	end

	gohelper.setActive(slot0._goobjectionmask, slot7 and not slot8)
end

function slot0.calculateHeight(slot0)
	if slot0._txtContent.preferredWidth <= AergusiEnum.MessageTxtMaxWidth then
		recthelper.setSize(slot0._contentBgRt, slot1 + AergusiEnum.MessageBgOffsetWidth, AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight)
		recthelper.setSize(slot0._contentRt, slot1, AergusiEnum.MessageTxtOneLineHeight)

		return
	end

	slot2 = slot0._txtContent.preferredHeight

	recthelper.setSize(slot0._contentBgRt, AergusiEnum.MessageTxtMaxWidth + AergusiEnum.MessageBgOffsetWidth, slot2 + AergusiEnum.MessageBgOffsetHeight)
	recthelper.setSize(slot0._contentRt, AergusiEnum.MessageTxtMaxWidth, slot2)
end

function slot0.getHeight(slot0)
	if slot0._txtContent.preferredWidth <= AergusiEnum.MessageTxtMaxWidth then
		slot0.height = Mathf.Max(AergusiEnum.MinHeight[slot0.type] + AergusiEnum.DialogDoubtOffsetHeight, AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight + AergusiEnum.MessageNameHeight + AergusiEnum.DialogDoubtOffsetHeight)

		return slot0.height
	end

	slot1 = AergusiEnum.MessageTxtMaxWidth
	slot0.height = Mathf.Max(AergusiEnum.MinHeight[slot0.type] + AergusiEnum.DialogDoubtOffsetHeight, AergusiEnum.MessageTxtOneLineHeight * slot0._txtContent:GetTextInfo(slot0._txtContent.text).lineCount + AergusiEnum.MessageBgOffsetHeight + AergusiEnum.MessageNameHeight + AergusiEnum.DialogDoubtOffsetHeight)

	return slot0.height
end

function slot0._addEvents(slot0)
	slot0._btndoubted:AddClickListener(slot0._btndoubtedOnClick, slot0)
	slot0._btnobjection:AddClickListener(slot0._btnobjectionOnClick, slot0)
	slot0._btnask:AddClickListener(slot0._btnaskOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, slot0._onShowDialogGroupFinished, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnClickShowResultTip, slot0._onShowTips, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnDialogDoubtClick, slot0._onDialogDoubtClick, slot0)
end

function slot0._removeEvents(slot0)
	slot0._btndoubted:RemoveClickListener()
	slot0._btnobjection:RemoveClickListener()
	slot0._btnask:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, slot0._onShowDialogGroupFinished, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnClickShowResultTip, slot0._onShowTips, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnDialogDoubtClick, slot0._onDialogDoubtClick, slot0)
end

function slot0._onShowDialogGroupFinished(slot0)
	slot0:refresh()

	if AergusiDialogModel.instance:getUnlockAutoShow() then
		slot0:_onShowTips(AergusiDialogModel.instance:getNextPromptOperate(false))
	end
end

function slot0._onShowTips(slot0, slot1)
	if slot0.stepCo.id == slot1.groupId and slot0.stepCo.stepId == slot1.stepId then
		if slot1.type == AergusiEnum.OperationType.Refutation then
			AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_pop)
			gohelper.setActive(slot0._btndoubted.gameObject, false)
			gohelper.setActive(slot0._godoubted, true)
			gohelper.setActive(slot0._goselectframe, true)
			gohelper.setActive(slot0._goobjectionselectframe, true)
			gohelper.setActive(slot0._goaskselectframe, false)
		elseif slot1.type == AergusiEnum.OperationType.Probe then
			AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_pop)
			gohelper.setActive(slot0._btndoubted.gameObject, false)
			gohelper.setActive(slot0._godoubted, true)
			gohelper.setActive(slot0._goselectframe, true)
			gohelper.setActive(slot0._goobjectionselectframe, false)
			gohelper.setActive(slot0._goaskselectframe, true)
		end
	else
		gohelper.setActive(slot0._goselectframe, false)
		gohelper.setActive(slot0._godoubted, false)
		gohelper.setActive(slot0._btndoubted.gameObject, AergusiConfig.instance:getEvidenceConfig(slot0.stepCo.id).dialogGroupType == AergusiEnum.DialogGroupType.Interact)
	end
end

function slot0._onDialogDoubtClick(slot0, slot1)
	if slot1.id == slot0.stepCo.id and slot1.stepId == slot0.stepCo.stepId then
		slot0._doubting = true
	else
		gohelper.setActive(slot0._goselectframe, false)

		slot0._doubting = false
	end

	slot0:refresh()
end

function slot0._btndoubtedOnClick(slot0)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogDoubtClick, slot0.stepCo)
end

function slot0._btnobjectionOnClick(slot0)
	slot1 = 0

	if slot0.stepCo.condition ~= "" and string.splitToNumber(slot0.stepCo.condition, "#")[1] == AergusiEnum.OperationType.Refutation then
		slot1 = slot2[3]
	end

	AergusiController.instance:openAergusiClueView({
		episodeId = AergusiModel.instance:getCurEpisode(),
		type = AergusiEnum.OperationType.Refutation,
		groupId = slot1,
		stepId = slot0.stepCo.stepId,
		couldPrompt = true,
		callback = slot0._onRefuteEvidenceFinished,
		callbackObj = slot0
	})
end

function slot0._onRefuteEvidenceFinished(slot0, slot1)
	if slot1 < 0 then
		return
	end

	if slot1 > 0 then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnRefuteStartGroup, slot1)
	else
		slot0:refresh()
		AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceError, slot0.stepCo, AergusiEnum.OperationType.Refutation)
	end
end

function slot0._btnaskOnClick(slot0)
	if slot0.stepCo.condition ~= "" and string.splitToNumber(slot0.stepCo.condition, "#")[1] == AergusiEnum.OperationType.NotKeyProbe then
		slot2 = {}

		for slot8, slot9 in pairs(AergusiModel.instance.instance:getEpisodeClueConfigs(AergusiModel.instance:getCurEpisode(), true)) do
			table.insert(slot2, slot9.clueName)
		end

		StatController.instance:track(StatEnum.EventName.AergusiProbe, {
			[StatEnum.EventProperties.EpisodeId] = tostring(slot3),
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(slot0.stepCo.id).conditionStr,
			[StatEnum.EventProperties.ProbeDialogId] = tostring(slot0.stepCo.id),
			[StatEnum.EventProperties.ProbeStepId] = tostring(slot0.stepCo.stepId),
			[StatEnum.EventProperties.ProbeResult] = "NotKey Probe",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = slot2
		})
		AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogNotKeyAsk, slot1[2])

		return
	end

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, AergusiModel.instance:getCurEpisode(), AergusiEnum.OperationType.Probe, string.format("%s", slot0.stepCo.stepId), slot0._onAskFinished, slot0)
end

function slot0._onAskFinished(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	for slot10, slot11 in pairs(AergusiModel.instance.instance:getEpisodeClueConfigs(AergusiModel.instance:getCurEpisode(), true)) do
		table.insert({}, slot11.clueName)
	end

	if slot3.operationResult == "0" then
		StatController.instance:track(StatEnum.EventName.AergusiProbe, {
			[StatEnum.EventProperties.EpisodeId] = tostring(slot5),
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(slot0.stepCo.id).conditionStr,
			[StatEnum.EventProperties.ProbeDialogId] = tostring(slot0.stepCo.id),
			[StatEnum.EventProperties.ProbeStepId] = tostring(slot0.stepCo.stepId),
			[StatEnum.EventProperties.ProbeResult] = "Key Probe",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = slot4
		})
		AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogAskSuccess, slot0.stepCo)
	else
		StatController.instance:track(StatEnum.EventName.AergusiProbe, {
			[StatEnum.EventProperties.EpisodeId] = tostring(slot5),
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(slot0.stepCo.id).conditionStr,
			[StatEnum.EventProperties.ProbeDialogId] = tostring(slot0.stepCo.id),
			[StatEnum.EventProperties.ProbeStepId] = tostring(slot0.stepCo.stepId),
			[StatEnum.EventProperties.ProbeResult] = "Invalid Probe",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = slot4
		})
		AergusiDialogModel.instance:addErrorOperate({
			groupId = slot0.stepCo.id,
			stepId = slot0.stepCo.stepId,
			type = AergusiEnum.OperationType.Probe
		})
		slot0:refresh()
		AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogAskFail, slot0.stepCo)
	end
end

function slot0._btncloseOnClick(slot0)
	slot0._doubting = false

	slot0:refresh()
end

function slot0.onDestroy(slot0)
	slot0:_removeEvents()
	slot0._simageAvatar:UnLoadImage()
	slot0._simageAvatarGrey:UnLoadImage()
end

return slot0
