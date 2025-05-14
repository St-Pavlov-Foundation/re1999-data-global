module("modules.logic.voice.VoiceChooseModel", package.seeall)

local var_0_0 = class("VoiceChooseModel", ListScrollModel)

function var_0_0.initModel(arg_1_0, arg_1_1)
	local var_1_0 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local var_1_1 = {}
	local var_1_2 = SLFramework.GameUpdate.OptionalUpdate.Instance

	for iter_1_0 = 1, #var_1_0 do
		local var_1_3 = var_1_0[iter_1_0]
		local var_1_4 = GameConfig:GetDefaultVoiceShortcut()
		local var_1_5 = var_1_2:GetLocalVersion(var_1_3)

		if var_1_3 == var_1_4 then
			table.insert(var_1_1, 1, {
				lang = var_1_3,
				choose = var_1_3 == arg_1_1
			})
		elseif not string.nilorempty(var_1_5) then
			table.insert(var_1_1, {
				lang = var_1_3,
				choose = var_1_3 == arg_1_1
			})
		end
	end

	arg_1_0:setList(var_1_1)
end

function var_0_0.getChoose(arg_2_0)
	local var_2_0 = arg_2_0:getList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1.choose then
			return iter_2_1.lang
		end
	end
end

function var_0_0.choose(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getList()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		iter_3_1.choose = iter_3_1.lang == arg_3_1
	end

	arg_3_0:onModelUpdate()
end

var_0_0.instance = var_0_0.New()

return var_0_0
