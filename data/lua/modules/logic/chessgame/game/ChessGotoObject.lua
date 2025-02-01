module("modules.logic.chessgame.game.ChessGotoObject", package.seeall)

slot0 = class("ChessGotoObject")

function slot0.ctor(slot0, slot1)
	slot0._target = slot1
	slot0._srcList = nil
	slot0._itemTrackMark = false
end

function slot0.init(slot0)
end

function slot0.initAttract(slot0)
	slot0._attractEnemyMap = {}

	if slot0._target.config and slot0._target.config.interactType == ChessGameEnum.InteractType.Item and not string.nilorempty(slot0._target.config.showParam) then
		for slot5, slot6 in pairs(string.splitToNumber(slot0._target.config.showParam, "#")) do
			logNormal("ChessGotoObject initAttract : " .. tostring(slot6))

			slot0._attractEnemyMap[slot6] = true
		end
	end
end

function slot0.updateGoToObject(slot0)
	slot1 = nil

	if slot0._target.originData.data then
		slot1 = slot2.goToObject
	end

	if slot0._goToObjectId == slot1 then
		return
	end

	slot0:deleteRelation()

	slot0._goToObjectId = slot1

	if ChessGameController.instance.interacts:get(slot1) ~= nil then
		slot4.goToObject:addSource(slot0._target.originData.id)
	end

	slot0:refreshTarget()
end

function slot0.deleteRelation(slot0)
end

function slot0.refreshSource(slot0)
	if slot0._target.avatar and slot0._target.avatar.goTracked then
		if slot0._srcList then
			gohelper.setActive(slot0._target.avatar.goTracked, #slot0._srcList > 0)
		else
			gohelper.setActive(slot0._target.avatar.goTracked, false)
		end
	end
end

function slot0.refreshTarget(slot0)
	if slot0._target.avatar then
		slot1 = false
		slot2 = false

		if slot0._goToObjectId ~= nil and slot0._goToObjectId ~= 0 then
			slot3 = nil

			if ChessGameController.instance.interacts:get(slot0._goToObjectId) ~= nil then
				slot3 = slot4.objType
			end

			if slot3 == ChessGameEnum.InteractType.Item or slot3 == ChessGameEnum.InteractType.NoEffectItem then
				slot2 = true
			else
				slot1 = true
			end
		end

		if slot0._target.originData.data and slot3.lostTarget == true then
			gohelper.setActive(slot0._target.avatar.goTrackItem, false)
			gohelper.setActive(slot0._target.avatar.goTrack, false)

			return
		end

		gohelper.setActive(slot0._target.avatar.goTrackItem, slot2 or slot0._itemTrackMark)
		gohelper.setActive(slot0._target.avatar.goTrack, slot1)
	end
end

function slot0.addSource(slot0, slot1)
	slot0._srcList = slot0._srcList or {}

	table.insert(slot0._srcList, slot1)
	slot0:refreshSource()
end

function slot0.removeSource(slot0, slot1)
	if slot0._srcList then
		tabletool.removeValue(slot0._srcList, slot1)
	end

	slot0:refreshSource()
end

function slot0.setItemTrackMark(slot0, slot1)
	slot0._itemTrackMark = slot1
end

function slot0.setMarkAttract(slot0, slot1)
	for slot5, slot6 in pairs(slot0._attractEnemyMap) do
		if ChessGameController.instance.interacts:get(slot5) ~= nil then
			slot7.goToObject:setItemTrackMark(slot1)
			slot7.goToObject:refreshTarget()
		end
	end
end

function slot0.onAvatarLoaded(slot0)
	if not slot0._target.avatar.loader then
		return
	end

	slot0._target.avatar.goTracked = gohelper.findChild(slot1:getInstGO(), "piecea/vx_tracked")
	slot0._target.avatar.goTrack = gohelper.findChild(slot1:getInstGO(), "piecea/vx_track")
	slot0._target.avatar.goTrackItem = gohelper.findChild(slot1:getInstGO(), "piecea/vx_wenao")

	slot0:refreshSource()
	slot0:refreshTarget()
end

function slot0.dispose(slot0)
	slot0:deleteRelation()
end

return slot0
