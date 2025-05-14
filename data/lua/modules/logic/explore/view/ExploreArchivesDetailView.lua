module("modules.logic.explore.view.ExploreArchivesDetailView", package.seeall)

local var_0_0 = class("ExploreArchivesDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_title")
	arg_1_0._txtinfo = gohelper.findChildTextMesh(arg_1_0.viewGO, "mask/#txt_info")
	arg_1_0._txtdec = gohelper.findChildTextMesh(arg_1_0.viewGO, "mask/Scroll View/Viewport/Content/#txt_dec")

	local var_1_0 = arg_1_0._txtinfo.gameObject

	arg_1_0._tmpMarkTopText = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, TMPMarkTopText)

	arg_1_0._tmpMarkTopText:setTopOffset(0, -2.6)
	arg_1_0._tmpMarkTopText:setLineSpacing(31)
	arg_1_0._tmpMarkTopText:registerRebuildLayout(var_1_0.transform.parent)

	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_open)

	local var_4_0 = lua_explore_story.configDict[arg_4_0.viewParam.chapterId][arg_4_0.viewParam.id]
	local var_4_1 = var_4_0.title
	local var_4_2 = GameUtil.utf8sub(var_4_1, 1, 1)
	local var_4_3 = GameUtil.utf8sub(var_4_1, 2, #var_4_1)

	arg_4_0._txttitle.text = string.format("<size=50>%s</size>%s", var_4_2, var_4_3)

	arg_4_0._tmpMarkTopText:setData(var_4_0.desc)

	arg_4_0._txtdec.text = var_4_0.content

	arg_4_0._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. var_4_0.res))
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClose(arg_6_0)
	GameUtil.onDestroyViewMember(arg_6_0, "_tmpMarkTopText")
	arg_6_0._simageicon:UnLoadImage()
end

return var_0_0
