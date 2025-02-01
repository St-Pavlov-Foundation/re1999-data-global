module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaController", package.seeall)

slot0 = class("TianShiNaNaController", BaseController)

function slot0.onInit(slot0)
	slot0._stepFlow = nil
end

function slot0.reInit(slot0)
	slot0:clearFlow()
end

function slot0.addConstEvents(slot0)
	slot0:registerCallback(TianShiNaNaEvent.ExitLevel, slot0.clearFlow, slot0)
end

function slot0.openMainView(slot0)
	Activity167Rpc.instance:sendGetAct167InfoRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, slot0._onRecvMsg, slot0)
end

function slot0._onRecvMsg(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		ViewMgr.instance:openView(ViewName.TianShiNaNaMainView)
	end
end

function slot0.buildFlow(slot0, slot1)
	slot2 = slot0._stepFlow
	slot0._stepFlow = slot0._stepFlow or FlowSequence.New()

	slot0._stepFlow:addWork(TianShiNaNaPlayEffectWork.New())

	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if cjson.decode(slot9.param).stepType == TianShiNaNaEnum.StepType.Move and slot10.id == TianShiNaNaModel.instance:getHeroMo().co.id then
			table.insert(slot4, slot10)
		end

		if _G[string.format("TianShiNaNa%sStep", TianShiNaNaEnum.StepTypeToName[slot10.stepType] or "")] then
			slot12 = slot11.New()

			slot12:initData(slot10)
			slot0._stepFlow:addWork(slot12)
		else
			logError("未处理步骤类型" .. slot10.stepType)
		end
	end

	slot3:setWalkPath(slot4)

	if not slot2 then
		slot0._stepFlow:addWork(TianShiNaNaMapCollapseStep.New())
		slot0._stepFlow:registerDoneListener(slot0.flowDone, slot0)

		if TianShiNaNaModel.instance.sceneLevelLoadFinish then
			if TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.DoStep then
				TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
			end

			slot0._stepFlow:start()
		else
			TianShiNaNaModel.instance.waitStartFlow = true
		end
	end
end

function slot0.checkBeginFlow(slot0)
	TianShiNaNaModel.instance.waitStartFlow = false

	if TianShiNaNaModel.instance.waitStartFlow and slot0._stepFlow then
		slot0._stepFlow:start()
	end
end

function slot0.flowDone(slot0, slot1)
	slot0:dispatchEvent(TianShiNaNaEvent.OnFlowEnd, slot1)

	slot0._stepFlow = nil
end

function slot0.clearFlow(slot0)
	TianShiNaNaModel.instance.waitStartFlow = false

	if slot0._stepFlow then
		slot0._stepFlow:onDestroyInternal()

		slot0._stepFlow = nil
	end
end

slot0.instance = slot0.New()

return slot0
