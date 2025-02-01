module("modules.logic.test.view.TestUIViewContainer", package.seeall)

slot0 = class("TestUIViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_lefttopbtns"),
		TestUIView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			}, nil, function ()
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_close)
			end)
		}
	end
end

return slot0
