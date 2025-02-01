module("modules.logic.explore.controller.trigger.ExploreTriggerBonusScene", package.seeall)

slot0 = class("ExploreTriggerBonusScene", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.ExploreBonusSceneView, {
		id = tonumber(slot2.mo.specialDatas[1]),
		unit = slot2,
		callBack = slot0.onFinish,
		callBackObj = slot0
	})
end

function slot0.onFinish(slot0, slot1)
	ExploreSimpleModel.instance:onGetBonus(tonumber(slot0._unit.mo.specialDatas[1]), slot1)
	ExploreStepController.instance:insertClientStep({
		stepType = ExploreEnum.StepType.BonusSceneClient
	}, 1)
	slot0:sendTriggerRequest(table.concat(slot1, "#"))
end

function slot0.clearWork(slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBonusSceneView)
end

return slot0
