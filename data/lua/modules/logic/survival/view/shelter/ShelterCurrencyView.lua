module("modules.logic.survival.view.shelter.ShelterCurrencyView", package.seeall)

local var_0_0 = class("ShelterCurrencyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRoot = gohelper.findChild(arg_1_0.viewGO, arg_1_0.rootGOPath)
	arg_1_0._gocurrency = gohelper.findChild(arg_1_0.goRoot, "tag")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_0.goRoot, "tag/#txt_tag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
end

function var_0_0.ctor(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super.ctor(arg_4_0)

	arg_4_0.param = arg_4_1
	arg_4_0.rootGOPath = arg_4_2
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:onShelterBagUpdate()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onShelterBagUpdate(arg_9_0)
	if not arg_9_0.param then
		gohelper.setActive(arg_9_0._gocontainer, false)

		return
	end

	local var_9_0 = arg_9_0.param[1]
	local var_9_1 = SurvivalShelterModel.instance:getWeekInfo().bag:getItemCountPlus(var_9_0)

	arg_9_0._txtNum.text = var_9_1
end

return var_0_0
