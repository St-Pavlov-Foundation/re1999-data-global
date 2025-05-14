module("modules.logic.versionactivity1_4.act131.model.Activity131LogListModel", package.seeall)

local var_0_0 = class("Activity131LogListModel", MixScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._infos = nil
end

function var_0_0.setLogList(arg_2_0, arg_2_1)
	arg_2_0._infos = {}

	local var_2_0 = {}

	if arg_2_1 then
		arg_2_0._infos = arg_2_1

		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_1 = Activity131LogMo.New()
			local var_2_2 = string.split(iter_2_1.param, "#")
			local var_2_3 = tonumber(var_2_2[2])

			var_2_1:init(iter_2_1.speaker, iter_2_1.content, var_2_3)
			table.insert(var_2_0, var_2_1)
		end
	end

	arg_2_0:setList(var_2_0)
end

function var_0_0.getInfoList(arg_3_0, arg_3_1)
	local var_3_0 = {}

	if not arg_3_0._infos or #arg_3_0._infos <= 0 then
		return var_3_0
	end

	local var_3_1 = gohelper.findChildText(arg_3_1, "Viewport/logcontent/storylogitem/go_normal/txt_content")
	local var_3_2 = 0
	local var_3_3

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._infos) do
		local var_3_4 = 0
		local var_3_5 = GameUtil.filterRichText(iter_3_1.content)
		local var_3_6 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(var_3_1, var_3_5) + 13.96
		local var_3_7

		if var_3_3 and iter_3_1.speaker == var_3_3.speaker then
			var_3_7 = 1
		else
			if iter_3_0 > 1 then
				var_3_0[iter_3_0 - 1].lineLength = var_3_0[iter_3_0 - 1].lineLength + 40
			end

			var_3_7 = 0
		end

		table.insert(var_3_0, SLFramework.UGUI.MixCellInfo.New(var_3_7, var_3_6, nil))

		var_3_3 = iter_3_1
	end

	return var_3_0
end

function var_0_0.clearData(arg_4_0)
	arg_4_0._infos = nil
end

function var_0_0.setPlayingLogAudio(arg_5_0, arg_5_1)
	arg_5_0._playingId = arg_5_1
end

function var_0_0.setPlayingLogAudioFinished(arg_6_0, arg_6_1)
	if arg_6_0._playingId == arg_6_1 then
		arg_6_0._playingId = 0
	end
end

function var_0_0.getPlayingLogAudioId(arg_7_0)
	return arg_7_0._playingId
end

var_0_0.instance = var_0_0.New()

return var_0_0
