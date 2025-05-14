module("modules.logic.explore.map.unit.ExploreDoor", package.seeall)

local var_0_0 = class("ExploreDoor", ExploreBaseDisplayUnit)

var_0_0.PairAnim = {
	[ExploreAnimEnum.AnimName.nToA] = ExploreAnimEnum.AnimName.aToN,
	[ExploreAnimEnum.AnimName.count0to1] = ExploreAnimEnum.AnimName.count1to0,
	[ExploreAnimEnum.AnimName.count1to2] = ExploreAnimEnum.AnimName.count2to1,
	[ExploreAnimEnum.AnimName.count2to3] = ExploreAnimEnum.AnimName.count3to2,
	[ExploreAnimEnum.AnimName.count3to4] = ExploreAnimEnum.AnimName.count4to3
}

function var_0_0.onInit(arg_1_0)
	arg_1_0._count = 0
	arg_1_0._totalCount = 0
end

function var_0_0.setName(arg_2_0, arg_2_1)
	arg_2_0.go.name = arg_2_1
end

function var_0_0.setupMO(arg_3_0)
	arg_3_0.mo:updateWalkable()
end

function var_0_0.onResLoaded(arg_4_0)
	var_0_0.super.onResLoaded(arg_4_0)

	local var_4_0 = arg_4_0._displayTr:Find("effect")

	gohelper.setActive(var_4_0, arg_4_0.mo.isPreventItem)

	if arg_4_0.mo.specialDatas[2] == "1" then
		arg_4_0.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_red"))
	elseif arg_4_0.mo.specialDatas[2] == "2" then
		arg_4_0.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_blue"))
	elseif arg_4_0.mo.specialDatas[2] == "3" then
		arg_4_0.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_green"))
	end
end

function var_0_0.onUpdateCount(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 then
		arg_5_0._count = arg_5_1
		arg_5_0._totalCount = arg_5_2

		arg_5_0:playAnim(arg_5_0:getIdleAnim())
	elseif arg_5_1 < arg_5_0._count then
		if arg_5_0._count == arg_5_0._totalCount then
			arg_5_0:playAnim(ExploreAnimEnum.AnimName.aToN)
		elseif arg_5_0:_canChangeCountAnim() then
			arg_5_0:playAnim(string.format("count%dto%d", arg_5_0._count, arg_5_1))
		end

		arg_5_0._count = arg_5_1
	elseif arg_5_1 > arg_5_0._count then
		if arg_5_1 == arg_5_0._totalCount then
			arg_5_0:playAnim(ExploreAnimEnum.AnimName.nToA)
		elseif arg_5_0:_canChangeCountAnim() then
			arg_5_0:playAnim(string.format("count%dto%d", arg_5_0._count, arg_5_1))
		end

		arg_5_0._count = arg_5_1
	end
end

function var_0_0._canChangeCountAnim(arg_6_0)
	local var_6_0 = arg_6_0.animComp._curAnim

	if var_6_0 == ExploreAnimEnum.AnimName.aToN or var_6_0 == ExploreAnimEnum.AnimName.nToA then
		return false
	end

	return true
end

function var_0_0.getIdleAnim(arg_7_0)
	if arg_7_0._count > 0 and arg_7_0._count ~= arg_7_0._totalCount then
		return "count" .. arg_7_0._count
	else
		return var_0_0.super.getIdleAnim(arg_7_0)
	end
end

function var_0_0.onActiveChange(arg_8_0, arg_8_1)
	if not arg_8_1 then
		arg_8_0.mo:updateWalkable()
		arg_8_0:checkLight()
	elseif arg_8_0.animComp:isIdleAnim() then
		arg_8_0.mo:updateWalkable()
		arg_8_0:checkLight()
	end

	arg_8_0:checkShowIcon()

	if arg_8_0._totalCount == 0 then
		var_0_0.super.onActiveChange(arg_8_0, arg_8_1)
	end
end

function var_0_0.canTrigger(arg_9_0)
	if arg_9_0.mo and arg_9_0.mo:isInteractActiveState() then
		return false
	end

	return var_0_0.super.canTrigger(arg_9_0)
end

function var_0_0.isPassLight(arg_10_0)
	return arg_10_0.mo:isWalkable()
end

function var_0_0.onAnimEnd(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.mo:updateWalkable()
	arg_11_0:checkLight()

	if not arg_11_0.animComp:isIdleAnim(arg_11_2) then
		return
	end

	local var_11_0 = arg_11_0:getIdleAnim()

	if var_11_0 ~= arg_11_2 then
		arg_11_0.animComp:playAnim(var_11_0)
	end
end

function var_0_0.onEnter(arg_12_0, ...)
	if arg_12_0.mo.isPreventItem then
		ExploreMapModel.instance:updateNodeCanPassItem(ExploreHelper.getKey(arg_12_0.mo.nodePos), false)
	end

	var_0_0.super.onEnter(arg_12_0, ...)
end

function var_0_0.onExit(arg_13_0, ...)
	if arg_13_0.mo.isPreventItem then
		ExploreMapModel.instance:updateNodeCanPassItem(ExploreHelper.getKey(arg_13_0.mo.nodePos), true)
	end

	var_0_0.super.onExit(arg_13_0, ...)
end

return var_0_0
