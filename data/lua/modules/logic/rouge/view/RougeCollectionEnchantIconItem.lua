module("modules.logic.rouge.view.RougeCollectionEnchantIconItem", package.seeall)

local var_0_0 = class("RougeCollectionEnchantIconItem", RougeCollectionIconItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

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
	arg_4_0._holeImageTab = arg_4_0:getUserDataTb_()

	arg_4_0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, arg_4_0.updateEnchantInfo, arg_4_0)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	var_0_0.super.onUpdateMO(arg_5_0, arg_5_1.cfgId)

	arg_5_0._mo = arg_5_1

	arg_5_0:refreshAllHoles()
end

function var_0_0.refreshAllHoles(arg_6_0)
	local var_6_0 = arg_6_0._collectionCfg and arg_6_0._collectionCfg.holeNum or 0

	gohelper.setActive(arg_6_0._goholetool, var_6_0 > 0)

	if var_6_0 > 0 then
		local var_6_1 = arg_6_0._mo:getAllEnchantId() or {}

		gohelper.CreateObjList(arg_6_0, arg_6_0.refrehHole, var_6_1, arg_6_0._goholetool, arg_6_0._goholeitem)
	end
end

function var_0_0.refrehHole(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChild(arg_7_1, "go_none")
	local var_7_1 = gohelper.findChild(arg_7_1, "go_get")
	local var_7_2 = arg_7_2 and arg_7_2 > 0

	gohelper.setActive(var_7_1, var_7_2)
	gohelper.setActive(var_7_0, not var_7_2)

	if not var_7_2 then
		return
	end

	local var_7_3 = gohelper.findChildSingleImage(arg_7_1, "go_get/image_enchanticon")
	local var_7_4, var_7_5 = arg_7_0._mo:getEnchantIdAndCfgId(arg_7_3)
	local var_7_6 = RougeCollectionHelper.getCollectionIconUrl(var_7_5)

	var_7_3:LoadImage(var_7_6)

	arg_7_0._holeImageTab[var_7_3] = true
end

function var_0_0.updateEnchantInfo(arg_8_0, arg_8_1)
	if not arg_8_0._mo or arg_8_0._mo.id ~= arg_8_1 then
		return
	end

	arg_8_0:refreshAllHoles()
end

function var_0_0.destroy(arg_9_0)
	if arg_9_0._holeImageTab then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._holeImageTab) do
			iter_9_0:UnLoadImage()
		end
	end

	var_0_0.super.destroy(arg_9_0)
end

return var_0_0
