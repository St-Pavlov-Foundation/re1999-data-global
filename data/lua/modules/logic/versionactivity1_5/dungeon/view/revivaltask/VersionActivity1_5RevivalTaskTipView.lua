module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskTipView", package.seeall)

local var_0_0 = class("VersionActivity1_5RevivalTaskTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotipscontainer = gohelper.findChild(arg_1_0.viewGO, "#go_tipcontainer")
	arg_1_0._goclosetip = gohelper.findChild(arg_1_0.viewGO, "#go_tipcontainer/#go_closetip")
	arg_1_0._txtTipTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_tipcontainer/#go_tips/#txt_title")
	arg_1_0._simageTipPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_tipcontainer/#go_tips/#simage_pic")
	arg_1_0._txtTipDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_tipcontainer/#go_tips/#txt_desc")
	arg_1_0._btnReplay = gohelper.findChildButton(arg_1_0.viewGO, "#go_tipcontainer/#go_tips/#btn_replay")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReplay:AddClickListener(arg_2_0.onClickBtnReplay, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReplay:RemoveClickListener()
end

function var_0_0.onClickBtnReplay(arg_4_0)
	if not arg_4_0.isShowBtn then
		return
	end

	if arg_4_0.showType == DungeonEnum.ElementType.None then
		ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
			fragmentId = arg_4_0.showParam
		})
	elseif arg_4_0.showType == DungeonEnum.ElementType.EnterDialogue then
		DialogueController.instance:enterDialogue(arg_4_0.showParam)
	else
		logError("un support type, " .. tostring(arg_4_0.showType))
	end
end

function var_0_0.onClickCloseBtn(arg_5_0)
	arg_5_0.config = nil

	gohelper.setActive(arg_5_0._gotipscontainer, false)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gotipscontainer, false)

	arg_6_0.closeClick = gohelper.getClickWithDefaultAudio(arg_6_0._goclosetip)

	arg_6_0.closeClick:AddClickListener(arg_6_0.onClickCloseBtn, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ShowSubTaskDetail, arg_6_0.showSubTaskDetail, arg_6_0)
end

function var_0_0.showSubTaskDetail(arg_7_0, arg_7_1)
	arg_7_0.config = arg_7_1

	gohelper.setActive(arg_7_0._gotipscontainer, true)

	arg_7_0._txtTipTitle.text = arg_7_0.config.title

	if LangSettings.instance:isEn() then
		arg_7_0._txtTipDesc.text = arg_7_0.config.desc .. " " .. arg_7_0.config.descSuffix
	else
		arg_7_0._txtTipDesc.text = arg_7_0.config.desc .. arg_7_0.config.descSuffix
	end

	arg_7_0._simageTipPic:LoadImage(ResUrl.getV1a5RevivalTaskSingleBg(arg_7_0.config.image))
	arg_7_0:showReplayBtn()
end

function var_0_0.showReplayBtn(arg_8_0)
	local var_8_0 = arg_8_0.config.elementList[1]
	local var_8_1 = lua_chapter_map_element.configDict[var_8_0]

	arg_8_0.isShowBtn = false

	if var_8_1.type == DungeonEnum.ElementType.None then
		if var_8_1.fragment ~= 0 then
			arg_8_0.isShowBtn = true
			arg_8_0.showType = DungeonEnum.ElementType.None
			arg_8_0.showParam = var_8_1.fragment
		end
	elseif var_8_1.type == DungeonEnum.ElementType.EnterDialogue then
		arg_8_0.isShowBtn = true
		arg_8_0.showType = DungeonEnum.ElementType.EnterDialogue
		arg_8_0.showParam = tonumber(var_8_1.param)
	end

	gohelper.setActive(arg_8_0._btnReplay, arg_8_0.isShowBtn)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simageTipPic:UnLoadImage()
	arg_9_0.closeClick:RemoveClickListener()
end

return var_0_0
