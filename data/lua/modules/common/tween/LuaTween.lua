module("modules.common.tween.LuaTween", package.seeall)

slot0 = _M

function slot0.getEaseFunc(slot0)
	if uv0.TweenFuncDict[slot0] then
		return slot1
	end

	return uv0.linear
end

function slot0.tween(slot0, slot1, slot2, slot3, slot4)
	return uv0.getEaseFunc(slot4)(slot0, slot1, slot2, slot3)
end

function slot0.linear(slot0, slot1, slot2, slot3)
	return slot2 * slot0 / slot3 + slot1
end

function slot0.inSine(slot0, slot1, slot2, slot3)
	return -slot2 * Mathf.Cos(slot0 / slot3 * Mathf.PI / 2) + slot2 + slot1
end

function slot0.outSine(slot0, slot1, slot2, slot3)
	return slot2 * Mathf.Sin(slot0 / slot3 * Mathf.PI / 2) + slot1
end

function slot0.inOutSine(slot0, slot1, slot2, slot3)
	return -slot2 / 2 * (Mathf.Cos(Mathf.PI * slot0 / slot3) - 1) + slot1
end

function slot0.inQuad(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3

	return slot2 * slot0 * slot0 + slot1
end

function slot0.outQuad(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3

	return -slot2 * slot0 * (slot0 - 2) + slot1
end

function slot0.inOutQuad(slot0, slot1, slot2, slot3)
	if slot0 / (slot3 / 2) < 1 then
		return slot2 / 2 * slot0 * slot0 + slot1
	end

	slot0 = slot0 - 1

	return -slot2 / 2 * (slot0 * (slot0 - 2) - 1) + slot1
end

function slot0.inCubic(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3

	return slot2 * slot0 * slot0 * slot0 + slot1
end

function slot0.outCubic(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3 - 1

	return slot2 * (slot0 * slot0 * slot0 + 1) + slot1
end

function slot0.inOutCubic(slot0, slot1, slot2, slot3)
	if slot0 / (slot3 / 2) < 1 then
		return slot2 / 2 * slot0 * slot0 * slot0 + slot1
	end

	slot0 = slot0 - 2

	return slot2 / 2 * (slot0 * slot0 * slot0 + 2) + slot1
end

function slot0.inQuart(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3

	return slot2 * slot0 * slot0 * slot0 * slot0 + slot1
end

function slot0.outQuart(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3 - 1

	return -slot2 * (slot0 * slot0 * slot0 * slot0 - 1) + slot1
end

function slot0.inOutQuart(slot0, slot1, slot2, slot3)
	if slot0 / (slot3 / 2) < 1 then
		return slot2 / 2 * slot0 * slot0 * slot0 * slot0 + slot1
	end

	slot0 = slot0 - 2

	return -slot2 / 2 * (slot0 * slot0 * slot0 * slot0 - 2) + slot1
end

function slot0.inQuint(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3

	return slot2 * slot0 * slot0 * slot0 * slot0 * slot0 + slot1
end

function slot0.outQuint(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3 - 1

	return slot2 * (slot0 * slot0 * slot0 * slot0 * slot0 + 1) + slot1
end

function slot0.inOutQuint(slot0, slot1, slot2, slot3)
	if slot0 / (slot3 / 2) < 1 then
		return slot2 / 2 * slot0 * slot0 * slot0 * slot0 * slot0 + slot1
	end

	slot0 = slot0 - 2

	return slot2 / 2 * (slot0 * slot0 * slot0 * slot0 * slot0 + 2) + slot1
end

function slot0.inExpo(slot0, slot1, slot2, slot3)
	if slot0 == 0 then
		return slot1
	else
		return slot2 * Mathf.Pow(2, 10 * (slot0 / slot3 - 1)) + slot1
	end
end

function slot0.outExpo(slot0, slot1, slot2, slot3)
	if slot0 == slot3 then
		return slot1 + slot2
	else
		return slot2 * (-Mathf.Pow(2, -10 * slot0 / slot3) + 1) + slot1
	end
end

function slot0.inOutExpo(slot0, slot1, slot2, slot3)
	if slot0 == 0 then
		return slot1
	end

	if slot0 == slot3 then
		return slot1 + slot2
	end

	if slot0 / (slot3 / 2) < 1 then
		return slot2 / 2 * Mathf.Pow(2, 10 * (slot0 - 1)) + slot1
	end

	return slot2 / 2 * (-Mathf.Pow(2, -10 * (slot0 - 1)) + 2) + slot1
end

function slot0.inCirc(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3

	return -slot2 * (Mathf.Sqrt(1 - slot0 * slot0) - 1) + slot1
end

function slot0.outCirc(slot0, slot1, slot2, slot3)
	slot0 = slot0 / slot3 - 1

	return slot2 * Mathf.Sqrt(1 - slot0 * slot0) + slot1
end

function slot0.inOutCirc(slot0, slot1, slot2, slot3)
	if slot0 / (slot3 / 2) < 1 then
		return -slot2 / 2 * (Mathf.Sqrt(1 - slot0 * slot0) - 1) + slot1
	end

	slot0 = slot0 - 2

	return slot2 / 2 * (Mathf.Sqrt(1 - slot0 * slot0) + 1) + slot1
end

function slot0.inBack(slot0, slot1, slot2, slot3)
	slot4 = 1.70158
	slot0 = slot0 / slot3

	return slot2 * slot0 * slot0 * ((slot4 + 1) * slot0 - slot4) + slot1
end

function slot0.outBack(slot0, slot1, slot2, slot3)
	slot4 = 1.70158
	slot0 = slot0 / slot3 - 1

	return slot2 * (slot0 * slot0 * ((slot4 + 1) * slot0 + slot4) + 1) + slot1
end

function slot0.inOutBack(slot0, slot1, slot2, slot3)
	slot4 = 1.70158 * 1.525

	if slot0 / (slot3 / 2) < 1 then
		return slot2 / 2 * slot0 * slot0 * ((slot4 + 1) * slot0 - slot4) + slot1
	end

	slot0 = slot0 - 2
	slot4 = slot4 * 1.525

	return slot2 / 2 * (slot0 * slot0 * ((slot4 + 1) * slot0 + slot4) + 2) + slot1
end

function slot0.inElastic(slot0, slot1, slot2, slot3)
	if slot0 == 0 then
		return slot1
	end

	if slot0 / slot3 == 1 then
		return slot1 + slot2
	end

	slot4 = slot3 * 0.3
	slot0 = slot0 - 1

	return -(slot2 * Mathf.Pow(2, 10 * slot0) * Mathf.Sin((slot0 * slot3 - slot4 / 4) * 2 * Mathf.PI / slot4)) + slot1
end

function slot0.outElastic(slot0, slot1, slot2, slot3)
	if slot0 == 0 then
		return slot1
	end

	if slot0 / slot3 == 1 then
		return slot1 + slot2
	end

	slot4 = slot3 * 0.3

	return slot2 * Mathf.Pow(2, -10 * slot0) * Mathf.Sin((slot0 * slot3 - slot4 / 4) * 2 * Mathf.PI / slot4) + slot2 + slot1
end

function slot0.inOutElastic(slot0, slot1, slot2, slot3)
	if slot0 == 0 then
		return slot1
	end

	if slot0 / (slot3 / 2) == 2 then
		return slot1 + slot2
	end

	slot5 = slot2
	slot6 = slot3 * 0.44999999999999996 / 4

	if slot0 < 1 then
		slot0 = slot0 - 1

		return -0.5 * slot5 * Mathf.Pow(2, 10 * slot0) * Mathf.Sin((slot0 * slot3 - slot6) * 2 * Mathf.PI / slot4) + slot1
	end

	slot0 = slot0 - 1

	return slot5 * Mathf.Pow(2, -10 * slot0) * Mathf.Sin((slot0 * slot3 - slot6) * 2 * Mathf.PI / slot4) * 0.5 + slot2 + slot1
end

function slot0.inBounce(slot0, slot1, slot2, slot3)
	return slot2 - uv0.outBounce(slot3 - slot0, 0, slot2, slot3) + slot1
end

function slot0.outBounce(slot0, slot1, slot2, slot3)
	if slot0 / slot3 < 0.36363636363636365 then
		return slot2 * 7.5625 * slot0 * slot0 + slot1
	end

	if slot0 < 0.7272727272727273 then
		slot0 = slot0 - 0.5454545454545454

		return slot2 * (7.5625 * slot0 * slot0 + 0.75) + slot1
	end

	if slot0 < 0.9090909090909091 then
		slot0 = slot0 - 0.8181818181818182

		return slot2 * (7.5625 * slot0 * slot0 + 0.9375) + slot1
	end

	slot0 = slot0 - 0.9545454545454546

	return slot2 * (7.5625 * slot0 * slot0 + 0.984375) + slot1
end

function slot0.inOutBounce(slot0, slot1, slot2, slot3)
	if slot0 < slot3 / 2 then
		return uv0.inBounce(slot0 * 2, 0, slot2, slot3) * 0.5 + slot1
	end

	return uv0.outBounce(slot0 * 2 - slot3, 0, slot2, slot3) * 0.5 + slot2 * 0.5 + slot1
end

slot0.TweenFuncDict = {
	[EaseType.Linear] = slot0.linear,
	[EaseType.InSine] = slot0.inSine,
	[EaseType.OutSine] = slot0.outSine,
	[EaseType.InOutSine] = slot0.inOutSine,
	[EaseType.InQuad] = slot0.inQuad,
	[EaseType.OutQuad] = slot0.outQuad,
	[EaseType.InOutQuad] = slot0.inOutQuad,
	[EaseType.InCubic] = slot0.inCubic,
	[EaseType.OutCubic] = slot0.outCubic,
	[EaseType.InOutCubic] = slot0.inOutCubic,
	[EaseType.InQuart] = slot0.inQuart,
	[EaseType.OutQuart] = slot0.outQuart,
	[EaseType.InOutQuart] = slot0.inOutQuart,
	[EaseType.InQuint] = slot0.inQuint,
	[EaseType.OutQuint] = slot0.outQuint,
	[EaseType.InOutQuint] = slot0.inOutQuint,
	[EaseType.InExpo] = slot0.inExpo,
	[EaseType.OutExpo] = slot0.outExpo,
	[EaseType.InOutExpo] = slot0.inOutExpo,
	[EaseType.InCirc] = slot0.inCirc,
	[EaseType.OutCirc] = slot0.outCirc,
	[EaseType.InOutCirc] = slot0.inOutCirc,
	[EaseType.InBack] = slot0.inBack,
	[EaseType.OutBack] = slot0.outBack,
	[EaseType.InOutBack] = slot0.inOutBack,
	[EaseType.InElastic] = slot0.inElastic,
	[EaseType.OutElastic] = slot0.outElastic,
	[EaseType.InOutElastic] = slot0.inOutElastic,
	[EaseType.InBounce] = slot0.inBounce,
	[EaseType.OutBounce] = slot0.outBounce,
	[EaseType.InOutBounce] = slot0.inOutBounce
}

return slot0
