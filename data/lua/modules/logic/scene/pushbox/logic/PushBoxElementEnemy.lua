module("modules.logic.scene.pushbox.logic.PushBoxElementEnemy", package.seeall)

local var_0_0 = class("PushBoxElementEnemy", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	arg_1_0._gameObject = arg_1_1
	arg_1_0._transform = arg_1_1.transform
	arg_1_0._cell = arg_1_2
	arg_1_0._ani = arg_1_0:getUserDataTb_()

	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshElement, arg_1_0._onRefreshElement, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.StepFinished, arg_1_0._onStepFinished, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.RevertStep, arg_1_0._onRevertStep, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.StartElement, arg_1_0._onStartElement, arg_1_0)
end

function var_0_0.setRendererIndex(arg_2_0)
	local var_2_0 = arg_2_0._cell:getRendererIndex()

	for iter_2_0 = 0, arg_2_0._transform.childCount - 1 do
		local var_2_1 = arg_2_0._transform:GetChild(iter_2_0)

		var_2_1:GetChild(0):GetComponent("MeshRenderer").sortingOrder = var_2_0

		table.insert(arg_2_0._ani, gohelper.findChildComponent(var_2_1.gameObject, "eyeglow", typeof(UnityEngine.Animator)))
	end
end

function var_0_0._onStartElement(arg_3_0)
	local var_3_0 = arg_3_0._game_mgr:getEnemyIndex(arg_3_0)
	local var_3_1 = arg_3_0._game_mgr:getConfig()

	arg_3_0._act_rule = GameUtil.splitString2(string.split(var_3_1.enemy_act, "_")[var_3_0], true, "|", "#")
	arg_3_0._alarm_value = var_3_1.enemy_alarm
	arg_3_0._index = 1
	arg_3_0._next_act_time = arg_3_0._act_rule[arg_3_0._index][2] + Time.realtimeSinceStartup

	arg_3_0:_startAct()
	TaskDispatcher.runDelay(arg_3_0._onTime, arg_3_0, arg_3_0._act_rule[arg_3_0._index][2])
end

function var_0_0._onRevertStep(arg_4_0, arg_4_1)
	if arg_4_1.enemy_direction then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.enemy_direction) do
			if iter_4_1.pos_x == arg_4_0._cell:getPosX() and iter_4_1.pos_y == arg_4_0._cell:getPosY() then
				arg_4_0._index = iter_4_1.index

				arg_4_0:doAct()
			end
		end
	end
end

function var_0_0._onTime(arg_5_0)
	if arg_5_0._in_area and arg_5_0:_characterInArea() then
		return
	end

	arg_5_0._index = arg_5_0._index + 1

	if arg_5_0._index > #arg_5_0._act_rule then
		arg_5_0._index = 1
	end

	arg_5_0:doAct()
end

function var_0_0.doAct(arg_6_0)
	arg_6_0:_startAct()

	arg_6_0._next_act_time = arg_6_0._act_rule[arg_6_0._index][2] + Time.realtimeSinceStartup

	TaskDispatcher.runDelay(arg_6_0._onTime, arg_6_0, arg_6_0._act_rule[arg_6_0._index][2])
end

function var_0_0._onRefreshElement(arg_7_0)
	arg_7_0._check_warning = true

	if arg_7_0._in_area and not arg_7_0:_characterInArea() then
		if Time.realtimeSinceStartup > arg_7_0._next_act_time then
			arg_7_0:_onTime()
		end

		arg_7_0._check_warning = false

		return
	end
end

function var_0_0._onStepFinished(arg_8_0)
	if not arg_8_0._check_warning then
		return
	end

	if arg_8_0._game_mgr:cellIsInvincible(arg_8_0._act_cell_x, arg_8_0._act_cell_y) then
		return
	end

	if arg_8_0:_characterInArea() then
		arg_8_0._game_mgr:changeWarning(arg_8_0._alarm_value)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_alert)
	end
end

function var_0_0._startAct(arg_9_0)
	arg_9_0._act_cell_x = arg_9_0._cell:getPosX()
	arg_9_0._act_cell_y = arg_9_0._cell:getPosY()

	local var_9_0 = arg_9_0._act_rule[arg_9_0._index][1]

	if var_9_0 == PushBoxGameMgr.Direction.Up then
		arg_9_0._act_cell_y = arg_9_0._act_cell_y - 1
	elseif var_9_0 == PushBoxGameMgr.Direction.Down then
		arg_9_0._act_cell_y = arg_9_0._act_cell_y + 1
	elseif var_9_0 == PushBoxGameMgr.Direction.Left then
		arg_9_0._act_cell_x = arg_9_0._act_cell_x - 1
	elseif var_9_0 == PushBoxGameMgr.Direction.Right then
		arg_9_0._act_cell_x = arg_9_0._act_cell_x + 1
	end

	arg_9_0._act_cell = arg_9_0._game_mgr:getCell(arg_9_0._act_cell_x, arg_9_0._act_cell_y)

	local var_9_1 = tostring(var_9_0)

	for iter_9_0 = 0, 3 do
		local var_9_2 = arg_9_0._gameObject.transform:GetChild(iter_9_0)

		gohelper.setActive(var_9_2.gameObject, var_9_1 == var_9_2.name)

		local var_9_3 = gohelper.findChild(var_9_2.gameObject, "eyeglow"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

		if var_9_3 then
			for iter_9_1 = 0, var_9_3.Length - 1 do
				var_9_3[iter_9_1].sortingOrder = arg_9_0._act_cell:getRendererIndex() + 2
			end
		end
	end

	if arg_9_0._game_mgr:cellIsInvincible(arg_9_0._act_cell_x, arg_9_0._act_cell_y) then
		return
	end

	if arg_9_0:_characterInArea() then
		arg_9_0._game_mgr:changeWarning(arg_9_0._alarm_value)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_alert)
		arg_9_0._game_mgr:detectGameOver()
	end
end

function var_0_0._characterInArea(arg_10_0)
	arg_10_0._in_area = arg_10_0._game_mgr:characterInArea(arg_10_0._act_cell_x, arg_10_0._act_cell_y)

	if arg_10_0._ani then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._ani) do
			iter_10_1:Play(arg_10_0._in_area and "click" or "loop")
		end
	end

	return arg_10_0._in_area
end

function var_0_0.getIndex(arg_11_0)
	return arg_11_0._index
end

function var_0_0.getPosX(arg_12_0)
	return arg_12_0._cell:getPosX()
end

function var_0_0.getPosY(arg_13_0)
	return arg_13_0._cell:getPosY()
end

function var_0_0.getObj(arg_14_0)
	return arg_14_0._gameObject
end

function var_0_0.getCell(arg_15_0)
	return arg_15_0._cell
end

function var_0_0.releaseSelf(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._onTime, arg_16_0)
	arg_16_0:__onDispose()
end

var_0_0.Direction = {
	180,
	0,
	90,
	-90
}

return var_0_0
