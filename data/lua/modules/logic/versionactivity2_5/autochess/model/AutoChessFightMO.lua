module("modules.logic.versionactivity2_5.autochess.model.AutoChessFightMO", package.seeall)

slot0 = pureTable("AutoChessFightMO")

function slot0.init(slot0, slot1)
	slot0.round = slot1.round

	slot0:initWarZones(slot1.warZones)

	slot0.mySideMaster = uv0.copyMaster(slot1.mySideMaster)
	slot0.enemyMaster = uv0.copyMaster(slot1.enemyMaster)
end

function slot0.initWarZones(slot0, slot1)
	slot0.warZones = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = {
			id = slot6.id,
			type = slot6.type,
			positions = {}
		}

		for slot11, slot12 in ipairs(slot6.positions) do
			table.insert(slot7.positions, {
				index = slot12.index,
				teamType = slot12.teamType,
				chess = slot12.chess
			})
		end

		table.insert(slot0.warZones, slot7)
	end
end

function slot0.copyMaster(slot0)
	return {
		id = slot0.id,
		teamType = slot0.teamType,
		hp = slot0.hp,
		uid = slot0.uid,
		skill = slot0.skill,
		buffContainer = slot0.buffContainer
	}
end

function slot0.updateMasterSkill(slot0, slot1)
	slot0.mySideMaster.skill = slot1

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function slot0.unlockMasterSkill(slot0, slot1)
	if slot0.mySideMaster.uid == slot1 then
		slot0.mySideMaster.skill.unlock = true
	elseif slot0.enemyMaster.uid == slot1 then
		slot0.enemyMaster.skill.unlock = true
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function slot0.updateMaster(slot0, slot1)
	slot0.mySideMaster = uv0.copyMaster(slot1)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function slot0.hasUpgradeableChess(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.warZones) do
		for slot10, slot11 in ipairs(slot6.positions) do
			if slot11.index < AutoChessEnum.BoardSize.Column and slot11.chess.id == slot1 and slot11.chess.maxExpLimit ~= 0 then
				return true
			end
		end
	end

	return false
end

return slot0
