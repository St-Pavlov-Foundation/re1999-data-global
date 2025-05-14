module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandFullScreenNumber", package.seeall)

local var_0_0 = class("FairyLandFullScreenNumber", UserDataDispose)
local var_0_1 = UnityEngine.Time

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1.viewGO
	arg_1_0.goNum = gohelper.findChild(arg_1_0.viewGO, "numbg")
	arg_1_0.textContent = gohelper.findChild(arg_1_0.viewGO, "numbg/content")
	arg_1_0.text = gohelper.findChildText(arg_1_0.viewGO, "numbg/content/Text")
	arg_1_0.content = "1.4142135623730950488016887242096980785696718753769480731766797379907324784621070388503875343276415727350138462309122970249248360558507372126441214970999358314132226659275055927557999505011527820605714701095599716059702745345968620147285174186408891986095523292304843087143214508397626036279952514079896872533965463318088296406206152583523950547457502877599617298355752203375318570113543746034084988471603868999706990048150305440277903164542478230684929369186215805784631115966687130130156185689872372352885092648612494977154218334204285686060146824720771435854874155657069677653720226485447015858801620758474922657226002085584466521458398893944370926591800311388246468157082630100594858704003186480342194897278290641045072636881313739855256117322040245091227700226941127573627280495738108967504018369868368450725799364729060762996941380475654823728997180326802474420629269124859052181004459842150591120249441341728531478105803603371077309182869314710171111683916581726889419758716582152128229518488472"
	arg_1_0.numTab = {}

	local var_1_0 = 1

	for iter_1_0 in string.gmatch(arg_1_0.content, ".") do
		arg_1_0.numTab[var_1_0] = iter_1_0
		var_1_0 = var_1_0 + 1
	end

	arg_1_0.numCount = var_1_0 - 1
	arg_1_0._showCheckStamp = 0
end

function var_0_0.addUpdate(arg_2_0)
	if arg_2_0.hasAddUpdate then
		return
	end

	arg_2_0.hasAddUpdate = true

	LateUpdateBeat:Add(arg_2_0._updateText, arg_2_0)
end

function var_0_0._updateText(arg_3_0)
	if arg_3_0.showTextTween then
		arg_3_0._showCheckStamp = arg_3_0._showCheckStamp + var_0_1.deltaTime

		if arg_3_0._showCheckStamp > arg_3_0.showTweenStamp then
			arg_3_0._showCheckStamp = 0

			arg_3_0:_playShowText()
		end
	end

	if arg_3_0.showZeroTween then
		arg_3_0._showCheckStamp = arg_3_0._showCheckStamp + var_0_1.deltaTime

		if arg_3_0._showCheckStamp > arg_3_0.showTweenStamp then
			arg_3_0._showCheckStamp = 0

			arg_3_0:_playZeroTween()
		end
	end
end

function var_0_0.playShowTween(arg_4_0)
	if arg_4_0.showTextTween then
		return
	end

	gohelper.setActive(arg_4_0.goNum, true)

	local var_4_0 = #arg_4_0.content * 0.1

	arg_4_0.text.text = ""
	arg_4_0.showStartIndex = 1
	arg_4_0.showStartCount = 1
	arg_4_0.showTextIsFull = false
	arg_4_0.textWidth = recthelper.getWidth(arg_4_0.text.transform)
	arg_4_0.textHeight = recthelper.getHeight(arg_4_0.text.transform)
	arg_4_0.lineCount = math.floor(arg_4_0.textWidth / 50)
	arg_4_0.showAddCount = math.ceil(arg_4_0.lineCount / 10)
	arg_4_0.showTextTween = true
	arg_4_0.showZeroTween = false
	arg_4_0.showTweenStamp = 0.01

	arg_4_0:addUpdate()
end

function var_0_0._playShowText(arg_5_0)
	if not arg_5_0.showTextIsFull and arg_5_0.text.preferredHeight > arg_5_0.textHeight then
		arg_5_0.showTextIsFull = true
		arg_5_0.showTweenStamp = 0.1
	end

	if arg_5_0.showTextIsFull then
		arg_5_0.showStartIndex = arg_5_0.showStartIndex + 1
	else
		arg_5_0.showStartCount = arg_5_0.showStartCount + 20
	end

	local var_5_0 = arg_5_0:getShowText(arg_5_0.showStartIndex, arg_5_0.showStartCount)

	arg_5_0.text.text = var_5_0
end

function var_0_0.getShowText(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.showTextTab then
		arg_6_0.showTextTab = {}
	end

	local var_6_0

	for iter_6_0 = 1, arg_6_2 do
		local var_6_1 = iter_6_0 + arg_6_1

		if var_6_1 > arg_6_0.numCount then
			var_6_1 = var_6_1 % arg_6_0.numCount
		end

		arg_6_0.showTextTab[iter_6_0] = arg_6_0.numTab[var_6_1] or ""
	end

	return table.concat(arg_6_0.showTextTab, "")
end

function var_0_0.playZeroTween(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.showZeroTween then
		return
	end

	gohelper.setActive(arg_7_0.goNum, true)

	arg_7_0.showTextTween = false
	arg_7_0.showZeroTween = true
	arg_7_0.showTweenStamp = 0.1
	arg_7_0.zeroCallback = arg_7_1
	arg_7_0.zeroCallbackObj = arg_7_2

	arg_7_0:addUpdate()
end

function var_0_0._playZeroTween(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:getZeroText()

	arg_8_0.text.text = var_8_0

	if var_8_1 then
		arg_8_0.showZeroTween = false

		TaskDispatcher.runDelay(arg_8_0._onFinishZeroTween, arg_8_0, 0.5)
	end
end

function var_0_0._onFinishZeroTween(arg_9_0)
	if arg_9_0.zeroCallback then
		arg_9_0.zeroCallback(arg_9_0.zeroCallbackObj)
	end
end

function var_0_0.getZeroText(arg_10_0)
	if not arg_10_0.showTextTab then
		arg_10_0.showTextTab = {}
	end

	local var_10_0 = true
	local var_10_1

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.showTextTab) do
		local var_10_2 = tonumber(iter_10_1)

		if var_10_2 then
			if var_10_2 ~= 0 then
				var_10_2 = var_10_2 - 1
				var_10_0 = false
			end
		else
			var_10_2 = iter_10_1
		end

		arg_10_0.showTextTab[iter_10_0] = var_10_2
	end

	return table.concat(arg_10_0.showTextTab, ""), var_10_0
end

function var_0_0.clear(arg_11_0)
	gohelper.setActive(arg_11_0.goNum, false)
	TaskDispatcher.cancelTask(arg_11_0._onFinishZeroTween, arg_11_0)

	arg_11_0.showTextTween = false
	arg_11_0.showZeroTween = false

	if arg_11_0.hasAddUpdate then
		LateUpdateBeat:Remove(arg_11_0._updateText, arg_11_0)

		arg_11_0.hasAddUpdate = false
	end
end

function var_0_0.destory(arg_12_0)
	arg_12_0:clear()
	arg_12_0:__onDispose()
end

return var_0_0
