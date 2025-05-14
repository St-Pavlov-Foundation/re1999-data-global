module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessUnitEntityBase", package.seeall)

local var_0_0 = class("TeamChessUnitEntityBase", LuaCompBase)
local var_0_1 = ZProj.TweenHelper

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform
	arg_1_0._posX = 0
	arg_1_0._posY = 0
	arg_1_0._posZ = 0
	arg_1_0._lastActive = nil
	arg_1_0._canClick = false
	arg_1_0._canDrag = false
	arg_1_0._scale = 1
end

function var_0_0.updateMo(arg_2_0, arg_2_1)
	arg_2_0._unitMo = arg_2_1

	arg_2_0:setScale(arg_2_1:getScale())
	arg_2_0:loadAsset(arg_2_0._unitMo:getUnitPath())
end

function var_0_0.loadAsset(arg_3_0, arg_3_1)
	if not string.nilorempty(arg_3_1) and not arg_3_0._loader then
		arg_3_0._loader = PrefabInstantiate.Create(arg_3_0.go)

		arg_3_0._loader:startLoad(arg_3_1, arg_3_0._onResLoaded, arg_3_0)
	end
end

function var_0_0.updatePos(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._posX, arg_4_0._posY, arg_4_0._posZ = arg_4_1, arg_4_2, arg_4_3

	transformhelper.setPos(arg_4_0.trans, arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.moveToPos(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_1.DOMove(arg_5_0.trans, arg_5_1, arg_5_2, arg_5_3, EliminateTeamChessEnum.entityMoveTime, arg_5_0._onMoveEnd, nil, nil, EaseType.OutQuart)
end

function var_0_0.getPosXYZ(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = transformhelper.getPos(arg_6_0.trans)

	return var_6_0, var_6_1 + 0.4, var_6_2
end

function var_0_0.getTopPosXYZ(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = arg_7_0:getPosXYZ()

	return var_7_0 - 0.1, var_7_1 + 0.5, var_7_2
end

function var_0_0.setActive(arg_8_0, arg_8_1)
	if arg_8_0._lastActive == nil then
		arg_8_0._lastActive = arg_8_1
	end

	if arg_8_0._lastActive ~= arg_8_1 then
		gohelper.setActive(arg_8_0.go, arg_8_1)

		arg_8_0._lastActive = arg_8_1
	end
end

function var_0_0.setCanClick(arg_9_0, arg_9_1)
	arg_9_0._canClick = arg_9_1
end

function var_0_0.setCanDrag(arg_10_0, arg_10_1)
	arg_10_0._canDrag = arg_10_1
end

function var_0_0.setScale(arg_11_0, arg_11_1)
	arg_11_0._scale = arg_11_1 or 1
end

function var_0_0._onResLoaded(arg_12_0)
	arg_12_0._resGo = arg_12_0._loader:getInstGO()

	transformhelper.setLocalScale(arg_12_0._resGo.transform, arg_12_0._scale, arg_12_0._scale, arg_12_0._scale)
end

function var_0_0.dispose(arg_13_0)
	arg_13_0:onDestroy()
end

function var_0_0.onDestroy(arg_14_0)
	gohelper.destroy(arg_14_0.go)

	arg_14_0._lastActive = nil

	if arg_14_0._loader then
		arg_14_0._loader:onDestroy()

		arg_14_0._loader = nil
	end
end

return var_0_0
