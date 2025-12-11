module("modules.logic.survival.view.shelter.SurvivalMonsterEventBuffItem", package.seeall)

local var_0_0 = class("SurvivalMonsterEventBuffItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "#go_unfinish")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "scroll_buffDec/Viewport/Content/#txt_dec")
	arg_1_0._txtdecfinished = gohelper.findChildText(arg_1_0.viewGO, "scroll_buffDec/Viewport/Content/#txt_dec_finished")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "#go_finished")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0.icon = gohelper.findChildImage(arg_1_0.viewGO, "#go_unfinish/icon")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._ani = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.initItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.survivalIntrudeSchemeMo = arg_7_2
	arg_7_0._co = SurvivalConfig.instance:getShelterIntrudeSchemeConfig(arg_7_1)

	if arg_7_0._co == nil then
		logError("SurvivalMonsterEventBuffItem:initItem id is nil" .. arg_7_1)
	end

	arg_7_0._txtdec.text = arg_7_0._co and arg_7_0._co.desc or ""
	arg_7_0._txtdecfinished.text = arg_7_0._co and arg_7_0._co.desc or ""

	local var_7_0 = arg_7_0.survivalIntrudeSchemeMo:getDisplayIcon()

	UISpriteSetMgr.instance:setSurvivalSprite(arg_7_0.icon, var_7_0)
end

function var_0_0.updateItem(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._gofinished, arg_8_1)
	gohelper.setActive(arg_8_0._txtdecfinished.gameObject, arg_8_1)
	gohelper.setActive(arg_8_0._gounfinish, not arg_8_1)
	gohelper.setActive(arg_8_0._txtdec.gameObject, not arg_8_1)

	if arg_8_0._lastState == nil or arg_8_0._lastState ~= arg_8_1 then
		arg_8_0:playAni(arg_8_1 and "finished" or "open")
	end

	arg_8_0._lastState = arg_8_1
end

function var_0_0.playAni(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0._ani:Play(arg_9_1, 0, 0)
	end
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
