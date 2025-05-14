module("modules.logic.fight.view.FightCardDeckViewItem", package.seeall)

local var_0_0 = class("FightCardDeckViewItem", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._cardObj = gohelper.findChild(arg_1_0.viewGO, "card/card")
	arg_1_0._select = gohelper.findChild(arg_1_0.viewGO, "select")

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

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._cardObj, FightViewCardItem, FightEnum.CardShowType.Deck)
end

function var_0_0.refreshItem(arg_7_0, arg_7_1)
	arg_7_0._data = arg_7_1

	arg_7_0._cardItem:updateItem(arg_7_1.entityId, arg_7_1.skillId, arg_7_1)
end

function var_0_0.showCount(arg_8_0, arg_8_1)
	arg_8_0._cardItem:showCountPart(arg_8_1)
end

function var_0_0.setSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._select, arg_9_1)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
