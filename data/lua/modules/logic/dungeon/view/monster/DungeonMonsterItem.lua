module("modules.logic.dungeon.view.monster.DungeonMonsterItem", package.seeall)

local var_0_0 = class("DungeonMonsterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btncategoryOnClick(arg_4_0)
	arg_4_0._view:selectCell(arg_4_0._index, true)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._singleImage = gohelper.findChildImage(arg_5_0.viewGO, "image")
	arg_5_0._quality = gohelper.findChildImage(arg_5_0.viewGO, "quality")
	arg_5_0._goselected = gohelper.findChild(arg_5_0.viewGO, "#go_selected")
	arg_5_0._click = SLFramework.UGUI.UIClickListener.Get(arg_5_0._singleImage.gameObject)
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0._click:AddClickListener(arg_6_0._btncategoryOnClick, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	local var_8_0 = FightConfig.instance:getSkinCO(arg_8_0._mo.config.skinId)
	local var_8_1 = var_8_0 and var_8_0.headIcon or nil

	if var_8_1 then
		gohelper.getSingleImage(arg_8_0._singleImage.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_8_1))
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._quality, "bp_quality_01")
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	if arg_9_1 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMonster, arg_9_0._mo.config)
	end

	arg_9_0._goselected:SetActive(arg_9_1)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
