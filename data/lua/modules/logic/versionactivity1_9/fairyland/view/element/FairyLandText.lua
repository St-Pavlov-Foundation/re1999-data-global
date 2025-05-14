module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandText", package.seeall)

local var_0_0 = class("FairyLandText", FairyLandElementBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.itemGO = gohelper.findChild(arg_1_0._go, "item")
	arg_1_0.wordComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.itemGO, FairyLandWordComp, {
		co = arg_1_0._config.config,
		res1 = arg_1_0._elements.wordRes1,
		res2 = arg_1_0._elements.wordRes2
	})
end

function var_0_0.onRefresh(arg_2_0)
	return
end

function var_0_0.updatePos(arg_3_0)
	local var_3_0 = -100
	local var_3_1 = -120
	local var_3_2 = 244
	local var_3_3 = 73
	local var_3_4 = arg_3_0:getPos()
	local var_3_5 = var_3_0 + var_3_4 * var_3_2
	local var_3_6 = var_3_1 - var_3_4 * var_3_3

	recthelper.setAnchor(arg_3_0._transform, var_3_5, var_3_6)
end

function var_0_0.onDestroyElement(arg_4_0)
	return
end

return var_0_0
