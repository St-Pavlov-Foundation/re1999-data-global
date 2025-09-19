module("modules.logic.dungeon.view.jump.DungeonJumpGameNodeItem", package.seeall)

local var_0_0 = class("DungeonJumpGameNodeItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goFightObj = gohelper.findChild(arg_1_0.viewGO, "#go_Fight")
	arg_1_0._imageNodeBg = gohelper.findChildImage(arg_1_0.viewGO, "#image_Floor")
	arg_1_0._btnFight = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#go_Fight")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnFight:AddClickListener(arg_2_0._clickFight, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnFight:RemoveClickListener()
end

function var_0_0._clickFight(arg_4_0)
	if arg_4_0._onClickFightAction then
		arg_4_0._onClickFightAction(arg_4_0._onClickActionObj)
	end
end

function var_0_0.setFightAction(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._onClickFightAction = arg_5_1
	arg_5_0._onClickActionObj = arg_5_2
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateData(arg_7_0, arg_7_1)
	arg_7_0._x = arg_7_1.x
	arg_7_0._y = arg_7_1.y
	arg_7_0._type = arg_7_1.type

	UISpriteSetMgr.instance:setUiFBSprite(arg_7_0._imageNodeBg, DungeonJumpGameEnum.JumoNodeBg[arg_7_1.bg])
	gohelper.setActive(arg_7_0._goFightObj, arg_7_1.isBattle)
end

function var_0_0.initNode(arg_8_0)
	recthelper.setAnchor(arg_8_0.viewGO.transform, arg_8_0._x, arg_8_0._y)
end

function var_0_0.setNodeActive(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.viewGO, arg_9_1)
end

function var_0_0.setNodeScale(arg_10_0, arg_10_1, arg_10_2)
	transformhelper.setLocalScale(arg_10_0._imageNodeBg.transform, arg_10_1, arg_10_2, 1)
end

function var_0_0._editableAddEvents(arg_11_0)
	return
end

function var_0_0._editableRemoveEvents(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
