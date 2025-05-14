module("modules.logic.explore.view.ExploreBonusRewardView", package.seeall)

local var_0_0 = class("ExploreBonusRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gobtnsitem = gohelper.findChild(arg_1_0.viewGO, "#go_btns/#btn_level")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "top/title/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)

	local var_4_0 = arg_4_0.viewParam
	local var_4_1 = DungeonConfig.instance:getChapterEpisodeCOList(var_4_0.id)

	arg_4_0._episodeCoList = var_4_1
	arg_4_0._btns = {}

	gohelper.CreateObjList(arg_4_0, arg_4_0.createItem, var_4_1, arg_4_0._gobtns, arg_4_0._gobtnsitem)

	local var_4_2, var_4_3, var_4_4, var_4_5, var_4_6, var_4_7 = ExploreSimpleModel.instance:getChapterCoinCount(var_4_0.id)

	arg_4_0._txtnum.text = string.format("<color=#f68736>%d</color>/%d", var_4_2, var_4_5)

	arg_4_0:onClickLevel(1)
end

function var_0_0.createItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = gohelper.findChildTextMesh(arg_5_1, "#txt_name")
	local var_5_1 = gohelper.findChild(arg_5_1, "#select_btn")

	var_5_0.text = arg_5_2.name

	local var_5_2 = gohelper.findChildImage(arg_5_1, "")
	local var_5_3 = gohelper.findButtonWithAudio(arg_5_1)

	arg_5_0:addClickCb(var_5_3, arg_5_0.onClickLevel, arg_5_0, arg_5_3)

	arg_5_0._btns[arg_5_3] = {
		var_5_0,
		var_5_2,
		var_5_1
	}
end

function var_0_0.onClickLevel(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._episodeCoList[arg_6_1]

	ExploreTaskModel.instance:getTaskList(0):setList(ExploreConfig.instance:getRewardConfig(arg_6_0.viewParam.id, var_6_0.id))

	for iter_6_0 = 1, #arg_6_0._btns do
		ZProj.UGUIHelper.SetColorAlpha(arg_6_0._btns[iter_6_0][1], iter_6_0 == arg_6_1 and 1 or 0.5)
		ZProj.UGUIHelper.SetColorAlpha(arg_6_0._btns[iter_6_0][2], iter_6_0 == arg_6_1 and 1 or 0.3)
		gohelper.setActive(arg_6_0._btns[iter_6_0][3], iter_6_0 == arg_6_1)
	end
end

function var_0_0.onClickModalMask(arg_7_0)
	arg_7_0:closeThis()
end

return var_0_0
