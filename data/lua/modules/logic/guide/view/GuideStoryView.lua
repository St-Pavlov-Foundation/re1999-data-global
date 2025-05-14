module("modules.logic.guide.view.GuideStoryView", package.seeall)

local var_0_0 = class("GuideStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._storyGO = gohelper.findChild(arg_1_0.viewGO, "story")
	arg_1_0._txtContent = gohelper.findChildText(arg_1_0.viewGO, "story/go_content/txt_content")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:_updateUI()
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, arg_2_0._updateUI, arg_2_0)
end

function var_0_0.onUpdateParam(arg_3_0)
	arg_3_0:_updateUI()
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, arg_3_0._updateUI, arg_3_0)
end

function var_0_0._updateUI(arg_4_0)
	if not arg_4_0.viewParam then
		return
	end

	gohelper.setActive(arg_4_0._storyGO, arg_4_0.viewParam.hasStory)

	if not arg_4_0.viewParam.hasStory then
		return
	end

	arg_4_0._txtContent.text = LuaUtil.replaceSpace(arg_4_0.viewParam.storyContent)

	LuaUtil.updateTMPRectHeight(arg_4_0._txtContent)
end

function var_0_0.onClose(arg_5_0)
	return
end

return var_0_0
