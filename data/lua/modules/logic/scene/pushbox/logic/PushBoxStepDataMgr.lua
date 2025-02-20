module("modules.logic.scene.pushbox.logic.PushBoxStepDataMgr", package.seeall)

slot0 = class("PushBoxStepDataMgr", UserDataDispose)
slot0.StepType = {
	PushBox = 2,
	Move = 1
}

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._game_mgr = slot1
	slot0._scene = slot1._scene
	slot0._scene_root = slot1._scene_root
end

function slot0.init(slot0)
	slot0._step_data = {}
end

function slot0._onRevertStep(slot0)
	if not table.remove(slot0._step_data) then
		GameFacade.showToast(ToastEnum.PushBoxGame)

		return
	end

	slot0._game_mgr.character:revertDirection(slot1.characterDirection)

	if slot1.step_type == uv0.StepType.Move then
		slot0._game_mgr.character:revertMove(slot1.from_x, slot1.from_y)
	elseif slot1.step_type == uv0.StepType.PushBox then
		slot0._game_mgr:pushBox(slot1.to_x, slot1.to_y, slot1.from_x, slot1.from_y)
		slot0._game_mgr.character:revertMove(slot1.character_pos_x, slot1.character_pos_y)
	end

	if slot0:getLastStep() then
		slot0._game_mgr:setWarning(slot2.warning)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RevertStep, slot2)
	else
		slot0._game_mgr:setWarning(0)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StartElement)
	end
end

function slot0.markStepData(slot0)
	slot1 = slot0:getLastStep()
	slot1.warning = slot0._game_mgr:getCurWarning()
	slot1.characterDirection = slot0._game_mgr.character:getDirection()
	slot1.enemy_direction = {}

	for slot6, slot7 in ipairs(slot0._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Enemy)) do
		table.insert(slot1.enemy_direction, {
			pos_x = slot7:getPosX(),
			pos_y = slot7:getPosY(),
			index = slot7:getIndex()
		})
	end

	slot1.fan_time = {}
	slot6 = PushBoxGameMgr.ElementType.Fan

	for slot6, slot7 in ipairs(slot0._game_mgr:getElementLogicList(slot6)) do
		if slot7._start_time then
			-- Nothing
		end

		table.insert(slot1.fan_time, {
			active = slot7:getState(),
			pos_x = slot7:getPosX(),
			pos_y = slot7:getPosY(),
			left_time = slot0._game_mgr:getConfig().fan_duration - (Time.realtimeSinceStartup - slot7._start_time)
		})
	end
end

function slot0.getLastStep(slot0)
	return slot0._step_data[#slot0._step_data]
end

function slot0.getStepCount(slot0)
	return slot0._step_data and #slot0._step_data or 0
end

function slot0.moveCharacter(slot0, slot1, slot2)
	table.insert(slot0._step_data, {
		step_type = uv0.StepType.Move,
		from_x = slot1,
		from_y = slot2
	})
end

function slot0.pushBox(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0._game_mgr.character

	table.insert(slot0._step_data, {
		step_type = uv0.StepType.PushBox,
		from_x = slot1,
		from_y = slot2,
		to_x = slot3,
		to_y = slot4,
		character_pos_x = slot5:getPosX(),
		character_pos_y = slot5:getPosY()
	})
end

function slot0.releaseSelf(slot0)
	slot0:__onDispose()
end

return slot0
