module("modules.logic.explore.map.whirl.comp.ExploreWhirlFollowComp", package.seeall)

slot0 = class("ExploreWhirlFollowComp", LuaCompBase)
slot1 = {
	Down = -1,
	Up = 1
}

function slot0.ctor(slot0, slot1)
	slot0._whirl = slot1
	slot0._isPause = false
end

function slot0.setup(slot0, slot1)
	slot0._go = slot1
	slot0._trans = slot1.transform
	slot0._minHeight = 0.6
	slot0._maxHeight = 0.8
	slot0._radius = 0.4
	slot0._upDownSpeed = 0.003
	slot0._moveSpeed = 0.05
	slot0._rotateSpeed = 1
	slot0._nowHeight = 0.7
	slot0._nowDir = uv0.Up
end

function slot0.start(slot0)
	slot0._isPause = false

	slot0:onUpdatePos()
end

function slot0.pause(slot0)
	slot0._isPause = true
end

function slot0.onUpdate(slot0)
	if not slot0._go or slot0._isPause then
		return
	end

	slot0:onUpdatePos()
end

function slot0._getHero(slot0)
	return ExploreController.instance:getMap():getHero()
end

function slot0.onUpdatePos(slot0)
	slot1 = slot0:_getHero()._displayTr
	slot3 = -slot1.forward:Mul(slot0._radius) + slot1.position

	if slot0._nowDir == uv0.Up then
		slot0._nowHeight = slot0._nowHeight + slot0._upDownSpeed

		if slot0._maxHeight <= slot0._nowHeight then
			slot0._nowDir = uv0.Down
		end
	else
		slot0._nowHeight = slot0._nowHeight - slot0._upDownSpeed

		if slot0._nowHeight <= slot0._minHeight then
			slot0._nowDir = uv0.Up
		end
	end

	slot3.y = slot0._nowHeight

	slot0._trans:Rotate(0, slot0._rotateSpeed, 0)

	if slot0._trans.position:Sub(slot3):SqrMagnitude() > slot0._moveSpeed * slot0._moveSpeed then
		slot6 = Vector3.Lerp(slot0._trans.position, slot3, slot0._moveSpeed / math.sqrt(slot5)) - slot2
		slot6.y = 0

		if slot6:SqrMagnitude() > 1 then
			slot8 = slot6:SetNormalize():Add(slot2)
			slot8.y = slot3.y
			slot3 = slot8
		end

		slot0._trans.position = slot3
	else
		slot0._trans.position = slot3
	end
end

function slot0.onDestroy(slot0)
	slot0._go = nil
	slot0._trans = nil
	slot0._whirl = nil
	slot0._isPause = false
end

return slot0
