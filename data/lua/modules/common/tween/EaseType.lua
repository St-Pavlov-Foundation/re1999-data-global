module("modules.common.tween.EaseType", package.seeall)

local var_0_0 = _M

var_0_0.Linear = 1
var_0_0.InSine = 2
var_0_0.OutSine = 3
var_0_0.InOutSine = 4
var_0_0.InQuad = 5
var_0_0.OutQuad = 6
var_0_0.InOutQuad = 7
var_0_0.InCubic = 8
var_0_0.OutCubic = 9
var_0_0.InOutCubic = 10
var_0_0.InQuart = 11
var_0_0.OutQuart = 12
var_0_0.InOutQuart = 13
var_0_0.InQuint = 14
var_0_0.OutQuint = 15
var_0_0.InOutQuint = 16
var_0_0.InExpo = 17
var_0_0.OutExpo = 18
var_0_0.InOutExpo = 19
var_0_0.InCirc = 20
var_0_0.OutCirc = 21
var_0_0.InOutCirc = 22
var_0_0.InElastic = 23
var_0_0.OutElastic = 24
var_0_0.InOutElastic = 25
var_0_0.InBack = 26
var_0_0.OutBack = 27
var_0_0.InOutBack = 28
var_0_0.InBounce = 29
var_0_0.OutBounce = 30
var_0_0.InOutBounce = 31
var_0_0.Str2TypeDict = {
	linear = var_0_0.Linear,
	insine = var_0_0.InSine,
	outsine = var_0_0.OutSine,
	inoutsine = var_0_0.InOutSine,
	inquad = var_0_0.InQuad,
	outquad = var_0_0.OutQuad,
	inoutquad = var_0_0.InOutQuad,
	incubic = var_0_0.InCubic,
	outcubic = var_0_0.OutCubic,
	inoutcubic = var_0_0.InOutCubic,
	inquart = var_0_0.InQuart,
	outquart = var_0_0.OutQuart,
	inoutquart = var_0_0.InOutQuart,
	inquint = var_0_0.InQuint,
	outquint = var_0_0.OutQuint,
	inoutquint = var_0_0.InOutQuint,
	inexpo = var_0_0.InExpo,
	outexpo = var_0_0.OutExpo,
	inoutexpo = var_0_0.InOutExpo,
	incirc = var_0_0.InCirc,
	outcirc = var_0_0.OutCirc,
	inoutcirc = var_0_0.InOutCirc,
	inback = var_0_0.InBack,
	outback = var_0_0.OutBack,
	inoutback = var_0_0.InOutBack,
	inelastic = var_0_0.InElastic,
	outelastic = var_0_0.OutElastic,
	inoutelastic = var_0_0.InOutElastic,
	inbounce = var_0_0.InBounce,
	outbounce = var_0_0.OutBounce,
	inoutbounce = var_0_0.InOutBounce
}

function var_0_0.Str2Type(arg_1_0)
	if string.nilorempty(arg_1_0) then
		return var_0_0.Linear
	end

	if type(arg_1_0) == "number" then
		return arg_1_0
	end

	arg_1_0 = string.lower(arg_1_0)

	local var_1_0 = var_0_0.Str2TypeDict[arg_1_0]

	if var_1_0 then
		return var_1_0
	end

	if string.find(arg_1_0, "ease") == 1 then
		arg_1_0 = string.sub(arg_1_0, 5)

		local var_1_1 = var_0_0.Str2TypeDict[arg_1_0]

		if var_1_1 then
			return var_1_1
		end
	end

	return var_0_0.Linear
end

return var_0_0
