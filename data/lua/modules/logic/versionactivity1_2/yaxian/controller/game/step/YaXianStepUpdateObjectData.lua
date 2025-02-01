module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepUpdateObjectData", package.seeall)

slot0 = class("YaXianStepUpdateObjectData", YaXianStepBase)

function slot0.start(slot0)
	slot1 = slot0.originData.object
	slot0.interactId = slot1.id
	slot2 = slot1.data

	logNormal("start update object data : " .. slot0.interactId)

	if YaXianGameModel.instance:getInteractMo(slot0.interactId) then
		slot3:updateDataByTableData(slot2)

		if slot3.config.interactType == YaXianGameEnum.InteractType.Player then
			slot0:handleUpdateSkillInfo(slot2 and slot2.skills)
			slot0:handleUpdateEffects(slot2 and slot2.effects)
		end
	end

	slot0:finish()
end

function slot0.handleUpdateSkillInfo(slot0, slot1)
	if YaXianGameModel.instance:updateSkillInfoAndCheckHasChange(slot1) then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
	end
end

function slot0.handleUpdateEffects(slot0, slot1)
	if YaXianGameModel.instance:updateEffectsAndCheckHasChange(slot1) then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
	end
end

function slot0.dispose(slot0)
end

return slot0
