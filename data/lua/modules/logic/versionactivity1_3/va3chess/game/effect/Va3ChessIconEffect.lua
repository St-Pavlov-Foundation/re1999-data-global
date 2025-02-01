module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessIconEffect", package.seeall)

slot0 = class("Va3ChessIconEffect", Va3ChessEffectBase)

function slot0.onAvatarLoaded(slot0)
	if not slot0._loader then
		return
	end

	if not gohelper.isNil(slot0._loader:getInstGO()) then
		gohelper.setLayer(slot1, UnityLayer.Scene, true)

		slot2 = gohelper.findChild(slot1, "icon_tanhao")
		slot0._target.avatar.goTrack = slot2

		gohelper.setActive(slot2, false)

		slot3 = gohelper.findChild(slot1, "icon_jianshi")
		slot0._target.avatar.goTracked = slot3

		gohelper.setActive(slot3, false)

		slot0.moveKillIcon = gohelper.findChild(slot1, "icon_kejisha")

		gohelper.setActive(slot0.moveKillIcon, false)

		slot0.willKillPlayerIcon = gohelper.findChild(slot1, "icon_yuxi")

		gohelper.setActive(slot0.willKillPlayerIcon, false)

		slot0.fireBallKillIcon = gohelper.findChild(slot1, "icon_huoyanbiaoji")

		gohelper.setActive(slot0.fireBallKillIcon, false)
	end

	slot0._dirPointGODict = {}
	slot0._dirCanFireKillEffGODict = {}

	for slot5, slot6 in pairs(Va3ChessEnum.Direction) do
		if not gohelper.isNil(slot0._target.avatar["goFaceTo" .. slot6]) then
			slot0._dirPointGODict[slot6] = gohelper.findChild(slot7, slot0._effectCfg.piontName)
			slot9 = gohelper.findChild(slot7, "selected")
			slot0._dirCanFireKillEffGODict[slot6] = slot9

			gohelper.setActive(slot9, false)
		end
	end

	slot0:refreshEffectFaceTo()
end

function slot0.refreshEffectFaceTo(slot0)
	if not slot0._dirPointGODict then
		return
	end

	if not gohelper.isNil(slot0._dirPointGODict[slot0._target.originData:getDirection()]) then
		slot3, slot4, slot5 = transformhelper.getPos(slot2.transform)

		transformhelper.setPos(slot0.effectGO.transform, slot3, slot4, slot5)
	end

	slot0:refreshKillEffect()
end

function slot0.refreshKillEffect(slot0)
	slot1 = false
	slot2 = {}

	if slot0._target and slot0._target.originData and slot0._target.originData.data then
		slot2 = slot0._target.originData.data.alertArea
	end

	if slot2 and #slot2 > 0 then
		for slot6, slot7 in ipairs(slot2) do
			if Va3ChessGameController.instance:getPlayerNextCanWalkPosDict()[Activity142Helper.getPosHashKey(slot7.x, slot7.y)] then
				break
			end
		end
	end

	gohelper.setActive(slot0.willKillPlayerIcon, slot1)

	slot3 = Activity142Helper.isCanFireKill(slot0._target)

	gohelper.setActive(slot0.fireBallKillIcon, slot3)
	slot0:refreshCanMoveKillEffect()
	slot0:refreshCanFireBallKillEffect(slot3)
end

function slot0.refreshCanMoveKillEffect(slot0)
	gohelper.setActive(slot0.moveKillIcon, Activity142Helper.isCanMoveKill(slot0._target))
end

function slot0.refreshCanFireBallKillEffect(slot0, slot1)
	if not slot0._dirCanFireKillEffGODict then
		return
	end

	for slot6, slot7 in pairs(slot0._dirCanFireKillEffGODict) do
		gohelper.setActive(slot7, slot1 and slot0._target.originData:getDirection() == slot6)
	end
end

function slot0.isShowEffect(slot0, slot1)
	if not slot0._loader then
		return
	end

	if not gohelper.isNil(slot0._loader:getInstGO()) then
		gohelper.setActive(slot2, slot1)
	end
end

function slot0.onDispose(slot0)
	if slot0._dirPointGODict then
		for slot4, slot5 in pairs(slot0._dirPointGODict) do
			slot5 = nil
		end

		slot0._dirPointGODict = nil
	end

	if slot0._dirCanFireKillEffGODict then
		for slot4, slot5 in pairs(slot0._dirCanFireKillEffGODict) do
			slot5 = nil
		end

		slot0._dirCanFireKillEffGODict = nil
	end
end

return slot0
