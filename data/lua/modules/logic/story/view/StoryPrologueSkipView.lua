module("modules.logic.story.view.StoryPrologueSkipView", package.seeall)

local var_0_0 = class("StoryPrologueSkipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_fg")
	arg_1_0._simagefg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simage_fg")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "ani/simage_1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "ani/simage_2")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#btn_close")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#txt_content")
	arg_1_0._bgClick = gohelper.getClickWithAudio(arg_1_0._simagefg.gameObject)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._bgClick:AddClickListener(arg_2_0._onBgClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._bgClick:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:_hideStoryViewContent(false)
	arg_4_0:closeThis()
	StoryController.instance:dispatchEvent(StoryEvent.OnSkipClick)
end

function var_0_0._onBgClick(arg_5_0)
	arg_5_0:_hideStoryViewContent(false)
	arg_5_0:closeThis()
	StoryController.instance:dispatchEvent(StoryEvent.OnSkipClick)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	NavigateMgr.instance:addEscape(arg_8_0.viewName, arg_8_0._btncloseOnClick, arg_8_0)

	arg_8_0._txtcontent.text = arg_8_0.viewParam.content

	arg_8_0._simagefg:LoadImage(ResUrl.getStoryPrologueSkip("prologueskip_fullbg2"))
	arg_8_0._simagefg2:LoadImage(ResUrl.getStoryPrologueSkip("bg1"))
	arg_8_0._simagebg1:LoadImage(ResUrl.getStoryPrologueSkip("bg2"))
	arg_8_0._simagebg2:LoadImage(ResUrl.getStoryPrologueSkip("bg3"))
	arg_8_0:_hideStoryViewContent(true)
end

function var_0_0._hideStoryViewContent(arg_9_0, arg_9_1)
	local var_9_0 = ViewMgr.instance:getContainer(ViewName.StoryHeroView)

	gohelper.setActive(var_9_0.viewGO, not arg_9_1)

	local var_9_1 = ViewMgr.instance:getContainer(ViewName.StoryView)
	local var_9_2 = gohelper.findChild(var_9_1.viewGO, "#go_contentroot")

	gohelper.setActive(var_9_2, not arg_9_1)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagefg:UnLoadImage()
	arg_11_0._simagefg2:UnLoadImage()
	arg_11_0._simagebg1:UnLoadImage()
	arg_11_0._simagebg2:UnLoadImage()
end

return var_0_0
