module("modules.logic.dungeon.view.DungeonFragmentInfoView", package.seeall)

local var_0_0 = class("DungeonFragmentInfoView", BaseView)
local var_0_1 = -40

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._go1 = gohelper.findChild(arg_1_0.viewGO, "#go_1")
	arg_1_0._txttitlecn = gohelper.findChildText(arg_1_0.viewGO, "#go_1/#txt_titlecn")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_1/#scroll_content")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#go_1/#scroll_content/Viewport/Content/#txt_content")
	arg_1_0._gochatarea = gohelper.findChild(arg_1_0.viewGO, "#go_1/#scroll_content/Viewport/Content/#go_chatarea")
	arg_1_0._layoutchatarea = arg_1_0._gochatarea:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	arg_1_0._gochatitem = gohelper.findChild(arg_1_0.viewGO, "#go_1/#scroll_content/Viewport/Content/#go_chatarea/#go_chatitem")
	arg_1_0._gobottommask = gohelper.findChild(arg_1_0.viewGO, "#go_1/#scroll_content/#go_bottommask")
	arg_1_0._simagefragmenticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_1/#simage_fragmenticon")
	arg_1_0._go3 = gohelper.findChild(arg_1_0.viewGO, "#go_3")
	arg_1_0._txttitle3 = gohelper.findChildText(arg_1_0.viewGO, "#go_3/#txt_title3")
	arg_1_0._scrollcontent3 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_3/#scroll_content3")
	arg_1_0._txtinfo3 = gohelper.findChildText(arg_1_0.viewGO, "#go_3/#scroll_content3/Viewport/Content/#txt_info3")
	arg_1_0._go4 = gohelper.findChild(arg_1_0.viewGO, "#go_4")
	arg_1_0._txttitle4 = gohelper.findChildText(arg_1_0.viewGO, "#go_4/#txt_title4")
	arg_1_0._scrollcontent4 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_4/#scroll_content4")
	arg_1_0._txtinfo4 = gohelper.findChildText(arg_1_0.viewGO, "#go_4/#scroll_content4/Viewport/Content/#txt_info4")
	arg_1_0._go5 = gohelper.findChild(arg_1_0.viewGO, "#go_5")
	arg_1_0._txttitle5 = gohelper.findChildText(arg_1_0.viewGO, "#go_5/#txt_titlecn")
	arg_1_0._scrollcontent5 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_5/#scroll_content")
	arg_1_0._txtinfo5 = gohelper.findChildText(arg_1_0.viewGO, "#go_5/#scroll_content/Viewport/Content/#txt_content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._scrollcontent:AddOnValueChanged(arg_2_0._onValueChnaged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._scrollcontent:RemoveOnValueChanged()
end

var_0_0.FragmentInfoTypeMap = {
	1,
	1,
	3,
	4,
	5
}

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._pauseColor = GameUtil.parseColor("#3D3939")
	arg_5_0._playColor = GameUtil.parseColor("#946747")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0._showDialog(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = gohelper.cloneInPlace(arg_7_0._gochatitem)

	gohelper.setActive(var_7_0, true)

	local var_7_1 = gohelper.findChildText(var_7_0, "name")

	var_7_1.text = not string.nilorempty(arg_7_3) and arg_7_3 .. ":" or ""

	if not arg_7_3 then
		local var_7_2 = gohelper.findChild(var_7_0, "usericon")

		gohelper.setActive(var_7_2, true)
	end

	local var_7_3 = gohelper.findChildText(var_7_0, "info")
	local var_7_4 = var_7_3.gameObject
	local var_7_5 = IconMgr.instance:getCommonTextMarkTop(var_7_4):GetComponent(gohelper.Type_TextMesh)
	local var_7_6 = gohelper.onceAddComponent(var_7_4, typeof(ZProj.TMPMark))

	var_7_6:SetMarkTopGo(var_7_5.gameObject)

	local var_7_7 = StoryTool.filterMarkTop(arg_7_2)

	var_7_6:SetTopOffset(0, -0.5971)

	var_7_5.fontSize = 18
	var_7_3.text = var_7_7

	local var_7_8 = StoryTool.getMarkTopTextList(arg_7_2)
	local var_7_9 = {
		commontextmarktopTextList = arg_7_0:getUserDataTb_()
	}

	if #var_7_8 > 0 then
		TaskDispatcher.runDelay(function()
			if gohelper.isNil(var_7_4) then
				return
			end

			var_7_6:SetMarksTop(var_7_8)

			local var_8_0 = var_7_4.transform
			local var_8_1 = var_8_0.childCount

			for iter_8_0 = 1, var_8_1 do
				local var_8_2 = var_8_0:GetChild(iter_8_0 - 1).gameObject

				if var_8_2.name == "commontextmarktop(Clone)" then
					table.insert(var_7_9.commontextmarktopTextList, var_8_2:GetComponent(gohelper.Type_TextMesh))
				end
			end
		end, nil, 0.01)
	end

	local var_7_10 = gohelper.findChildButtonWithAudio(var_7_0, "play")
	local var_7_11 = gohelper.findChildButtonWithAudio(var_7_0, "pause")

	if var_7_10 and arg_7_4 and arg_7_4 > 0 then
		gohelper.setActive(var_7_10.gameObject, true)
		arg_7_0:_initBtn(var_7_10, var_7_11, arg_7_4, var_7_1, var_7_3)

		local var_7_12 = arg_7_0._btnList[#arg_7_0._btnList]

		table.insert(var_7_12, var_7_9)
	end
end

function var_0_0._initBtn(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	table.insert(arg_9_0._btnList, {
		arg_9_1,
		arg_9_2,
		arg_9_3,
		arg_9_4,
		arg_9_5
	})
	arg_9_1:AddClickListener(arg_9_0._onPlay, arg_9_0, arg_9_3)
	arg_9_2:AddClickListener(arg_9_0._onPause, arg_9_0, arg_9_3)
end

function var_0_0._onPlay(arg_10_0, arg_10_1)
	arg_10_0:_stopAudio()

	arg_10_0._audioId = arg_10_1

	if not arg_10_0._audioParam then
		arg_10_0._audioParam = AudioParam.New()
	end

	arg_10_0._audioParam.callback = arg_10_0._onAudioStop
	arg_10_0._audioParam.callbackTarget = arg_10_0

	AudioEffectMgr.instance:playAudio(arg_10_0._audioId, arg_10_0._audioParam)
	arg_10_0:_refreshBtnStatus(arg_10_1, true)
end

function var_0_0._onPause(arg_11_0, arg_11_1)
	arg_11_0:_stopAudio()
	arg_11_0:_refreshBtnStatus(arg_11_1, false)
end

function var_0_0._onAudioStop(arg_12_0, arg_12_1)
	arg_12_0._audioId = nil

	arg_12_0:_refreshBtnStatus(arg_12_1, false)
end

function var_0_0._refreshBtnStatus(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._btnList) do
		local var_13_0 = iter_13_1[1]
		local var_13_1 = iter_13_1[2]
		local var_13_2 = iter_13_1[3]
		local var_13_3 = iter_13_1[4]
		local var_13_4 = iter_13_1[5]
		local var_13_5 = iter_13_1[#iter_13_1].commontextmarktopTextList

		for iter_13_2, iter_13_3 in ipairs(var_13_5) do
			iter_13_3.color = arg_13_2 and arg_13_1 == var_13_2 and arg_13_0._playColor or arg_13_0._pauseColor
		end

		if arg_13_1 == var_13_2 then
			gohelper.setActive(var_13_0.gameObject, not arg_13_2)
			gohelper.setActive(var_13_1.gameObject, arg_13_2)

			var_13_3.color = arg_13_2 and arg_13_0._playColor or arg_13_0._pauseColor
			var_13_4.color = arg_13_2 and arg_13_0._playColor or arg_13_0._pauseColor
		else
			gohelper.setActive(var_13_0.gameObject, true)
			gohelper.setActive(var_13_1.gameObject, false)

			var_13_3.color = arg_13_0._pauseColor
			var_13_4.color = arg_13_0._pauseColor
		end
	end
end

function var_0_0._stopAudio(arg_14_0)
	if arg_14_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_14_0._audioId)

		arg_14_0._audioId = nil
	end
end

function var_0_0._generateDialogByHandbook(arg_15_0)
	local var_15_0 = HandbookConfig.instance:getDialogByFragment(arg_15_0._fragmentId)
	local var_15_1 = lua_chapter_map_element_dialog.configDict[var_15_0]
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		table.insert(var_15_2, iter_15_1)
	end

	table.sort(var_15_2, function(arg_16_0, arg_16_1)
		return arg_16_0.stepId < arg_16_1.stepId
	end)

	local var_15_3 = {}

	for iter_15_2, iter_15_3 in ipairs(arg_15_0._dialogIdList) do
		var_15_3[tonumber(iter_15_3)] = true
	end

	local var_15_4 = {}
	local var_15_5 = 1

	while var_15_5 <= #var_15_2 do
		var_15_5 = arg_15_0:_getSelectorResult(var_15_5, var_15_2, var_15_4, var_15_3, true)
		var_15_5 = var_15_5 + 1
	end

	local var_15_6 = true

	for iter_15_4, iter_15_5 in ipairs(var_15_4) do
		arg_15_0:_showDialog(nil, iter_15_5.text, iter_15_5.speaker, iter_15_5.audio)

		if iter_15_5.audio and iter_15_5.audio > 0 then
			var_15_6 = false
		end
	end

	local var_15_7 = 0

	if var_15_6 then
		var_15_7 = var_0_1
	end

	arg_15_0._layoutchatarea.padding.left = var_15_7
end

function var_0_0._getSelectorResult(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	while arg_17_1 <= #arg_17_2 do
		local var_17_0 = arg_17_2[arg_17_1]

		if var_17_0.type == "dialog" and arg_17_5 then
			table.insert(arg_17_3, {
				text = var_17_0.content,
				speaker = var_17_0.speaker,
				audio = var_17_0.audio
			})
		elseif var_17_0.type == "selector" then
			arg_17_1 = arg_17_0:_getSelectorResult(arg_17_1 + 1, arg_17_2, arg_17_3, arg_17_4, arg_17_4[tonumber(var_17_0.param)])
		elseif var_17_0.type == "selectorend" then
			return arg_17_1
		elseif var_17_0.type == "options" then
			local var_17_1 = string.splitToNumber(var_17_0.param, "#")
			local var_17_2 = string.split(var_17_0.content, "#")
			local var_17_3 = LangSettings.instance:getCurLangShortcut()

			for iter_17_0, iter_17_1 in ipairs(var_17_1) do
				if var_17_3 == "zh" then
					if arg_17_4[iter_17_1] then
						table.insert(arg_17_3, {
							text = string.format("<color=#c95318>\"%s\"</color>", var_17_2[iter_17_0])
						})

						break
					end
				elseif arg_17_4[iter_17_1] then
					table.insert(arg_17_3, {
						text = string.format("<color=#c95318>%s</color>", var_17_2[iter_17_0])
					})

					break
				end
			end
		end

		arg_17_1 = arg_17_1 + 1
	end

	return arg_17_1
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0._btnList = arg_18_0:getUserDataTb_()
	arg_18_0._elementId = arg_18_0.viewParam.elementId
	arg_18_0._fragmentId = arg_18_0.viewParam.fragmentId
	arg_18_0._dialogIdList = arg_18_0.viewParam.dialogIdList
	arg_18_0._isFromHandbook = arg_18_0.viewParam.isFromHandbook
	arg_18_0._notShowToast = arg_18_0.viewParam.notShowToast

	local var_18_0 = lua_chapter_map_fragment.configDict[arg_18_0._fragmentId]

	for iter_18_0 = 1, 5 do
		local var_18_1 = var_0_0.FragmentInfoTypeMap[iter_18_0] or 1

		gohelper.setActive(arg_18_0["_go" .. var_18_1], var_18_1 == (var_0_0.FragmentInfoTypeMap[var_18_0.type] or 1))
	end

	local var_18_2 = var_0_0.FragmentInfoTypeMap[var_18_0.type] and var_18_0.type or 1
	local var_18_3 = var_0_0["fragmentInfoShowHandleFunc" .. var_18_2]

	if var_18_3 then
		var_18_3(arg_18_0, var_18_0)
	end

	if not DungeonEnum.NotPopFragmentToastDict[arg_18_0._fragmentId] and not arg_18_0._isFromHandbook and not arg_18_0._notShowToast then
		local var_18_4 = var_18_0.toastId

		if var_18_4 and var_18_4 ~= 0 then
			GameFacade.showToast(var_18_4)
		else
			GameFacade.showToast(ToastEnum.DungeonFragmentInfo, var_18_0.title)
		end
	end

	if not string.nilorempty(var_18_0.res) then
		arg_18_0._simagefragmenticon:LoadImage(ResUrl.getDungeonFragmentIcon(var_18_0.res))
	end

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
end

function var_0_0._onValueChnaged(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._gobottommask, gohelper.getRemindFourNumberFloat(arg_19_0._scrollcontent.verticalNormalizedPosition) > 0)
end

function var_0_0.onClose(arg_20_0)
	arg_20_0:_stopAudio()

	if arg_20_0._elementId then
		DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, arg_20_0._elementId)
	end
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagefragmenticon:UnLoadImage()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._btnList) do
		iter_21_1[1]:RemoveClickListener()
		iter_21_1[2]:RemoveClickListener()
	end
end

function var_0_0.fragmentInfoShowHandleFunc1(arg_22_0, arg_22_1)
	arg_22_0._txtcontent.text = arg_22_1.content
	arg_22_0._txttitlecn.text = arg_22_1.title

	gohelper.setActive(arg_22_0._txtcontent.gameObject, true)
end

function var_0_0.fragmentInfoShowHandleFunc2(arg_23_0, arg_23_1)
	arg_23_0._txttitlecn.text = arg_23_1.title
	arg_23_0._txtcontent.text = arg_23_1.content

	gohelper.setActive(arg_23_0._txtcontent.gameObject, true)
	gohelper.setActive(arg_23_0._gochatarea, true)

	if arg_23_0._isFromHandbook and arg_23_0._dialogIdList then
		arg_23_0:_generateDialogByHandbook()
	else
		local var_23_0 = true
		local var_23_1 = DungeonMapModel.instance:getDialog()

		for iter_23_0, iter_23_1 in ipairs(var_23_1) do
			arg_23_0:_showDialog(iter_23_1[1], iter_23_1[2], iter_23_1[3], iter_23_1[4])

			if iter_23_1[4] and iter_23_1[4] > 0 then
				var_23_0 = false
			end
		end

		local var_23_2 = 0

		if var_23_0 then
			var_23_2 = var_0_1
		end

		arg_23_0._layoutchatarea.padding.left = var_23_2

		DungeonMapModel.instance:clearDialog()
		DungeonMapModel.instance:clearDialogId()
	end
end

function var_0_0.fragmentInfoShowHandleFunc3(arg_24_0, arg_24_1)
	arg_24_0._txtinfo3.text = arg_24_1.content
	arg_24_0._txttitle3.text = arg_24_1.title

	gohelper.setActive(arg_24_0._txtinfo3.gameObject, true)

	if arg_24_0._fragmentId == 32 and GameConfig:GetCurLangType() == LangSettings.jp then
		arg_24_0._txtinfo3.alignment = TMPro.TextAlignmentOptions.Left
	end
end

function var_0_0.fragmentInfoShowHandleFunc4(arg_25_0, arg_25_1)
	arg_25_0._txtinfo4.text = arg_25_1.content
	arg_25_0._txttitle4.text = arg_25_1.title

	gohelper.setActive(arg_25_0._txtinfo4.gameObject, true)
end

function var_0_0.fragmentInfoShowHandleFunc5(arg_26_0, arg_26_1)
	arg_26_0._txtinfo5.text = arg_26_1.content
	arg_26_0._txttitle5.text = arg_26_1.title

	gohelper.setActive(arg_26_0._txtinfo5.gameObject, true)
end

return var_0_0
