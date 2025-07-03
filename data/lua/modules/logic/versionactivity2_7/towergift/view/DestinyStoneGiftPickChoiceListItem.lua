module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceListItem", package.seeall)

local var_0_0 = class("DestinyStoneGiftPickChoiceListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorole = gohelper.findChild(arg_1_0.viewGO, "role")
	arg_1_0._godestiny = gohelper.findChild(arg_1_0.viewGO, "#go_destiny")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_destiny/locked")
	arg_1_0._simagelockStone = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_destiny/locked/#image_stone")
	arg_1_0._gounlocked = gohelper.findChild(arg_1_0.viewGO, "#go_destiny/unlock")
	arg_1_0._simageunlockStone = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_destiny/unlock/#image_stone")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_destiny/unlock/#txt_level")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "select")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.viewGO, "go_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, arg_2_0.updateSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, arg_3_0.updateSelect, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	DestinyStoneGiftPickChoiceListModel.instance:setCurrentSelectMo(arg_4_0._mo)
end

function var_0_0.updateSelect(arg_5_0)
	local var_5_0 = DestinyStoneGiftPickChoiceListModel.instance:isSelectedMo(arg_5_0._mo.stoneId)

	gohelper.setActive(arg_5_0._goselect, var_5_0)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
	arg_6_0:updateSelect()
end

function var_0_0.refreshUI(arg_7_0)
	if not arg_7_0._mo then
		return
	end

	arg_7_0:_refreshHeroItem()
	arg_7_0:_refreshStone()
end

function var_0_0._refreshHeroItem(arg_8_0)
	if not arg_8_0.herocomponent then
		arg_8_0.herocomponent = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._gorole, DestinyStoneGiftPickChoiceListHeroItem)

		arg_8_0.herocomponent:init(arg_8_0._gorole)
	end

	local var_8_0 = SummonCustomPickChoiceMO.New()

	var_8_0:init(tonumber(arg_8_0._mo.heroId))
	arg_8_0.herocomponent:onUpdateMO(var_8_0)
end

function var_0_0._refreshStone(arg_9_0)
	local var_9_0 = arg_9_0._mo.isUnLock

	gohelper.setActive(arg_9_0._golocked, not var_9_0)
	gohelper.setActive(arg_9_0._gounlocked, var_9_0)

	if var_9_0 then
		arg_9_0._txtlevel.text = GameUtil.getRomanNums(arg_9_0._mo.stonelevel)
	else
		arg_9_0._txtlevel.text = ""
	end

	local var_9_1, var_9_2 = arg_9_0._mo.stoneMo:getNameAndIcon()

	arg_9_0._simagelockStone:LoadImage(var_9_2)
	arg_9_0._simageunlockStone:LoadImage(var_9_2)
end

return var_0_0
