module("modules.spine.rolefaceeffect.CommonRoleFaceEffect", package.seeall)

local var_0_0 = class("CommonRoleFaceEffect", BaseSpineRoleFaceEffect)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1
	arg_1_0._spineGo = arg_1_0._spine._spineGo
	arg_1_0._faceList = string.split(arg_1_1.face, "|")
	arg_1_0._nodeList = GameUtil.splitString2(arg_1_1.node, false, "|", "#")
end

function var_0_0.showFaceEffect(arg_2_0, arg_2_1)
	arg_2_0:_setNodeVisible(arg_2_0._index, false)

	arg_2_0._index = tabletool.indexOf(arg_2_0._faceList, arg_2_1)

	arg_2_0:_setNodeVisible(arg_2_0._index, true)
end

function var_0_0._setNodeVisible(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_0._nodeList[arg_3_1]

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = gohelper.findChild(arg_3_0._spineGo, iter_3_1)

		gohelper.setActive(var_3_1, arg_3_2)
	end
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._spineGo = nil
end

return var_0_0
