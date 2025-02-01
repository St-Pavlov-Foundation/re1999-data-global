module("modules.logic.versionactivity2_1.activity165.controller.Activity165Controller", package.seeall)

slot0 = class("Activity165Controller", BaseController)

function slot0.addConstEvents(slot0)
end

function slot0.openActivity165EnterView(slot0)
	Activity165Model.instance:onInitInfo()
	ViewMgr.instance:openView(ViewName.Activity165StoryEnterView)
end

function slot0.openActivity165ReviewView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.Activity165StoryReviewView, {
		storyId = slot1,
		view = slot2
	})
end

function slot0.openActivity165EditView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.Activity165StoryEditView, {
		storyId = slot1,
		reviewEnding = slot2
	})
end

slot0.instance = slot0.New()

return slot0
