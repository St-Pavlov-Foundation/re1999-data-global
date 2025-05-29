module("modules.logic.fight.view.FightWeekWalkEnemyTipsView", package.seeall)

local var_0_0 = class("FightWeekWalkEnemyTipsView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.objContent = gohelper.findChild(arg_1_0.viewGO, "#go_enemyinfocontainer/enemy/#scroll_enemy/viewport/content")
	arg_1_0.objItem = gohelper.findChild(arg_1_0.viewGO, "#go_enemyinfocontainer/enemy/#scroll_enemy/viewport/content/#go_enemyitem")
	arg_1_0.btnClose = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_enemyinfocontainer/#btn_close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.btnClose, arg_2_0.onBtnClose)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onBtnClose(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onConstructor(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = FightDataHelper.entityMgr:getEnemySubList()

	table.insert(var_6_0, 1, true)
	gohelper.CreateObjList(arg_6_0, arg_6_0._onItemShow, var_6_0, arg_6_0.objContent, arg_6_0.objItem)
end

function var_0_0._onItemShow(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3 == 1 then
		return
	end

	local var_7_0 = gohelper.findChildImage(arg_7_1, "head/#simage_icon")
	local var_7_1 = gohelper.findChildImage(arg_7_1, "head/#image_career")
	local var_7_2 = gohelper.findChildText(arg_7_1, "#txt_name")
	local var_7_3 = gohelper.findChildText(arg_7_1, "#txt_level")
	local var_7_4 = gohelper.findChildText(arg_7_1, "hp/hp_label/image_HPFrame/#txt_hp")
	local var_7_5 = gohelper.findChild(arg_7_1, "hp/hp_label/image_HPFrame/#go_multihp")

	var_7_2.text = arg_7_2:getEntityName()
	var_7_3.text = HeroConfig.instance:getLevelDisplayVariant(arg_7_2.level)
	var_7_4.text = arg_7_2.currentHp

	gohelper.setActive(var_7_5, false)
	UISpriteSetMgr.instance:setCommonSprite(var_7_1, "lssx_" .. arg_7_2.career)

	local var_7_6 = arg_7_2:getSpineSkinCO()

	if var_7_6 then
		gohelper.getSingleImage(var_7_0.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_7_6.headIcon))
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
