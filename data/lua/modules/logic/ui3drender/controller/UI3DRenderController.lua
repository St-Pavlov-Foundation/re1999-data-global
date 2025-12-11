module("modules.logic.ui3drender.controller.UI3DRenderController", package.seeall)

local var_0_0 = class("UI3DRenderController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.curPosIndex = 0
	arg_1_0.startPos = {
		8000,
		10000
	}
	arg_1_0.distance = 500
	arg_1_0.curPos = {
		arg_1_0.startPos[1],
		arg_1_0.startPos[2]
	}
end

function var_0_0.getSurvivalUI3DRender(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:_addIndex()

	local var_2_0 = SurvivalUI3DRender.New(arg_2_1, arg_2_2, {
		arg_2_3 and arg_2_3.x or arg_2_0.curPos[1],
		arg_2_3 and arg_2_3.y or 0,
		arg_2_3 and arg_2_3.z or arg_2_0.curPos[2]
	})

	var_2_0:init()

	return var_2_0
end

function var_0_0.removeSurvivalUI3DRender(arg_3_0, arg_3_1)
	arg_3_1:dispose()
	arg_3_0:_reduceIndex()
end

function var_0_0._addIndex(arg_4_0)
	arg_4_0.curPosIndex = arg_4_0.curPosIndex + 1
	arg_4_0.curPos[1] = arg_4_0.curPos[1] + arg_4_0.distance
end

function var_0_0._reduceIndex(arg_5_0)
	arg_5_0.curPosIndex = arg_5_0.curPosIndex - 1

	if arg_5_0.curPosIndex <= 0 then
		arg_5_0.curPos = {
			arg_5_0.startPos[1],
			arg_5_0.startPos[2]
		}
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
