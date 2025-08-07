module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonFragmentInfoView", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonFragmentInfoView", BaseView)
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

	var_7_3.text = arg_7_2

	local var_7_4 = gohelper.findChildButtonWithAudio(var_7_0, "play")
	local var_7_5 = gohelper.findChildButtonWithAudio(var_7_0, "pause")

	if var_7_4 and arg_7_4 and arg_7_4 > 0 then
		gohelper.setActive(var_7_4.gameObject, true)
		arg_7_0:_initBtn(var_7_4, var_7_5, arg_7_4, var_7_1, var_7_3)
	end
end

function var_0_0._initBtn(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	table.insert(arg_8_0._btnList, {
		arg_8_1,
		arg_8_2,
		arg_8_3,
		arg_8_4,
		arg_8_5
	})
	arg_8_1:AddClickListener(arg_8_0._onPlay, arg_8_0, arg_8_3)
	arg_8_2:AddClickListener(arg_8_0._onPause, arg_8_0, arg_8_3)
end

function var_0_0._onPlay(arg_9_0, arg_9_1)
	arg_9_0:_stopAudio()

	arg_9_0._audioId = arg_9_1

	if not arg_9_0._audioParam then
		arg_9_0._audioParam = AudioParam.New()
	end

	arg_9_0._audioParam.callback = arg_9_0._onAudioStop
	arg_9_0._audioParam.callbackTarget = arg_9_0

	AudioEffectMgr.instance:playAudio(arg_9_0._audioId, arg_9_0._audioParam)
	arg_9_0:_refreshBtnStatus(arg_9_1, true)
end

function var_0_0._onPause(arg_10_0, arg_10_1)
	arg_10_0:_stopAudio()
	arg_10_0:_refreshBtnStatus(arg_10_1, false)
end

function var_0_0._onAudioStop(arg_11_0, arg_11_1)
	arg_11_0._audioId = nil

	arg_11_0:_refreshBtnStatus(arg_11_1, false)
end

function var_0_0._refreshBtnStatus(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._btnList) do
		local var_12_0 = iter_12_1[1]
		local var_12_1 = iter_12_1[2]
		local var_12_2 = iter_12_1[3]
		local var_12_3 = iter_12_1[4]
		local var_12_4 = iter_12_1[5]

		if arg_12_1 == var_12_2 then
			gohelper.setActive(var_12_0.gameObject, not arg_12_2)
			gohelper.setActive(var_12_1.gameObject, arg_12_2)

			var_12_3.color = arg_12_2 and arg_12_0._playColor or arg_12_0._pauseColor
			var_12_4.color = arg_12_2 and arg_12_0._playColor or arg_12_0._pauseColor
		else
			gohelper.setActive(var_12_0.gameObject, true)
			gohelper.setActive(var_12_1.gameObject, false)

			var_12_3.color = arg_12_0._pauseColor
			var_12_4.color = arg_12_0._pauseColor
		end
	end
end

function var_0_0._stopAudio(arg_13_0)
	if arg_13_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_13_0._audioId)

		arg_13_0._audioId = nil
	end
end

function var_0_0._generateDialogByHandbook(arg_14_0)
	local var_14_0 = HandbookConfig.instance:getDialogByFragment(arg_14_0._fragmentId)
	local var_14_1 = lua_chapter_map_element_dialog.configDict[var_14_0]
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		table.insert(var_14_2, iter_14_1)
	end

	table.sort(var_14_2, function(arg_15_0, arg_15_1)
		return arg_15_0.stepId < arg_15_1.stepId
	end)

	local var_14_3 = {}

	for iter_14_2, iter_14_3 in ipairs(arg_14_0._dialogIdList) do
		var_14_3[tonumber(iter_14_3)] = true
	end

	local var_14_4 = {}
	local var_14_5 = 1

	while var_14_5 <= #var_14_2 do
		var_14_5 = arg_14_0:_getSelectorResult(var_14_5, var_14_2, var_14_4, var_14_3, true)
		var_14_5 = var_14_5 + 1
	end

	local var_14_6 = true

	for iter_14_4, iter_14_5 in ipairs(var_14_4) do
		arg_14_0:_showDialog(nil, iter_14_5.text, iter_14_5.speaker, iter_14_5.audio)

		if iter_14_5.audio and iter_14_5.audio > 0 then
			var_14_6 = false
		end
	end

	local var_14_7 = 0

	if var_14_6 then
		var_14_7 = var_0_1
	end

	arg_14_0._layoutchatarea.padding.left = var_14_7
end

function var_0_0._getSelectorResult(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	while arg_16_1 <= #arg_16_2 do
		local var_16_0 = arg_16_2[arg_16_1]

		if var_16_0.type == "dialog" and arg_16_5 then
			table.insert(arg_16_3, {
				text = var_16_0.content,
				speaker = var_16_0.speaker,
				audio = var_16_0.audio
			})
		elseif var_16_0.type == "selector" then
			arg_16_1 = arg_16_0:_getSelectorResult(arg_16_1 + 1, arg_16_2, arg_16_3, arg_16_4, arg_16_4[tonumber(var_16_0.param)])
		elseif var_16_0.type == "selectorend" then
			return arg_16_1
		elseif var_16_0.type == "options" then
			local var_16_1 = string.splitToNumber(var_16_0.param, "#")
			local var_16_2 = string.split(var_16_0.content, "#")

			for iter_16_0, iter_16_1 in ipairs(var_16_1) do
				if arg_16_4[iter_16_1] then
					table.insert(arg_16_3, {
						text = string.format("<color=#c95318>\"%s\"</color>", var_16_2[iter_16_0])
					})

					break
				end
			end
		end

		arg_16_1 = arg_16_1 + 1
	end

	return arg_16_1
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0._btnList = arg_17_0:getUserDataTb_()
	arg_17_0._elementId = arg_17_0.viewParam.elementId
	arg_17_0._fragmentId = arg_17_0.viewParam.fragmentId
	arg_17_0._dialogIdList = arg_17_0.viewParam.dialogIdList
	arg_17_0._isFromHandbook = arg_17_0.viewParam.isFromHandbook
	arg_17_0._notShowToast = arg_17_0.viewParam.notShowToast

	local var_17_0 = lua_chapter_map_fragment.configDict[arg_17_0._fragmentId]

	for iter_17_0 = 1, 5 do
		local var_17_1 = var_0_0.FragmentInfoTypeMap[iter_17_0] or 1

		gohelper.setActive(arg_17_0["_go" .. var_17_1], var_17_1 == (var_0_0.FragmentInfoTypeMap[var_17_0.type] or 1))
	end

	local var_17_2 = var_0_0.FragmentInfoTypeMap[var_17_0.type] and var_17_0.type or 1
	local var_17_3 = var_0_0["fragmentInfoShowHandleFunc" .. var_17_2]

	if var_17_3 then
		var_17_3(arg_17_0, var_17_0)
	end

	if not DungeonEnum.NotPopFragmentToastDict[arg_17_0._fragmentId] and not arg_17_0._isFromHandbook and not arg_17_0._notShowToast then
		local var_17_4 = var_17_0.toastId

		if var_17_4 and var_17_4 ~= 0 then
			GameFacade.showToast(var_17_4)
		else
			GameFacade.showToast(ToastEnum.DungeonFragmentInfo, var_17_0.title)
		end
	end

	if not string.nilorempty(var_17_0.res) then
		arg_17_0._simagefragmenticon:LoadImage(ResUrl.getDungeonFragmentIcon(var_17_0.res))
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_unlockFragment)
end

function var_0_0._onValueChnaged(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._gobottommask, gohelper.getRemindFourNumberFloat(arg_18_0._scrollcontent.verticalNormalizedPosition) > 0)
end

function var_0_0.onClose(arg_19_0)
	arg_19_0:_stopAudio()

	if arg_19_0._elementId then
		DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, arg_19_0._elementId)
	end
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0._simagefragmenticon:UnLoadImage()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._btnList) do
		iter_20_1[1]:RemoveClickListener()
		iter_20_1[2]:RemoveClickListener()
	end
end

function var_0_0.fragmentInfoShowHandleFunc1(arg_21_0, arg_21_1)
	arg_21_0._txtcontent.text = arg_21_1.content
	arg_21_0._txttitlecn.text = arg_21_1.title

	gohelper.setActive(arg_21_0._txtcontent.gameObject, true)
end

function var_0_0.fragmentInfoShowHandleFunc2(arg_22_0, arg_22_1)
	arg_22_0._txttitlecn.text = arg_22_1.title
	arg_22_0._txtcontent.text = arg_22_1.content

	gohelper.setActive(arg_22_0._txtcontent.gameObject, true)
	gohelper.setActive(arg_22_0._gochatarea, true)

	if arg_22_0._isFromHandbook and arg_22_0._dialogIdList then
		arg_22_0:_generateDialogByHandbook()
	else
		local var_22_0 = true
		local var_22_1 = DungeonMapModel.instance:getDialog()

		for iter_22_0, iter_22_1 in ipairs(var_22_1) do
			arg_22_0:_showDialog(iter_22_1[1], iter_22_1[2], iter_22_1[3], iter_22_1[4])

			if iter_22_1[4] and iter_22_1[4] > 0 then
				var_22_0 = false
			end
		end

		local var_22_2 = 0

		if var_22_0 then
			var_22_2 = var_0_1
		end

		arg_22_0._layoutchatarea.padding.left = var_22_2

		DungeonMapModel.instance:clearDialog()
		DungeonMapModel.instance:clearDialogId()
	end
end

function var_0_0.fragmentInfoShowHandleFunc3(arg_23_0, arg_23_1)
	arg_23_0._txtinfo3.text = arg_23_1.content
	arg_23_0._txttitle3.text = arg_23_1.title

	gohelper.setActive(arg_23_0._txtinfo3.gameObject, true)
end

function var_0_0.fragmentInfoShowHandleFunc4(arg_24_0, arg_24_1)
	arg_24_0._txtinfo4.text = arg_24_1.content
	arg_24_0._txttitle4.text = arg_24_1.title

	gohelper.setActive(arg_24_0._txtinfo4.gameObject, true)
end

function var_0_0.fragmentInfoShowHandleFunc5(arg_25_0, arg_25_1)
	arg_25_0._txtinfo5.text = arg_25_1.content
	arg_25_0._txttitle5.text = arg_25_1.title

	gohelper.setActive(arg_25_0._txtinfo5.gameObject, true)
end

return var_0_0
