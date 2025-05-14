module("modules.live2d.Live2dSpecialLogic", package.seeall)

local var_0_0 = class("Live2dSpecialLogic")
local var_0_1 = {
	"pikelesi"
}

function var_0_0.setAlwaysFade(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = false

	if arg_1_2 then
		for iter_1_0, iter_1_1 in ipairs(var_0_1) do
			if string.find(arg_1_1, iter_1_1) then
				var_1_0 = true

				break
			end
		end
	end

	arg_1_0:SetAlwaysFade(var_1_0)
end

local var_0_2 = {
	{
		id = 306501,
		effect = "Drawables/bone/effect-Bone",
		frameVisible = 1
	},
	{
		id = 306502,
		effect = "Drawables/bone/effect-Bone",
		frameVisible = 1
	}
}

function var_0_0.getFakeUIEffect(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(var_0_2) do
		if string.find(arg_2_0, iter_2_1.id) then
			return iter_2_1, string.split(iter_2_1.effect, "|")
		end
	end
end

return var_0_0
