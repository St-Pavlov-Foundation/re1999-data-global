module("modules.logic.dungeon.view.DungeonFragmentInfoView", package.seeall)

slot0 = class("DungeonFragmentInfoView", BaseView)
slot1 = -40

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._go1 = gohelper.findChild(slot0.viewGO, "#go_1")
	slot0._txttitlecn = gohelper.findChildText(slot0.viewGO, "#go_1/#txt_titlecn")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#go_1/#scroll_content")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#go_1/#scroll_content/Viewport/Content/#txt_content")
	slot0._gochatarea = gohelper.findChild(slot0.viewGO, "#go_1/#scroll_content/Viewport/Content/#go_chatarea")
	slot0._layoutchatarea = slot0._gochatarea:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	slot0._gochatitem = gohelper.findChild(slot0.viewGO, "#go_1/#scroll_content/Viewport/Content/#go_chatarea/#go_chatitem")
	slot0._gobottommask = gohelper.findChild(slot0.viewGO, "#go_1/#scroll_content/#go_bottommask")
	slot0._simagefragmenticon = gohelper.findChildSingleImage(slot0.viewGO, "#go_1/#simage_fragmenticon")
	slot0._go3 = gohelper.findChild(slot0.viewGO, "#go_3")
	slot0._txttitle3 = gohelper.findChildText(slot0.viewGO, "#go_3/#txt_title3")
	slot0._scrollcontent3 = gohelper.findChildScrollRect(slot0.viewGO, "#go_3/#scroll_content3")
	slot0._txtinfo3 = gohelper.findChildText(slot0.viewGO, "#go_3/#scroll_content3/Viewport/Content/#txt_info3")
	slot0._go4 = gohelper.findChild(slot0.viewGO, "#go_4")
	slot0._txttitle4 = gohelper.findChildText(slot0.viewGO, "#go_4/#txt_title4")
	slot0._scrollcontent4 = gohelper.findChildScrollRect(slot0.viewGO, "#go_4/#scroll_content4")
	slot0._txtinfo4 = gohelper.findChildText(slot0.viewGO, "#go_4/#scroll_content4/Viewport/Content/#txt_info4")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._scrollcontent:AddOnValueChanged(slot0._onValueChnaged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._scrollcontent:RemoveOnValueChanged()
end

slot0.FragmentInfoTypeMap = {
	1,
	1,
	3,
	4
}

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._pauseColor = GameUtil.parseColor("#3D3939")
	slot0._playColor = GameUtil.parseColor("#946747")
end

function slot0.onUpdateParam(slot0)
end

function slot0._showDialog(slot0, slot1, slot2, slot3, slot4)
	slot5 = gohelper.cloneInPlace(slot0._gochatitem)

	gohelper.setActive(slot5, true)

	gohelper.findChildText(slot5, "name").text = not string.nilorempty(slot3) and slot3 .. ":" or ""

	if not slot3 then
		gohelper.setActive(gohelper.findChild(slot5, "usericon"), true)
	end

	slot8 = gohelper.findChildText(slot5, "info")
	slot9 = IconMgr.instance:getCommonTextMarkTop(slot8.gameObject):GetComponent(gohelper.Type_TextMesh)
	slot10 = gohelper.onceAddComponent(slot8.gameObject, typeof(ZProj.TMPMark))

	slot10:SetMarkTopGo(slot9.gameObject)
	slot10:SetTopOffset(0, -0.5971)

	slot9.fontSize = 18
	slot8.text = StoryTool.filterMarkTop(slot2)

	TaskDispatcher.runDelay(function ()
		uv1:SetMarksTop(StoryTool.getMarkTopTextList(uv0))
	end, nil, 0.01)

	if gohelper.findChildButtonWithAudio(slot5, "play") and slot4 and slot4 > 0 then
		gohelper.setActive(slot12.gameObject, true)
		slot0:_initBtn(slot12, gohelper.findChildButtonWithAudio(slot5, "pause"), slot4, slot6, slot8)
	end
end

function slot0._initBtn(slot0, slot1, slot2, slot3, slot4, slot5)
	table.insert(slot0._btnList, {
		slot1,
		slot2,
		slot3,
		slot4,
		slot5
	})
	slot1:AddClickListener(slot0._onPlay, slot0, slot3)
	slot2:AddClickListener(slot0._onPause, slot0, slot3)
end

function slot0._onPlay(slot0, slot1)
	slot0:_stopAudio()

	slot0._audioId = slot1

	if not slot0._audioParam then
		slot0._audioParam = AudioParam.New()
	end

	slot0._audioParam.callback = slot0._onAudioStop
	slot0._audioParam.callbackTarget = slot0

	AudioEffectMgr.instance:playAudio(slot0._audioId, slot0._audioParam)
	slot0:_refreshBtnStatus(slot1, true)
end

function slot0._onPause(slot0, slot1)
	slot0:_stopAudio()
	slot0:_refreshBtnStatus(slot1, false)
end

function slot0._onAudioStop(slot0, slot1)
	slot0._audioId = nil

	slot0:_refreshBtnStatus(slot1, false)
end

function slot0._refreshBtnStatus(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._btnList) do
		if slot1 == slot7[3] then
			gohelper.setActive(slot7[1].gameObject, not slot2)
			gohelper.setActive(slot7[2].gameObject, slot2)

			slot7[4].color = slot2 and slot0._playColor or slot0._pauseColor
			slot7[5].color = slot2 and slot0._playColor or slot0._pauseColor
		else
			gohelper.setActive(slot8.gameObject, true)
			gohelper.setActive(slot9.gameObject, false)

			slot11.color = slot0._pauseColor
			slot12.color = slot0._pauseColor
		end
	end
end

function slot0._stopAudio(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end
end

function slot0._generateDialogByHandbook(slot0)
	slot3 = {}

	for slot7, slot8 in pairs(lua_chapter_map_element_dialog.configDict[HandbookConfig.instance:getDialogByFragment(slot0._fragmentId)]) do
		table.insert(slot3, slot8)
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.stepId < slot1.stepId
	end)

	slot4 = {
		[tonumber(slot9)] = true
	}

	for slot8, slot9 in ipairs(slot0._dialogIdList) do
		-- Nothing
	end

	slot5 = {}
	slot6 = 1

	while slot6 <= #slot3 do
		slot6 = slot0:_getSelectorResult(slot6, slot3, slot5, slot4, true) + 1
	end

	slot7 = true

	for slot11, slot12 in ipairs(slot5) do
		slot0:_showDialog(nil, slot12.text, slot12.speaker, slot12.audio)

		if slot12.audio and slot12.audio > 0 then
			slot7 = false
		end
	end

	slot8 = 0

	if slot7 then
		slot8 = uv0
	end

	slot0._layoutchatarea.padding.left = slot8
end

function slot0._getSelectorResult(slot0, slot1, slot2, slot3, slot4, slot5)
	while slot1 <= #slot2 do
		if slot2[slot1].type == "dialog" and slot5 then
			table.insert(slot3, {
				text = slot6.content,
				speaker = slot6.speaker,
				audio = slot6.audio
			})
		elseif slot6.type == "selector" then
			slot1 = slot0:_getSelectorResult(slot1 + 1, slot2, slot3, slot4, slot4[tonumber(slot6.param)])
		elseif slot6.type == "selectorend" then
			return slot1
		elseif slot6.type == "options" then
			for slot13, slot14 in ipairs(string.splitToNumber(slot6.param, "#")) do
				if LangSettings.instance:getCurLangShortcut() == "zh" then
					if slot4[slot14] then
						table.insert(slot3, {
							text = string.format("<color=#c95318>\"%s\"</color>", string.split(slot6.content, "#")[slot13])
						})

						break
					end
				elseif slot4[slot14] then
					table.insert(slot3, {
						text = string.format("<color=#c95318>%s</color>", slot8[slot13])
					})

					break
				end
			end
		end

		slot1 = slot1 + 1
	end

	return slot1
end

function slot0.onOpen(slot0)
	slot0._btnList = slot0:getUserDataTb_()
	slot0._elementId = slot0.viewParam.elementId
	slot0._fragmentId = slot0.viewParam.fragmentId
	slot0._dialogIdList = slot0.viewParam.dialogIdList
	slot0._isFromHandbook = slot0.viewParam.isFromHandbook
	slot0._notShowToast = slot0.viewParam.notShowToast
	slot1 = lua_chapter_map_fragment.configDict[slot0._fragmentId]

	for slot5 = 1, 4 do
		slot6 = uv0.FragmentInfoTypeMap[slot5] or 1

		gohelper.setActive(slot0["_go" .. slot6], slot6 == (uv0.FragmentInfoTypeMap[slot1.type] or 1))
	end

	if uv0["fragmentInfoShowHandleFunc" .. (uv0.FragmentInfoTypeMap[slot1.type] and slot1.type or 1)] then
		slot3(slot0, slot1)
	end

	if not DungeonEnum.NotPopFragmentToastDict[slot0._fragmentId] and not slot0._isFromHandbook and not slot0._notShowToast then
		if slot1.toastId and slot4 ~= 0 then
			GameFacade.showToast(slot4)
		else
			GameFacade.showToast(ToastEnum.DungeonFragmentInfo, slot1.title)
		end
	end

	if not string.nilorempty(slot1.res) then
		slot0._simagefragmenticon:LoadImage(ResUrl.getDungeonFragmentIcon(slot1.res))
	end

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
end

function slot0._onValueChnaged(slot0, slot1)
	gohelper.setActive(slot0._gobottommask, gohelper.getRemindFourNumberFloat(slot0._scrollcontent.verticalNormalizedPosition) > 0)
end

function slot0.onClose(slot0)
	slot0:_stopAudio()

	if slot0._elementId then
		DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, slot0._elementId)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagefragmenticon:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._btnList) do
		slot5[1]:RemoveClickListener()
		slot5[2]:RemoveClickListener()
	end
end

function slot0.fragmentInfoShowHandleFunc1(slot0, slot1)
	slot0._txtcontent.text = slot1.content
	slot0._txttitlecn.text = slot1.title

	gohelper.setActive(slot0._txtcontent.gameObject, true)
end

function slot0.fragmentInfoShowHandleFunc2(slot0, slot1)
	slot0._txttitlecn.text = slot1.title
	slot0._txtcontent.text = slot1.content

	gohelper.setActive(slot0._txtcontent.gameObject, true)
	gohelper.setActive(slot0._gochatarea, true)

	if slot0._isFromHandbook and slot0._dialogIdList then
		slot0:_generateDialogByHandbook()
	else
		slot2 = true

		for slot7, slot8 in ipairs(DungeonMapModel.instance:getDialog()) do
			slot0:_showDialog(slot8[1], slot8[2], slot8[3], slot8[4])

			if slot8[4] and slot8[4] > 0 then
				slot2 = false
			end
		end

		slot4 = 0

		if slot2 then
			slot4 = uv0
		end

		slot0._layoutchatarea.padding.left = slot4

		DungeonMapModel.instance:clearDialog()
		DungeonMapModel.instance:clearDialogId()
	end
end

function slot0.fragmentInfoShowHandleFunc3(slot0, slot1)
	slot0._txtinfo3.text = slot1.content
	slot0._txttitle3.text = slot1.title

	gohelper.setActive(slot0._txtinfo3.gameObject, true)

	if slot0._fragmentId == 32 and GameConfig:GetCurLangType() == LangSettings.jp then
		slot0._txtinfo3.alignment = TMPro.TextAlignmentOptions.Left
	end
end

function slot0.fragmentInfoShowHandleFunc4(slot0, slot1)
	slot0._txtinfo4.text = slot1.content
	slot0._txttitle4.text = slot1.title

	gohelper.setActive(slot0._txtinfo4.gameObject, true)
end

return slot0
