module("modules.logic.gm.model.GMResetCardsModel", package.seeall)

local var_0_0 = class("GMResetCardsModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._model1 = ListScrollModel.New()
	arg_1_0._model2 = ListScrollModel.New()
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._model1:onInit()
	arg_2_0._model2:onInit()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0._model1:reInit()
	arg_3_0._model2:reInit()
end

function var_0_0.clear(arg_4_0)
	arg_4_0._model1:clear()
	arg_4_0._model2:clear()
end

function var_0_0.getModel1(arg_5_0)
	return arg_5_0._model1
end

function var_0_0.getModel2(arg_6_0)
	return arg_6_0._model2
end

var_0_0.instance = var_0_0.New()

return var_0_0
