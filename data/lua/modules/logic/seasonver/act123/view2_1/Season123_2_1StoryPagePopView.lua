module("modules.logic.seasonver.act123.view2_1.Season123_2_1StoryPagePopView", package.seeall)

local var_0_0 = class("Season123_2_1StoryPagePopView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godetailPage = gohelper.findChild(arg_1_0.viewGO, "Root/#go_detailPage")
	arg_1_0._txtdetailTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_detailPage/Left/Title/#txt_detailTitle")
	arg_1_0._simagePolaroid = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#go_detailPage/Left/#simage_Polaroid")
	arg_1_0._txtdetailPageTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_detailPage/Right/#txt_detailPageTitle")
	arg_1_0._txtAuthor = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_detailPage/Right/#txt_Author")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#go_detailPage/Right/#scroll_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_detailPage/Right/#scroll_desc/Viewport/#txt_desc")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "Root/#go_detailPage/Right/#go_arrow")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.transScrollDesc = arg_5_0._scrolldesc.gameObject:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_role_culture_open)

	arg_7_0.actId = arg_7_0.viewParam.actId
	arg_7_0.stageId = arg_7_0.viewParam.stageId

	arg_7_0:refreshDetailPageUI()
	arg_7_0:fitScrollHeight()
end

function var_0_0.refreshDetailPageUI(arg_8_0)
	local var_8_0 = Season123Config.instance:getStoryConfig(arg_8_0.actId, arg_8_0.stageId)

	arg_8_0._txtdetailTitle.text = GameUtil.setFirstStrSize(var_8_0.title, 80)

	local var_8_1 = Season123ViewHelper.getIconUrl("singlebg/%s_season_singlebg/storycover/%s.png", var_8_0.picture, arg_8_0.actId)

	arg_8_0._simagePolaroid:LoadImage(var_8_1)

	arg_8_0._txtdetailPageTitle.text = var_8_0.subTitle
	arg_8_0._txtAuthor.text = var_8_0.subContent

	gohelper.setActive(arg_8_0._txtAuthor.gameObject, not string.nilorempty(var_8_0.subContent))
	recthelper.setHeight(arg_8_0._scrolldesc.gameObject.transform, string.nilorempty(var_8_0.subContent) and 705 or 585)

	arg_8_0._txtdesc.text = var_8_0.content
end

var_0_0.scrollDescHeight = 650
var_0_0.maxDescSpacing = 41
var_0_0.minDescSpacing = 35
var_0_0.minDescFontSize = 27

function var_0_0.fitScrollHeight(arg_9_0)
	local var_9_0 = ZProj.GameHelper.GetTmpLineHeight(arg_9_0._txtAuthor, 1)
	local var_9_1 = arg_9_0._txtAuthor.preferredHeight - var_9_0

	recthelper.setHeight(arg_9_0.transScrollDesc, var_0_0.scrollDescHeight - var_9_1)
	TaskDispatcher.cancelTask(arg_9_0.setDescSpacing, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0.setDescSpacing, arg_9_0, 0.01)
end

function var_0_0.setDescSpacing(arg_10_0)
	local var_10_0 = Mathf.Lerp(var_0_0.maxDescSpacing, var_0_0.minDescSpacing, arg_10_0._txtdesc.fontSize - var_0_0.minDescFontSize)

	arg_10_0._txtdesc.lineSpacing = var_10_0
end

function var_0_0.onClose(arg_11_0)
	Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewClose)
	TaskDispatcher.cancelTask(arg_11_0.setDescSpacing, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagePolaroid:UnLoadImage()
end

return var_0_0
