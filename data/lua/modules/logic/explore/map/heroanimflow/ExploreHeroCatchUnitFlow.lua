module("modules.logic.explore.map.heroanimflow.ExploreHeroCatchUnitFlow", package.seeall)

slot0 = class("ExploreHeroCatchUnitFlow")

function slot0.catchUnit(slot0, slot1)
	if ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	slot0._catchUnit = slot1

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	slot2 = slot0:getHero()

	slot2:setTrOffset(ExploreHelper.xyToDir(slot1.mo.nodePos.x - slot2.nodePos.x, slot1.mo.nodePos.y - slot2.nodePos.y), (slot2:getPos() - slot1:getPos()):SetNormalize():Mul(0.3):Add(slot1:getPos()), 0.39, slot0.onRoleMoveToUnitEnd, slot0)
	slot2:setMoveSpeed(0.3)
end

function slot0.onRoleMoveToUnitEnd(slot0)
	slot0:getHero():setMoveSpeed(0)

	if slot0._catchUnit then
		slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPick)
	else
		slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPut)
	end

	TaskDispatcher.runDelay(slot0._delayCatchUnit, slot0, 0.4)
end

function slot0._delayCatchUnit(slot0)
	if slot0._catchUnit then
		if slot0:getHero():getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right) then
			slot0._catchUnit:setParent(slot2, ExploreEnum.ExplorePipePotHangType.Carry)
		end

		AudioMgr.instance:trigger(AudioEnum.Explore.Pick_Pot)
	else
		slot0._uncatchUnit:setParent(ExploreController.instance:getMap():getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
		AudioMgr.instance:trigger(AudioEnum.Explore.Put_Pot)
	end

	TaskDispatcher.runDelay(slot0._onCatchEnd, slot0, 0.4)
end

function slot0._onCatchEnd(slot0)
	slot0:getHero():setMoveSpeed(0)

	if slot0._catchUnit then
		slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)

		slot2 = ExploreHelper.tileToPos(ExploreHelper.posToTile(slot1:getPos() + slot1._displayTr.localPosition))
		slot2.y = slot1:getPos().y

		slot1:setTrOffset(nil, slot2, 0.21, slot0.onRoleMoveToCenterEnd, slot0)
		slot1:setMoveSpeed(0.3)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	else
		slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
		slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.MoveBack)

		slot2 = slot1:getPos():Clone()
		slot3 = ExploreHelper.dirToXY(slot1.dir)
		slot4 = slot2:Clone()
		slot4.x = slot4.x - slot3.x * 1
		slot4.z = slot4.z - slot3.y * 1
		slot2.x = slot2.x - slot3.x * 0.3
		slot2.z = slot2.z - slot3.y * 0.3
		slot1._displayTr.localPosition = slot2 - slot4

		slot1:setPos(slot4, nil, true)
		slot1:setTrOffset(slot1.dir, slot4, 0.6, slot0.onRoleMoveBackEnd, slot0)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	end
end

function slot0.onRoleMoveToCenterEnd(slot0)
	slot1 = slot0:getHero()

	slot1:setPos(slot1:getPos() + slot1._displayTr.localPosition)

	slot1._displayTr.localPosition = Vector3.zero

	slot1:setMoveSpeed(0)

	slot0._catchUnit = nil

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.CatchUnit)
end

function slot0.onRoleMoveBackEnd(slot0)
	if slot0._catchUnit and slot0._fromUnit then
		slot0:getHero():setMoveSpeed(0)
	else
		slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	end

	if slot0._endCallBack and slot0._fromUnit then
		slot0._endCallBack(slot0._fromUnit)
	end

	slot0._catchUnit = nil
	slot0._uncatchUnit = nil
	slot0._fromUnit = nil
	slot0._endCallBack = nil

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.CatchUnit)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryEnd)
end

function slot0.uncatchUnit(slot0, slot1)
	slot2 = slot0:getHero()

	if ExploreHeroResetFlow.instance:isReseting() then
		slot1:setParent(ExploreController.instance:getMap():getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
		slot2:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)

		return
	end

	transformhelper.setLocalPos(slot1.trans, 0, 0, 0)

	slot0._uncatchUnit = slot1

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	slot3 = ExploreHelper.dirToXY(slot2.dir)
	slot4 = slot2:getPos():Clone()
	slot4.x = slot4.x - slot3.x * 0.3
	slot4.z = slot4.z - slot3.y * 0.3

	slot2:setTrOffset(slot2.dir, slot4, 0.39, slot0.onRoleMoveToUnitEnd, slot0)
	slot2:setMoveSpeed(0.3)
end

function slot0.getHero(slot0)
	return ExploreController.instance:getMap():getHero()
end

function slot0.isInFlow(slot0, slot1)
	if not slot1 then
		return slot0._catchUnit or slot0._uncatchUnit
	end

	return slot1 == slot0._catchUnit or slot1 == slot0._uncatchUnit
end

function slot0.catchUnitFrom(slot0, slot1, slot2, slot3)
	if ExploreHeroResetFlow.instance:isReseting() then
		slot3(slot2)

		return
	end

	slot0._catchUnit = slot1
	slot0._fromUnit = slot2
	slot0._endCallBack = slot3

	slot0:moveToFromUnit(slot2)
end

function slot0.uncatchUnitFrom(slot0, slot1, slot2, slot3)
	if ExploreHeroResetFlow.instance:isReseting() then
		slot3(slot2)

		return
	end

	slot0._uncatchUnit = slot1
	slot0._fromUnit = slot2
	slot0._endCallBack = slot3

	transformhelper.setLocalPos(slot0._uncatchUnit.trans, 0, 0, 0)
	slot0:moveToFromUnit(slot2)
end

function slot0.moveToFromUnit(slot0, slot1)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	slot2 = slot0:getHero()

	slot2:setTrOffset(ExploreHelper.xyToDir(slot1.mo.nodePos.x - slot2.nodePos.x, slot1.mo.nodePos.y - slot2.nodePos.y), (slot2:getPos() - slot1:getPos()):SetNormalize():Mul(0.3):Add(slot1:getPos()), 0.39, slot0.onRoleMoveToFromUnitEnd, slot0)
	slot2:setMoveSpeed(0.3)
end

function slot0.onRoleMoveToFromUnitEnd(slot0)
	slot0:getHero():setMoveSpeed(0)

	slot2 = 0.4

	if slot0._catchUnit then
		slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPick)
	else
		slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPut)

		slot2 = 0.2
	end

	TaskDispatcher.runDelay(slot0._delayCatchUnitFromUnit, slot0, slot2)
end

function slot0._delayCatchUnitFromUnit(slot0)
	slot1 = 0.4

	if slot0._catchUnit then
		if slot0:getHero():getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right) then
			slot0._catchUnit:setParent(slot3, ExploreEnum.ExplorePipePotHangType.Carry)
		end

		AudioMgr.instance:trigger(AudioEnum.Explore.Take_On_Pot)
	else
		slot0._uncatchUnit:setParent(slot0._fromUnit.trans, ExploreEnum.ExplorePipePotHangType.Put)

		slot1 = 0.6

		AudioMgr.instance:trigger(AudioEnum.Explore.Take_Off_Pot)
	end

	TaskDispatcher.runDelay(slot0._onCatchFromUnitEnd, slot0, slot1)
end

function slot0._onCatchFromUnitEnd(slot0)
	slot1 = slot0._fromUnit
	slot2 = slot0:getHero()

	slot2:setTrOffset(ExploreHelper.xyToDir(slot1.nodePos.x - slot2.nodePos.x, slot1.mo.nodePos.y - slot2.nodePos.y), ExploreHelper.tileToPos(slot2.nodePos), 0.39, slot0.onRoleMoveBackEnd, slot0)

	if slot0._catchUnit then
		slot2:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)
		slot2:setMoveSpeed(0.3)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	else
		slot2:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
		slot2:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.MoveBack)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	end
end

function slot0.clear(slot0)
	slot0._catchUnit = nil
	slot0._uncatchUnit = nil
	slot0._fromUnit = nil
	slot0._endCallBack = nil

	TaskDispatcher.cancelTask(slot0._delayCatchUnitFromUnit, slot0)
	TaskDispatcher.cancelTask(slot0._delayCatchUnit, slot0)
	TaskDispatcher.cancelTask(slot0._onCatchEnd, slot0)
	TaskDispatcher.cancelTask(slot0._onCatchFromUnitEnd, slot0)
end

slot0.instance = slot0.New()

return slot0
