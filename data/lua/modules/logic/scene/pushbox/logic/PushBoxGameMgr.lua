module("modules.logic.scene.pushbox.logic.PushBoxGameMgr", package.seeall)

slot0 = class("PushBoxGameMgr", BaseSceneComp)
slot0.Direction = {
	Down = 2,
	Up = 1,
	Left = 3,
	Right = 4
}
slot0.ElementType = {
	WallPicUp2 = 52,
	Goal = 0,
	Enemy = 6,
	WallLeft = 54,
	WallCornerTopRight = 72,
	WallUp = 50,
	WallUpDoublePic2 = 58,
	WallUpDoublePic1 = 57,
	WallCornerBottomRight = 74,
	Road = 5,
	Box = 2,
	WallRight2 = 56,
	Fan = 4,
	LightRight = 43,
	WallCornerBottomLeft = 73,
	WallCornerTopLeft = 71,
	Mechanics = 3,
	WallPicUp1 = 51,
	WallRight = 53,
	WallLeft2 = 55,
	LightLeft = 42,
	Character = 7,
	LightDown = 41,
	LightUp = 40,
	Empty = 1
}

function slot0.onInit(slot0)
end

function slot0.setCharacterPos(slot0, slot1, slot2, slot3)
	slot0.character:setPos(slot1, slot2, slot3)
end

function slot0.stepOver(slot0)
	if slot0:detectGameOver() then
		return
	end

	slot0.step_data:markStepData()

	if slot0:getCell(slot0.character:getPosX(), slot0.character:getPosY()):getCellType() == uv0.ElementType.Goal and slot1:doorIsOpend() then
		slot0._isFinish = true

		if not PushBoxModel.instance:getPassData(slot0:getCurStageID()) then
			uv0.finishNewEpisode = true
		elseif PushBoxModel.instance:getPassData(slot0:getCurStageID()).state == 0 then
			uv0.finishNewEpisode = true
		else
			uv0.finishNewEpisode = false
		end

		PushBoxController.instance:registerCallback(PushBoxEvent.DataEvent.FinishEpisodeReply, slot0._onFinishEpisodeReply, slot0)
		PushBoxRpc.instance:sendFinishEpisodeRequest(PushBoxModel.instance:getCurActivityID(), slot0:getCurStageID(), slot0.step_data:getStepCount(), slot0.data:getCurWarning())
	end
end

function slot0._onFinishEpisodeReply(slot0, slot1)
	if slot1 == 0 then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.GameWin, slot0.data:getCurWarning())
	end
end

function slot0.detectGameOver(slot0)
	if slot0._isFinish then
		return
	end

	if slot0.data:gameOver() then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.GameOver)

		return true
	end

	return false
end

function slot0.revertStep(slot0)
	slot0._reverting = true

	slot0.step_data:_onRevertStep()

	slot0._reverting = false

	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, slot0:getCurWarning())
end

function slot0.revertGame(slot0)
	if slot0.step_data:getStepCount() == 0 then
		GameFacade.showToast(ToastEnum.PushBoxGame)

		return
	end

	slot0:onSceneClose()
	slot0:onSceneStart()
	slot0:startGame(slot0:getCurStageID())
	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, slot0:getCurWarning())
end

function slot0.getCurWarning(slot0)
	return slot0.data:getCurWarning()
end

function slot0.changeWarning(slot0, slot1)
	if slot0._reverting then
		return
	end

	if slot0:getCell(slot0.character:getPosX(), slot0.character:getPosY()):getCellType() == uv0.ElementType.Fan then
		return
	end

	slot0.data:changeWarning(slot1)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, slot0:getCurWarning())
end

function slot0.setWarning(slot0, slot1)
	slot0.data:setWarning(slot1)
end

function slot0.setCellInvincible(slot0, slot1, slot2, slot3)
	for slot8, slot9 in ipairs(slot0.cell_mgr._cell_list) do
		if math.abs(slot2 - slot9:getPosX()) <= 1 and math.abs(slot3 - slot9:getPosY()) <= 1 then
			slot9:setCellInvincible(slot1)
		end
	end

	if not slot1 then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshFanElement)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StepFinished)
		slot0:detectGameOver()
	end
end

function slot0.cellIsInvincible(slot0, slot1, slot2)
	return slot0:getCell(slot1, slot2):getInvincible()
end

function slot0.characterInArea(slot0, slot1, slot2)
	if slot1 == slot0.character:getPosX() and slot2 == slot0.character:getPosY() then
		return true
	end
end

function slot0.cellHasBox(slot0, slot1, slot2)
	return slot0:getCell(slot1, slot2):getBox()
end

function slot0.pushBox(slot0, slot1, slot2, slot3, slot4)
	slot0.cell_mgr:pushBox(slot1, slot2, slot3, slot4)
end

function slot0._onMove(slot0, slot1)
	slot0.character:move(slot1)
end

function slot0.getCell(slot0, slot1, slot2)
	return slot0.cell_mgr:getCell(slot1, slot2)
end

function slot0.getElement(slot0, slot1, slot2, slot3)
	return slot0.cell_mgr:getElement(slot1, slot2, slot3)
end

function slot0.outOfBounds(slot0, slot1, slot2)
	return not slot0.cell_mgr:getCell(slot1, slot2)
end

function slot0.detectCellData(slot0)
	slot0.cell_mgr:detectCellData()
end

function slot0.getElementLogicList(slot0, slot1)
	return slot0.cell_mgr._element_logic[slot1] or {}
end

function slot0.getEnemyIndex(slot0, slot1)
	for slot7, slot8 in ipairs(slot0:getElementLogicList(uv0.ElementType.Enemy)) do
		if slot1 == slot8 then
			return 0 + 1
		end
	end

	return slot3
end

function slot0.typeIsLight(slot0, slot1)
	return slot1 == uv0.ElementType.LightUp or slot1 == uv0.ElementType.LightDown or slot1 == uv0.ElementType.LightLeft or slot1 == uv0.ElementType.LightRight
end

function slot0.typeIsDoor(slot0, slot1)
	return slot1 == uv0.ElementType.Goal
end

function slot0.typeIsEnemy(slot0, slot1)
	return slot1 == uv0.ElementType.Enemy
end

function slot0.typeIsCharacter(slot0, slot1)
	return slot1 == uv0.ElementType.Character
end

function slot0.typeIsMechanics(slot0, slot1)
	return slot1 == uv0.ElementType.Mechanics
end

function slot0.getConfig(slot0)
	return PushBoxEpisodeConfig.instance:getConfig(slot0._stage_id)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	PushBoxController.instance:registerCallback(PushBoxEvent.Move, slot0._onMove, slot0)

	slot0._scene = slot0:getCurScene()
	slot0._scene_root = slot0._scene:getSceneContainerGO()
end

function slot0.onSceneClose(slot0)
	slot0:releaseComs()
	PushBoxController.instance:unregisterCallback(PushBoxEvent.Move, slot0._onMove, slot0)
	PushBoxController.instance:unregisterCallback(PushBoxEvent.DataEvent.FinishEpisodeReply, slot0._onFinishEpisodeReply, slot0)
end

function slot0.releaseComs(slot0)
	if slot0.cell_mgr then
		slot0.cell_mgr:releaseSelf()

		slot0.cell_mgr = nil
	end

	if slot0.character then
		slot0.character:releaseSelf()

		slot0.character = nil
	end

	if slot0.step_data then
		slot0.step_data:releaseSelf()

		slot0.step_data = nil
	end

	if slot0.data then
		slot0.data:releaseSelf()

		slot0.data = nil
	end
end

function slot0.getCurStageID(slot0)
	return slot0._stage_id
end

function slot0.initComs(slot0)
	slot0.cell_mgr = PushBoxCellMgr.New(slot0)
	slot0.character = PushBoxCharacter.New(slot0)
	slot0.step_data = PushBoxStepDataMgr.New(slot0)
	slot0.data = PushBoxDataMgr.New(slot0)
end

function slot0.playOpenAni(slot0)
	slot0._scene_root.transform:GetChild(0):GetComponent(typeof(UnityEngine.Animator)):Play("open", 0, 0)
end

function slot0.hideRoot(slot0)
	gohelper.setActive(slot0._scene_root.transform:GetChild(0).gameObject, false)
end

function slot0.gameIsFinish(slot0)
	return slot0._isFinish
end

function slot0.startGame(slot0, slot1)
	slot0._isFinish = nil

	slot0:releaseComs()
	slot0:initComs()

	slot0._stage_id = slot1

	slot0.cell_mgr:init()
	slot0.character:init()
	slot0.step_data:init()
	slot0.data:init()
	PushBoxController.instance:dispatchEvent(PushBoxEvent.StartElement)
end

return slot0
