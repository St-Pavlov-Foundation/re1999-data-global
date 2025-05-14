module("modules.logic.dungeon.view.DungeonMonsterView", package.seeall)

local var_0_0 = class("DungeonMonsterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagequality = gohelper.findChildImage(arg_1_0.viewGO, "desc/#simage_quality")
	arg_1_0._simageicon = gohelper.findChildImage(arg_1_0.viewGO, "desc/#simage_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_desc")
	arg_1_0._simagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "desc/#simage_careericon")
	arg_1_0._scrollmonster = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_monster")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "content_prefab/#go_selected")

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

function var_0_0._btnbackOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	DungeonMonsterListModel.instance:setMonsterList(arg_7_0.viewParam.monsterDisplayList)
	arg_7_0.viewContainer:getScrollView():setSelect(DungeonMonsterListModel.instance.initSelectMO)
	arg_7_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeMonster, arg_7_0._onChangeMonster, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0._onChangeMonster(arg_9_0, arg_9_1)
	arg_9_0._txtname.text = arg_9_1.name
	arg_9_0._txtdesc.text = arg_9_1.des

	UISpriteSetMgr.instance:setCommonSprite(arg_9_0._simagecareericon, "lssx_" .. tostring(arg_9_1.career))

	local var_9_0 = FightConfig.instance:getSkinCO(arg_9_1.skinId)
	local var_9_1 = var_9_0 and var_9_0.headIcon or nil

	if var_9_1 then
		gohelper.getSingleImage(arg_9_0._simageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_9_1))
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_9_0._simagequality, "bp_quality_01")
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
