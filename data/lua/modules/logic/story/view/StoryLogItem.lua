module("modules.logic.story.view.StoryLogItem", package.seeall)

local var_0_0 = class("StoryLogItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_name")
	arg_1_0._goplayicon = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_playicon")
	arg_1_0._gostopicon = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_stopicon")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_name/#go_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#go_name/#txt_name")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_content")
	arg_1_0._gonorole = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_norole")
	arg_1_0._gobranch = gohelper.findChild(arg_1_0.viewGO, "#go_branch")
	arg_1_0._simagebranch1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_branch/#simage_branch1")
	arg_1_0._txtbranch1 = gohelper.findChildText(arg_1_0.viewGO, "#go_branch/#simage_branch1/#txt_branch1")
	arg_1_0._simagebranch2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_branch/#simage_branch2")
	arg_1_0._txtbranch2 = gohelper.findChildText(arg_1_0.viewGO, "#go_branch/#simage_branch2/#txt_branch2")
	arg_1_0._simagebranch3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_branch/#simage_branch3")
	arg_1_0._txtbranch3 = gohelper.findChildText(arg_1_0.viewGO, "#go_branch/#simage_branch3/#txt_branch3")
	arg_1_0._simagebranch4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_branch/#simage_branch4")
	arg_1_0._txtbranch4 = gohelper.findChildText(arg_1_0.viewGO, "#go_branch/#simage_branch4/#txt_branch4")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_play")
	arg_1_0._btnstop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_stop")
	arg_1_0._goselect1 = gohelper.findChild(arg_1_0.viewGO, "#go_branch/#simage_branch1/#go_select1")
	arg_1_0._goselect2 = gohelper.findChild(arg_1_0.viewGO, "#go_branch/#simage_branch2/#go_select2")
	arg_1_0._goselect3 = gohelper.findChild(arg_1_0.viewGO, "#go_branch/#simage_branch3/#go_select3")
	arg_1_0._goselect4 = gohelper.findChild(arg_1_0.viewGO, "#go_branch/#simage_branch4/#go_select4")

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
	arg_4_0._txtbranchs = {
		arg_4_0._txtbranch1,
		arg_4_0._txtbranch2,
		arg_4_0._txtbranch3,
		arg_4_0._txtbranch4
	}
	arg_4_0._simagebranchs = {
		arg_4_0._simagebranch1,
		arg_4_0._simagebranch2,
		arg_4_0._simagebranch3,
		arg_4_0._simagebranch4
	}
	arg_4_0._goselects = {
		arg_4_0._goselect1,
		arg_4_0._goselect2,
		arg_4_0._goselect3,
		arg_4_0._goselect4
	}

	arg_4_0._btnplay:AddClickListener(arg_4_0._onPlayClick, arg_4_0)
	arg_4_0._btnstop:AddClickListener(arg_4_0._onStopClick, arg_4_0)
	StoryController.instance:registerCallback(StoryEvent.LogSelected, arg_4_0._onItemSelected, arg_4_0)
	StoryController.instance:registerCallback(StoryEvent.LogAudioFinished, arg_4_0._onItemAudioFinished, arg_4_0)

	arg_4_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_4_0._txtcontent.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_4_0._conMark = gohelper.onceAddComponent(arg_4_0._txtcontent.gameObject, typeof(ZProj.TMPMark))

	arg_4_0._conMark:SetMarkTopGo(arg_4_0._txtmarktop.gameObject)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0._onItemAudioFinished(arg_7_0)
	if arg_7_0._hasLowPassAudio then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Lowpass)

		arg_7_0._hasLowPassAudio = false
	end

	if not arg_7_0._audioId or arg_7_0._audioId == 0 then
		return
	end

	if not arg_7_0._mo or type(arg_7_0._mo.info) ~= "number" then
		return
	end

	if arg_7_0._audioId == StoryLogListModel.instance:getPlayingLogAudioId() then
		gohelper.setActive(arg_7_0._gostopicon, false)
		gohelper.setActive(arg_7_0._goplayicon, true)
		gohelper.setActive(arg_7_0._btnplay.gameObject, true)
		gohelper.setActive(arg_7_0._btnstop.gameObject, false)

		local var_7_0 = StoryStepModel.instance:getStepListById(arg_7_0._mo.info).conversation

		if var_7_0.type == StoryEnum.ConversationType.Player or var_7_0.nameShow and var_7_0.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and var_7_0.type ~= StoryEnum.ConversationType.None and var_7_0.type ~= StoryEnum.ConversationType.ScreenDialog then
			arg_7_0:_setItemContentColor("#CCAD8F")
		else
			arg_7_0:_setItemContentColor("#EEF1E8")
			SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
		end
	end
end

function var_0_0._onItemSelected(arg_8_0, arg_8_1)
	if not arg_8_1 or arg_8_1 == 0 or not arg_8_0._audioId or arg_8_0._audioId == 0 then
		return
	end

	if arg_8_0._audioId == arg_8_1 then
		return
	end

	if type(arg_8_0._mo.info) == "number" then
		if StoryStepModel.instance:getStepListById(arg_8_0._mo.info).conversation.type == StoryEnum.ConversationType.None then
			gohelper.setActive(arg_8_0._goplayicon, false)
			gohelper.setActive(arg_8_0._gostopicon, false)
			gohelper.setActive(arg_8_0._btnplay.gameObject, false)
			gohelper.setActive(arg_8_0._btnstop.gameObject, false)

			return
		end

		if arg_8_0._audioId ~= 0 then
			AudioEffectMgr.instance:stopAudio(arg_8_0._audioId, 0)
			gohelper.setActive(arg_8_0._goplayicon, true)
			gohelper.setActive(arg_8_0._gostopicon, false)
			gohelper.setActive(arg_8_0._btnplay.gameObject, true)
			gohelper.setActive(arg_8_0._btnstop.gameObject, false)
		else
			gohelper.setActive(arg_8_0._goplayicon, false)
			gohelper.setActive(arg_8_0._gostopicon, false)
			gohelper.setActive(arg_8_0._btnplay.gameObject, false)
			gohelper.setActive(arg_8_0._btnstop.gameObject, false)
		end
	elseif type(arg_8_0._mo.info) == "table" then
		gohelper.setActive(arg_8_0._goplayicon, false)
		gohelper.setActive(arg_8_0._gostopicon, false)
		gohelper.setActive(arg_8_0._btnplay.gameObject, false)
		gohelper.setActive(arg_8_0._btnstop.gameObject, false)
	end
end

function var_0_0._onPlayClick(arg_9_0)
	gohelper.setActive(arg_9_0._gostopicon, true)
	gohelper.setActive(arg_9_0._goplayicon, false)
	gohelper.setActive(arg_9_0._btnplay.gameObject, false)
	gohelper.setActive(arg_9_0._btnstop.gameObject, true)
	arg_9_0:_setItemContentColor("#D56B39")
	SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")

	if arg_9_0._audioId ~= 0 and StoryLogListModel.instance:getPlayingLogAudioId() ~= arg_9_0._audioId then
		AudioEffectMgr.instance:stopAudio(StoryLogListModel.instance:getPlayingLogAudioId(), 0)
		AudioEffectMgr.instance:stopAudio(arg_9_0._audioId, 0)
	end

	local var_9_0 = {}

	var_9_0.loopNum = 1
	var_9_0.fadeInTime = 0
	var_9_0.fadeOutTime = 0
	var_9_0.volume = 100
	var_9_0.callback = arg_9_0._onAudioFinished
	var_9_0.callbackTarget = arg_9_0

	AudioEffectMgr.instance:playAudio(arg_9_0._audioId, var_9_0)
	StoryLogListModel.instance:setPlayingLogAudio(arg_9_0._audioId)
	StoryController.instance:dispatchEvent(StoryEvent.LogSelected, arg_9_0._audioId)

	local var_9_1 = StoryStepModel.instance:getStepListById(arg_9_0._mo.info).conversation

	if #var_9_1.audios > 1 then
		for iter_9_0, iter_9_1 in pairs(var_9_1.audios) do
			if iter_9_1 == AudioEnum.Story.Play_Lowpass then
				arg_9_0._hasLowPassAudio = true

				AudioMgr.instance:trigger(AudioEnum.Story.Play_Lowpass)

				break
			end
		end
	end
end

function var_0_0._onStopClick(arg_10_0)
	gohelper.setActive(arg_10_0._gostopicon, false)
	gohelper.setActive(arg_10_0._goplayicon, true)
	gohelper.setActive(arg_10_0._btnplay.gameObject, true)
	gohelper.setActive(arg_10_0._btnstop.gameObject, false)

	local var_10_0 = StoryStepModel.instance:getStepListById(arg_10_0._mo.info).conversation

	if var_10_0.type == StoryEnum.ConversationType.Player or var_10_0.nameShow and var_10_0.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and var_10_0.type ~= StoryEnum.ConversationType.None and var_10_0.type ~= StoryEnum.ConversationType.ScreenDialog then
		arg_10_0:_setItemContentColor("#CCAD8F")
	else
		arg_10_0:_setItemContentColor("#EEF1E8")
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end

	StoryLogListModel.instance:setPlayingLogAudioFinished(arg_10_0._audioId)
	AudioEffectMgr.instance:stopAudio(arg_10_0._audioId, 0)
end

function var_0_0._onAudioFinished(arg_11_0)
	StoryController.instance:dispatchEvent(StoryEvent.LogAudioFinished)

	if arg_11_0._audioId ~= StoryLogListModel.instance:getPlayingLogAudioId() then
		StoryLogListModel.instance:setPlayingLogAudio(0)
	end

	if arg_11_0._audioId == 0 then
		return
	end

	StoryLogListModel.instance:setPlayingLogAudioFinished(arg_11_0._audioId)
	gohelper.setActive(arg_11_0._gostopicon, false)
	gohelper.setActive(arg_11_0._goplayicon, true)
	gohelper.setActive(arg_11_0._btnplay.gameObject, true)
	gohelper.setActive(arg_11_0._btnstop.gameObject, false)

	local var_11_0 = StoryStepModel.instance:getStepListById(arg_11_0._mo.info).conversation

	if var_11_0.type == StoryEnum.ConversationType.Player or var_11_0.nameShow and var_11_0.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and var_11_0.type ~= StoryEnum.ConversationType.None and var_11_0.type ~= StoryEnum.ConversationType.ScreenDialog then
		arg_11_0:_setItemContentColor("#CCAD8F")
	else
		arg_11_0:_setItemContentColor("#EEF1E8")
		SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_1 then
		return
	end

	arg_12_0._mo = arg_12_1

	arg_12_0:_setItemContentColor("#EEF1E8")
	SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")

	if type(arg_12_1.info) == "number" then
		gohelper.setActive(arg_12_0._gonormal, true)
		gohelper.setActive(arg_12_0._gobranch, false)

		local var_12_0 = StoryStepModel.instance:getStepListById(arg_12_1.info).conversation
		local var_12_1 = string.find(var_12_0.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "<voffset") and var_12_0.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] or GameUtil.filterRichText(var_12_0.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

		if SDKModel.instance:isDmm() and LangSettings.instance:isJp() then
			local var_12_2 = StoryController.instance._curStoryId
			local var_12_3 = arg_12_1.info

			if var_12_2 == 100601 and var_12_3 == 36 then
				var_12_1 = "はっ！　正気の沙汰じゃない。一家そろって◯◯◯だぞ！"
			elseif var_12_2 == 100602 and var_12_3 == 30 then
				var_12_1 = "あんたらがマヌス・ヴェンデッタの仮面を研究したおかげで、その副作用が徹底的に分かったぜ！　おかげで、ラプラスの廊下は身体のあちこちから石油を垂らす◯◯◯で埋まっちまったがな。"
			elseif var_12_2 == 100726 and var_12_3 == 32 then
				var_12_1 = "ははは！　死ね、無様な◯◯◯どもが！！"
			end
		end

		arg_12_0._audioId = var_12_0.audios[1] or 0

		local var_12_4 = StoryModel.instance:getStoryTxtByVoiceType(StoryTool.getFilterDia(var_12_1), arg_12_0._audioId)
		local var_12_5 = StoryTool.getMarkTopTextList(var_12_4)
		local var_12_6 = StoryTool.filterMarkTop(var_12_4)

		if var_12_0.effType == StoryEnum.ConversationEffectType.Magic then
			var_12_6 = StoryConfig.instance:replaceStoryMagicText(var_12_6)
		end

		if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
			var_12_6 = string.gsub(var_12_6, "<glitch>", "")
			var_12_6 = string.gsub(var_12_6, "</glitch>", "")
		else
			var_12_6 = string.gsub(var_12_6, "<glitch>", "<i><b>")
			var_12_6 = string.gsub(var_12_6, "</glitch>", "</i></b>")
		end

		arg_12_0._txtcontent.text = StoryTool.filterSpTag(var_12_6)

		TaskDispatcher.runDelay(function()
			if arg_12_0._conMark then
				arg_12_0._conMark:SetMarksTop(var_12_5)
			end
		end, nil, 0.01)

		if var_12_0.type ~= StoryEnum.ConversationType.Aside then
			gohelper.setActive(arg_12_0._gonorole, false)

			if not var_12_0.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] or var_12_0.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == "" or not var_12_0.nameShow then
				gohelper.setActive(arg_12_0._goname, false)
			elseif arg_12_2 == 1 then
				gohelper.setActive(arg_12_0._goname, false)
			else
				arg_12_0._txtname.text = string.format("%s:", string.split(var_12_0.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "_")[1])

				gohelper.setActive(arg_12_0._goname, true)
			end

			if arg_12_0._audioId ~= 0 then
				local var_12_7 = arg_12_0._audioId == StoryLogListModel.instance:getPlayingLogAudioId()

				gohelper.setActive(arg_12_0._gostopicon, var_12_7)
				gohelper.setActive(arg_12_0._goplayicon, not var_12_7)
				gohelper.setActive(arg_12_0._btnplay.gameObject, not var_12_7)
				gohelper.setActive(arg_12_0._btnstop.gameObject, var_12_7)

				if var_12_7 then
					arg_12_0:_setItemContentColor("#D56B39")
				end
			else
				gohelper.setActive(arg_12_0._gostopicon, false)
				gohelper.setActive(arg_12_0._goplayicon, false)
				gohelper.setActive(arg_12_0._btnplay.gameObject, false)
				gohelper.setActive(arg_12_0._btnstop.gameObject, false)
			end
		else
			gohelper.setActive(arg_12_0._gonorole, false)
			gohelper.setActive(arg_12_0._goname, false)

			if arg_12_0._audioId ~= 0 then
				local var_12_8 = arg_12_0._audioId == StoryLogListModel.instance:getPlayingLogAudioId()

				gohelper.setActive(arg_12_0._gostopicon, var_12_8)
				gohelper.setActive(arg_12_0._goplayicon, not var_12_8)
				gohelper.setActive(arg_12_0._btnplay.gameObject, not var_12_8)
				gohelper.setActive(arg_12_0._btnstop.gameObject, var_12_8)

				if var_12_8 then
					arg_12_0:_setItemContentColor("#D56B39")
					SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")
				end
			else
				gohelper.setActive(arg_12_0._gostopicon, false)
				gohelper.setActive(arg_12_0._goplayicon, false)
				gohelper.setActive(arg_12_0._btnplay.gameObject, false)
				gohelper.setActive(arg_12_0._btnstop.gameObject, false)
			end
		end

		if var_12_0.type == StoryEnum.ConversationType.Player or var_12_0.nameShow and var_12_0.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and var_12_0.type ~= StoryEnum.ConversationType.None and var_12_0.type ~= StoryEnum.ConversationType.ScreenDialog then
			gohelper.setActive(arg_12_0._goicon, true)
			arg_12_0:_setItemContentColor("#CCAD8F")
		else
			gohelper.setActive(arg_12_0._goicon, false)
		end
	elseif type(arg_12_1.info) == "table" then
		gohelper.setActive(arg_12_0._gonormal, false)
		gohelper.setActive(arg_12_0._gobranch, true)
		gohelper.setActive(arg_12_0._goplayicon, false)
		gohelper.setActive(arg_12_0._gostopicon, false)
		gohelper.setActive(arg_12_0._btnplay.gameObject, false)
		gohelper.setActive(arg_12_0._btnstop.gameObject, false)

		local var_12_9 = {
			false,
			false,
			false,
			false
		}
		local var_12_10 = StoryModel.instance:getStoryBranchOpts(arg_12_1.info.stepId)

		for iter_12_0, iter_12_1 in ipairs(var_12_10) do
			var_12_9[iter_12_0] = true
			arg_12_0._txtbranchs[iter_12_0].text = iter_12_1.branchTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

			if iter_12_0 == arg_12_1.info.index then
				arg_12_0._simagebranchs[iter_12_0]:LoadImage(ResUrl.getStoryItem("bg_xuanxiang_ovr.png"))
				ZProj.UGUIHelper.SetColorAlpha(arg_12_0._txtbranchs[iter_12_0], 1)
				gohelper.setActive(arg_12_0._goselects[iter_12_0], true)
			else
				arg_12_0._simagebranchs[iter_12_0]:LoadImage(ResUrl.getStoryItem("bg_xuanxiang.png"))
				ZProj.UGUIHelper.SetColorAlpha(arg_12_0._txtbranchs[iter_12_0], 0.7)
				gohelper.setActive(arg_12_0._goselects[iter_12_0], false)
			end
		end

		for iter_12_2 = 1, 4 do
			gohelper.setActive(arg_12_0._simagebranchs[iter_12_2].gameObject, var_12_9[iter_12_2])
		end
	end
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	return
end

function var_0_0._setItemContentColor(arg_15_0, arg_15_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtname, arg_15_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtcontent, arg_15_1)

	local var_15_0 = arg_15_0._conMark.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if var_15_0 then
		local var_15_1 = var_15_0:GetEnumerator()

		while var_15_1:MoveNext() do
			local var_15_2 = var_15_1.Current.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic))

			if var_15_2 then
				SLFramework.UGUI.GuiHelper.SetColor(var_15_2, arg_15_1)
			end
		end
	end

	TaskDispatcher.runDelay(function()
		if not arg_15_0._txtcontent then
			return
		end

		local var_16_0 = {}
		local var_16_1 = arg_15_0._txtcontent.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

		if var_16_1 then
			local var_16_2 = var_16_1:GetEnumerator()

			while var_16_2:MoveNext() do
				local var_16_3 = var_16_2.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

				table.insert(var_16_0, var_16_3)
			end
		end

		local var_16_4 = GameUtil.parseColor(arg_15_1 .. "FF")

		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			if iter_16_1.sharedMaterial then
				iter_16_1.sharedMaterial = UnityEngine.Object.Instantiate(iter_16_1.sharedMaterial)

				iter_16_1.materialForRendering:EnableKeyword("_GRADUAL_ON")
				iter_16_1.materialForRendering:SetColor("_Color", var_16_4)
			end
		end
	end, nil, 0.01)
end

function var_0_0.onDestroy(arg_17_0)
	if arg_17_0._audioId ~= 0 then
		StoryLogListModel.instance:setPlayingLogAudioFinished(arg_17_0._audioId)
		AudioEffectMgr.instance:stopAudio(arg_17_0._audioId, 0)
	end

	arg_17_0._btnplay:RemoveClickListener()
	arg_17_0._btnstop:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, arg_17_0._onItemSelected, arg_17_0)
	StoryController.instance:unregisterCallback(StoryEvent.LogAudioFinished, arg_17_0._onItemAudioFinished, arg_17_0)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._simagebranchs) do
		arg_17_0._simagebranchs[iter_17_0]:UnLoadImage()
	end

	arg_17_0._simagebranchs = nil
	arg_17_0._txtbranchs = nil
	arg_17_0._goselects = nil
end

return var_0_0
