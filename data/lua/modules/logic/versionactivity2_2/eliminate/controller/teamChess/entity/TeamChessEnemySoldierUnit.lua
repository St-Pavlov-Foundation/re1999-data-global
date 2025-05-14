module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessEnemySoldierUnit", package.seeall)

local var_0_0 = class("TeamChessEnemySoldierUnit", TeamChessSoldierUnit)

function var_0_0._onResLoaded(arg_1_0)
	var_0_0.super._onResLoaded(arg_1_0)

	if gohelper.isNil(arg_1_0._frontGo) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_put)
	arg_1_0:refreshMeshOrder()
	arg_1_0:playAnimator("in")
	arg_1_0:setActive(true)
end

function var_0_0.setOutlineActive(arg_2_0, arg_2_1)
	if gohelper.isNil(arg_2_0._frontOutLineGo) then
		return
	end

	gohelper.setActive(arg_2_0._frontOutLineGo.gameObject, arg_2_1)
	var_0_0.super.setOutlineActive(arg_2_0, arg_2_1)
end

function var_0_0.setNormalActive(arg_3_0, arg_3_1)
	if gohelper.isNil(arg_3_0._frontGo) then
		return
	end

	gohelper.setActive(arg_3_0._frontGo.gameObject, arg_3_1)
	var_0_0.super.setNormalActive(arg_3_0, arg_3_1)
end

function var_0_0.setGrayActive(arg_4_0, arg_4_1)
	if gohelper.isNil(arg_4_0._frontGrayGo) then
		return
	end

	gohelper.setActive(arg_4_0._frontGrayGo.gameObject, arg_4_1)
	var_0_0.super.setGrayActive(arg_4_0, arg_4_1)
end

return var_0_0
