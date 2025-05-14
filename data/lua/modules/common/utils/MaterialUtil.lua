module("modules.common.utils.MaterialUtil", package.seeall)

local var_0_0 = _M

var_0_0._MainColorId = UnityEngine.Shader.PropertyToID("_MainColor")
var_0_0._MaskColorId = UnityEngine.Shader.PropertyToID("_MaskColor")
var_0_0._NoiseMap = UnityEngine.Shader.PropertyToID("_NoiseMap")

function var_0_0.GetMainColor(arg_1_0)
	if not gohelper.isNil(arg_1_0) then
		return arg_1_0:GetColor(var_0_0._MainColorId)
	end
end

function var_0_0.setMainColor(arg_2_0, arg_2_1)
	if not gohelper.isNil(arg_2_0) then
		arg_2_0:SetColor(var_0_0._MainColorId, arg_2_1)
	end
end

function var_0_0.getLerpValue(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_0 == "int" or arg_3_0 == "float" then
		return Mathf.Lerp(arg_3_1, arg_3_2, arg_3_3)
	elseif arg_3_0 == "Color" then
		arg_3_4 = arg_3_4 or Color.New()
		arg_3_4.r = Mathf.Lerp(arg_3_1.r, arg_3_2.r, arg_3_3)
		arg_3_4.g = Mathf.Lerp(arg_3_1.g, arg_3_2.g, arg_3_3)
		arg_3_4.b = Mathf.Lerp(arg_3_1.b, arg_3_2.b, arg_3_3)
		arg_3_4.a = Mathf.Lerp(arg_3_1.a, arg_3_2.a, arg_3_3)

		return arg_3_4
	elseif arg_3_0 == "Vector2" then
		arg_3_4 = arg_3_4 or Vector2.New()
		arg_3_4.x = Mathf.Lerp(arg_3_1.x, arg_3_2.x, arg_3_3)
		arg_3_4.y = Mathf.Lerp(arg_3_1.y, arg_3_2.y, arg_3_3)

		return arg_3_4
	elseif arg_3_0 == "Vector3" then
		arg_3_4 = arg_3_4 or Vector3.New()
		arg_3_4.x = Mathf.Lerp(arg_3_1.x, arg_3_2.x, arg_3_3)
		arg_3_4.y = Mathf.Lerp(arg_3_1.y, arg_3_2.y, arg_3_3)
		arg_3_4.z = Mathf.Lerp(arg_3_1.z, arg_3_2.z, arg_3_3)

		return arg_3_4
	elseif arg_3_0 == "Vector4" then
		arg_3_4 = arg_3_4 or Vector4.New()
		arg_3_4.x = Mathf.Lerp(arg_3_1.x, arg_3_2.x, arg_3_3)
		arg_3_4.y = Mathf.Lerp(arg_3_1.y, arg_3_2.y, arg_3_3)
		arg_3_4.z = Mathf.Lerp(arg_3_1.z, arg_3_2.z, arg_3_3)
		arg_3_4.w = Mathf.Lerp(arg_3_1.w, arg_3_2.w, arg_3_3)

		return arg_3_4
	elseif arg_3_0 == "variant" then
		if arg_3_1 == arg_3_2 then
			return (arg_3_1 == "1" or arg_3_1 == "true" or arg_3_1 == true) and true or false
		elseif arg_3_3 >= 1 then
			return (arg_3_2 == "1" or arg_3_2 == "true" or arg_3_2 == true) and true or false
		else
			return (arg_3_1 == "1" or arg_3_1 == "true" or arg_3_1 == true) and true or false
		end
	end
end

function var_0_0.getPropValueFromStr(arg_4_0, arg_4_1)
	if arg_4_0 == "int" or arg_4_0 == "float" then
		return tonumber(arg_4_1)
	elseif arg_4_0 == "Color" then
		return Color.New(unpack(string.splitToNumber(arg_4_1, ",")))
	elseif arg_4_0 == "Vector2" then
		return Vector2.New(unpack(string.splitToNumber(arg_4_1, ",")))
	elseif arg_4_0 == "Vector3" then
		return Vector3.New(unpack(string.splitToNumber(arg_4_1, ",")))
	elseif arg_4_0 == "Vector4" then
		return Vector4.New(unpack(string.splitToNumber(arg_4_1, ",")))
	elseif arg_4_0 == "variant" then
		return (arg_4_1 == "1" or string.lower(arg_4_1) == "true") and true or false
	end
end

function var_0_0.getPropValueFromMat(arg_5_0, arg_5_1, arg_5_2)
	if gohelper.isNil(arg_5_0) then
		return
	end

	if arg_5_2 == "int" then
		return arg_5_0:GetInt(arg_5_1)
	elseif arg_5_2 == "float" then
		return arg_5_0:GetFloat(arg_5_1)
	elseif arg_5_2 == "Color" then
		return arg_5_0:GetColor(arg_5_1)
	elseif arg_5_2 == "Vector2" or arg_5_2 == "Vector3" or arg_5_2 == "Vector4" then
		return arg_5_0:GetVector(arg_5_1)
	elseif arg_5_2 == "variant" then
		return arg_5_0:IsKeywordEnabled(arg_5_1)
	end
end

function var_0_0.setPropValue(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if gohelper.isNil(arg_6_0) then
		return
	end

	if arg_6_2 == "int" then
		arg_6_0:SetInt(arg_6_1, arg_6_3)
	elseif arg_6_2 == "float" then
		arg_6_0:SetFloat(arg_6_1, arg_6_3)
	elseif arg_6_2 == "Color" then
		arg_6_0:SetColor(arg_6_1, arg_6_3)
	elseif arg_6_2 == "Vector2" or arg_6_2 == "Vector3" or arg_6_2 == "Vector4" then
		arg_6_0:SetVector(arg_6_1, arg_6_3)
	elseif arg_6_2 == "variant" then
		if arg_6_3 == "1" or arg_6_3 == "true" or arg_6_3 == true then
			arg_6_0:EnableKeyword(arg_6_1)
		else
			arg_6_0:DisableKeyword(arg_6_1)
		end
	end
end

return var_0_0
