module("modules.logic.versionactivity2_1.activity165.controller.Activity165Controller", package.seeall)

local var_0_0 = class("Activity165Controller", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	return
end

function var_0_0.openActivity165EnterView(arg_2_0)
	Activity165Model.instance:onInitInfo()
	ViewMgr.instance:openView(ViewName.Activity165StoryEnterView)
end

function var_0_0.openActivity165ReviewView(arg_3_0, arg_3_1, arg_3_2)
	ViewMgr.instance:openView(ViewName.Activity165StoryReviewView, {
		storyId = arg_3_1,
		view = arg_3_2
	})
end

function var_0_0.openActivity165EditView(arg_4_0, arg_4_1, arg_4_2)
	ViewMgr.instance:openView(ViewName.Activity165StoryEditView, {
		storyId = arg_4_1,
		reviewEnding = arg_4_2
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
