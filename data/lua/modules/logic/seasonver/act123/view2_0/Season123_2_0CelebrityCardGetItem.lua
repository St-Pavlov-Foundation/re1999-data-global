module("modules.logic.seasonver.act123.view2_0.Season123_2_0CelebrityCardGetItem", package.seeall)

local var_0_0 = class("Season123_2_0CelebrityCardGetItem", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorare1 = gohelper.findChild(arg_1_0.viewGO, "#go_rare1")
	arg_1_0._gorare2 = gohelper.findChild(arg_1_0.viewGO, "#go_rare2")
	arg_1_0._gorare3 = gohelper.findChild(arg_1_0.viewGO, "#go_rare3")
	arg_1_0._gorare4 = gohelper.findChild(arg_1_0.viewGO, "#go_rare4")
	arg_1_0._gorare5 = gohelper.findChild(arg_1_0.viewGO, "#go_rare5")

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

function var_0_0.onRefreshViewParam(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._uid = arg_4_1
	arg_4_0._noClick = arg_4_2
	arg_4_0._equipId = arg_4_3
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshData(arg_5_0._uid)
end

function var_0_0.refreshData(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:_getItemID(arg_6_1)

	arg_6_0._itemId = var_6_0

	arg_6_0:_checkCreateIcon()
	arg_6_0._icon:updateData(var_6_0)
	arg_6_0._icon:setIndexLimitShowState(true)
end

function var_0_0._checkCreateIcon(arg_7_0)
	if not arg_7_0._icon then
		arg_7_0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0.viewGO, Season123_2_0CelebrityCardEquip)

		arg_7_0._icon:setClickCall(arg_7_0.onBtnClick, arg_7_0)

		if arg_7_0._noClick then
			local var_7_0 = gohelper.onceAddComponent(arg_7_0.viewGO, typeof(UnityEngine.CanvasGroup))

			var_7_0.interactable = false
			var_7_0.blocksRaycasts = false
		end
	end
end

function var_0_0.onBtnClick(arg_8_0)
	if arg_8_0._noClick then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, arg_8_0._itemId)
end

function var_0_0._getItemID(arg_9_0, arg_9_1)
	local var_9_0
	local var_9_1 = arg_9_0:getParentView()

	if var_9_1 and var_9_1.isItemID and var_9_1:isItemID() then
		var_9_0 = arg_9_1
	else
		local var_9_2 = Season123Model.instance:getCurSeasonId()
		local var_9_3 = Season123Model.instance:getAllItemMo(var_9_2)

		var_9_0 = var_9_3[arg_9_1] and var_9_3[arg_9_1].itemId
	end

	var_9_0 = arg_9_0._equipId or var_9_0

	return var_9_0
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0._icon then
		arg_11_0._icon:setClickCall(nil, nil)
		arg_11_0._icon:disposeUI()
	end
end

return var_0_0
