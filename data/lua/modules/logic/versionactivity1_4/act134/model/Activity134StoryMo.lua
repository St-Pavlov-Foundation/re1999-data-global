module("modules.logic.versionactivity1_4.act134.model.Activity134StoryMo", package.seeall)

local var_0_0 = class("Activity134StoryMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.config = nil
	arg_1_0.index = nil
	arg_1_0.status = Activity134Enum.StroyStatus.Orgin
	arg_1_0.title = nil
	arg_1_0.desc = {}
	arg_1_0.introduce = {}
	arg_1_0.needTokensType = nil
	arg_1_0.needTokensId = nil
	arg_1_0.needTokensQuantity = nil
	arg_1_0.icon = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.config = arg_2_2
	arg_2_0.index = arg_2_1
	arg_2_0.title = arg_2_2.title
	arg_2_0.storyType = arg_2_2.storyType

	arg_2_0:setDesc()

	local var_2_0 = string.splitToNumber(arg_2_2.needTokens, "#")

	arg_2_0.needTokensType = var_2_0[1]
	arg_2_0.needTokensId = var_2_0[2]
	arg_2_0.needTokensQuantity = var_2_0[3]
end

function var_0_0.setDesc(arg_3_0)
	if not arg_3_0.config then
		return
	end

	local var_3_0 = arg_3_0.config.desc
	local var_3_1 = string.split(var_3_0, "|")

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_2 = Activity134Config.instance:getStoryConfig(tonumber(iter_3_1))

		if not var_3_2 or var_3_2.storyType ~= arg_3_0.storyType then
			logError("[1.4运营活动下半场尘封记录数据错误] 故事配置错误:" .. iter_3_1)

			return
		end

		table.insert(arg_3_0.desc, var_3_2)
	end
end

return var_0_0
