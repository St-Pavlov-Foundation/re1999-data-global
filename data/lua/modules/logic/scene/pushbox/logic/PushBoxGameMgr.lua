module("modules.logic.scene.pushbox.logic.PushBoxGameMgr", package.seeall)

local var_0_0 = class("PushBoxGameMgr", BaseSceneComp)

var_0_0.Direction = {
	Down = 2,
	Up = 1,
	Left = 3,
	Right = 4
}
var_0_0.ElementType = {
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

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.setCharacterPos(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.character:setPos(arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.stepOver(arg_3_0)
	if arg_3_0:detectGameOver() then
		return
	end

	arg_3_0.step_data:markStepData()

	local var_3_0 = arg_3_0:getCell(arg_3_0.character:getPosX(), arg_3_0.character:getPosY())

	if var_3_0:getCellType() == var_0_0.ElementType.Goal and var_3_0:doorIsOpend() then
		arg_3_0._isFinish = true

		if not PushBoxModel.instance:getPassData(arg_3_0:getCurStageID()) then
			var_0_0.finishNewEpisode = true
		elseif PushBoxModel.instance:getPassData(arg_3_0:getCurStageID()).state == 0 then
			var_0_0.finishNewEpisode = true
		else
			var_0_0.finishNewEpisode = false
		end

		PushBoxController.instance:registerCallback(PushBoxEvent.DataEvent.FinishEpisodeReply, arg_3_0._onFinishEpisodeReply, arg_3_0)
		PushBoxRpc.instance:sendFinishEpisodeRequest(PushBoxModel.instance:getCurActivityID(), arg_3_0:getCurStageID(), arg_3_0.step_data:getStepCount(), arg_3_0.data:getCurWarning())
	end
end

function var_0_0._onFinishEpisodeReply(arg_4_0, arg_4_1)
	if arg_4_1 == 0 then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.GameWin, arg_4_0.data:getCurWarning())
	end
end

function var_0_0.detectGameOver(arg_5_0)
	if arg_5_0._isFinish then
		return
	end

	if arg_5_0.data:gameOver() then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.GameOver)

		return true
	end

	return false
end

function var_0_0.revertStep(arg_6_0)
	arg_6_0._reverting = true

	arg_6_0.step_data:_onRevertStep()

	arg_6_0._reverting = false

	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, arg_6_0:getCurWarning())
end

function var_0_0.revertGame(arg_7_0)
	if arg_7_0.step_data:getStepCount() == 0 then
		GameFacade.showToast(ToastEnum.PushBoxGame)

		return
	end

	arg_7_0:onSceneClose()
	arg_7_0:onSceneStart()
	arg_7_0:startGame(arg_7_0:getCurStageID())
	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, arg_7_0:getCurWarning())
end

function var_0_0.getCurWarning(arg_8_0)
	return arg_8_0.data:getCurWarning()
end

function var_0_0.changeWarning(arg_9_0, arg_9_1)
	if arg_9_0._reverting then
		return
	end

	if arg_9_0:getCell(arg_9_0.character:getPosX(), arg_9_0.character:getPosY()):getCellType() == var_0_0.ElementType.Fan then
		return
	end

	arg_9_0.data:changeWarning(arg_9_1)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshWarningNum, arg_9_0:getCurWarning())
end

function var_0_0.setWarning(arg_10_0, arg_10_1)
	arg_10_0.data:setWarning(arg_10_1)
end

function var_0_0.setCellInvincible(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.cell_mgr._cell_list

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if math.abs(arg_11_2 - iter_11_1:getPosX()) <= 1 and math.abs(arg_11_3 - iter_11_1:getPosY()) <= 1 then
			iter_11_1:setCellInvincible(arg_11_1)
		end
	end

	if not arg_11_1 then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshFanElement)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StepFinished)
		arg_11_0:detectGameOver()
	end
end

function var_0_0.cellIsInvincible(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0:getCell(arg_12_1, arg_12_2):getInvincible()
end

function var_0_0.characterInArea(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == arg_13_0.character:getPosX() and arg_13_2 == arg_13_0.character:getPosY() then
		return true
	end
end

function var_0_0.cellHasBox(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0:getCell(arg_14_1, arg_14_2):getBox()
end

function var_0_0.pushBox(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0.cell_mgr:pushBox(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
end

function var_0_0._onMove(arg_16_0, arg_16_1)
	arg_16_0.character:move(arg_16_1)
end

function var_0_0.getCell(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0.cell_mgr:getCell(arg_17_1, arg_17_2)
end

function var_0_0.getElement(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return arg_18_0.cell_mgr:getElement(arg_18_1, arg_18_2, arg_18_3)
end

function var_0_0.outOfBounds(arg_19_0, arg_19_1, arg_19_2)
	return not arg_19_0.cell_mgr:getCell(arg_19_1, arg_19_2)
end

function var_0_0.detectCellData(arg_20_0)
	arg_20_0.cell_mgr:detectCellData()
end

function var_0_0.getElementLogicList(arg_21_0, arg_21_1)
	return arg_21_0.cell_mgr._element_logic[arg_21_1] or {}
end

function var_0_0.getEnemyIndex(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getElementLogicList(var_0_0.ElementType.Enemy)
	local var_22_1 = 0

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		var_22_1 = var_22_1 + 1

		if arg_22_1 == iter_22_1 then
			return var_22_1
		end
	end

	return var_22_1
end

function var_0_0.typeIsLight(arg_23_0, arg_23_1)
	return arg_23_1 == var_0_0.ElementType.LightUp or arg_23_1 == var_0_0.ElementType.LightDown or arg_23_1 == var_0_0.ElementType.LightLeft or arg_23_1 == var_0_0.ElementType.LightRight
end

function var_0_0.typeIsDoor(arg_24_0, arg_24_1)
	return arg_24_1 == var_0_0.ElementType.Goal
end

function var_0_0.typeIsEnemy(arg_25_0, arg_25_1)
	return arg_25_1 == var_0_0.ElementType.Enemy
end

function var_0_0.typeIsCharacter(arg_26_0, arg_26_1)
	return arg_26_1 == var_0_0.ElementType.Character
end

function var_0_0.typeIsMechanics(arg_27_0, arg_27_1)
	return arg_27_1 == var_0_0.ElementType.Mechanics
end

function var_0_0.getConfig(arg_28_0)
	return PushBoxEpisodeConfig.instance:getConfig(arg_28_0._stage_id)
end

function var_0_0.onSceneStart(arg_29_0, arg_29_1, arg_29_2)
	PushBoxController.instance:registerCallback(PushBoxEvent.Move, arg_29_0._onMove, arg_29_0)

	arg_29_0._scene = arg_29_0:getCurScene()
	arg_29_0._scene_root = arg_29_0._scene:getSceneContainerGO()
end

function var_0_0.onSceneClose(arg_30_0)
	arg_30_0:releaseComs()
	PushBoxController.instance:unregisterCallback(PushBoxEvent.Move, arg_30_0._onMove, arg_30_0)
	PushBoxController.instance:unregisterCallback(PushBoxEvent.DataEvent.FinishEpisodeReply, arg_30_0._onFinishEpisodeReply, arg_30_0)
end

function var_0_0.releaseComs(arg_31_0)
	if arg_31_0.cell_mgr then
		arg_31_0.cell_mgr:releaseSelf()

		arg_31_0.cell_mgr = nil
	end

	if arg_31_0.character then
		arg_31_0.character:releaseSelf()

		arg_31_0.character = nil
	end

	if arg_31_0.step_data then
		arg_31_0.step_data:releaseSelf()

		arg_31_0.step_data = nil
	end

	if arg_31_0.data then
		arg_31_0.data:releaseSelf()

		arg_31_0.data = nil
	end
end

function var_0_0.getCurStageID(arg_32_0)
	return arg_32_0._stage_id
end

function var_0_0.initComs(arg_33_0)
	arg_33_0.cell_mgr = PushBoxCellMgr.New(arg_33_0)
	arg_33_0.character = PushBoxCharacter.New(arg_33_0)
	arg_33_0.step_data = PushBoxStepDataMgr.New(arg_33_0)
	arg_33_0.data = PushBoxDataMgr.New(arg_33_0)
end

function var_0_0.playOpenAni(arg_34_0)
	arg_34_0._scene_root.transform:GetChild(0):GetComponent(typeof(UnityEngine.Animator)):Play("open", 0, 0)
end

function var_0_0.hideRoot(arg_35_0)
	gohelper.setActive(arg_35_0._scene_root.transform:GetChild(0).gameObject, false)
end

function var_0_0.gameIsFinish(arg_36_0)
	return arg_36_0._isFinish
end

function var_0_0.startGame(arg_37_0, arg_37_1)
	arg_37_0._isFinish = nil

	arg_37_0:releaseComs()
	arg_37_0:initComs()

	arg_37_0._stage_id = arg_37_1

	arg_37_0.cell_mgr:init()
	arg_37_0.character:init()
	arg_37_0.step_data:init()
	arg_37_0.data:init()
	PushBoxController.instance:dispatchEvent(PushBoxEvent.StartElement)
end

return var_0_0
