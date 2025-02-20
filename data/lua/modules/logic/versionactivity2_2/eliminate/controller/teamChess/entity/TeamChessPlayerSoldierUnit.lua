module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessPlayerSoldierUnit", package.seeall)

slot0 = class("TeamChessPlayerSoldierUnit", TeamChessSoldierUnit)

function slot0._onResLoaded(slot0)
	uv0.super._onResLoaded(slot0)

	if gohelper.isNil(slot0._backGo) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_put)
	slot0:playAnimator("in")
	slot0:refreshMeshOrder()
	slot0:setActive(true)
	slot0:refreshShowModeState()
end

function slot0.setOutlineActive(slot0, slot1)
	if gohelper.isNil(slot0._backOutLineGo) then
		return
	end

	gohelper.setActive(slot0._backOutLineGo.gameObject, slot1)
	uv0.super.setOutlineActive(slot0, slot1)
end

function slot0.setNormalActive(slot0, slot1)
	if gohelper.isNil(slot0._backGo) then
		return
	end

	gohelper.setActive(slot0._backGo.gameObject, slot1)
	uv0.super.setNormalActive(slot0, slot1)
end

function slot0.setGrayActive(slot0, slot1)
	if gohelper.isNil(slot0._backGrayGo) then
		return
	end

	gohelper.setActive(slot0._backGrayGo.gameObject, slot1)
	uv0.super.setGrayActive(slot0, slot1)
end

function slot0.onDrag(slot0, slot1, slot2)
	if not slot0._unitMo:canActiveMove() then
		return
	end

	slot0:cacheModel()
	slot0:setShowModeType()

	slot3 = slot0._unitMo

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDrag, slot3.soldierId, slot3.uid, slot3.stronghold, slot1, slot2)
end

function slot0.onDragEnd(slot0, slot1, slot2)
	if not slot0._unitMo:canActiveMove() then
		return
	end

	slot0:restoreModel()

	slot3 = slot0._unitMo

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEnd, slot3.soldierId, slot3.uid, slot3.stronghold, slot1, slot2)
end

return slot0
