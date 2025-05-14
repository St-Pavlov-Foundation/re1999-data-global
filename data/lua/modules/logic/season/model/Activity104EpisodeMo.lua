local var_0_0 = pureTable("Activity104EpisodeMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.layer = 0
	arg_1_0.state = 0
	arg_1_0.readAfterStory = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.layer = arg_2_1.layer
	arg_2_0.state = arg_2_1.state
	arg_2_0.readAfterStory = arg_2_1.readAfterStory
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0.layer = arg_3_1.layer
	arg_3_0.state = arg_3_1.state
	arg_3_0.readAfterStory = arg_3_1.readAfterStory
end

function var_0_0.markStory(arg_4_0, arg_4_1)
	arg_4_0.readAfterStory = arg_4_1
end

return var_0_0
