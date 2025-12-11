module("modules.logic.necrologiststory.view.comp.NecrologistStoryTextComp", package.seeall)

local var_0_0 = class("NecrologistStoryTextComp", LuaCompBase)

function var_0_0._onSetMarksTop(arg_1_0)
	if arg_1_0._txtmarktop and not gohelper.isNil(arg_1_0._txtmarktopGo) then
		arg_1_0._txtConMark:SetMarksTop(arg_1_0._markTopList)
	end
end

function var_0_0._setMarksTop(arg_2_0, arg_2_1)
	FrameTimerController.instance:unregister(arg_2_0._fTimer)

	if arg_2_1 or #arg_2_0._markTopList == 0 then
		gohelper.setActive(arg_2_0._txtmarktopGo, false)
	else
		arg_2_0._fTimer = FrameTimerController.instance:register(function()
			arg_2_0:_onSetMarksTop()
		end, nil, 2)

		arg_2_0._fTimer:Start()
	end
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._markTopList = {}
	arg_4_0._txtmarktopGo = IconMgr.instance:getCommonTextMarkTop(arg_4_1)
	arg_4_0._txtmarktop = arg_4_0._txtmarktopGo:GetComponent(gohelper.Type_TextMesh)
	arg_4_0._txtConMark = gohelper.onceAddComponent(arg_4_1, typeof(ZProj.TMPMark))

	arg_4_0._txtConMark:SetMarkTopGo(arg_4_0._txtmarktopGo)
	arg_4_0._txtConMark:SetTopOffset(0, -2)

	arg_4_0.txtGO = arg_4_1
	arg_4_0.transform = arg_4_1.transform
	arg_4_0.textComponent = gohelper.findChildTextMesh(arg_4_1, "")
	arg_4_0.txtHyperLink = NecrologistStoryHelper.addHyperLinkClick(arg_4_0.textComponent)
	arg_4_0.typewriterSpeed = 30
	arg_4_0.typewriterTime = 1 / arg_4_0.typewriterSpeed
end

function var_0_0.setTextNormal(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._markTopList = StoryTool.getMarkTopTextList(arg_5_1) or {}
	arg_5_0.metaText = StoryTool.filterMarkTop(arg_5_1)
	arg_5_0.finishCallback = arg_5_2
	arg_5_0.callbackObj = arg_5_3

	arg_5_0:onTextFinish()
end

function var_0_0.setTextWithTypewriter(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0._markTopList = StoryTool.getMarkTopTextList(arg_6_1) or {}

	arg_6_0:clearTextTimer()

	arg_6_0.metaText = StoryTool.filterMarkTop(arg_6_1)
	arg_6_0.charList = arg_6_0:getUCharArr(arg_6_0.metaText)
	arg_6_0.charIndex = 1
	arg_6_0.charCount = #arg_6_0.charList
	arg_6_0.tagStack = {}
	arg_6_0.tagCount = 0
	arg_6_0.frameCallback = arg_6_2
	arg_6_0.finishCallback = arg_6_3
	arg_6_0.callbackObj = arg_6_4

	arg_6_0:setText(LuaUtil.emptyStr)
	TaskDispatcher.runRepeat(arg_6_0._showTypewriterText, arg_6_0, arg_6_0.typewriterTime)
end

function var_0_0._showTypewriterText(arg_7_0)
	if arg_7_0:isDone() then
		arg_7_0:onTextFinish()

		return
	end

	local var_7_0 = arg_7_0:getTypewriterShowText()

	if var_7_0 then
		arg_7_0.curText = var_7_0
		arg_7_0.textComponent.text = var_7_0

		if arg_7_0.frameCallback then
			arg_7_0.frameCallback(arg_7_0.callbackObj)
		end
	else
		arg_7_0:_showTypewriterText()
	end
end

function var_0_0.setText(arg_8_0, arg_8_1)
	arg_8_0.curText = arg_8_1
	arg_8_0.textComponent.text = arg_8_1
end

function var_0_0.isDone(arg_9_0)
	return arg_9_0.charIndex > arg_9_0.charCount
end

function var_0_0.onTextFinish(arg_10_0)
	arg_10_0:clearTextTimer()

	if not arg_10_0.charCount then
		arg_10_0.charCount = 0
	end

	arg_10_0.charIndex = arg_10_0.charCount + 1

	arg_10_0:setText(arg_10_0.metaText)
	arg_10_0:_setMarksTop()
	arg_10_0:doFinishCallback()
end

function var_0_0.doFinishCallback(arg_11_0)
	local var_11_0 = arg_11_0.finishCallback
	local var_11_1 = arg_11_0.callbackObj

	if var_11_0 then
		var_11_0(var_11_1)
	end
end

function var_0_0.getTypewriterShowText(arg_12_0)
	if arg_12_0:isDone() then
		return arg_12_0.metaText
	end

	local var_12_0
	local var_12_1 = arg_12_0.charIndex
	local var_12_2 = arg_12_0.charList[var_12_1]
	local var_12_3 = #arg_12_0.tagStack

	if string.sub(var_12_2, 1, 1) == "<" then
		if string.sub(var_12_2, 2, 2) ~= "/" then
			table.insert(arg_12_0.tagStack, var_12_2)
		elseif var_12_3 > 0 then
			table.remove(arg_12_0.tagStack)
		end
	else
		var_12_0 = arg_12_0.curText

		if var_12_3 > 0 then
			if arg_12_0.tagCount == var_12_3 then
				local var_12_4 = ""

				for iter_12_0 = var_12_3, 1, -1 do
					local var_12_5 = arg_12_0.tagStack[iter_12_0]

					var_12_4 = var_12_4 .. string.gsub(var_12_5, "<", "</")
				end

				local var_12_6 = -string.len(var_12_4) - 1

				var_12_0 = string.format("%s%s%s", string.sub(var_12_0, 1, var_12_6), var_12_2, var_12_4)
			else
				for iter_12_1, iter_12_2 in ipairs(arg_12_0.tagStack) do
					var_12_0 = var_12_0 .. iter_12_2
				end

				var_12_0 = var_12_0 .. var_12_2

				for iter_12_3 = var_12_3, 1, -1 do
					local var_12_7 = arg_12_0.tagStack[iter_12_3]

					var_12_0 = var_12_0 .. string.gsub(var_12_7, "<", "</")
				end
			end
		else
			var_12_0 = var_12_0 .. var_12_2
		end

		arg_12_0.tagCount = var_12_3
	end

	arg_12_0.charIndex = arg_12_0.charIndex + 1

	return var_12_0
end

function var_0_0.getUCharArr(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if LuaUtil.isEmptyStr(arg_13_1) then
		return var_13_0
	end

	local var_13_1 = 1
	local var_13_2 = #arg_13_1

	while var_13_1 <= var_13_2 do
		if string.sub(arg_13_1, var_13_1, var_13_1) == "<" then
			local var_13_3 = string.find(arg_13_1, ">", var_13_1)

			if var_13_3 then
				table.insert(var_13_0, string.sub(arg_13_1, var_13_1, var_13_3))

				var_13_1 = var_13_3 + 1
			else
				table.insert(var_13_0, string.sub(arg_13_1, var_13_1, var_13_1))

				var_13_1 = var_13_1 + 1
			end
		else
			local var_13_4 = string.sub(arg_13_1, var_13_1, var_13_1)

			if string.byte(var_13_4) > 127 then
				local var_13_5 = string.byte(var_13_4)
				local var_13_6 = 1

				if var_13_5 >= 194 and var_13_5 <= 223 then
					var_13_6 = 2
				elseif var_13_5 >= 224 and var_13_5 <= 239 then
					var_13_6 = 3
				elseif var_13_5 >= 240 and var_13_5 <= 244 then
					var_13_6 = 4
				end

				var_13_4 = string.sub(arg_13_1, var_13_1, var_13_1 + var_13_6 - 1)
				var_13_1 = var_13_1 + var_13_6
			else
				var_13_1 = var_13_1 + 1
			end

			table.insert(var_13_0, var_13_4)
		end
	end

	return var_13_0
end

function var_0_0.clearTextTimer(arg_14_0)
	arg_14_0:_setMarksTop(true)
	TaskDispatcher.cancelTask(arg_14_0._showTypewriterText, arg_14_0)
end

function var_0_0.getTextStr(arg_15_0)
	return arg_15_0.curText
end

function var_0_0.onDestroy(arg_16_0)
	FrameTimerController.instance:unregister(arg_16_0._fTimer)
	arg_16_0:clearTextTimer()
end

return var_0_0
