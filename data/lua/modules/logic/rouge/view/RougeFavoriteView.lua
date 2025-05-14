module("modules.logic.rouge.view.RougeFavoriteView", package.seeall)

local var_0_0 = class("RougeFavoriteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._gorole4 = gohelper.findChild(arg_1_0.viewGO, "#go_role4")
	arg_1_0._gorole3 = gohelper.findChild(arg_1_0.viewGO, "#go_role3")
	arg_1_0._goluoleilai = gohelper.findChild(arg_1_0.viewGO, "#go_luoleilai")
	arg_1_0._gorole2 = gohelper.findChild(arg_1_0.viewGO, "#go_role2")
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "#go_role1")
	arg_1_0._gohailuo = gohelper.findChild(arg_1_0.viewGO, "#go_hailuo")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_story")
	arg_1_0._gonewstory = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_story/#go_new_story")
	arg_1_0._btnillustration = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_illustration")
	arg_1_0._gonewillustration = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_illustration/#go_new_illustration")
	arg_1_0._btnfaction = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_faction")
	arg_1_0._gonewfaction = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_faction/#go_new_faction")
	arg_1_0._btnresult = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_result")
	arg_1_0._btncollection = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_collection")
	arg_1_0._gonewcollection = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_collection/#go_new_collection")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
	arg_2_0._btnillustration:AddClickListener(arg_2_0._btnillustrationOnClick, arg_2_0)
	arg_2_0._btnfaction:AddClickListener(arg_2_0._btnfactionOnClick, arg_2_0)
	arg_2_0._btnresult:AddClickListener(arg_2_0._btnresultOnClick, arg_2_0)
	arg_2_0._btncollection:AddClickListener(arg_2_0._btncollectionOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0._btnillustration:RemoveClickListener()
	arg_3_0._btnfaction:RemoveClickListener()
	arg_3_0._btnresult:RemoveClickListener()
	arg_3_0._btncollection:RemoveClickListener()
end

function var_0_0._btnresultOnClick(arg_4_0)
	RougeController.instance:openRougeResultReportView()
end

function var_0_0._btncollectionOnClick(arg_5_0)
	RougeController.instance:openRougeFavoriteCollectionView()
end

function var_0_0._btnfactionOnClick(arg_6_0)
	RougeController.instance:openRougeFactionIllustrationView()
end

function var_0_0._btnillustrationOnClick(arg_7_0)
	RougeController.instance:openRougeIllustrationListView()
end

function var_0_0._btnstoryOnClick(arg_8_0)
	RougeController.instance:openRougeReviewView()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0:_updateNewFlag()
	arg_9_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, arg_9_0._updateNewFlag, arg_9_0)
end

function var_0_0._updateNewFlag(arg_10_0)
	gohelper.setActive(arg_10_0._gonewstory, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Story) > 0)
	gohelper.setActive(arg_10_0._gonewillustration, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Illustration) > 0)
	gohelper.setActive(arg_10_0._gonewfaction, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Faction) > 0)
	gohelper.setActive(arg_10_0._gonewcollection, RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Collection) > 0)
end

function var_0_0.showEnding(arg_11_0)
	local var_11_0 = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.FavoriteEndingShow)
	local var_11_1 = string.splitToNumber(var_11_0, "#")
	local var_11_2 = RougeOutsideModel.instance:getRougeGameRecord()

	gohelper.setActive(arg_11_0._gohailuo, var_11_2.passEndIdMap[var_11_1[1]] ~= nil)
	gohelper.setActive(arg_11_0._goluoleilai, var_11_2.passEndIdMap[var_11_1[2]] ~= nil)
end

function var_0_0.randomRoleShow(arg_12_0)
	local var_12_0 = math.random(1, 5)
	local var_12_1 = arg_12_0["_gorole" .. var_12_0]

	if var_12_1 then
		gohelper.setActive(var_12_1, true)
	end
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:randomRoleShow()
	arg_14_0:showEnding()
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio1)
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
