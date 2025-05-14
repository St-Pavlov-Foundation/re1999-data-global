module("modules.logic.versionactivity1_2.jiexika.view.Activity114DialogItem", package.seeall)

local var_0_0 = class("Activity114DialogItem", Activity114DialogBaseItem)
local var_0_1 = {
	1,
	"",
	{
		1,
		{
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		},
		false,
		0,
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		1,
		{},
		true,
		false,
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		},
		false,
		"",
		0,
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		},
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3
		}
	},
	{},
	{
		0,
		"",
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		{
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5,
			0.5
		},
		0,
		0,
		0,
		1,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		0,
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		},
		1
	},
	{},
	{},
	{},
	{},
	{},
	{},
	{
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		},
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		},
		{
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		}
	},
	{
		0,
		{
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	}
}
local var_0_2 = StoryStepMo.New()

function var_0_0.showTxt(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	gohelper.setActive(arg_1_0._conGo, true)

	var_0_1[3][15][1] = arg_1_1

	var_0_2:init(var_0_1)

	arg_1_0._endCallBack = arg_1_2
	arg_1_0._endCallObj = arg_1_3

	arg_1_0:playDialog(arg_1_1, var_0_2)
end

function var_0_0.skipDialog(arg_2_0)
	if arg_2_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_2_0._conTweenId)

		arg_2_0._conTweenId = nil
	end

	arg_2_0:conFinished()
end

function var_0_0.conFinished(arg_3_0, ...)
	if arg_3_0._endCallBack then
		arg_3_0._endCallBack(arg_3_0._endCallObj)
	end

	var_0_0.super.conFinished(arg_3_0, ...)
end

return var_0_0
