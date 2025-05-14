module("modules.logic.scene.pushbox.logic.PushBoxStepDataMgr", package.seeall)

local var_0_0 = class("PushBoxStepDataMgr", UserDataDispose)

var_0_0.StepType = {
	PushBox = 2,
	Move = 1
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._game_mgr = arg_1_1
	arg_1_0._scene = arg_1_1._scene
	arg_1_0._scene_root = arg_1_1._scene_root
end

function var_0_0.init(arg_2_0)
	arg_2_0._step_data = {}
end

function var_0_0._onRevertStep(arg_3_0)
	local var_3_0 = table.remove(arg_3_0._step_data)

	if not var_3_0 then
		GameFacade.showToast(ToastEnum.PushBoxGame)

		return
	end

	arg_3_0._game_mgr.character:revertDirection(var_3_0.characterDirection)

	if var_3_0.step_type == var_0_0.StepType.Move then
		arg_3_0._game_mgr.character:revertMove(var_3_0.from_x, var_3_0.from_y)
	elseif var_3_0.step_type == var_0_0.StepType.PushBox then
		arg_3_0._game_mgr:pushBox(var_3_0.to_x, var_3_0.to_y, var_3_0.from_x, var_3_0.from_y)
		arg_3_0._game_mgr.character:revertMove(var_3_0.character_pos_x, var_3_0.character_pos_y)
	end

	local var_3_1 = arg_3_0:getLastStep()

	if var_3_1 then
		arg_3_0._game_mgr:setWarning(var_3_1.warning)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RevertStep, var_3_1)
	else
		arg_3_0._game_mgr:setWarning(0)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StartElement)
	end
end

function var_0_0.markStepData(arg_4_0)
	local var_4_0 = arg_4_0:getLastStep()

	var_4_0.warning = arg_4_0._game_mgr:getCurWarning()
	var_4_0.characterDirection = arg_4_0._game_mgr.character:getDirection()

	local var_4_1 = arg_4_0._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Enemy)

	var_4_0.enemy_direction = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = {
			pos_x = iter_4_1:getPosX(),
			pos_y = iter_4_1:getPosY(),
			index = iter_4_1:getIndex()
		}

		table.insert(var_4_0.enemy_direction, var_4_2)
	end

	var_4_0.fan_time = {}

	local var_4_3 = arg_4_0._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Fan)

	for iter_4_2, iter_4_3 in ipairs(var_4_3) do
		local var_4_4 = {
			active = iter_4_3:getState(),
			pos_x = iter_4_3:getPosX(),
			pos_y = iter_4_3:getPosY()
		}

		if iter_4_3._start_time then
			var_4_4.left_time = arg_4_0._game_mgr:getConfig().fan_duration - (Time.realtimeSinceStartup - iter_4_3._start_time)
		end

		table.insert(var_4_0.fan_time, var_4_4)
	end
end

function var_0_0.getLastStep(arg_5_0)
	return arg_5_0._step_data[#arg_5_0._step_data]
end

function var_0_0.getStepCount(arg_6_0)
	return arg_6_0._step_data and #arg_6_0._step_data or 0
end

function var_0_0.moveCharacter(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {
		step_type = var_0_0.StepType.Move,
		from_x = arg_7_1,
		from_y = arg_7_2
	}

	table.insert(arg_7_0._step_data, var_7_0)
end

function var_0_0.pushBox(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_0._game_mgr.character
	local var_8_1 = {
		step_type = var_0_0.StepType.PushBox,
		from_x = arg_8_1,
		from_y = arg_8_2,
		to_x = arg_8_3,
		to_y = arg_8_4,
		character_pos_x = var_8_0:getPosX(),
		character_pos_y = var_8_0:getPosY()
	}

	table.insert(arg_8_0._step_data, var_8_1)
end

function var_0_0.releaseSelf(arg_9_0)
	arg_9_0:__onDispose()
end

return var_0_0
