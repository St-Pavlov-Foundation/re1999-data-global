module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogNormalLeftItem", package.seeall)

local var_0_0 = class("AergusiDialogNormalLeftItem", AergusiDialogItem)

function var_0_0.initView(arg_1_0)
	arg_1_0._gorolebg = gohelper.findChild(arg_1_0.go, "rolebg")
	arg_1_0._simageAvatar = gohelper.findChildSingleImage(arg_1_0.go, "rolebg/image_avatar")
	arg_1_0._gorolebggrey = gohelper.findChild(arg_1_0.go, "rolebg_grey")
	arg_1_0._simageAvatarGrey = gohelper.findChildSingleImage(arg_1_0.go, "rolebg_grey/image_avatar")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.go, "name")
	arg_1_0._txtNameGrey = gohelper.findChildText(arg_1_0.go, "name_grey")
	arg_1_0._goselectframe = gohelper.findChild(arg_1_0.go, "content_bg/selectframe")
	arg_1_0._txtContent = gohelper.findChildText(arg_1_0.go, "content_bg/txt_content")
	arg_1_0._contentRt = arg_1_0._txtContent:GetComponent(gohelper.Type_RectTransform)
	arg_1_0._btndoubted = gohelper.findChildButtonWithAudio(arg_1_0.go, "content_bg/#btn_doubted")
	arg_1_0._godoubted = gohelper.findChild(arg_1_0.go, "content_bg/#go_doubted")
	arg_1_0._btnobjection = gohelper.findChildButtonWithAudio(arg_1_0.go, "content_bg/#go_doubted/#btn_objection")
	arg_1_0._goobjectionmask = gohelper.findChild(arg_1_0.go, "content_bg/#go_doubted/#btn_objection/mask")
	arg_1_0._goobjectionselectframe = gohelper.findChild(arg_1_0.go, "content_bg/#go_doubted/#btn_objection/selectframe")

	gohelper.setActive(arg_1_0._goobjectionselectframe, false)

	arg_1_0._btnask = gohelper.findChildButtonWithAudio(arg_1_0.go, "content_bg/#go_doubted/#btn_ask")
	arg_1_0._goaskmask = gohelper.findChild(arg_1_0.go, "content_bg/#go_doubted/#btn_ask/mask")
	arg_1_0._goaskselectframe = gohelper.findChild(arg_1_0.go, "content_bg/#go_doubted/#btn_ask/selectframe")

	gohelper.setActive(arg_1_0._goaskselectframe, false)

	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.go, "content_bg/#go_doubted/#btn_close")
	arg_1_0._gomaskgrey = gohelper.findChild(arg_1_0.go, "content_bg/mask_grey")
	arg_1_0._contentBgRt = gohelper.findChildComponent(arg_1_0.go, "content_bg", gohelper.Type_RectTransform)
	arg_1_0._doubting = false
	arg_1_0.go.name = string.format("normalleftitem_%s_%s", arg_1_0.stepCo.id, arg_1_0.stepCo.stepId)

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
	arg_1_0:_addEvents()

	arg_1_0._txtContentMarkTopIndex = arg_1_0:createMarktopCmp(arg_1_0._txtContent)

	arg_1_0:setTopOffset(arg_1_0._txtContentMarkTopIndex, 0, -6.151)
end

function var_0_0.refresh(arg_2_0)
	local var_2_0 = AergusiDialogModel.instance:getCurDialogGroup()

	gohelper.setActive(arg_2_0._gorolebg, var_2_0 == arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._gorolebggrey, var_2_0 ~= arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._txtName.gameObject, var_2_0 == arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._txtNameGrey.gameObject, var_2_0 ~= arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._gomaskgrey, var_2_0 ~= arg_2_0.stepCo.id)

	local var_2_1 = AergusiDialogModel.instance:getShowingGroupState()
	local var_2_2 = AergusiConfig.instance:getEvidenceConfig(arg_2_0.stepCo.id).dialogGroupType == AergusiEnum.DialogGroupType.Interact

	gohelper.setActive(arg_2_0._btndoubted.gameObject, var_2_2 and not arg_2_0._doubting and not var_2_1 and var_2_0 == arg_2_0.stepCo.id)
	gohelper.setActive(arg_2_0._godoubted, var_2_2 and arg_2_0._doubting and not var_2_1 and var_2_0 == arg_2_0.stepCo.id)

	if var_2_0 ~= arg_2_0.stepCo.id then
		gohelper.setActive(arg_2_0._goselectframe, false)
	end

	arg_2_0._simageAvatar:LoadImage(ResUrl.getHeadIconSmall(arg_2_0.stepCo.speakerIcon))
	arg_2_0._simageAvatarGrey:LoadImage(ResUrl.getHeadIconSmall(arg_2_0.stepCo.speakerIcon))

	arg_2_0._txtName.text = arg_2_0.stepCo.speaker
	arg_2_0._txtNameGrey.text = arg_2_0.stepCo.speaker

	arg_2_0:setTextWithMarktopByIndex(arg_2_0._txtContentMarkTopIndex, arg_2_0.stepCo.content)

	local var_2_3 = {
		groupId = arg_2_0.stepCo.id,
		stepId = arg_2_0.stepCo.stepId,
		type = AergusiEnum.OperationType.Probe
	}
	local var_2_4 = AergusiDialogModel.instance:isOperateHasError(var_2_3)

	gohelper.setActive(arg_2_0._goaskmask, var_2_4)

	local var_2_5 = {
		groupId = arg_2_0.stepCo.id,
		stepId = arg_2_0.stepCo.stepId,
		type = AergusiEnum.OperationType.Refutation
	}
	local var_2_6 = AergusiDialogModel.instance:isOperateHasError(var_2_5)
	local var_2_7 = false

	if arg_2_0.stepCo.condition ~= "" and string.splitToNumber(arg_2_0.stepCo.condition, "#")[1] == AergusiEnum.OperationType.Refutation then
		var_2_7 = true
	end

	gohelper.setActive(arg_2_0._goobjectionmask, var_2_6 and not var_2_7)
end

function var_0_0.calculateHeight(arg_3_0)
	local var_3_0 = arg_3_0._txtContent.preferredWidth

	if var_3_0 <= AergusiEnum.MessageTxtMaxWidth then
		local var_3_1 = AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight

		recthelper.setSize(arg_3_0._contentBgRt, var_3_0 + AergusiEnum.MessageBgOffsetWidth, var_3_1)
		recthelper.setSize(arg_3_0._contentRt, var_3_0, AergusiEnum.MessageTxtOneLineHeight)

		return
	end

	local var_3_2 = AergusiEnum.MessageTxtMaxWidth
	local var_3_3 = arg_3_0._txtContent.preferredHeight
	local var_3_4 = var_3_3 + AergusiEnum.MessageBgOffsetHeight

	recthelper.setSize(arg_3_0._contentBgRt, AergusiEnum.MessageTxtMaxWidth + AergusiEnum.MessageBgOffsetWidth, var_3_4)
	recthelper.setSize(arg_3_0._contentRt, var_3_2, var_3_3)
end

function var_0_0.getHeight(arg_4_0)
	if arg_4_0._txtContent.preferredWidth <= AergusiEnum.MessageTxtMaxWidth then
		local var_4_0 = AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight

		arg_4_0.height = Mathf.Max(AergusiEnum.MinHeight[arg_4_0.type] + AergusiEnum.DialogDoubtOffsetHeight, var_4_0 + AergusiEnum.MessageNameHeight + AergusiEnum.DialogDoubtOffsetHeight)

		return arg_4_0.height
	end

	local var_4_1 = AergusiEnum.MessageTxtMaxWidth
	local var_4_2 = AergusiEnum.MessageTxtOneLineHeight * arg_4_0._txtContent:GetTextInfo(arg_4_0._txtContent.text).lineCount + AergusiEnum.MessageBgOffsetHeight

	arg_4_0.height = Mathf.Max(AergusiEnum.MinHeight[arg_4_0.type] + AergusiEnum.DialogDoubtOffsetHeight, var_4_2 + AergusiEnum.MessageNameHeight + AergusiEnum.DialogDoubtOffsetHeight)

	return arg_4_0.height
end

function var_0_0._addEvents(arg_5_0)
	arg_5_0._btndoubted:AddClickListener(arg_5_0._btndoubtedOnClick, arg_5_0)
	arg_5_0._btnobjection:AddClickListener(arg_5_0._btnobjectionOnClick, arg_5_0)
	arg_5_0._btnask:AddClickListener(arg_5_0._btnaskOnClick, arg_5_0)
	arg_5_0._btnclose:AddClickListener(arg_5_0._btncloseOnClick, arg_5_0)
	arg_5_0:addEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, arg_5_0._onShowDialogGroupFinished, arg_5_0)
	arg_5_0:addEventCb(AergusiController.instance, AergusiEvent.OnClickShowResultTip, arg_5_0._onShowTips, arg_5_0)
	arg_5_0:addEventCb(AergusiController.instance, AergusiEvent.OnDialogDoubtClick, arg_5_0._onDialogDoubtClick, arg_5_0)
end

function var_0_0._removeEvents(arg_6_0)
	arg_6_0._btndoubted:RemoveClickListener()
	arg_6_0._btnobjection:RemoveClickListener()
	arg_6_0._btnask:RemoveClickListener()
	arg_6_0._btnclose:RemoveClickListener()
	arg_6_0:removeEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, arg_6_0._onShowDialogGroupFinished, arg_6_0)
	arg_6_0:removeEventCb(AergusiController.instance, AergusiEvent.OnClickShowResultTip, arg_6_0._onShowTips, arg_6_0)
	arg_6_0:removeEventCb(AergusiController.instance, AergusiEvent.OnDialogDoubtClick, arg_6_0._onDialogDoubtClick, arg_6_0)
end

function var_0_0._onShowDialogGroupFinished(arg_7_0)
	arg_7_0:refresh()

	if AergusiDialogModel.instance:getUnlockAutoShow() then
		local var_7_0 = AergusiDialogModel.instance:getNextPromptOperate(false)

		arg_7_0:_onShowTips(var_7_0)
	end
end

function var_0_0._onShowTips(arg_8_0, arg_8_1)
	if arg_8_0.stepCo.id == arg_8_1.groupId and arg_8_0.stepCo.stepId == arg_8_1.stepId then
		if arg_8_1.type == AergusiEnum.OperationType.Refutation then
			AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_pop)
			gohelper.setActive(arg_8_0._btndoubted.gameObject, false)
			gohelper.setActive(arg_8_0._godoubted, true)
			gohelper.setActive(arg_8_0._goselectframe, true)
			gohelper.setActive(arg_8_0._goobjectionselectframe, true)
			gohelper.setActive(arg_8_0._goaskselectframe, false)
		elseif arg_8_1.type == AergusiEnum.OperationType.Probe then
			AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_pop)
			gohelper.setActive(arg_8_0._btndoubted.gameObject, false)
			gohelper.setActive(arg_8_0._godoubted, true)
			gohelper.setActive(arg_8_0._goselectframe, true)
			gohelper.setActive(arg_8_0._goobjectionselectframe, false)
			gohelper.setActive(arg_8_0._goaskselectframe, true)
		end
	else
		gohelper.setActive(arg_8_0._goselectframe, false)
		gohelper.setActive(arg_8_0._godoubted, false)

		local var_8_0 = AergusiConfig.instance:getEvidenceConfig(arg_8_0.stepCo.id).dialogGroupType == AergusiEnum.DialogGroupType.Interact

		gohelper.setActive(arg_8_0._btndoubted.gameObject, var_8_0)
	end
end

function var_0_0._onDialogDoubtClick(arg_9_0, arg_9_1)
	if arg_9_1.id == arg_9_0.stepCo.id and arg_9_1.stepId == arg_9_0.stepCo.stepId then
		arg_9_0._doubting = true
	else
		gohelper.setActive(arg_9_0._goselectframe, false)

		arg_9_0._doubting = false
	end

	arg_9_0:refresh()
end

function var_0_0._btndoubtedOnClick(arg_10_0)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogDoubtClick, arg_10_0.stepCo)
end

function var_0_0._btnobjectionOnClick(arg_11_0)
	local var_11_0 = 0

	if arg_11_0.stepCo.condition ~= "" then
		local var_11_1 = string.splitToNumber(arg_11_0.stepCo.condition, "#")

		if var_11_1[1] == AergusiEnum.OperationType.Refutation then
			var_11_0 = var_11_1[3]
		end
	end

	local var_11_2 = {
		episodeId = AergusiModel.instance:getCurEpisode(),
		type = AergusiEnum.OperationType.Refutation,
		groupId = var_11_0,
		stepId = arg_11_0.stepCo.stepId
	}

	var_11_2.couldPrompt = true
	var_11_2.callback = arg_11_0._onRefuteEvidenceFinished
	var_11_2.callbackObj = arg_11_0

	AergusiController.instance:openAergusiClueView(var_11_2)
end

function var_0_0._onRefuteEvidenceFinished(arg_12_0, arg_12_1)
	if arg_12_1 < 0 then
		return
	end

	if arg_12_1 > 0 then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnRefuteStartGroup, arg_12_1)
	else
		arg_12_0:refresh()

		local var_12_0 = AergusiEnum.OperationType.Refutation

		AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceError, arg_12_0.stepCo, var_12_0)
	end
end

function var_0_0._btnaskOnClick(arg_13_0)
	if arg_13_0.stepCo.condition ~= "" then
		local var_13_0 = string.splitToNumber(arg_13_0.stepCo.condition, "#")

		if var_13_0[1] == AergusiEnum.OperationType.NotKeyProbe then
			local var_13_1 = {}
			local var_13_2 = AergusiModel.instance:getCurEpisode()
			local var_13_3 = AergusiModel.instance.instance:getEpisodeClueConfigs(var_13_2, true)

			for iter_13_0, iter_13_1 in pairs(var_13_3) do
				table.insert(var_13_1, iter_13_1.clueName)
			end

			StatController.instance:track(StatEnum.EventName.AergusiProbe, {
				[StatEnum.EventProperties.EpisodeId] = tostring(var_13_2),
				[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(arg_13_0.stepCo.id).conditionStr,
				[StatEnum.EventProperties.ProbeDialogId] = tostring(arg_13_0.stepCo.id),
				[StatEnum.EventProperties.ProbeStepId] = tostring(arg_13_0.stepCo.stepId),
				[StatEnum.EventProperties.ProbeResult] = "NotKey Probe",
				[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
				[StatEnum.EventProperties.HoldClueName] = var_13_1
			})

			local var_13_4 = var_13_0[2]

			AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogNotKeyAsk, var_13_4)

			return
		end
	end

	local var_13_5 = VersionActivity2_1Enum.ActivityId.Aergusi
	local var_13_6 = AergusiModel.instance:getCurEpisode()
	local var_13_7 = AergusiEnum.OperationType.Probe
	local var_13_8 = arg_13_0.stepCo.stepId
	local var_13_9 = string.format("%s", var_13_8)

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_13_5, var_13_6, var_13_7, var_13_9, arg_13_0._onAskFinished, arg_13_0)
end

function var_0_0._onAskFinished(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 ~= 0 then
		return
	end

	local var_14_0 = {}
	local var_14_1 = AergusiModel.instance:getCurEpisode()
	local var_14_2 = AergusiModel.instance.instance:getEpisodeClueConfigs(var_14_1, true)

	for iter_14_0, iter_14_1 in pairs(var_14_2) do
		table.insert(var_14_0, iter_14_1.clueName)
	end

	if arg_14_3.operationResult == "0" then
		StatController.instance:track(StatEnum.EventName.AergusiProbe, {
			[StatEnum.EventProperties.EpisodeId] = tostring(var_14_1),
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(arg_14_0.stepCo.id).conditionStr,
			[StatEnum.EventProperties.ProbeDialogId] = tostring(arg_14_0.stepCo.id),
			[StatEnum.EventProperties.ProbeStepId] = tostring(arg_14_0.stepCo.stepId),
			[StatEnum.EventProperties.ProbeResult] = "Key Probe",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = var_14_0
		})
		AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogAskSuccess, arg_14_0.stepCo)
	else
		StatController.instance:track(StatEnum.EventName.AergusiProbe, {
			[StatEnum.EventProperties.EpisodeId] = tostring(var_14_1),
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(arg_14_0.stepCo.id).conditionStr,
			[StatEnum.EventProperties.ProbeDialogId] = tostring(arg_14_0.stepCo.id),
			[StatEnum.EventProperties.ProbeStepId] = tostring(arg_14_0.stepCo.stepId),
			[StatEnum.EventProperties.ProbeResult] = "Invalid Probe",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = var_14_0
		})

		local var_14_3 = {
			groupId = arg_14_0.stepCo.id,
			stepId = arg_14_0.stepCo.stepId,
			type = AergusiEnum.OperationType.Probe
		}

		AergusiDialogModel.instance:addErrorOperate(var_14_3)
		arg_14_0:refresh()
		AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogAskFail, arg_14_0.stepCo)
	end
end

function var_0_0._btncloseOnClick(arg_15_0)
	arg_15_0._doubting = false

	arg_15_0:refresh()
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0:_removeEvents()
	arg_16_0._simageAvatar:UnLoadImage()
	arg_16_0._simageAvatarGrey:UnLoadImage()
end

return var_0_0
