module("modules.logic.story.model.StoryLogListModel", package.seeall)

local var_0_0 = class("StoryLogListModel", MixScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._infos = nil
end

function var_0_0.setLogList(arg_2_0, arg_2_1)
	arg_2_0._infos = arg_2_1

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = StoryLogMo.New()

		var_2_1:init(iter_2_1)
		table.insert(var_2_0, var_2_1)
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
	local var_3_3 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._infos) do
		local var_3_4 = 0

		if type(iter_3_1) == "number" then
			local var_3_5 = StoryStepModel.instance:getStepListById(iter_3_1).conversation
			local var_3_6 = GameUtil.filterRichText(var_3_5.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

			var_3_4 = GameUtil.getTextHeightByLine(var_3_1, var_3_6, 42.35294, 13.96) + 80 - 42.35294 + 31.41

			if type(var_3_3) == "number" and var_3_3 > 0 then
				local var_3_7 = StoryStepModel.instance:getStepListById(var_3_3).conversation

				if var_3_7.type == var_3_5.type and var_3_7.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] == var_3_5.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] then
					var_3_2 = 1
					var_3_0[iter_3_0 - 1].lineLength = math.max(var_3_0[iter_3_0 - 1].lineLength - 20, 0)
				else
					var_3_2 = 0
				end
			else
				var_3_2 = 0
			end
		elseif type(iter_3_1) == "table" then
			var_3_4 = 55 * #StoryModel.instance:getStoryBranchOpts(iter_3_1.stepId) + 25
			var_3_2 = 0
		end

		table.insert(var_3_0, SLFramework.UGUI.MixCellInfo.New(var_3_2, var_3_4, nil))

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
