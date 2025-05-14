module("modules.logic.versionactivity2_4.pinball.entity.PinballResMineEntity", package.seeall)

local var_0_0 = class("PinballResMineEntity", PinballResEntity)

function var_0_0.onHitEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = PinballEntityMgr.instance:getEntity(arg_1_1)

	if not var_1_0 then
		return
	end

	if var_1_0:isResType() then
		var_1_0:doHit(1)
	end
end

function var_0_0.onHitCount(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or 1
	arg_2_0.totalHitCount = arg_2_0.totalHitCount - arg_2_1

	if arg_2_0.linkEntity then
		arg_2_0.linkEntity.totalHitCount = arg_2_0.linkEntity.totalHitCount - arg_2_1
	end

	if arg_2_0.totalHitCount <= 0 then
		PinballModel.instance:addGameRes(arg_2_0.resType, arg_2_0.resNum)
		PinballEntityMgr.instance:addNumShow(arg_2_0.resNum, arg_2_0.x + arg_2_0.width, arg_2_0.y + arg_2_0.height)
		PinballEntityMgr.instance:removeEntity(arg_2_0.id)
	end
end

function var_0_0.onCreateLinkEntity(arg_3_0, arg_3_1)
	arg_3_1.totalHitCount = arg_3_0.totalHitCount
end

function var_0_0.onInitByCo(arg_4_0)
	local var_4_0 = string.splitToNumber(arg_4_0.spData, "#") or {}

	arg_4_0.totalHitCount = var_4_0[1] or 0
	arg_4_0.resNum = var_4_0[2] or 0
end

return var_0_0
