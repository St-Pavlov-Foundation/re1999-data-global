module("modules.logic.survival.view.map.SurvivalDropSelectView", package.seeall)

local var_0_0 = class("SurvivalDropSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "titlebg/#txt_title")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_View/Reward/Viewport/Content/go_rewarditem")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "titlebg/numbg/#txt_num")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Bottom/#btn_confirm")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnget:AddClickListener(arg_2_0.onClickGetReward, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnget:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)
	arg_4_0:_refreshView()
end

function var_0_0.onUpdateParam(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)
	arg_5_0:_refreshView()
end

function var_0_0._refreshView(arg_6_0)
	arg_6_0._selectIndex = {}
	arg_6_0._panel = arg_6_0.viewParam.panel
	arg_6_0._selectObjs = arg_6_0:getUserDataTb_()
	arg_6_0._items = arg_6_0._panel.items

	gohelper.CreateObjList(arg_6_0, arg_6_0._createRewardItem, arg_6_0._items, nil, arg_6_0._goreward)
	arg_6_0:_refreshNum()

	arg_6_0._txtTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_reward_select_title"), arg_6_0._panel.canSelectNum)
end

function var_0_0._createRewardItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChild(arg_7_1, "go_select")
	local var_7_1 = gohelper.findChildClickWithDefaultAudio(arg_7_1, "go_card")

	gohelper.setActive(var_7_0, false)

	arg_7_0._selectObjs[arg_7_3] = var_7_0

	arg_7_0:addClickCb(var_7_1, arg_7_0._onBtnClick, arg_7_0, arg_7_3)

	local var_7_2 = gohelper.findChild(arg_7_1, "go_card/inst")

	if not var_7_2 then
		local var_7_3 = arg_7_0.viewContainer._viewSetting.otherRes.infoView

		var_7_2 = arg_7_0:getResInst(var_7_3, gohelper.findChild(arg_7_1, "go_card"), "inst")
	end

	local var_7_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_2, SurvivalBagInfoPart)

	var_7_4:updateMo(arg_7_2)
	var_7_4:setClickDescCallback(arg_7_0._onBtnClick, arg_7_0, arg_7_3)
end

function var_0_0._onBtnClick(arg_8_0, arg_8_1)
	local var_8_0 = tabletool.indexOf(arg_8_0._selectIndex, arg_8_1 - 1)

	if var_8_0 then
		table.remove(arg_8_0._selectIndex, var_8_0)
		gohelper.setActive(arg_8_0._selectObjs[arg_8_1], false)
	else
		if arg_8_0._panel.canSelectNum == tabletool.len(arg_8_0._selectIndex) then
			if arg_8_0._panel.canSelectNum ~= 1 then
				return
			else
				gohelper.setActive(arg_8_0._selectObjs[arg_8_0._selectIndex[1] + 1], false)

				arg_8_0._selectIndex[1] = nil
			end
		end

		table.insert(arg_8_0._selectIndex, arg_8_1 - 1)
		gohelper.setActive(arg_8_0._selectObjs[arg_8_1], true)
	end

	arg_8_0:_refreshNum()
end

function var_0_0._refreshNum(arg_9_0)
	local var_9_0 = tabletool.len(arg_9_0._selectIndex)

	if var_9_0 < arg_9_0._panel.canSelectNum then
		arg_9_0._txtnum.text = string.format("<#D64241>%d</color>/%d", var_9_0, arg_9_0._panel.canSelectNum)
	else
		arg_9_0._txtnum.text = string.format("%d/%d", var_9_0, arg_9_0._panel.canSelectNum)
	end
end

function var_0_0.onClickGetReward(arg_10_0)
	if tabletool.len(arg_10_0._selectIndex) < arg_10_0._panel.canSelectNum then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalDropSelect, MsgBoxEnum.BoxType.Yes_No, arg_10_0._realGetItems, nil, nil, arg_10_0, nil, nil)
	else
		arg_10_0:_realGetItems()
	end
end

function var_0_0._realGetItems(arg_11_0)
	SurvivalWeekRpc.instance:sendSurvivalPanelOperationRequest(arg_11_0._panel.uid, table.concat(arg_11_0._selectIndex, ","), arg_11_0._onRecvMsg, arg_11_0)
end

function var_0_0._onRecvMsg(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0:closeThis()
end

return var_0_0
