module("modules.logic.versionactivity1_2.jiexika.view.Activity114DialogItem", package.seeall)

slot0 = class("Activity114DialogItem", Activity114DialogBaseItem)
slot1 = {
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
slot2 = StoryStepMo.New()

function slot0.showTxt(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._conGo, true)

	uv0[3][15][1] = slot1

	uv1:init(uv0)

	slot0._endCallBack = slot2
	slot0._endCallObj = slot3

	slot0:playDialog(slot1, uv1)
end

function slot0.skipDialog(slot0)
	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot0:conFinished()
end

function slot0.conFinished(slot0, ...)
	if slot0._endCallBack then
		slot0._endCallBack(slot0._endCallObj)
	end

	uv0.super.conFinished(slot0, ...)
end

return slot0
