module("modules.logic.fight.entity.FightEntityAssembledMonsterSub", package.seeall)

slot0 = class("FightEntityAssembledMonsterSub", FightEntityMonster)

function slot0.getScale(slot0)
	return slot0.mainEntity:getScale()
end

function slot0.setScale(slot0, slot1)
	slot0.mainEntity:setScale(slot1)
end

function slot0.getHangPoint(slot0, slot1, slot2)
	if not slot2 and not string.nilorempty(slot1) and ModuleEnum.SpineHangPointRoot ~= slot1 then
		slot1 = string.format("%s_part_%d", slot1, slot0:getPartIndex())
	end

	return uv0.super.getHangPoint(slot0, slot1)
end

function slot0.resetAnimState(slot0)
	slot0.mainEntity:resetAnimState()
end

function slot0.setAlpha(slot0, slot1, slot2)
	slot0.mainEntity:setAlphaData(slot0.id, slot1, slot2)
end

function slot0.loadSpine(slot0)
end

function slot0.getMainEntityId(slot0)
	if slot0.mainEntityId then
		return slot0.mainEntityId
	end

	slot1 = nil

	for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		if lua_fight_assembled_monster.configDict[slot7.skin] and slot8.part == 1 then
			slot1 = slot7.id

			break
		end
	end

	if not slot1 then
		logError("构建组合怪部件,但是没有找到主怪")

		return
	end

	slot0.mainEntityId = slot1

	return slot0.mainEntityId
end

function slot0.getMainEntity(slot0)
	slot0.mainEntity = slot0.mainEntity or FightHelper.getEntity(slot0.mainEntityId)

	return slot0.mainEntity
end

function slot0.initComponents(slot0)
	if not slot0:getMainEntityId() then
		return
	end

	slot0:getMainEntity()

	slot0.filterComp = {
		moveHandler = true,
		curveMover = true,
		spineRenderer = true,
		spine = true,
		parabolaMover = true,
		mover = true,
		bezierMover = true
	}
	slot1 = FightHelper.getEntity(slot0.mainEntityId)
	slot0.mainSpine = slot1.spine
	slot0.spine = FightAssembledMonsterSpineSub.New(slot0)
	slot0.spineRenderer = slot1.spineRenderer
	slot0.mover = slot1.mover
	slot0.parabolaMover = slot1.parabolaMover
	slot0.bezierMover = slot1.bezierMover
	slot0.curveMover = slot1.curveMover
	slot0.moveHandler = slot1.moveHandler

	uv0.super.initComponents(slot0)
end

function slot0.getPartIndex(slot0)
	if slot0:getMO() then
		return lua_fight_assembled_monster.configDict[slot1.skin].part
	end
end

return slot0
