module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandOption", package.seeall)

local var_0_0 = class("FairyLandOption", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.dialogView = arg_1_1
	arg_1_0._go = gohelper.findChild(arg_1_1.dialogGO, "#go_Options")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0._go, "#go_Click")
	arg_1_0.goLeft = gohelper.findChild(arg_1_0._go, "Left")

	gohelper.setActive(arg_1_0.goLeft, false)

	arg_1_0.goRight = gohelper.findChild(arg_1_0._go, "Right")
	arg_1_0.btnNext = gohelper.findChildButtonWithAudio(arg_1_0.goRight, "#go_Next")
	arg_1_0.btnContent = gohelper.findChildButtonWithAudio(arg_1_0._go, "Right/#scroll_Dialogue/Viewport")

	arg_1_0:addClickCb(arg_1_0.btnNext, arg_1_0.onClickNext, arg_1_0)
	arg_1_0:addClickCb(arg_1_0.btnClick, arg_1_0.onClicBtnClick, arg_1_0)
	arg_1_0:addClickCb(arg_1_0.btnContent, arg_1_0.onClicBtnClick, arg_1_0)

	arg_1_0.bubbleItems = {}

	gohelper.setActive(arg_1_0.btnNext, false)
end

function var_0_0.onClicBtnClick(arg_2_0)
	local var_2_0 = arg_2_0.sectionConfig[arg_2_0.step + 1]

	if not (arg_2_0.sectionId == -1 or var_2_0 ~= nil) then
		return
	end

	arg_2_0:onClickNext()
end

function var_0_0.onClickNext(arg_3_0)
	if arg_3_0.sectionId == -1 then
		return
	end

	if not arg_3_0.dialogId then
		return
	end

	if arg_3_0.isPlaying then
		arg_3_0:showDialogText()
	else
		arg_3_0:playNextStep()
	end
end

function var_0_0.startDialog(arg_4_0, arg_4_1)
	arg_4_0.dialogId = arg_4_1.dialogId

	gohelper.setActive(arg_4_0._go, true)
	arg_4_0:initContentList()
	arg_4_0:selectOption(0)
	arg_4_0:playNextStep()
end

function var_0_0.selectOption(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.goLeft, false)

	arg_5_0.sectionId = arg_5_1
	arg_5_0.step = 0
	arg_5_0.sectionConfig = FairyLandConfig.instance:getDialogConfig(arg_5_0.dialogId, arg_5_0.sectionId)
end

function var_0_0.playNextStep(arg_6_0)
	arg_6_0.step = arg_6_0.step + 1

	local var_6_0 = arg_6_0.sectionConfig[arg_6_0.step]

	if not var_6_0 then
		arg_6_0:finished()

		return
	end

	arg_6_0:playStep(var_6_0)

	local var_6_1 = arg_6_0.sectionConfig[arg_6_0.step + 1]
	local var_6_2 = arg_6_0.sectionId == -1 or var_6_1 ~= nil

	gohelper.setActive(arg_6_0.btnNext, not var_6_2)
end

function var_0_0.playStep(arg_7_0, arg_7_1)
	arg_7_0.isPlaying = true

	if arg_7_1.type == "options" then
		arg_7_0:showOptions(arg_7_1)
	else
		arg_7_0:addContent(arg_7_1)
	end
end

function var_0_0.showDialogText(arg_8_0)
	local var_8_0 = arg_8_0.contentList and arg_8_0.contentList[#arg_8_0.contentList]

	if var_8_0 then
		var_8_0.fadeText:onTextFinished()
	end
end

function var_0_0.onTextPlayFinish(arg_9_0)
	arg_9_0.isPlaying = false
end

function var_0_0.finished(arg_10_0)
	arg_10_0.dialogId = nil
	arg_10_0.isPlaying = false

	arg_10_0.dialogView:finished()
end

function var_0_0.initContentList(arg_11_0)
	arg_11_0.contentIndex = 0

	if arg_11_0.contentList then
		return
	end

	arg_11_0.contentList = {}
	arg_11_0.scrollContent = gohelper.findChild(arg_11_0._go, "Right/#scroll_Dialogue/Viewport/LayoutGroup")
	arg_11_0.goContent = gohelper.findChild(arg_11_0.scrollContent, "#go_Option")
end

function var_0_0.addContent(arg_12_0, arg_12_1)
	arg_12_0.contentIndex = arg_12_0.contentIndex + 1

	local var_12_0 = arg_12_0:createContentItem(arg_12_0.contentIndex)

	gohelper.setActive(var_12_0.go, true)

	local var_12_1 = string.format(luaLang("fairyland_speker_content_overseas"), arg_12_1.speaker, arg_12_1.content)
	local var_12_2 = {}

	if arg_12_1.elementId == 1 then
		var_12_1 = string.format("<color=#B9AB9E>%s</color>", var_12_1)
	end

	var_12_2.content = var_12_1
	var_12_2.tween = true
	var_12_2.callback = arg_12_0.onTextPlayFinish
	var_12_2.callbackObj = arg_12_0

	var_12_0.fadeText:setText(var_12_2)
	gohelper.setActive(var_12_0.goBg1, arg_12_1.elementId == 1)
	gohelper.setActive(var_12_0.goBg2, arg_12_1.elementId == 0)
	gohelper.setActive(var_12_0.goStar, arg_12_1.elementId == 1)
	arg_12_0:playAudio(arg_12_1.audioId)
	arg_12_0:moveLast()
end

function var_0_0.createContentItem(arg_13_0, arg_13_1)
	if arg_13_0.contentList[arg_13_1] then
		return arg_13_0.contentList[arg_13_1]
	end

	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.index = arg_13_1
	var_13_0.go = gohelper.cloneInPlace(arg_13_0.goContent, tostring(arg_13_1))
	var_13_0.goBg1 = gohelper.findChild(var_13_0.go, "#go_BG1")
	var_13_0.goBg2 = gohelper.findChild(var_13_0.go, "#go_BG2")
	var_13_0.goText = gohelper.findChild(var_13_0.go, "#txt_Option")
	var_13_0.fadeText = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_0.goText, FairyLandTextFade)
	var_13_0.goStar = gohelper.findChild(var_13_0.go, "#txt_Option/image_Star")

	table.insert(arg_13_0.contentList, var_13_0)

	return var_13_0
end

function var_0_0.deleteContentItem(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_1.fadeText:onDestroy()
	end
end

function var_0_0.initOption(arg_15_0)
	if arg_15_0.optionList then
		return
	end

	arg_15_0.optionList = {}

	for iter_15_0 = 1, 3 do
		arg_15_0.optionList[iter_15_0] = arg_15_0:createOption(iter_15_0)
	end
end

function var_0_0.createOption(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getUserDataTb_()

	var_16_0.index = arg_16_1
	var_16_0.go = gohelper.findChild(arg_16_0.goLeft, "#go_Option" .. tostring(arg_16_1))
	var_16_0.btn = gohelper.findButtonWithAudio(var_16_0.go)

	var_16_0.btn:AddClickListener(arg_16_0.onClickOption, arg_16_0, var_16_0)

	var_16_0.txtOption = gohelper.findChildTextMesh(var_16_0.go, "#txt_Option")
	var_16_0.goStar = gohelper.findChild(var_16_0.go, "image_Star")

	return var_16_0
end

function var_0_0.showOptions(arg_17_0, arg_17_1)
	arg_17_0:initOption()

	arg_17_0.sectionId = -1

	gohelper.setActive(arg_17_0.goLeft, true)

	local var_17_0 = string.splitToNumber(arg_17_1.param, "#")
	local var_17_1 = string.split(arg_17_1.content, "#")
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		var_17_2[iter_17_1] = var_17_1[iter_17_0]
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.optionList) do
		arg_17_0:updateOption(iter_17_3, var_17_2[iter_17_2])
	end
end

function var_0_0.updateOption(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_2 then
		gohelper.setActive(arg_18_1.go, false)

		return
	end

	gohelper.setActive(arg_18_1.go, true)

	arg_18_1.txtOption.text = arg_18_2
end

function var_0_0.onClickOption(arg_19_0, arg_19_1)
	local var_19_0 = {}

	var_19_0.elementId = 1
	var_19_0.speaker = luaLang("mainrolename")
	var_19_0.content = arg_19_1.txtOption.text

	arg_19_0:addContent(var_19_0)
	arg_19_0:selectOption(arg_19_1.index)
end

function var_0_0.deleteOption(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return
	end

	arg_20_1.btn:RemoveClickListener()
end

function var_0_0.moveLast(arg_21_0)
	local var_21_0 = arg_21_0.scrollContent.transform

	ZProj.UGUIHelper.RebuildLayout(var_21_0)

	local var_21_1 = recthelper.getHeight(var_21_0.parent)
	local var_21_2 = recthelper.getHeight(var_21_0)
	local var_21_3 = math.max(var_21_2 - var_21_1, 0)

	recthelper.setAnchorY(var_21_0, var_21_3)
end

function var_0_0.hide(arg_22_0)
	gohelper.setActive(arg_22_0._go, false)

	if arg_22_0.contentList then
		for iter_22_0, iter_22_1 in pairs(arg_22_0.contentList) do
			gohelper.setActive(iter_22_1.go, false)

			if iter_22_1.fadeText then
				iter_22_1.fadeText:killTween()
			end
		end
	end
end

function var_0_0.playAudio(arg_23_0, arg_23_1)
	arg_23_0:stopAudio()

	if arg_23_1 and arg_23_1 > 0 then
		arg_23_0.playingId = AudioMgr.instance:trigger(arg_23_1)
	end
end

function var_0_0.stopAudio(arg_24_0)
	if arg_24_0.playingId then
		AudioMgr.instance:stopPlayingID(arg_24_0.playingId)

		arg_24_0.playingId = nil
	end
end

function var_0_0.dispose(arg_25_0)
	arg_25_0:stopAudio()

	if arg_25_0.optionList then
		for iter_25_0, iter_25_1 in pairs(arg_25_0.optionList) do
			arg_25_0:deleteOption(iter_25_1)
		end
	end

	if arg_25_0.contentList then
		for iter_25_2, iter_25_3 in pairs(arg_25_0.contentList) do
			arg_25_0:deleteContentItem(iter_25_3)
		end
	end

	arg_25_0:__onDispose()
end

return var_0_0
