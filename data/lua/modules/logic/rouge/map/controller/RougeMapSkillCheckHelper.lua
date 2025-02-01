module("modules.logic.rouge.map.controller.RougeMapSkillCheckHelper", package.seeall)

slot0 = class("RougeMapSkillCheckHelper")
slot0.CantUseMapSkillReason = {
	UseLimit = 1,
	DoingEvent = 5,
	CoinCost = 3,
	StepCd = 2,
	ForbidenPathSelect = 7,
	ForbidenMiddle = 6,
	PowerCost = 4,
	None = 0
}
slot0.CantUseSkillToast = {
	[slot0.CantUseMapSkillReason.UseLimit] = ToastEnum.CantUseMapSkill_StepCd,
	[slot0.CantUseMapSkillReason.StepCd] = ToastEnum.CantUseMapSkill_StepCd,
	[slot0.CantUseMapSkillReason.CoinCost] = ToastEnum.CantUseMapSkill,
	[slot0.CantUseMapSkillReason.PowerCost] = ToastEnum.CantUseMapSkill,
	[slot0.CantUseMapSkillReason.DoingEvent] = ToastEnum.CantUseMapSkill_DoingEvent,
	[slot0.CantUseMapSkillReason.ForbidenMiddle] = ToastEnum.CantUseMapSkill_MiddleLayer,
	[slot0.CantUseMapSkillReason.ForbidenPathSelect] = ToastEnum.CantUseMapSkill_MiddleLayer
}

function slot0.canUseMapSkill(slot0)
	return not uv0._getCantUseReason(slot0) or slot1 == uv0.CantUseMapSkillReason.None, slot1
end

function slot0._getCantUseReason(slot0)
	uv0._initSkillUseChcekFuncList()

	for slot5, slot6 in ipairs(uv0._checkFuncList) do
		if slot6(slot0, lua_rouge_map_skill.configDict[slot0.id]) and slot7 ~= uv0.CantUseMapSkillReason.None then
			return slot7
		end
	end
end

function slot0.showCantUseMapSkillToast(slot0)
	if uv0.CantUseSkillToast[slot0] then
		GameFacade.showToast(slot1)
	end
end

function slot0._initSkillUseChcekFuncList()
	if not uv0._checkFuncList then
		uv0._checkFuncList = {
			uv0.checkDoineEvent,
			uv0.checkMiddleLayer,
			uv0.checkPathSelectLayer,
			uv0.checkUseLimiter,
			uv0.checkStepCd,
			uv0.checkCoinCost,
			uv0.checkPowerCost
		}
	end
end

function slot0.checkDoineEvent(slot0, slot1)
	if RougeMapModel.instance:isNormalLayer() and RougeMapModel.instance:getCurNode() and slot3:checkIsNormal() and not slot3:isFinishEvent() then
		return uv0.CantUseMapSkillReason.DoingEvent
	end
end

function slot0.checkMiddleLayer(slot0, slot1)
	if slot1.middleLayerLimit == 0 and RougeMapModel.instance:isMiddle() then
		return uv0.CantUseMapSkillReason.ForbidenMiddle
	end
end

function slot0.checkPathSelectLayer(slot0, slot1)
	if slot1.middleLayerLimit == 0 and RougeMapModel.instance:isPathSelect() then
		return uv0.CantUseMapSkillReason.ForbidenPathSelect
	end
end

function slot0.checkUseLimiter(slot0, slot1)
	if slot1.useLimit <= slot0:getUseCount() then
		return uv0.CantUseMapSkillReason.UseLimit
	end
end

function slot0.checkStepCd(slot0, slot1)
	if slot1.stepCd <= slot0:getStepRecord() then
		return uv0.CantUseMapSkillReason.StepCd
	end
end

function slot0.checkCoinCost(slot0, slot1)
	if (RougeModel.instance:getRougeInfo() and slot2.coin or 0) < slot1.coinCost then
		return uv0.CantUseMapSkillReason.CoinCost
	end
end

function slot0.checkPowerCost(slot0, slot1)
	if (RougeModel.instance:getRougeInfo() and slot2.power or 0) < slot1.powerCost then
		return uv0.CantUseMapSkillReason.PowerCost
	end
end

function slot0._initUseMapSkillCallBackMap()
	if not uv0._mapSkillUseCallBackMap then
		uv0._mapSkillUseCallBackMap = {
			[13002] = uv0.useMapSkill_13002
		}
	end
end

function slot0.executeUseMapSkillCallBack(slot0)
	if not slot0 then
		return
	end

	uv0._initUseMapSkillCallBackMap()

	if uv0._mapSkillUseCallBackMap[slot0.id] then
		slot1(slot0)
	end
end

function slot1(slot0, slot1, slot2)
	if RougeMapModel.instance:getNode(slot0) and not slot3:checkIsEnd() and slot3.nextNodeList then
		for slot8, slot9 in ipairs(slot4) do
			slot11 = RougeMapModel.instance:getNode(slot9) and slot10:getEventCo()

			if slot10 and not slot10:checkIsEnd() and not (slot11 and slot11.type == RougeMapEnum.EventType.TreasurePlace) and not slot1[slot9] then
				slot1[slot9] = true

				table.insert(slot2, slot9)
			end

			uv0(slot9, slot1, slot2)
		end
	end
end

function slot0.useMapSkill_13002(slot0, slot1)
	if RougeMapModel.instance:isNormalLayer() then
		slot5 = {}

		uv0(RougeMapModel.instance:getCurNode() and slot3.nodeId, {}, slot5)

		if #slot5 < 2 then
			GameFacade.showToast(ToastEnum.UseMapSkillLimit_13002)
		end
	end
end

return slot0
