module("modules.logic.story.view.StoryViewMgr", package.seeall)

local var_0_0 = class("StoryViewMgr")

function var_0_0.open(arg_1_0, arg_1_1)
	return
end

function var_0_0.close(arg_2_0)
	return
end

function var_0_0.getStoryBackgroundView(arg_3_0)
	local var_3_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView)

	if not var_3_0 then
		return nil
	end

	return var_3_0.viewGO
end

function var_0_0.getStoryBlitEff(arg_4_0)
	local var_4_0 = arg_4_0:getStoryBackgroundView()

	if not var_4_0 then
		return
	end

	return (gohelper.findChild(var_4_0, "#go_blitbg"):GetComponent(typeof(UrpCustom.UIBlitEffect)))
end

function var_0_0.getStoryBlitEffSecond(arg_5_0)
	local var_5_0 = arg_5_0:getStoryBackgroundView()

	if not var_5_0 then
		return
	end

	return (gohelper.findChild(var_5_0, "#go_blitbgsecond"):GetComponent(typeof(UrpCustom.UIBlitEffect)))
end

function var_0_0.getStoryFrontBgGo(arg_6_0)
	local var_6_0 = arg_6_0:getStoryBackgroundView()

	if not var_6_0 then
		return nil
	end

	return (gohelper.findChild(var_6_0, "#go_upbg"))
end

function var_0_0.getStoryHeroView(arg_7_0)
	local var_7_0 = ViewMgr.instance:getContainer(ViewName.StoryHeroView)

	if not var_7_0 then
		return nil
	end

	return var_7_0.viewGO
end

function var_0_0.getStoryView(arg_8_0)
	local var_8_0 = ViewMgr.instance:getContainer(ViewName.StoryView)

	if not var_8_0 then
		return nil
	end

	return var_8_0.viewGO
end

function var_0_0.setStoryViewLayer(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getStoryView()

	if not var_9_0 then
		return
	end

	gohelper.setLayer(var_9_0, arg_9_1, true)
end

function var_0_0.getStoryLeadRoleSpineView(arg_10_0)
	local var_10_0 = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView)

	if not var_10_0 then
		return nil
	end

	return var_10_0.viewGO
end

function var_0_0.setStoryLeadRoleSpineViewLayer(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getStoryLeadRoleSpineView()

	if not var_11_0 then
		return
	end

	local var_11_1 = gohelper.findChild(var_11_0, "#go_spineroot")

	gohelper.setLayer(var_11_1, arg_11_1, true)
end

function var_0_0.getStoryFrontView(arg_12_0)
	local var_12_0 = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

	if not var_12_0 then
		return nil
	end

	return var_12_0.viewGO
end

var_0_0.instance = var_0_0.New()

return var_0_0
