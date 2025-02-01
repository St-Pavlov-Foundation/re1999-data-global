module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDialogAndMoveStep", package.seeall)

slot0 = class("TianShiNaNaDialogAndMoveStep", TianShiNaNaDialogStep)

function slot0.onStart(slot0, slot1)
	if slot0._data.isMonsterMove == 1 then
		return slot0:beginPlayDialog()
	end

	if not TianShiNaNaModel.instance:getHeroMo() then
		logError("对话时，角色不存在")

		return slot0:onDone(true)
	end

	slot0._targetEntity = TianShiNaNaEntityMgr.instance:getEntity(slot0._data.interactId)

	if not TianShiNaNaEntityMgr.instance:getEntity(slot2.co.id) then
		logError("对话时，角色不存在")

		return slot0:onDone(true)
	end

	if not slot0._targetEntity then
		logError("对话时，目标不存在")

		return slot0:onDone(true)
	end

	return slot3:moveToHalf(slot0._targetEntity._unitMo.x, slot0._targetEntity._unitMo.y, slot0._onEndMove, slot0)
end

function slot0._onEndMove(slot0)
	slot1 = TianShiNaNaModel.instance:getHeroMo()

	slot0._targetEntity:changeDir(slot1.x, slot1.y)
	slot0:beginPlayDialog()
end

return slot0
