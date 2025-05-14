module("modules.logic.season.view1_4.Season1_4EquipSelfChoiceItem", package.seeall)

local var_0_0 = class("Season1_4EquipSelfChoiceItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gocard = gohelper.findChild(arg_1_0.viewGO, "go_card")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "tag")
	arg_1_0._txtcount = gohelper.findChildTextMesh(arg_1_0.viewGO, "tag/bg/#txt_count")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._cfg = arg_4_1.cfg

	arg_4_0:refreshUI()
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0:checkCreateIcon()
	arg_5_0.icon:updateData(arg_5_0._cfg.equipId)
	gohelper.setActive(arg_5_0._goselect, Activity104SelfChoiceListModel.instance.curSelectedItemId == arg_5_0._cfg.equipId)

	local var_5_0 = Activity104Model.instance:getItemCount(arg_5_0._cfg.equipId, arg_5_0._view.viewParam.actId)

	arg_5_0._txtcount.text = tostring(var_5_0)
end

function var_0_0.checkCreateIcon(arg_6_0)
	if not arg_6_0.icon then
		local var_6_0 = arg_6_0._view.viewContainer:getSetting().otherRes[2]
		local var_6_1 = arg_6_0._view:getResInst(var_6_0, arg_6_0._gocard, "icon")

		arg_6_0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, Season1_4CelebrityCardEquip)

		arg_6_0.icon:setClickCall(arg_6_0.onClickSelf, arg_6_0)
		arg_6_0.icon:setLongPressCall(arg_6_0.onLongPress, arg_6_0)
	end
end

function var_0_0.showDetailTips(arg_7_0)
	local var_7_0 = {
		actId = arg_7_0._view.viewParam.actId
	}

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.EquipCard, arg_7_0._cfg.equipId, var_7_0)
end

function var_0_0.onClickSelf(arg_8_0)
	if Activity104SelfChoiceListModel.instance.curSelectedItemId ~= arg_8_0._cfg.equipId then
		Activity104EquipSelfChoiceController.instance:changeSelectCard(arg_8_0._cfg.equipId)
	end
end

function var_0_0.onLongPress(arg_9_0)
	arg_9_0:showDetailTips()
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0.icon then
		arg_10_0.icon:disposeUI()
	end
end

return var_0_0
