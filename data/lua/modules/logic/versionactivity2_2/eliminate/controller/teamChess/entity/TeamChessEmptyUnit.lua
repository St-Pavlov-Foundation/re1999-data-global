module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessEmptyUnit", package.seeall)

local var_0_0 = class("TeamChessEmptyUnit", TeamChessSoldierUnit)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform
end

function var_0_0.setPath(arg_2_0, arg_2_1)
	arg_2_0._path = arg_2_1

	arg_2_0:loadAsset(arg_2_1)
end

function var_0_0.setScreenPoint(arg_3_0, arg_3_1)
	arg_3_0._screenPoint = arg_3_1
end

function var_0_0.setUnitParentPosition(arg_4_0, arg_4_1)
	arg_4_0._unitParentPosition = arg_4_1
end

function var_0_0._onResLoaded(arg_5_0)
	var_0_0.super._onResLoaded(arg_5_0)

	if gohelper.isNil(arg_5_0._backGo) then
		return
	end

	arg_5_0:setAllMeshRenderOrderInLayer(20)
	arg_5_0:updateByScreenPos()
	arg_5_0:setActive(true)
end

function var_0_0.updateByScreenPos(arg_6_0)
	if arg_6_0._screenPoint == nil or arg_6_0._unitParentPosition == nil then
		return
	end

	local var_6_0, var_6_1, var_6_2 = recthelper.screenPosToWorldPos3(arg_6_0._screenPoint, nil, arg_6_0._unitParentPosition)

	arg_6_0:updatePos(var_6_0, var_6_1, var_6_2)
end

function var_0_0.setOutlineActive(arg_7_0, arg_7_1)
	if gohelper.isNil(arg_7_0._backOutLineGo) then
		return
	end

	if arg_7_0._normalActive then
		arg_7_0:setNormalActive(not arg_7_1, false)
	end

	gohelper.setActive(arg_7_0._backOutLineGo.gameObject, arg_7_1)
	var_0_0.super.setOutlineActive(arg_7_0, arg_7_1)
end

function var_0_0.setGrayActive(arg_8_0, arg_8_1)
	if gohelper.isNil(arg_8_0._backGrayGo) then
		return
	end

	if arg_8_0._normalActive then
		arg_8_0:setNormalActive(not arg_8_1, false)
	end

	gohelper.setActive(arg_8_0._backGrayGo.gameObject, arg_8_1)
end

function var_0_0.setNormalActive(arg_9_0, arg_9_1, arg_9_2)
	if gohelper.isNil(arg_9_0._backGo) then
		return
	end

	arg_9_2 = arg_9_2 == nil and true or arg_9_2

	if arg_9_2 then
		arg_9_0._active = arg_9_1
	end

	gohelper.setActive(arg_9_0._backGo.gameObject, arg_9_1)
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._screenPoint = nil

	var_0_0.super.onDestroy(arg_10_0)
end

return var_0_0
