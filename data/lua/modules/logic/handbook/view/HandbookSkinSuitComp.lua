module("modules.logic.handbook.view.HandbookSkinSuitComp", package.seeall)

local var_0_0 = class("HandbookSkinSuitComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._suitId = arg_1_1[1]
	arg_1_0._skinCfg = HandbookConfig.instance:getSkinSuitCfg(arg_1_0._suitId)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._goSuitName = gohelper.findChild(arg_2_0._go, "root/loop/scence/zh_text")
	arg_2_0._goSuitNameEn = gohelper.findChild(arg_2_0._go, "root/loop/scence/en_text")

	if arg_2_0._skinCfg.show ~= 1 then
		gohelper.setActive(arg_2_0._goSuitName, false)
		gohelper.setActive(arg_2_0._goSuitNameEn, false)
	else
		arg_2_0._textSuitName = arg_2_0._goSuitName:GetComponent(typeof(TMPro.TextMeshPro))
		arg_2_0._textSuitNameEn = arg_2_0._goSuitNameEn:GetComponent(typeof(TMPro.TextMeshPro))

		if arg_2_0._textSuitName then
			arg_2_0._textSuitName.text = arg_2_0._skinCfg.name
		end

		if arg_2_0._textSuitNameEn then
			arg_2_0._textSuitNameEn.text = arg_2_0._skinCfg.nameEn
		end
	end
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.onStart(arg_5_0)
	return
end

function var_0_0.dispose(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0
