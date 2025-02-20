module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessEnemySoldierUnit", package.seeall)

slot0 = class("TeamChessEnemySoldierUnit", TeamChessSoldierUnit)

function slot0._onResLoaded(slot0)
	uv0.super._onResLoaded(slot0)

	if gohelper.isNil(slot0._frontGo) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_put)
	slot0:refreshMeshOrder()
	slot0:playAnimator("in")
	slot0:setActive(true)
end

function slot0.setOutlineActive(slot0, slot1)
	if gohelper.isNil(slot0._frontOutLineGo) then
		return
	end

	gohelper.setActive(slot0._frontOutLineGo.gameObject, slot1)
	uv0.super.setOutlineActive(slot0, slot1)
end

function slot0.setNormalActive(slot0, slot1)
	if gohelper.isNil(slot0._frontGo) then
		return
	end

	gohelper.setActive(slot0._frontGo.gameObject, slot1)
	uv0.super.setNormalActive(slot0, slot1)
end

function slot0.setGrayActive(slot0, slot1)
	if gohelper.isNil(slot0._frontGrayGo) then
		return
	end

	gohelper.setActive(slot0._frontGrayGo.gameObject, slot1)
	uv0.super.setGrayActive(slot0, slot1)
end

return slot0
