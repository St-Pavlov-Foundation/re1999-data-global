module("modules.logic.explore.map.unit.ExploreDoor", package.seeall)

slot0 = class("ExploreDoor", ExploreBaseDisplayUnit)
slot0.PairAnim = {
	[ExploreAnimEnum.AnimName.nToA] = ExploreAnimEnum.AnimName.aToN,
	[ExploreAnimEnum.AnimName.count0to1] = ExploreAnimEnum.AnimName.count1to0,
	[ExploreAnimEnum.AnimName.count1to2] = ExploreAnimEnum.AnimName.count2to1,
	[ExploreAnimEnum.AnimName.count2to3] = ExploreAnimEnum.AnimName.count3to2,
	[ExploreAnimEnum.AnimName.count3to4] = ExploreAnimEnum.AnimName.count4to3
}

function slot0.onInit(slot0)
	slot0._count = 0
	slot0._totalCount = 0
end

function slot0.setName(slot0, slot1)
	slot0.go.name = slot1
end

function slot0.setupMO(slot0)
	slot0.mo:updateWalkable()
end

function slot0.onResLoaded(slot0)
	uv0.super.onResLoaded(slot0)
	gohelper.setActive(slot0._displayTr:Find("effect"), slot0.mo.isPreventItem)

	if slot0.mo.specialDatas[2] == "1" then
		slot0.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_red"))
	elseif slot0.mo.specialDatas[2] == "2" then
		slot0.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_blue"))
	elseif slot0.mo.specialDatas[2] == "3" then
		slot0.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_green"))
	end
end

function slot0.onUpdateCount(slot0, slot1, slot2)
	if slot2 then
		slot0._count = slot1
		slot0._totalCount = slot2

		slot0:playAnim(slot0:getIdleAnim())
	elseif slot1 < slot0._count then
		if slot0._count == slot0._totalCount then
			slot0:playAnim(ExploreAnimEnum.AnimName.aToN)
		elseif slot0:_canChangeCountAnim() then
			slot0:playAnim(string.format("count%dto%d", slot0._count, slot1))
		end

		slot0._count = slot1
	elseif slot0._count < slot1 then
		if slot1 == slot0._totalCount then
			slot0:playAnim(ExploreAnimEnum.AnimName.nToA)
		elseif slot0:_canChangeCountAnim() then
			slot0:playAnim(string.format("count%dto%d", slot0._count, slot1))
		end

		slot0._count = slot1
	end
end

function slot0._canChangeCountAnim(slot0)
	if slot0.animComp._curAnim == ExploreAnimEnum.AnimName.aToN or slot1 == ExploreAnimEnum.AnimName.nToA then
		return false
	end

	return true
end

function slot0.getIdleAnim(slot0)
	if slot0._count > 0 and slot0._count ~= slot0._totalCount then
		return "count" .. slot0._count
	else
		return uv0.super.getIdleAnim(slot0)
	end
end

function slot0.onActiveChange(slot0, slot1)
	if not slot1 then
		slot0.mo:updateWalkable()
		slot0:checkLight()
	elseif slot0.animComp:isIdleAnim() then
		slot0.mo:updateWalkable()
		slot0:checkLight()
	end

	slot0:checkShowIcon()

	if slot0._totalCount == 0 then
		uv0.super.onActiveChange(slot0, slot1)
	end
end

function slot0.canTrigger(slot0)
	if slot0.mo and slot0.mo:isInteractActiveState() then
		return false
	end

	return uv0.super.canTrigger(slot0)
end

function slot0.isPassLight(slot0)
	return slot0.mo:isWalkable()
end

function slot0.onAnimEnd(slot0, slot1, slot2)
	slot0.mo:updateWalkable()
	slot0:checkLight()

	if not slot0.animComp:isIdleAnim(slot2) then
		return
	end

	if slot0:getIdleAnim() ~= slot2 then
		slot0.animComp:playAnim(slot3)
	end
end

function slot0.onEnter(slot0, ...)
	if slot0.mo.isPreventItem then
		ExploreMapModel.instance:updateNodeCanPassItem(ExploreHelper.getKey(slot0.mo.nodePos), false)
	end

	uv0.super.onEnter(slot0, ...)
end

function slot0.onExit(slot0, ...)
	if slot0.mo.isPreventItem then
		ExploreMapModel.instance:updateNodeCanPassItem(ExploreHelper.getKey(slot0.mo.nodePos), true)
	end

	uv0.super.onExit(slot0, ...)
end

return slot0
