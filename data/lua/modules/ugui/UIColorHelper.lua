module("modules.ugui.UIColorHelper", package.seeall)

local var_0_0 = {
	PressColor = GameUtil.parseColor("#C8C8C8")
}

function var_0_0.setUIPressState(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if not arg_1_0 then
		return
	end

	local var_1_0 = arg_1_0:GetEnumerator()

	while var_1_0:MoveNext() do
		local var_1_1

		if arg_1_2 then
			local var_1_2 = arg_1_4 or 0.85

			var_1_1 = arg_1_1 and arg_1_1[var_1_0.Current] * var_1_2 or arg_1_3 or var_0_0.PressColor
			var_1_1.a = var_1_0.Current.color.a
		else
			var_1_1 = arg_1_1 and arg_1_1[var_1_0.Current] or Color.white
		end

		var_1_0.Current.color = var_1_1
	end
end

function var_0_0.setGameObjectPressState(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0.pressGoContainer or not arg_2_0.pressGoContainer[arg_2_1] then
		if not arg_2_0.pressGoContainer then
			arg_2_0.pressGoContainer = arg_2_0:getUserDataTb_()
		end

		arg_2_0.pressGoContainer[arg_2_1] = {}

		local var_2_0 = arg_2_1:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_2_0.pressGoContainer[arg_2_1].images = var_2_0

		local var_2_1 = arg_2_1:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_2_0.pressGoContainer[arg_2_1].tmps = var_2_1
		arg_2_0.pressGoContainer[arg_2_1].compColor = {}

		local var_2_2 = var_2_0:GetEnumerator()

		while var_2_2:MoveNext() do
			arg_2_0.pressGoContainer[arg_2_1].compColor[var_2_2.Current] = var_2_2.Current.color
		end

		local var_2_3 = var_2_1:GetEnumerator()

		while var_2_3:MoveNext() do
			arg_2_0.pressGoContainer[arg_2_1].compColor[var_2_3.Current] = var_2_3.Current.color
		end
	end

	if arg_2_0.pressGoContainer[arg_2_1] then
		var_0_0.setUIPressState(arg_2_0.pressGoContainer[arg_2_1].images, arg_2_0.pressGoContainer[arg_2_1].compColor, arg_2_2, nil, 0.7)
		var_0_0.setUIPressState(arg_2_0.pressGoContainer[arg_2_1].tmps, arg_2_0.pressGoContainer[arg_2_1].compColor, arg_2_2, nil, 0.7)
	end
end

function var_0_0.set(arg_3_0, arg_3_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_3_0, arg_3_1)
end

function var_0_0.setGray(arg_4_0, arg_4_1)
	ZProj.UGUIHelper.SetGrayscale(arg_4_0, arg_4_1 and true or false)
end

return var_0_0
