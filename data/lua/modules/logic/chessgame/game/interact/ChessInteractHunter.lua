module("modules.logic.chessgame.game.interact.ChessInteractHunter", package.seeall)

local var_0_0 = class("ChessInteractHunter", ChessInteractBase)

function var_0_0.onSelectCall(arg_1_0)
	return
end

function var_0_0.onCancelSelect(arg_2_0)
	return
end

function var_0_0.onSelectPos(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.onAvatarLoaded(arg_4_0)
	var_0_0.super.onAvatarLoaded(arg_4_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = true
	})
end

function var_0_0.onMoveBegin(arg_5_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = false
	})
end

function var_0_0.onDrawAlert(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._target.mo.posX
	local var_6_1 = arg_6_0._target.mo.posY

	arg_6_1[var_6_0] = arg_6_1[var_6_0] or {}
	arg_6_1[var_6_0][var_6_1] = arg_6_1[var_6_0][var_6_1] or {}

	table.insert(arg_6_1[var_6_0][var_6_1], false)
end

function var_0_0.refreshAlarmArea(arg_7_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = true
	})
end

function var_0_0.breakObstacle(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0, var_8_1 = arg_8_1.mo:getXY()
	local var_8_2 = (arg_8_0._target.mo.posX + var_8_0) / 2
	local var_8_3 = (arg_8_0._target.mo.posY + var_8_1) / 2

	arg_8_0:onMoveBegin()

	local function var_8_4()
		arg_8_0:refreshAlarmArea()
		arg_8_1:getHandler():playBreakAnim(arg_8_2, arg_8_3)
	end

	local function var_8_5()
		arg_8_0:moveTo(arg_8_0._target.mo.posX, arg_8_0._target.mo.posY, var_8_4, arg_8_0)
	end

	arg_8_0:moveTo(var_8_2, var_8_3, var_8_5, arg_8_0)
end

function var_0_0.moveTo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	var_0_0.super.moveTo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
end

function var_0_0.setAlertActive(arg_12_0, arg_12_1)
	return
end

function var_0_0.dispose(arg_13_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = false
	})
	var_0_0.super.dispose(arg_13_0)
end

return var_0_0
