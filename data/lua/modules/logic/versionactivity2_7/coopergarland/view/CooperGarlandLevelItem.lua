module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelItem", package.seeall)

local var_0_0 = class("CooperGarlandLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goType1 = gohelper.findChild(arg_1_0._go, "#go_Type1")
	arg_1_0._goIcon = gohelper.findChild(arg_1_0._go, "#go_Type1/image_Stage")
	arg_1_0._goType2 = gohelper.findChild(arg_1_0._go, "#go_Type2")
	arg_1_0._goSPIcon = gohelper.findChild(arg_1_0._go, "#go_Type2/image_Stage")
	arg_1_0._goStageItem = gohelper.findChild(arg_1_0._go, "#go_Type1/#go_StageItem")
	arg_1_0._imageStageItem = gohelper.findChildImage(arg_1_0._go, "#go_Type1/#go_StageItem")
	arg_1_0.spStageList = arg_1_0:getUserDataTb_()
	arg_1_0.spStageImageList = arg_1_0:getUserDataTb_()

	local var_1_0
	local var_1_1 = 0

	repeat
		var_1_1 = var_1_1 + 1

		local var_1_2 = gohelper.findChild(arg_1_0._go, string.format("#go_Type2/#go_StageItem%s", var_1_1))

		if var_1_2 then
			arg_1_0.spStageList[var_1_1] = var_1_2
			arg_1_0.spStageImageList[var_1_1] = var_1_2:GetComponent(gohelper.Type_Image)
		end
	until gohelper.isNil(var_1_2)

	arg_1_0._goSelected = gohelper.findChild(arg_1_0._go, "#go_Selected")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0._go, "#go_Locked")
	arg_1_0._goStar1 = gohelper.findChild(arg_1_0._go, "Stars/#go_Star1")
	arg_1_0._goStar2 = gohelper.findChild(arg_1_0._go, "Stars/#go_Star2")
	arg_1_0._goStar3 = gohelper.findChild(arg_1_0._go, "Stars/#go_Star3")
	arg_1_0._imageStageNum = gohelper.findChildImage(arg_1_0._go, "#image_StageNum")
	arg_1_0._txtStageName = gohelper.findChildText(arg_1_0._go, "#txt_StageName")
	arg_1_0._btnclick = gohelper.getClickWithDefaultAudio(arg_1_0._go)
	arg_1_0._animator = gohelper.findChildAnim(arg_1_0._go, "")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	CooperGarlandController.instance:clickEpisode(arg_4_0.actId, arg_4_0.episodeId)
end

function var_0_0.setData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.actId = arg_5_1
	arg_5_0.episodeId = arg_5_2
	arg_5_0.index = arg_5_3
	arg_5_0.gameIndex = arg_5_4

	arg_5_0:setInfo()
	arg_5_0:refreshUI()
end

function var_0_0.setInfo(arg_6_0)
	arg_6_0._txtStageName.text = CooperGarlandConfig.instance:getEpisodeName(arg_6_0.actId, arg_6_0.episodeId)

	UISpriteSetMgr.instance:setV2a7CooperGarlandSprite(arg_6_0._imageStageNum, string.format("v2a7_coopergarland_level_stage_0%s", arg_6_0.index))

	if arg_6_0.gameIndex then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.spStageList) do
			gohelper.setActive(iter_6_1, arg_6_0.gameIndex == iter_6_0)
		end
	end

	gohelper.setActive(arg_6_0._goType1, not arg_6_0.gameIndex)
	gohelper.setActive(arg_6_0._goType2, arg_6_0.gameIndex)
end

function var_0_0.refreshUI(arg_7_0, arg_7_1)
	arg_7_0:refreshStatus(arg_7_1)
	arg_7_0:refreshSelected()
end

function var_0_0.refreshStatus(arg_8_0, arg_8_1)
	local var_8_0 = false
	local var_8_1 = CooperGarlandModel.instance:isUnlockEpisode(arg_8_0.actId, arg_8_0.episodeId)

	if var_8_1 then
		var_8_0 = CooperGarlandModel.instance:isFinishedEpisode(arg_8_0.actId, arg_8_0.episodeId)
	end

	gohelper.setActive(arg_8_0._goStar1, not var_8_0)
	gohelper.setActive(arg_8_0._goStar2, var_8_0 and not arg_8_0.gameIndex)
	gohelper.setActive(arg_8_0._goStar3, var_8_0 and arg_8_0.gameIndex)

	local var_8_2 = var_8_1 and "#FFFFFF" or "#969696"

	if arg_8_0.gameIndex then
		SLFramework.UGUI.GuiHelper.SetColor(arg_8_0.spStageImageList[arg_8_0.gameIndex], var_8_2)
		ZProj.UGUIHelper.SetGrayscale(arg_8_0.spStageList[arg_8_0.gameIndex], not var_8_1)
		ZProj.UGUIHelper.SetGrayscale(arg_8_0._goSPIcon, not var_8_1)
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._imageStageItem, var_8_2)
		ZProj.UGUIHelper.SetGrayscale(arg_8_0._goStageItem, not var_8_1)
		ZProj.UGUIHelper.SetGrayscale(arg_8_0._goIcon, not var_8_1)
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._imageStageNum, var_8_1 and "#FFFFFF" or "#C8C8C8")
	ZProj.UGUIHelper.SetGrayscale(arg_8_0._imageStageNum.gameObject, not var_8_1)
	gohelper.setActive(arg_8_0._goLocked, not var_8_1)
	arg_8_0:_playAnim(arg_8_1)
end

function var_0_0._playAnim(arg_9_0, arg_9_1)
	if string.nilorempty(arg_9_1) then
		return
	end

	arg_9_0._animator:Play(arg_9_1, 0, 0)
end

function var_0_0.refreshSelected(arg_10_0)
	local var_10_0 = CooperGarlandModel.instance:isNewestEpisode(arg_10_0.actId, arg_10_0.episodeId)

	gohelper.setActive(arg_10_0._goSelected, var_10_0)
end

return var_0_0
