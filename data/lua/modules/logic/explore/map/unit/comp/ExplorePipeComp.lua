module("modules.logic.explore.map.unit.comp.ExplorePipeComp", package.seeall)

local var_0_0 = class("ExplorePipeComp", LuaCompBase)
local var_0_1 = UnityEngine.Shader.PropertyToID("_GasColor")
local var_0_2 = UnityEngine.Shader.PropertyToID("_Fade")
local var_0_3 = UnityEngine.Shader.PropertyToID("_Process")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0._allMatDict = {}
	arg_1_0._dirToPipeType = {}
	arg_1_0._fromColor = {}
	arg_1_0._toColor = {}
end

function var_0_0.initData(arg_2_0)
	for iter_2_0 = 0, 270, 90 do
		arg_2_0._dirToPipeType[iter_2_0] = arg_2_0.unit.mo:getDirType(iter_2_0)
	end

	arg_2_0._dirToPipeType[-1] = ExploreEnum.PipeGoNode.Center
end

function var_0_0.setup(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0._allMatDict = {}

	for iter_3_0, iter_3_1 in pairs(ExploreEnum.PipeGoNodeName) do
		local var_3_0 = arg_3_0:_getMat(iter_3_1)

		if var_3_0 then
			arg_3_0._allMatDict[iter_3_0] = var_3_0

			arg_3_0._allMatDict[iter_3_0]:SetFloat(var_0_3, 1)
		end
	end

	arg_3_0:tweenColor(1)
end

function var_0_0._getMat(arg_4_0, arg_4_1)
	local var_4_0 = gohelper.findChild(arg_4_0.go, "#go_rotate/" .. arg_4_1)

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0:GetComponent(typeof(UnityEngine.Renderer))

	return var_4_1 and var_4_1.material
end

function var_0_0.applyColor(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._dirToPipeType) do
		arg_5_0._fromColor[iter_5_0] = arg_5_0._toColor[iter_5_0]
		arg_5_0._toColor[iter_5_0] = arg_5_0.unit.mo:getColor(iter_5_0)
	end

	arg_5_0._toColor[-1] = arg_5_0.unit.mo:getColor(-1)

	if arg_5_1 then
		for iter_5_2, iter_5_3 in pairs(arg_5_0._toColor) do
			arg_5_0._fromColor[iter_5_2] = iter_5_3
		end

		arg_5_0._fromColor[-1] = arg_5_0._toColor[-1]

		arg_5_0:tweenColor(1)
	end
end

local var_0_4 = Color()

function var_0_0.tweenColor(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._toColor) do
		local var_6_0 = arg_6_0._dirToPipeType[iter_6_0]
		local var_6_1 = arg_6_0._allMatDict[var_6_0]

		if var_6_1 then
			if iter_6_1 == arg_6_0._fromColor[iter_6_0] then
				if iter_6_1 == ExploreEnum.PipeColor.None then
					var_6_1:SetFloat(var_0_2, 1)
				else
					var_6_1:SetFloat(var_0_2, 0)
					var_6_1:SetColor(var_0_1, ExploreEnum.PipeColorDef[iter_6_1])
				end
			elseif iter_6_1 == ExploreEnum.PipeColor.None then
				var_6_1:SetFloat(var_0_2, arg_6_1)
			elseif arg_6_0._fromColor[iter_6_0] == ExploreEnum.PipeColor.None then
				var_6_1:SetFloat(var_0_2, 1 - arg_6_1)
				var_6_1:SetColor(var_0_1, ExploreEnum.PipeColorDef[iter_6_1])
			else
				var_6_1:SetFloat(var_0_2, 0)
				var_6_1:SetColor(var_0_1, MaterialUtil.getLerpValue("Color", ExploreEnum.PipeColorDef[arg_6_0._fromColor[iter_6_0]], ExploreEnum.PipeColorDef[iter_6_1], arg_6_1, var_0_4))
			end
		end
	end
end

function var_0_0.clear(arg_7_0)
	arg_7_0._allMatDict = {}
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0:clear()

	arg_8_0._fromColor = {}
	arg_8_0._toColor = {}
	arg_8_0._dirToPipeType = {}
	arg_8_0.unit = nil
end

return var_0_0
