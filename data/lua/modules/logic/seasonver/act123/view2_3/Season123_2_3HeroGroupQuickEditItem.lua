module("modules.logic.seasonver.act123.view2_3.Season123_2_3HeroGroupQuickEditItem", package.seeall)

local var_0_0 = class("Season123_2_3HeroGroupQuickEditItem", Season123_2_3HeroGroupEditItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._imageorder = gohelper.findChildImage(arg_1_1, "#go_orderbg/#image_order")
	arg_1_0._goorderbg = gohelper.findChild(arg_1_1, "#go_orderbg")
	arg_1_0._gohp = gohelper.findChild(arg_1_1, "#go_hp")
	arg_1_0._sliderhp = gohelper.findChildSlider(arg_1_1, "#go_hp/#slider_hp")
	arg_1_0._imagehp = gohelper.findChildImage(arg_1_1, "#go_hp/#slider_hp/Fill Area/Fill")
	arg_1_0._godead = gohelper.findChild(arg_1_1, "#go_dead")

	arg_1_0:enableDeselect(false)
	arg_1_0._heroItem:setNewShow(false)
	gohelper.setActive(arg_1_0._goorderbg, false)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1

	arg_2_0._heroItem:onUpdateMO(arg_2_1)
	arg_2_0._heroItem:setNewShow(false)
	arg_2_0:updateLimitStatus()

	local var_2_0 = Season123HeroGroupQuickEditModel.instance:getHeroTeamPos(arg_2_0._mo.uid)

	arg_2_0._team_pos_index = var_2_0

	if var_2_0 ~= 0 then
		if not arg_2_0._open_ani_finish then
			TaskDispatcher.runDelay(arg_2_0._show_goorderbg, arg_2_0, 0.3)
		else
			arg_2_0:_show_goorderbg()
		end
	else
		gohelper.setActive(arg_2_0._goorderbg, false)
	end

	arg_2_0._open_ani_finish = true

	arg_2_0:refreshHp()
	arg_2_0:refreshDead()
end

function var_0_0._show_goorderbg(arg_3_0)
	gohelper.setActive(arg_3_0._goorderbg, true)
	UISpriteSetMgr.instance:setHeroGroupSprite(arg_3_0._imageorder, "biandui_shuzi_" .. arg_3_0._team_pos_index)
end

function var_0_0._onItemClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_4_0:checkRestrict(arg_4_0._mo.uid) or arg_4_0:checkHpZero(arg_4_0._mo.uid) then
		return
	end

	if arg_4_0._mo and not Season123HeroGroupQuickEditModel.instance:selectHero(arg_4_0._mo.uid) then
		return
	end

	if arg_4_0._isSelect and arg_4_0._enableDeselect then
		arg_4_0._view:selectCell(arg_4_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_4_0._view:selectCell(arg_4_0._index, true)
	end
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	arg_5_0._isSelect = arg_5_1

	if arg_5_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_5_0._mo)
	end
end

function var_0_0.onDestroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._show_goorderbg, arg_6_0)
	var_0_0.super.onDestroy(arg_6_0)
end

return var_0_0
