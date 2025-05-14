module("modules.logic.story.model.StoryStepMo", package.seeall)

local var_0_0 = pureTable("StoryStepMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.name = ""
	arg_1_0.conversation = {}
	arg_1_0.heroList = {}
	arg_1_0.bg = {}
	arg_1_0.audioList = {}
	arg_1_0.effList = {}
	arg_1_0.picList = {}
	arg_1_0.videoList = {}
	arg_1_0.navigateList = {}
	arg_1_0.optList = {}
	arg_1_0.mainRole = {}
	arg_1_0.mourningBorder = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1[1]
	arg_2_0.name = arg_2_1[2]
	arg_2_0.conversation = arg_2_0:_buildConversation(arg_2_1[3])
	arg_2_0.heroList = arg_2_0:_buildHero(arg_2_1[4])
	arg_2_0.bg = arg_2_0:_buildBackground(arg_2_1[5])
	arg_2_0.audioList = arg_2_0:_buildAudio(arg_2_1[6])
	arg_2_0.effList = arg_2_0:_buildEffect(arg_2_1[7])
	arg_2_0.picList = arg_2_0:_buildPictures(arg_2_1[8])
	arg_2_0.videoList = arg_2_0:_buildVideo(arg_2_1[9])
	arg_2_0.navigateList = arg_2_0:_buildNavigate(arg_2_1[10])
	arg_2_0.optList = arg_2_0:_buildOption(arg_2_1[11])
	arg_2_0.mainRole = arg_2_0:_buildMainRole(arg_2_1[12])
	arg_2_0.mourningBorder = arg_2_0:_buildMourningBorder(arg_2_1[13])
end

function var_0_0._buildConversation(arg_3_0, arg_3_1)
	local var_3_0 = StoryStepConversationMo.New()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function var_0_0._buildHero(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = StoryStepHeroMo.New()

		var_4_1:init(iter_4_1)
		table.insert(var_4_0, var_4_1)
	end

	return var_4_0
end

function var_0_0._buildBackground(arg_5_0, arg_5_1)
	local var_5_0 = StoryStepBGMo.New()

	var_5_0:init(arg_5_1)

	return var_5_0
end

function var_0_0._buildAudio(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_1 = StoryStepAudioMo.New()

		var_6_1:init(iter_6_1)
		table.insert(var_6_0, var_6_1)
	end

	return var_6_0
end

function var_0_0._buildEffect(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_1 = StoryStepEffectMo.New()

		var_7_1:init(iter_7_1)
		table.insert(var_7_0, var_7_1)
	end

	return var_7_0
end

function var_0_0._buildPictures(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_1 = StoryStepPictureMo.New()

		var_8_1:init(iter_8_1)
		table.insert(var_8_0, var_8_1)
	end

	return var_8_0
end

function var_0_0._buildVideo(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_1 = StoryStepVideoMo.New()

		var_9_1:init(iter_9_1)
		table.insert(var_9_0, var_9_1)
	end

	return var_9_0
end

function var_0_0._buildNavigate(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_1 = StoryStepNavigateMo.New()

		var_10_1:init(iter_10_1)
		table.insert(var_10_0, var_10_1)
	end

	return var_10_0
end

function var_0_0._buildOption(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1 = StoryStepOptionMo.New()

		var_11_1:init(iter_11_1)
		table.insert(var_11_0, var_11_1)
	end

	return var_11_0
end

function var_0_0._buildMainRole(arg_12_0, arg_12_1)
	local var_12_0 = StoryStepMainHeroMo.New()

	var_12_0:init(arg_12_1)

	return var_12_0
end

function var_0_0._buildMourningBorder(arg_13_0, arg_13_1)
	local var_13_0 = StoryStepMourningBorderMo.New()

	var_13_0:init(arg_13_1)

	return var_13_0
end

return var_0_0
