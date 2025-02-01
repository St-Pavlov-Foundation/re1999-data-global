module("modules.common.tween.EaseType", package.seeall)

slot0 = _M
slot0.Linear = 1
slot0.InSine = 2
slot0.OutSine = 3
slot0.InOutSine = 4
slot0.InQuad = 5
slot0.OutQuad = 6
slot0.InOutQuad = 7
slot0.InCubic = 8
slot0.OutCubic = 9
slot0.InOutCubic = 10
slot0.InQuart = 11
slot0.OutQuart = 12
slot0.InOutQuart = 13
slot0.InQuint = 14
slot0.OutQuint = 15
slot0.InOutQuint = 16
slot0.InExpo = 17
slot0.OutExpo = 18
slot0.InOutExpo = 19
slot0.InCirc = 20
slot0.OutCirc = 21
slot0.InOutCirc = 22
slot0.InBack = 23
slot0.OutBack = 24
slot0.InOutBack = 25
slot0.InElastic = 26
slot0.OutElastic = 27
slot0.InOutElastic = 28
slot0.InBounce = 29
slot0.OutBounce = 30
slot0.InOutBounce = 31
slot0.Str2TypeDict = {
	linear = slot0.Linear,
	insine = slot0.InSine,
	outsine = slot0.OutSine,
	inoutsine = slot0.InOutSine,
	inquad = slot0.InQuad,
	outquad = slot0.OutQuad,
	inoutquad = slot0.InOutQuad,
	incubic = slot0.InCubic,
	outcubic = slot0.OutCubic,
	inoutcubic = slot0.InOutCubic,
	inquart = slot0.InQuart,
	outquart = slot0.OutQuart,
	inoutquart = slot0.InOutQuart,
	inquint = slot0.InQuint,
	outquint = slot0.OutQuint,
	inoutquint = slot0.InOutQuint,
	inexpo = slot0.InExpo,
	outexpo = slot0.OutExpo,
	inoutexpo = slot0.InOutExpo,
	incirc = slot0.InCirc,
	outcirc = slot0.OutCirc,
	inoutcirc = slot0.InOutCirc,
	inback = slot0.InBack,
	outback = slot0.OutBack,
	inoutback = slot0.InOutBack,
	inelastic = slot0.InElastic,
	outelastic = slot0.OutElastic,
	inoutelastic = slot0.InOutElastic,
	inbounce = slot0.InBounce,
	outbounce = slot0.OutBounce,
	inoutbounce = slot0.InOutBounce
}

function slot0.Str2Type(slot0)
	if string.nilorempty(slot0) then
		return uv0.Linear
	end

	if type(slot0) == "number" then
		return slot0
	end

	if uv0.Str2TypeDict[string.lower(slot0)] then
		return slot1
	end

	if string.find(slot0, "ease") == 1 and uv0.Str2TypeDict[string.sub(slot0, 5)] then
		return slot1
	end

	return uv0.Linear
end

return slot0
