module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapGrid", package.seeall)

local var_0_0 = class("GaoSiNiaoMapGrid")
local var_0_1 = 99999

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._mapMO = arg_1_1
	arg_1_0.index = {
		x = arg_1_2[1],
		y = arg_1_2[2]
	}
	arg_1_0.type = arg_1_3.gtype or GaoSiNiaoEnum.GridType.Empty
	arg_1_0.ePathType = arg_1_3.ptype or GaoSiNiaoEnum.PathType.None
	arg_1_0.zRot = arg_1_3.zRot or 0
	arg_1_0.bMovable = arg_1_3.bMovable or false
	arg_1_0._distanceToStart = var_0_1
	arg_1_0._forceInZoneMask = false
	arg_1_0._forceOutZoneMask = false
end

function var_0_0.distanceToStart(arg_2_0)
	return arg_2_0:_isConnedStart() and arg_2_0._distanceToStart or var_0_1
end

function var_0_0.setDistanceToStartByStartGrid(arg_3_0, arg_3_1)
	arg_3_0._distanceToStart = 0 + math.abs(arg_3_0:x() - arg_3_1:x()) + math.abs(arg_3_0:y() - arg_3_1:y())
end

function var_0_0.setId(arg_4_0, arg_4_1)
	arg_4_0._id = arg_4_1
end

function var_0_0.id(arg_5_0)
	return arg_5_0._id
end

function var_0_0.x(arg_6_0)
	return arg_6_0.index.x
end

function var_0_0.y(arg_7_0)
	return arg_7_0.index.y
end

function var_0_0.indexStr(arg_8_0)
	return string.format("(%s,%s)", arg_8_0.index.x, arg_8_0.index.y)
end

function var_0_0.isIndex(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0.index.x == arg_9_1 and arg_9_2 == arg_9_0.index.y
end

function var_0_0.isEmpty(arg_10_0)
	return arg_10_0.type == GaoSiNiaoEnum.GridType.Empty
end

function var_0_0.isStart(arg_11_0)
	return arg_11_0.type == GaoSiNiaoEnum.GridType.Start
end

function var_0_0.isEnd(arg_12_0)
	return arg_12_0.type == GaoSiNiaoEnum.GridType.End
end

function var_0_0.isWall(arg_13_0)
	return arg_13_0.type == GaoSiNiaoEnum.GridType.Wall
end

function var_0_0.isPortal(arg_14_0)
	return arg_14_0.type == GaoSiNiaoEnum.GridType.Portal
end

function var_0_0.isPath(arg_15_0)
	return arg_15_0.type == GaoSiNiaoEnum.GridType.Path
end

function var_0_0.isFixedPath(arg_16_0)
	return arg_16_0:isPath() and not arg_16_0.bMovable
end

function var_0_0.rootId(arg_17_0)
	if not arg_17_0._mapMO then
		return arg_17_0:id()
	end

	return arg_17_0._mapMO:rootId(arg_17_0)
end

function var_0_0.isRoot(arg_18_0)
	return arg_18_0:rootId() == arg_18_0:id()
end

function var_0_0._getGrid(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0._mapMO then
		return
	end

	return arg_19_0._mapMO:getGrid(arg_19_1, arg_19_2)
end

function var_0_0._merge(arg_20_0, arg_20_1)
	if not arg_20_0._mapMO then
		return
	end

	return arg_20_0._mapMO:merge(arg_20_0, arg_20_1)
end

function var_0_0._isConned(arg_21_0, arg_21_1)
	if not arg_21_0._mapMO then
		return
	end

	return arg_21_0._mapMO:isConned(arg_21_0, arg_21_1)
end

function var_0_0._isConnedStart(arg_22_0)
	if not arg_22_0._mapMO then
		return
	end

	return arg_22_0._mapMO:isConnedStart(arg_22_0)
end

function var_0_0._isPlacedBagItem(arg_23_0)
	if not arg_23_0._mapMO then
		return
	end

	return arg_23_0._mapMO:isPlacedBagItem(arg_23_0)
end

function var_0_0._getPlacedBagItem(arg_24_0)
	if not arg_24_0._mapMO then
		return
	end

	return arg_24_0._mapMO:getPlacedBagItem(arg_24_0)
end

function var_0_0._whoActivedPortalGrid(arg_25_0)
	if not arg_25_0._mapMO then
		return
	end

	return arg_25_0._mapMO:whoActivedPortalGrid()
end

function var_0_0.T(arg_26_0)
	arg_26_0:_getGrid(arg_26_0:x(), arg_26_0:y() - 1)
end

function var_0_0.R(arg_27_0)
	arg_27_0:_getGrid(arg_27_0:x() + 1, arg_27_0:y())
end

function var_0_0.B(arg_28_0)
	arg_28_0:_getGrid(arg_28_0:x(), arg_28_0:y() + 1)
end

function var_0_0.L(arg_29_0)
	arg_29_0:_getGrid(arg_29_0:x() - 1, arg_29_0:y())
end

function var_0_0.isConnedT(arg_30_0)
	local var_30_0 = arg_30_0:T()

	if not var_30_0 then
		return false
	end

	return arg_30_0:_isConned(var_30_0)
end

function var_0_0.isConnedR(arg_31_0)
	local var_31_0 = arg_31_0:R()

	if not var_31_0 then
		return false
	end

	return arg_31_0:_isConned(var_31_0)
end

function var_0_0.isConnedB(arg_32_0)
	local var_32_0 = arg_32_0:B()

	if not var_32_0 then
		return false
	end

	return arg_32_0:_isConned(var_32_0)
end

function var_0_0.isConnedL(arg_33_0)
	local var_33_0 = arg_33_0:L()

	if not var_33_0 then
		return false
	end

	return arg_33_0:_isConned(var_33_0)
end

function var_0_0.getNeighborGridList(arg_34_0)
	local var_34_0 = {
		false,
		false,
		false,
		false
	}

	for iter_34_0 = 1, 4 do
		local var_34_1 = arg_34_0:x() + GaoSiNiaoEnum.dX[iter_34_0]
		local var_34_2 = arg_34_0:y() + GaoSiNiaoEnum.dY[iter_34_0]

		var_34_0[iter_34_0] = arg_34_0:_getGrid(var_34_1, var_34_2) or false
	end

	return var_34_0
end

function var_0_0.getNeighborWalkableGridList(arg_35_0)
	local var_35_0 = {
		false,
		false,
		false,
		false
	}
	local var_35_1 = arg_35_0:out_ZoneMask()

	for iter_35_0 = 1, 4 do
		local var_35_2 = GaoSiNiaoEnum.bitPos2Dir(iter_35_0 - 1)

		if Bitwise.has(var_35_1, var_35_2) then
			local var_35_3 = arg_35_0:x() + GaoSiNiaoEnum.dX[iter_35_0]
			local var_35_4 = arg_35_0:y() + GaoSiNiaoEnum.dY[iter_35_0]

			var_35_0[iter_35_0] = arg_35_0:_getGrid(var_35_3, var_35_4) or false
		end
	end

	return var_35_0
end

function var_0_0.getRelativeZoneMask(arg_36_0, arg_36_1)
	for iter_36_0 = 1, 4 do
		local var_36_0 = GaoSiNiaoEnum.bitPos2Dir(iter_36_0 - 1)
		local var_36_1 = arg_36_0:x() + GaoSiNiaoEnum.dX[iter_36_0]
		local var_36_2 = arg_36_0:y() + GaoSiNiaoEnum.dY[iter_36_0]

		if arg_36_0:_getGrid(var_36_1, var_36_2) == arg_36_1 then
			return var_36_0
		end
	end

	return GaoSiNiaoEnum.ZoneMask.None
end

function var_0_0.set_forceInZoneMask(arg_37_0, arg_37_1)
	arg_37_0._forceInZoneMask = arg_37_1
end

function var_0_0.set_forceOutZoneMask(arg_38_0, arg_38_1)
	arg_38_0._forceOutZoneMask = arg_38_1
end

function var_0_0._internal_tryConnNeighbor(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_1 then
		return false
	end

	assert(arg_39_2 > 0)

	local var_39_0 = Bitwise["&"](arg_39_0:in_ZoneMask(), arg_39_1:out_ZoneMask())

	return (Bitwise.has(var_39_0, GaoSiNiaoEnum.flipDir(arg_39_2)))
end

function var_0_0._protal_ZoneMask_default(arg_40_0)
	assert(arg_40_0:isPortal())

	if arg_40_0:isConnedT() then
		return GaoSiNiaoEnum.ZoneMask.South
	elseif arg_40_0:isConnedR() then
		return GaoSiNiaoEnum.ZoneMask.West
	elseif arg_40_0:isConnedB() then
		return GaoSiNiaoEnum.ZoneMask.North
	elseif arg_40_0:isConnedL() then
		return GaoSiNiaoEnum.ZoneMask.East
	else
		return GaoSiNiaoEnum.ZoneMask.All
	end
end

function var_0_0.in_ZoneMask(arg_41_0)
	if arg_41_0._forceInZoneMask then
		return arg_41_0._forceInZoneMask
	end

	local var_41_0 = arg_41_0:_getPlacedBagItem()

	if var_41_0 then
		return var_41_0:in_ZoneMask()
	elseif arg_41_0:isPortal() then
		return arg_41_0:_protal_ZoneMask_default()
	end

	return arg_41_0:_in_ZoneMask_default()
end

function var_0_0.out_ZoneMask(arg_42_0)
	if arg_42_0._forceOutZoneMask then
		return arg_42_0._forceOutZoneMask
	end

	local var_42_0 = arg_42_0:_getPlacedBagItem()

	if var_42_0 then
		return var_42_0:out_ZoneMask()
	elseif arg_42_0:isPortal() then
		return arg_42_0:_protal_ZoneMask_default()
	end

	return arg_42_0:_out_ZoneMask_default()
end

function var_0_0._in_ZoneMask_default(arg_43_0)
	if arg_43_0:isStart() or arg_43_0:isEnd() then
		return GaoSiNiaoEnum.ZoneMask.All
	elseif arg_43_0:isWall() or arg_43_0:isEmpty() then
		return GaoSiNiaoEnum.ZoneMask.None
	elseif arg_43_0:isFixedPath() then
		return GaoSiNiaoEnum.PathInfo[arg_43_0.ePathType].inZM
	else
		assert(false, "[in_ZoneMask] unsupported type: " .. tostring(arg_43_0.type))
	end
end

function var_0_0._out_ZoneMask_default(arg_44_0)
	if arg_44_0:isStart() or arg_44_0:isEnd() then
		return GaoSiNiaoEnum.ZoneMask.All
	elseif arg_44_0:isWall() or arg_44_0:isEmpty() then
		return GaoSiNiaoEnum.ZoneMask.None
	elseif arg_44_0:isFixedPath() then
		return GaoSiNiaoEnum.PathInfo[arg_44_0.ePathType].outZM
	else
		assert(false, "[out_ZoneMask] unsupported type: " .. tostring(arg_44_0.type))
	end
end

return var_0_0
