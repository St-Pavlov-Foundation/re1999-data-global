module("modules.common.utils.MaterialUtil", package.seeall)

slot0 = _M
slot0._MainColorId = UnityEngine.Shader.PropertyToID("_MainColor")
slot0._MaskColorId = UnityEngine.Shader.PropertyToID("_MaskColor")
slot0._NoiseMap = UnityEngine.Shader.PropertyToID("_NoiseMap")

function slot0.GetMainColor(slot0)
	if not gohelper.isNil(slot0) then
		return slot0:GetColor(uv0._MainColorId)
	end
end

function slot0.setMainColor(slot0, slot1)
	if not gohelper.isNil(slot0) then
		slot0:SetColor(uv0._MainColorId, slot1)
	end
end

function slot0.getLerpValue(slot0, slot1, slot2, slot3, slot4)
	if slot0 == "int" or slot0 == "float" then
		return Mathf.Lerp(slot1, slot2, slot3)
	elseif slot0 == "Color" then
		slot4 = slot4 or Color.New()
		slot4.r = Mathf.Lerp(slot1.r, slot2.r, slot3)
		slot4.g = Mathf.Lerp(slot1.g, slot2.g, slot3)
		slot4.b = Mathf.Lerp(slot1.b, slot2.b, slot3)
		slot4.a = Mathf.Lerp(slot1.a, slot2.a, slot3)

		return slot4
	elseif slot0 == "Vector2" then
		slot4 = slot4 or Vector2.New()
		slot4.x = Mathf.Lerp(slot1.x, slot2.x, slot3)
		slot4.y = Mathf.Lerp(slot1.y, slot2.y, slot3)

		return slot4
	elseif slot0 == "Vector3" then
		slot4 = slot4 or Vector3.New()
		slot4.x = Mathf.Lerp(slot1.x, slot2.x, slot3)
		slot4.y = Mathf.Lerp(slot1.y, slot2.y, slot3)
		slot4.z = Mathf.Lerp(slot1.z, slot2.z, slot3)

		return slot4
	elseif slot0 == "Vector4" then
		slot4 = slot4 or Vector4.New()
		slot4.x = Mathf.Lerp(slot1.x, slot2.x, slot3)
		slot4.y = Mathf.Lerp(slot1.y, slot2.y, slot3)
		slot4.z = Mathf.Lerp(slot1.z, slot2.z, slot3)
		slot4.w = Mathf.Lerp(slot1.w, slot2.w, slot3)

		return slot4
	elseif slot0 == "variant" then
		if slot1 == slot2 then
			return (slot1 == "1" or slot1 == "true" or slot1 == true) and true or false
		elseif slot3 >= 1 then
			return (slot2 == "1" or slot2 == "true" or slot2 == true) and true or false
		else
			return (slot1 == "1" or slot1 == "true" or slot1 == true) and true or false
		end
	end
end

function slot0.getPropValueFromStr(slot0, slot1)
	if slot0 == "int" or slot0 == "float" then
		return tonumber(slot1)
	elseif slot0 == "Color" then
		return Color.New(unpack(string.splitToNumber(slot1, ",")))
	elseif slot0 == "Vector2" then
		return Vector2.New(unpack(string.splitToNumber(slot1, ",")))
	elseif slot0 == "Vector3" then
		return Vector3.New(unpack(string.splitToNumber(slot1, ",")))
	elseif slot0 == "Vector4" then
		return Vector4.New(unpack(string.splitToNumber(slot1, ",")))
	elseif slot0 == "variant" then
		return (slot1 == "1" or string.lower(slot1) == "true") and true or false
	end
end

function slot0.getPropValueFromMat(slot0, slot1, slot2)
	if gohelper.isNil(slot0) then
		return
	end

	if slot2 == "int" then
		return slot0:GetInt(slot1)
	elseif slot2 == "float" then
		return slot0:GetFloat(slot1)
	elseif slot2 == "Color" then
		return slot0:GetColor(slot1)
	elseif slot2 == "Vector2" or slot2 == "Vector3" or slot2 == "Vector4" then
		return slot0:GetVector(slot1)
	elseif slot2 == "variant" then
		return slot0:IsKeywordEnabled(slot1)
	end
end

function slot0.setPropValue(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot0) then
		return
	end

	if slot2 == "int" then
		slot0:SetInt(slot1, slot3)
	elseif slot2 == "float" then
		slot0:SetFloat(slot1, slot3)
	elseif slot2 == "Color" then
		slot0:SetColor(slot1, slot3)
	elseif slot2 == "Vector2" or slot2 == "Vector3" or slot2 == "Vector4" then
		slot0:SetVector(slot1, slot3)
	elseif slot2 == "variant" then
		if slot3 == "1" or slot3 == "true" or slot3 == true then
			slot0:EnableKeyword(slot1)
		else
			slot0:DisableKeyword(slot1)
		end
	end
end

return slot0
