module("modules.logic.commandstation.view.CommandStationPaperMarkItem", package.seeall)

local var_0_0 = class("CommandStationPaperMarkItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.isAfter = arg_1_1.after
	arg_1_0.style = arg_1_1.style
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.transform = arg_2_1.transform
	arg_2_0._loader = PrefabInstantiate.Create(arg_2_1)

	arg_2_0._loader:startLoad(arg_2_0:getResPath(), arg_2_0._onLoadedFinish, arg_2_0)
end

function var_0_0.getResPath(arg_3_0)
	if arg_3_0.isAfter then
		return string.format("ui/viewres/commandstation/stickeritem/aftermarkitem_stk%s.prefab", arg_3_0.style)
	else
		return string.format("ui/viewres/commandstation/stickeritem/beforemarkitem_tuhei%s.prefab", arg_3_0.style)
	end
end

function var_0_0._onLoadedFinish(arg_4_0)
	local var_4_0 = arg_4_0._loader:getInstGO()

	arg_4_0._anim = gohelper.findChildAnim(var_4_0, "")
	arg_4_0._anim.keepAnimatorControllerStateOnDisable = true

	arg_4_0:playAnim(arg_4_0._animType)
end

function var_0_0.playAnim(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_0._animType = arg_5_1

	local var_5_0 = arg_5_0._anim

	if not var_5_0 then
		return
	end

	if arg_5_0.isAfter then
		if arg_5_0._animType == 1 then
			var_5_0:Play("in", 0, 0)

			var_5_0.speed = 0
		elseif arg_5_0._animType == 2 then
			var_5_0:Play("in", 0, 0)

			var_5_0.speed = 1
		else
			var_5_0:Play("idle", 0, 0)
		end
	elseif arg_5_0._animType == 1 then
		var_5_0:Play("idle", 0, 0)
	elseif arg_5_0._animType == 2 then
		var_5_0:Play("out", 0, 0)
	else
		var_5_0:Play("out", 0, 1)
	end
end

function var_0_0.destroy(arg_6_0)
	if arg_6_0._loader then
		arg_6_0._loader:dispose()

		arg_6_0._loader = nil
	end
end

return var_0_0
