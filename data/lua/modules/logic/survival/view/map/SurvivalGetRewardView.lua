module("modules.logic.survival.view.map.SurvivalGetRewardView", package.seeall)

local var_0_0 = class("SurvivalGetRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "titlebg/#txt_title")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_View/Reward/Viewport/Content/go_rewarditem")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "titlebg/numbg")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "Bottom/txt_tips")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Bottom/#btn_confirm")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)
	gohelper.setActive(arg_4_0._btnget, false)
	gohelper.setActive(arg_4_0._gonum, false)
	gohelper.setActive(arg_4_0._gotips, true)
	arg_4_0:_refreshView()
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:_refreshView()
end

function var_0_0._refreshView(arg_6_0)
	arg_6_0._items = arg_6_0.viewParam.items

	SurvivalBagSortHelper.sortItems(arg_6_0._items, SurvivalEnum.ItemSortType.ItemReward, true)
	gohelper.CreateObjList(arg_6_0, arg_6_0._createRewardItem, arg_6_0._items, nil, arg_6_0._goreward)

	arg_6_0._txtTitle.text = arg_6_0.viewParam.title or luaLang("survival_reward_title")
end

function var_0_0._createRewardItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChild(arg_7_1, "go_select")

	gohelper.setActive(var_7_0, false)

	local var_7_1 = gohelper.findChild(arg_7_1, "#btn_click")

	gohelper.setActive(var_7_1, false)

	local var_7_2 = gohelper.findChild(arg_7_1, "go_card/inst")

	if not var_7_2 then
		local var_7_3 = arg_7_0.viewContainer._viewSetting.otherRes.infoView

		var_7_2 = arg_7_0:getResInst(var_7_3, gohelper.findChild(arg_7_1, "go_card"), "inst")
	end

	MonoHelper.addNoUpdateLuaComOnceToGo(var_7_2, SurvivalBagInfoPart):updateMo(arg_7_2)
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

return var_0_0
