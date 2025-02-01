module("modules.logic.seasonver.act123.controller.Season123ControllerCardEffectHandleFunc", package.seeall)

slot0 = Season123Controller

function slot0.activeHandleFuncController()
end

function slot0.ReduceRoundCount(slot0, slot1, slot2)
	Season123Model.instance:getActInfo(slot2.actId):getStageMO(slot2.stage):updateReduceEpisodeRoundState(slot2.layer, GameUtil.getTabLen(slot1) > 0)
end

slot0.SpecialEffctHandleFunc = {
	[Activity123Enum.EquipCardEffect.ReduceRoundCount] = slot0.ReduceRoundCount
}

return slot0
