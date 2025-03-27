module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleRoundMO", package.seeall)

slot0 = string.format
slot1 = table.insert
slot2 = class("V2a4_WarmUpBattleRoundMO")

function slot2.ctor(slot0, slot1, slot2, slot3)
	slot0._index = slot2
	slot0._waveMO = slot1
	slot0._gachaMO = slot3
	slot0._isFinished = false
	slot0._isWin = false
	slot0._state = V2a4_WarmUpEnum.RoundState.None
	slot0._userAnsIsYes = nil
end

function slot2.index(slot0)
	return slot0._index
end

function slot2.isWin(slot0)
	return slot0._isWin
end

function slot2.isFinished(slot0)
	return slot0._isFinished
end

function slot2.userAnsIsYes(slot0)
	return slot0._userAnsIsYes
end

function slot2.cfgId(slot0)
	return slot0._gachaMO:cfgId()
end

function slot2.type(slot0)
	return slot0._gachaMO:type()
end

function slot2.isText(slot0)
	return slot0:type() == V2a4_WarmUpEnum.AskType.Text
end

function slot2.isPhoto(slot0)
	return slot0:type() == V2a4_WarmUpEnum.AskType.Photo
end

function slot2.resUrl(slot0)
	return ResUrl.getV2a4WarmUpSingleBg(slot0._gachaMO:imgName())
end

function slot2.answer(slot0, slot1)
	if slot0._isFinished then
		return
	end

	slot0._isFinished = true
	slot0._userAnsIsYes = slot1
	slot0._isWin = slot0._gachaMO:ansIsYes() == slot1
end

function slot2.isPreTalk(slot0)
	return slot0._state == V2a4_WarmUpEnum.RoundState.PreTalk
end

function slot2.isAsk(slot0)
	return slot0._state == V2a4_WarmUpEnum.RoundState.Ask
end

function slot2.isWaitAns(slot0)
	return slot0._state == V2a4_WarmUpEnum.RoundState.WaitAns
end

function slot2.isAnsed(slot0)
	return slot0._state == V2a4_WarmUpEnum.RoundState.Ansed
end

function slot2.isReplyResult(slot0)
	return slot0._state == V2a4_WarmUpEnum.RoundState.ReplyResult
end

function slot2.isLastRound(slot0)
	return slot0._waveMO:isLastRound()
end

function slot2.isFirstRound(slot0)
	return slot0._waveMO:isFirstRound()
end

function slot2.isFirstWave(slot0)
	return slot0._waveMO:isFirstWave()
end

function slot2.isNeedPreface(slot0)
	return slot0:isFirstWave() and not V2a4_WarmUpController.instance:getIsShownPreface()
end

function slot2.isNeedPassTalkAllYes(slot0)
	return slot0:isLastRound() and slot0._waveMO:isAllAskYes()
end

function slot2._moveState(slot0)
	slot0._tmp_dialogStep = 0

	if slot0._state + 1 == V2a4_WarmUpEnum.RoundState.__End then
		slot0._tmp_dialogCOList = {}

		return false
	end

	if slot0:isWaitAns() then
		slot0._state = slot0._isFinished and slot1 or slot0._state
	else
		slot0._state = slot1
	end

	slot2 = nil

	if isDebugBuild then
		slot3 = {}

		function slot2(slot0, slot1)
			if not slot0 then
				uv0(uv1, uv2("error state = %s, dialog type = %s", uv3.s_state(uv4._state), slot1))
				uv4:dump(uv1, 1)
				logError(table.concat(uv1, "\n"))
			end
		end
	end

	if slot0:isPreTalk() then
		if slot0:isFirstRound() then
			if slot0:isNeedPreface() then
				slot0._tmp_dialogCOList = slot0._gachaMO:getDialogCOList_prefaceAndPreTalk()

				V2a4_WarmUpController.instance:setIsShownPreface(true)
			else
				slot0._tmp_dialogCOList = slot0._gachaMO:getDialogCOList_preTalk()
			end
		else
			return slot0:_moveState()
		end
	elseif slot0:isAsk() then
		slot0._tmp_dialogCOList = slot0._gachaMO:getDialogCOList_yesorno()
	elseif slot0:isWaitAns() then
		slot4 = V2a4_WarmUpConfig.instance:getRandomDialogCO(V2a4_WarmUpEnum.DialogType.Wait)

		if isDebugBuild then
			slot2(slot4 ~= nil, slot3)
		end

		slot0._tmp_dialogCOList = slot0._gachaMO:getDialogCOList(slot4.id)
	elseif slot0:isAnsed() then
		slot4 = V2a4_WarmUpConfig.instance:getRandomDialogCO(slot0:userAnsIsYes() and V2a4_WarmUpEnum.DialogType.AnsTrue or V2a4_WarmUpEnum.DialogType.AnsFalse)

		if isDebugBuild then
			slot2(slot4 ~= nil, slot3)
		end

		slot0._tmp_dialogCOList = slot0._gachaMO:getDialogCOList(slot4.id)
	elseif slot0:isReplyResult() then
		if slot0:isWin() then
			if slot0:isLastRound() then
				slot0._tmp_dialogCOList = slot0:isNeedPassTalkAllYes() and slot0._gachaMO:getDialogCOList_passTalkAllYes() or slot0._gachaMO:getDialogCOList_passTalk()
			else
				if not V2a4_WarmUpConfig.instance:getRandomDialogCO(V2a4_WarmUpEnum.DialogType.ReplyAnsRight) then
					slot0._tmp_dialogStep = 0
					slot0._tmp_dialogCOList = {}

					return true
				end

				slot0._tmp_dialogCOList = slot0._gachaMO:getDialogCOList(slot4.id)
			end
		else
			slot0._tmp_dialogCOList = slot0._gachaMO:getDialogCOList_failTalk()
		end
	end

	slot0._tmp_dialogStep = 1

	return true
end

function slot2.moveStep(slot0)
	slot1 = slot0._tmp_dialogCOList or {}
	slot2 = slot0._tmp_dialogStep or 0
	slot3 = nil

	if isDebugBuild then
		slot4 = {}

		function slot3(slot0)
			if not slot0 then
				uv0(uv1, uv2("error step: %s", uv3._tmp_dialogStep))
				uv3:dump(uv1, 1)
				logError(table.concat(uv1, "\n"))
			end
		end
	end

	if slot2 < #slot1 then
		slot0._tmp_dialogStep = slot2 + 1

		if isDebugBuild then
			slot3(slot1[slot2] ~= nil)
		end

		return true, slot1[slot2]
	end

	return slot0:_moveState(), slot0._tmp_dialogCOList[1]
end

function slot2.isLastStep(slot0)
	return (slot0._tmp_dialogStep or 0) == #(slot0._tmp_dialogCOList or {})
end

function slot2.s_state(slot0)
	for slot4, slot5 in pairs(V2a4_WarmUpEnum.RoundState) do
		if slot5 == slot0 then
			return slot4
		end
	end

	return "[V2a4_WarmUpBattleRoundMO.s_state] error!!"
end

function slot2.dump(slot0, slot1, slot2)
	slot3 = string.rep("\t", slot2 or 0)

	uv0(slot1, slot3 .. uv1("index = %s", slot0._index))
	uv0(slot1, slot3 .. uv1("wave = %s", slot0._waveMO:index()))
	uv0(slot1, slot3 .. uv1("isFinished = %s", slot0._isFinished))
	uv0(slot1, slot3 .. uv1("isWin = %s", slot0._isWin))
	uv0(slot1, slot3 .. uv1("state = %s", uv2.s_state(slot0._state)))
	uv0(slot1, slot3 .. uv1("_step = %s", slot0._tmp_dialogStep or 0))

	slot4 = {}

	for slot8, slot9 in ipairs(slot0._tmp_dialogCOList or {}) do
		uv0(slot4, slot9.id)
	end

	uv0(slot1, slot3 .. uv1("_stepList = %s", table.concat(slot4, ",")))
	uv0(slot1, slot3 .. "GachaRound = {")
	slot0._gachaMO:dump(slot1, slot2 + 1)
	uv0(slot1, slot3 .. "}")
end

return slot2
