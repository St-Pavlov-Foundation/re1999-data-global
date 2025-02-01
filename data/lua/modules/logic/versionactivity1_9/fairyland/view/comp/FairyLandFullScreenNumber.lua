module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandFullScreenNumber", package.seeall)

slot0 = class("FairyLandFullScreenNumber", UserDataDispose)
slot1 = UnityEngine.Time

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1.viewGO
	slot0.goNum = gohelper.findChild(slot0.viewGO, "numbg")
	slot0.textContent = gohelper.findChild(slot0.viewGO, "numbg/content")
	slot0.text = gohelper.findChildText(slot0.viewGO, "numbg/content/Text")
	slot0.content = "1.4142135623730950488016887242096980785696718753769480731766797379907324784621070388503875343276415727350138462309122970249248360558507372126441214970999358314132226659275055927557999505011527820605714701095599716059702745345968620147285174186408891986095523292304843087143214508397626036279952514079896872533965463318088296406206152583523950547457502877599617298355752203375318570113543746034084988471603868999706990048150305440277903164542478230684929369186215805784631115966687130130156185689872372352885092648612494977154218334204285686060146824720771435854874155657069677653720226485447015858801620758474922657226002085584466521458398893944370926591800311388246468157082630100594858704003186480342194897278290641045072636881313739855256117322040245091227700226941127573627280495738108967504018369868368450725799364729060762996941380475654823728997180326802474420629269124859052181004459842150591120249441341728531478105803603371077309182869314710171111683916581726889419758716582152128229518488472"
	slot0.numTab = {}
	slot2 = 1

	for slot6 in string.gmatch(slot0.content, ".") do
		slot0.numTab[slot2] = slot6
		slot2 = slot2 + 1
	end

	slot0.numCount = slot2 - 1
	slot0._showCheckStamp = 0
end

function slot0.addUpdate(slot0)
	if slot0.hasAddUpdate then
		return
	end

	slot0.hasAddUpdate = true

	LateUpdateBeat:Add(slot0._updateText, slot0)
end

function slot0._updateText(slot0)
	if slot0.showTextTween then
		slot0._showCheckStamp = slot0._showCheckStamp + uv0.deltaTime

		if slot0.showTweenStamp < slot0._showCheckStamp then
			slot0._showCheckStamp = 0

			slot0:_playShowText()
		end
	end

	if slot0.showZeroTween then
		slot0._showCheckStamp = slot0._showCheckStamp + uv0.deltaTime

		if slot0.showTweenStamp < slot0._showCheckStamp then
			slot0._showCheckStamp = 0

			slot0:_playZeroTween()
		end
	end
end

function slot0.playShowTween(slot0)
	if slot0.showTextTween then
		return
	end

	gohelper.setActive(slot0.goNum, true)

	slot1 = #slot0.content * 0.1
	slot0.text.text = ""
	slot0.showStartIndex = 1
	slot0.showStartCount = 1
	slot0.showTextIsFull = false
	slot0.textWidth = recthelper.getWidth(slot0.text.transform)
	slot0.textHeight = recthelper.getHeight(slot0.text.transform)
	slot0.lineCount = math.floor(slot0.textWidth / 50)
	slot0.showAddCount = math.ceil(slot0.lineCount / 10)
	slot0.showTextTween = true
	slot0.showZeroTween = false
	slot0.showTweenStamp = 0.01

	slot0:addUpdate()
end

function slot0._playShowText(slot0)
	if not slot0.showTextIsFull and slot0.textHeight < slot0.text.preferredHeight then
		slot0.showTextIsFull = true
		slot0.showTweenStamp = 0.1
	end

	if slot0.showTextIsFull then
		slot0.showStartIndex = slot0.showStartIndex + 1
	else
		slot0.showStartCount = slot0.showStartCount + 20
	end

	slot0.text.text = slot0:getShowText(slot0.showStartIndex, slot0.showStartCount)
end

function slot0.getShowText(slot0, slot1, slot2)
	if not slot0.showTextTab then
		slot0.showTextTab = {}
	end

	slot3 = nil

	for slot7 = 1, slot2 do
		if slot0.numCount < slot7 + slot1 then
			slot3 = slot3 % slot0.numCount
		end

		slot0.showTextTab[slot7] = slot0.numTab[slot3] or ""
	end

	return table.concat(slot0.showTextTab, "")
end

function slot0.playZeroTween(slot0, slot1, slot2)
	if slot0.showZeroTween then
		return
	end

	gohelper.setActive(slot0.goNum, true)

	slot0.showTextTween = false
	slot0.showZeroTween = true
	slot0.showTweenStamp = 0.1
	slot0.zeroCallback = slot1
	slot0.zeroCallbackObj = slot2

	slot0:addUpdate()
end

function slot0._playZeroTween(slot0)
	slot0.text.text, slot2 = slot0:getZeroText()

	if slot2 then
		slot0.showZeroTween = false

		TaskDispatcher.runDelay(slot0._onFinishZeroTween, slot0, 0.5)
	end
end

function slot0._onFinishZeroTween(slot0)
	if slot0.zeroCallback then
		slot0.zeroCallback(slot0.zeroCallbackObj)
	end
end

function slot0.getZeroText(slot0)
	if not slot0.showTextTab then
		slot0.showTextTab = {}
	end

	slot1 = true
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.showTextTab) do
		if tonumber(slot7) then
			if slot2 ~= 0 then
				slot2 = slot2 - 1
				slot1 = false
			end
		else
			slot2 = slot7
		end

		slot0.showTextTab[slot6] = slot2
	end

	return table.concat(slot0.showTextTab, ""), slot1
end

function slot0.clear(slot0)
	gohelper.setActive(slot0.goNum, false)
	TaskDispatcher.cancelTask(slot0._onFinishZeroTween, slot0)

	slot0.showTextTween = false
	slot0.showZeroTween = false

	if slot0.hasAddUpdate then
		LateUpdateBeat:Remove(slot0._updateText, slot0)

		slot0.hasAddUpdate = false
	end
end

function slot0.destory(slot0)
	slot0:clear()
	slot0:__onDispose()
end

return slot0
