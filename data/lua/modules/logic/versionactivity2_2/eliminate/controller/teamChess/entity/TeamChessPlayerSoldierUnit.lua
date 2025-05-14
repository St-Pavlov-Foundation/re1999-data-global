module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessPlayerSoldierUnit", package.seeall)

local var_0_0 = class("TeamChessPlayerSoldierUnit", TeamChessSoldierUnit)

function var_0_0._onResLoaded(arg_1_0)
	var_0_0.super._onResLoaded(arg_1_0)

	if gohelper.isNil(arg_1_0._backGo) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_put)
	arg_1_0:playAnimator("in")
	arg_1_0:refreshMeshOrder()
	arg_1_0:setActive(true)
	arg_1_0:refreshShowModeState()
end

function var_0_0.setOutlineActive(arg_2_0, arg_2_1)
	if gohelper.isNil(arg_2_0._backOutLineGo) then
		return
	end

	gohelper.setActive(arg_2_0._backOutLineGo.gameObject, arg_2_1)
	var_0_0.super.setOutlineActive(arg_2_0, arg_2_1)
end

function var_0_0.setNormalActive(arg_3_0, arg_3_1)
	if gohelper.isNil(arg_3_0._backGo) then
		return
	end

	gohelper.setActive(arg_3_0._backGo.gameObject, arg_3_1)
	var_0_0.super.setNormalActive(arg_3_0, arg_3_1)
end

function var_0_0.setGrayActive(arg_4_0, arg_4_1)
	if gohelper.isNil(arg_4_0._backGrayGo) then
		return
	end

	gohelper.setActive(arg_4_0._backGrayGo.gameObject, arg_4_1)
	var_0_0.super.setGrayActive(arg_4_0, arg_4_1)
end

function var_0_0.onDrag(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._unitMo:canActiveMove() then
		return
	end

	arg_5_0:cacheModel()
	arg_5_0:setShowModeType()

	local var_5_0 = arg_5_0._unitMo

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDrag, var_5_0.soldierId, var_5_0.uid, var_5_0.stronghold, arg_5_1, arg_5_2)
end

function var_0_0.onDragEnd(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._unitMo:canActiveMove() then
		return
	end

	arg_6_0:restoreModel()

	local var_6_0 = arg_6_0._unitMo

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEnd, var_6_0.soldierId, var_6_0.uid, var_6_0.stronghold, arg_6_1, arg_6_2)
end

return var_0_0
