module("modules.logic.turnback.model.TurnbackSignInModel", package.seeall)

slot0 = class("TurnbackSignInModel", ListScrollModel)

function slot0.OnInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.signInInfoMoList = {}
end

function slot0.setSignInInfoList(slot0, slot1)
	slot0.signInInfoMoList = {}

	for slot6 = 1, #slot1 do
		slot7 = TurnbackSignInInfoMo.New()

		slot7:init(slot1[slot6], TurnbackModel.instance:getCurTurnbackId())
		table.insert(slot0.signInInfoMoList, slot7)
	end

	table.sort(slot0.signInInfoMoList, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
	slot0:setSignInList()
end

function slot0.getSignInInfoMoList(slot0)
	return slot0.signInInfoMoList
end

function slot0.getSignInStateById(slot0, slot1)
	if slot0.signInInfoMoList[slot1] then
		return slot2.state
	end
end

function slot0.setSignInList(slot0)
	if GameUtil.getTabLen(slot0.signInInfoMoList) > 0 then
		slot0:setList(slot0.signInInfoMoList)
	end
end

function slot0.updateSignInInfoState(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.signInInfoMoList) do
		if slot7.id == slot1 then
			slot7:updateState(slot2)

			break
		end
	end

	slot0:setList(slot0.signInInfoMoList)
end

function slot0.getTheFirstCanGetIndex(slot0)
	for slot4, slot5 in ipairs(slot0.signInInfoMoList) do
		if slot5.state == TurnbackEnum.SignInState.CanGet then
			return slot4
		end
	end

	return 0
end

function slot0.setOpenTimeStamp(slot0)
	slot0.startTimeStamp = UnityEngine.Time.realtimeSinceStartup
end

function slot0.getOpenTimeStamp(slot0)
	return slot0.startTimeStamp
end

slot0.instance = slot0.New()

return slot0
