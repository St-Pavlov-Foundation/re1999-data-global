module("modules.logic.story.view.StoryLogItem", package.seeall)

slot0 = class("StoryLogItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._goname = gohelper.findChild(slot0.viewGO, "#go_normal/#go_name")
	slot0._goplayicon = gohelper.findChild(slot0.viewGO, "#go_normal/#go_playicon")
	slot0._gostopicon = gohelper.findChild(slot0.viewGO, "#go_normal/#go_stopicon")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_normal/#go_name/#go_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_normal/#go_name/#txt_name")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_content")
	slot0._gonorole = gohelper.findChild(slot0.viewGO, "#go_normal/#go_norole")
	slot0._gobranch = gohelper.findChild(slot0.viewGO, "#go_branch")
	slot0._simagebranch1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_branch/#simage_branch1")
	slot0._txtbranch1 = gohelper.findChildText(slot0.viewGO, "#go_branch/#simage_branch1/#txt_branch1")
	slot0._simagebranch2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_branch/#simage_branch2")
	slot0._txtbranch2 = gohelper.findChildText(slot0.viewGO, "#go_branch/#simage_branch2/#txt_branch2")
	slot0._simagebranch3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_branch/#simage_branch3")
	slot0._txtbranch3 = gohelper.findChildText(slot0.viewGO, "#go_branch/#simage_branch3/#txt_branch3")
	slot0._simagebranch4 = gohelper.findChildSingleImage(slot0.viewGO, "#go_branch/#simage_branch4")
	slot0._txtbranch4 = gohelper.findChildText(slot0.viewGO, "#go_branch/#simage_branch4/#txt_branch4")
	slot0._btnplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_play")
	slot0._btnstop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_stop")
	slot0._goselect1 = gohelper.findChild(slot0.viewGO, "#go_branch/#simage_branch1/#go_select1")
	slot0._goselect2 = gohelper.findChild(slot0.viewGO, "#go_branch/#simage_branch2/#go_select2")
	slot0._goselect3 = gohelper.findChild(slot0.viewGO, "#go_branch/#simage_branch3/#go_select3")
	slot0._goselect4 = gohelper.findChild(slot0.viewGO, "#go_branch/#simage_branch4/#go_select4")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtbranchs = {
		slot0._txtbranch1,
		slot0._txtbranch2,
		slot0._txtbranch3,
		slot0._txtbranch4
	}
	slot0._simagebranchs = {
		slot0._simagebranch1,
		slot0._simagebranch2,
		slot0._simagebranch3,
		slot0._simagebranch4
	}
	slot0._goselects = {
		slot0._goselect1,
		slot0._goselect2,
		slot0._goselect3,
		slot0._goselect4
	}

	slot0._btnplay:AddClickListener(slot0._onPlayClick, slot0)
	slot0._btnstop:AddClickListener(slot0._onStopClick, slot0)
	StoryController.instance:registerCallback(StoryEvent.LogSelected, slot0._onItemSelected, slot0)
	StoryController.instance:registerCallback(StoryEvent.LogAudioFinished, slot0._onItemAudioFinished, slot0)

	slot0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(slot0._txtcontent.gameObject):GetComponent(gohelper.Type_TextMesh)
	slot0._conMark = gohelper.onceAddComponent(slot0._txtcontent.gameObject, typeof(ZProj.TMPMark))

	slot0._conMark:SetMarkTopGo(slot0._txtmarktop.gameObject)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._onItemAudioFinished(slot0)
	if slot0._hasLowPassAudio then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Lowpass)

		slot0._hasLowPassAudio = false
	end

	if not slot0._audioId or slot0._audioId == 0 then
		return
	end

	if not slot0._mo or type(slot0._mo.info) ~= "number" then
		return
	end

	if slot0._audioId == StoryLogListModel.instance:getPlayingLogAudioId() then
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._goplayicon, true)
		gohelper.setActive(slot0._btnplay.gameObject, true)
		gohelper.setActive(slot0._btnstop.gameObject, false)

		if StoryStepModel.instance:getStepListById(slot0._mo.info).conversation.type == StoryEnum.ConversationType.Player or slot1.nameShow and slot1.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and slot1.type ~= StoryEnum.ConversationType.None and slot1.type ~= StoryEnum.ConversationType.ScreenDialog then
			slot0:_setItemContentColor("#CCAD8F")
		else
			slot0:_setItemContentColor("#EEF1E8")
			SLFramework.UGUI.GuiHelper.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
		end
	end
end

function slot0._onItemSelected(slot0, slot1)
	if not slot1 or slot1 == 0 or not slot0._audioId or slot0._audioId == 0 then
		return
	end

	if slot0._audioId == slot1 then
		return
	end

	if type(slot0._mo.info) == "number" then
		if StoryStepModel.instance:getStepListById(slot0._mo.info).conversation.type == StoryEnum.ConversationType.None then
			gohelper.setActive(slot0._goplayicon, false)
			gohelper.setActive(slot0._gostopicon, false)
			gohelper.setActive(slot0._btnplay.gameObject, false)
			gohelper.setActive(slot0._btnstop.gameObject, false)

			return
		end

		if slot0._audioId ~= 0 then
			AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
			gohelper.setActive(slot0._goplayicon, true)
			gohelper.setActive(slot0._gostopicon, false)
			gohelper.setActive(slot0._btnplay.gameObject, true)
			gohelper.setActive(slot0._btnstop.gameObject, false)
		else
			gohelper.setActive(slot0._goplayicon, false)
			gohelper.setActive(slot0._gostopicon, false)
			gohelper.setActive(slot0._btnplay.gameObject, false)
			gohelper.setActive(slot0._btnstop.gameObject, false)
		end
	elseif type(slot0._mo.info) == "table" then
		gohelper.setActive(slot0._goplayicon, false)
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._btnplay.gameObject, false)
		gohelper.setActive(slot0._btnstop.gameObject, false)
	end
end

function slot0._onPlayClick(slot0)
	gohelper.setActive(slot0._gostopicon, true)
	gohelper.setActive(slot0._goplayicon, false)
	gohelper.setActive(slot0._btnplay.gameObject, false)
	gohelper.setActive(slot0._btnstop.gameObject, true)
	slot0:_setItemContentColor("#D56B39")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")

	if slot0._audioId ~= 0 and StoryLogListModel.instance:getPlayingLogAudioId() ~= slot0._audioId then
		AudioEffectMgr.instance:stopAudio(StoryLogListModel.instance:getPlayingLogAudioId(), 0)
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
	end

	AudioEffectMgr.instance:playAudio(slot0._audioId, {
		loopNum = 1,
		fadeInTime = 0,
		fadeOutTime = 0,
		volume = 100,
		callback = slot0._onAudioFinished,
		callbackTarget = slot0
	})
	StoryLogListModel.instance:setPlayingLogAudio(slot0._audioId)
	StoryController.instance:dispatchEvent(StoryEvent.LogSelected, slot0._audioId)

	if #StoryStepModel.instance:getStepListById(slot0._mo.info).conversation.audios > 1 then
		for slot6, slot7 in pairs(slot2.audios) do
			if slot7 == AudioEnum.Story.Play_Lowpass then
				slot0._hasLowPassAudio = true

				AudioMgr.instance:trigger(AudioEnum.Story.Play_Lowpass)

				break
			end
		end
	end
end

function slot0._onStopClick(slot0)
	gohelper.setActive(slot0._gostopicon, false)
	gohelper.setActive(slot0._goplayicon, true)
	gohelper.setActive(slot0._btnplay.gameObject, true)
	gohelper.setActive(slot0._btnstop.gameObject, false)

	if StoryStepModel.instance:getStepListById(slot0._mo.info).conversation.type == StoryEnum.ConversationType.Player or slot1.nameShow and slot1.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and slot1.type ~= StoryEnum.ConversationType.None and slot1.type ~= StoryEnum.ConversationType.ScreenDialog then
		slot0:_setItemContentColor("#CCAD8F")
	else
		slot0:_setItemContentColor("#EEF1E8")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end

	StoryLogListModel.instance:setPlayingLogAudioFinished(slot0._audioId)
	AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
end

function slot0._onAudioFinished(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.LogAudioFinished)

	if slot0._audioId ~= StoryLogListModel.instance:getPlayingLogAudioId() then
		StoryLogListModel.instance:setPlayingLogAudio(0)
	end

	if slot0._audioId == 0 then
		return
	end

	StoryLogListModel.instance:setPlayingLogAudioFinished(slot0._audioId)
	gohelper.setActive(slot0._gostopicon, false)
	gohelper.setActive(slot0._goplayicon, true)
	gohelper.setActive(slot0._btnplay.gameObject, true)
	gohelper.setActive(slot0._btnstop.gameObject, false)

	if StoryStepModel.instance:getStepListById(slot0._mo.info).conversation.type == StoryEnum.ConversationType.Player or slot1.nameShow and slot1.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and slot1.type ~= StoryEnum.ConversationType.None and slot1.type ~= StoryEnum.ConversationType.ScreenDialog then
		slot0:_setItemContentColor("#CCAD8F")
	else
		slot0:_setItemContentColor("#EEF1E8")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._mo = slot1

	slot0:_setItemContentColor("#EEF1E8")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")

	if type(slot1.info) == "number" then
		gohelper.setActive(slot0._gonormal, true)
		gohelper.setActive(slot0._gobranch, false)

		slot4 = string.find(StoryStepModel.instance:getStepListById(slot1.info).conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "<voffset") and slot3.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] or GameUtil.filterRichText(slot3.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

		if SDKModel.instance:isDmm() and LangSettings.instance:isJp() then
			if StoryController.instance._curStoryId == 100601 and slot1.info == 36 then
				slot4 = "はっ！　正気の沙汰じゃない。一家そろって◯◯◯だぞ！"
			elseif slot5 == 100602 and slot6 == 30 then
				slot4 = "あんたらがマヌス・ヴェンデッタの仮面を研究したおかげで、その副作用が徹底的に分かったぜ！　おかげで、ラプラスの廊下は身体のあちこちから石油を垂らす◯◯◯で埋まっちまったがな。"
			elseif slot5 == 100726 and slot6 == 32 then
				slot4 = "ははは！　死ね、無様な◯◯◯どもが！！"
			end
		end

		slot0._audioId = slot3.audios[1] or 0
		slot4 = StoryModel.instance:getStoryTxtByVoiceType(StoryTool.getFilterDia(slot4), slot0._audioId)
		slot5 = StoryTool.getMarkTopTextList(slot4)

		if slot3.effType == StoryEnum.ConversationEffectType.Magic then
			slot4 = StoryConfig.instance:replaceStoryMagicText(StoryTool.filterMarkTop(slot4))
		end

		slot0._txtcontent.text = StoryTool.filterSpTag(slot4)

		TaskDispatcher.runDelay(function ()
			if uv0._conMark then
				uv0._conMark:SetMarksTop(uv1)
			end
		end, nil, 0.01)

		if slot3.type ~= StoryEnum.ConversationType.Aside then
			gohelper.setActive(slot0._gonorole, false)

			if not slot3.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] or slot3.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == "" or not slot3.nameShow then
				gohelper.setActive(slot0._goname, false)
			elseif slot2 == 1 then
				gohelper.setActive(slot0._goname, false)
			else
				slot0._txtname.text = string.format("%s:", string.split(slot3.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "_")[1])

				gohelper.setActive(slot0._goname, true)
			end

			if slot0._audioId ~= 0 then
				slot6 = slot0._audioId == StoryLogListModel.instance:getPlayingLogAudioId()

				gohelper.setActive(slot0._gostopicon, slot6)
				gohelper.setActive(slot0._goplayicon, not slot6)
				gohelper.setActive(slot0._btnplay.gameObject, not slot6)
				gohelper.setActive(slot0._btnstop.gameObject, slot6)

				if slot6 then
					slot0:_setItemContentColor("#D56B39")
				end
			else
				gohelper.setActive(slot0._gostopicon, false)
				gohelper.setActive(slot0._goplayicon, false)
				gohelper.setActive(slot0._btnplay.gameObject, false)
				gohelper.setActive(slot0._btnstop.gameObject, false)
			end
		else
			gohelper.setActive(slot0._gonorole, false)
			gohelper.setActive(slot0._goname, false)

			if slot0._audioId ~= 0 then
				slot6 = slot0._audioId == StoryLogListModel.instance:getPlayingLogAudioId()

				gohelper.setActive(slot0._gostopicon, slot6)
				gohelper.setActive(slot0._goplayicon, not slot6)
				gohelper.setActive(slot0._btnplay.gameObject, not slot6)
				gohelper.setActive(slot0._btnstop.gameObject, slot6)

				if slot6 then
					slot0:_setItemContentColor("#D56B39")
					SLFramework.UGUI.GuiHelper.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")
				end
			else
				gohelper.setActive(slot0._gostopicon, false)
				gohelper.setActive(slot0._goplayicon, false)
				gohelper.setActive(slot0._btnplay.gameObject, false)
				gohelper.setActive(slot0._btnstop.gameObject, false)
			end
		end

		if slot3.type == StoryEnum.ConversationType.Player or slot3.nameShow and slot3.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == luaLang("mainrolename") and slot3.type ~= StoryEnum.ConversationType.None and slot3.type ~= StoryEnum.ConversationType.ScreenDialog then
			gohelper.setActive(slot0._goicon, true)
			slot0:_setItemContentColor("#CCAD8F")
		else
			gohelper.setActive(slot0._goicon, false)
		end

		return
	end

	if type(slot1.info) == "table" then
		gohelper.setActive(slot0._gonormal, false)
		gohelper.setActive(slot0._gobranch, true)
		gohelper.setActive(slot0._goplayicon, false)
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._btnplay.gameObject, false)
		gohelper.setActive(slot0._btnstop.gameObject, false)

		slot3 = {
			false,
			false,
			false,
			false,
			[slot8] = true
		}

		for slot8, slot9 in ipairs(StoryModel.instance:getStoryBranchOpts(slot1.info.stepId)) do
			slot0._txtbranchs[slot8].text = slot9.branchTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

			if slot8 == slot1.info.index then
				slot0._simagebranchs[slot8]:LoadImage(ResUrl.getStoryItem("bg_xuanxiang_ovr.png"))
				ZProj.UGUIHelper.SetColorAlpha(slot0._txtbranchs[slot8], 1)
				gohelper.setActive(slot0._goselects[slot8], true)
			else
				slot0._simagebranchs[slot8]:LoadImage(ResUrl.getStoryItem("bg_xuanxiang.png"))
				ZProj.UGUIHelper.SetColorAlpha(slot0._txtbranchs[slot8], 0.7)
				gohelper.setActive(slot0._goselects[slot8], false)
			end
		end

		for slot8 = 1, 4 do
			gohelper.setActive(slot0._simagebranchs[slot8].gameObject, slot3[slot8])
		end
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0._setItemContentColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcontent, slot1)

	if slot0._conMark.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic)) then
		slot3 = slot2:GetEnumerator()

		while slot3:MoveNext() do
			if slot3.Current.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic)) then
				SLFramework.UGUI.GuiHelper.SetColor(slot4, slot1)
			end
		end
	end

	TaskDispatcher.runDelay(function ()
		if not uv0._txtcontent then
			return
		end

		slot0 = {}

		if uv0._txtcontent.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true) then
			slot2 = slot1:GetEnumerator()

			while slot2:MoveNext() do
				table.insert(slot0, slot2.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI)))
			end
		end

		for slot6, slot7 in pairs(slot0) do
			if slot7.sharedMaterial then
				slot7.sharedMaterial = UnityEngine.Object.Instantiate(slot7.sharedMaterial)

				slot7.materialForRendering:EnableKeyword("_GRADUAL_ON")
				slot7.materialForRendering:SetColor("_Color", GameUtil.parseColor(uv1 .. "FF"))
			end
		end
	end, nil, 0.01)
end

function slot0.onDestroy(slot0)
	if slot0._audioId ~= 0 then
		StoryLogListModel.instance:setPlayingLogAudioFinished(slot0._audioId)
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
	end

	slot0._btnplay:RemoveClickListener()
	slot0._btnstop:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, slot0._onItemSelected, slot0)

	slot4 = slot0._onItemAudioFinished
	slot5 = slot0

	StoryController.instance:unregisterCallback(StoryEvent.LogAudioFinished, slot4, slot5)

	for slot4, slot5 in ipairs(slot0._simagebranchs) do
		slot0._simagebranchs[slot4]:UnLoadImage()
	end

	slot0._simagebranchs = nil
	slot0._txtbranchs = nil
	slot0._goselects = nil
end

return slot0
