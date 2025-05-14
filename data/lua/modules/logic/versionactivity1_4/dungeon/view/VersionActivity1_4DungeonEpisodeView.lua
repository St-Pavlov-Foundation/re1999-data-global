module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonEpisodeView", package.seeall)

local var_0_0 = class("VersionActivity1_4DungeonEpisodeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "rotate/layout/top/title/#txt_title")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "rotate/#go_bg/#txt_info")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/right/#go_fight/#btn_fight")
	arg_1_0._btnbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#btn_closetip")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "rotate/right/#go_fight/cost/#txt_cost")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/right/#go_fight/cost/#simage_costicon")
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem")
	arg_1_0.rewardItems = arg_1_0:getUserDataTb_()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnbg:AddClickListener(arg_2_0._btnbgOnClick, arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnbgOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnbg:RemoveClickListener()
	arg_3_0._btnclosetip:RemoveClickListener()
end

function var_0_0._btnbgOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnyesOnClick(arg_5_0)
	local var_5_0 = DungeonConfig.instance:getEpisodeCO(arg_5_0.episodeId)

	if not var_5_0 then
		return
	end

	DungeonFightController.instance:enterFight(var_5_0.chapterId, var_5_0.id, 1)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0.episodeId = arg_7_0.viewParam.episodeId

	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.episodeId = arg_8_0.viewParam.episodeId

	arg_8_0._simagecosticon:LoadImage(ResUrl.getCurrencyItemIcon("204_btn"))
	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	local var_9_0 = DungeonConfig.instance:getEpisodeCO(arg_9_0.episodeId)

	if not var_9_0 then
		return
	end

	arg_9_0.txtName.text = var_9_0.name
	arg_9_0.txtDesc.text = var_9_0.desc

	local var_9_1 = 0

	if not string.nilorempty(var_9_0.cost) then
		var_9_1 = string.splitToNumber(var_9_0.cost, "#")[3]
	end

	arg_9_0._txtcost.text = "-" .. var_9_1

	if var_9_1 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._txtcost, "#070706")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._txtcost, "#800015")
	end

	arg_9_0:refreshReward(var_9_0)
end

function var_0_0.refreshReward(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goactivityrewarditem, false)

	local var_10_0 = {}
	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3 = DungeonModel.instance:getEpisodeInfo(arg_10_1.id)

	if var_10_3 and var_10_3.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_10_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_10_1.id))

		var_10_2 = #var_10_0
	end

	if var_10_3 and var_10_3.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_10_0, DungeonModel.instance:getEpisodeFirstBonus(arg_10_1.id))

		var_10_1 = #var_10_0
	end

	tabletool.addValues(var_10_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_10_1.id))

	if #var_10_0 == 0 then
		gohelper.setActive(arg_10_0.goRewardContent, false)

		return
	end

	gohelper.setActive(arg_10_0.goRewardContent, true)

	local var_10_4 = math.min(#var_10_0, 3)
	local var_10_5
	local var_10_6

	for iter_10_0 = 1, var_10_4 do
		local var_10_7 = arg_10_0.rewardItems[iter_10_0]

		if not var_10_7 then
			var_10_7 = arg_10_0:getUserDataTb_()
			var_10_7.go = gohelper.cloneInPlace(arg_10_0._goactivityrewarditem, "item" .. iter_10_0)
			var_10_7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_10_7.go, "itemicon"))
			var_10_7.gonormal = gohelper.findChild(var_10_7.go, "rare/#go_rare1")
			var_10_7.gofirst = gohelper.findChild(var_10_7.go, "rare/#go_rare2")
			var_10_7.goadvance = gohelper.findChild(var_10_7.go, "rare/#go_rare3")
			var_10_7.gofirsthard = gohelper.findChild(var_10_7.go, "rare/#go_rare4")
			var_10_7.txtnormal = gohelper.findChildText(var_10_7.go, "rare/#go_rare1/txt")

			table.insert(arg_10_0.rewardItems, var_10_7)
		end

		local var_10_8 = var_10_0[iter_10_0]

		gohelper.setActive(var_10_7.gonormal, false)
		gohelper.setActive(var_10_7.gofirst, false)
		gohelper.setActive(var_10_7.goadvance, false)
		gohelper.setActive(var_10_7.gofirsthard, false)

		local var_10_9
		local var_10_10
		local var_10_11 = var_10_8[4] or var_10_8[3]
		local var_10_12 = true
		local var_10_13 = var_10_7.gofirst
		local var_10_14 = var_10_7.goadvance

		if iter_10_0 <= var_10_2 then
			gohelper.setActive(var_10_14, true)
		elseif iter_10_0 <= var_10_1 then
			gohelper.setActive(var_10_13, true)
		else
			gohelper.setActive(var_10_7.gonormal, true)

			var_10_7.txtnormal.text = luaLang("dungeon_prob_flag" .. var_10_8[3])
		end

		var_10_7.iconItem:setMOValue(var_10_8[1], var_10_8[2], var_10_11, nil, true)
		var_10_7.iconItem:setCountFontSize(42)
		var_10_7.iconItem:setHideLvAndBreakFlag(true)
		var_10_7.iconItem:hideEquipLvAndBreak(true)
		var_10_7.iconItem:customOnClickCallback(arg_10_0._onRewardItemClick, arg_10_0)
		gohelper.setActive(var_10_7.go, true)
	end

	for iter_10_1 = var_10_4 + 1, #arg_10_0.rewardItems do
		gohelper.setActive(arg_10_0.rewardItems[iter_10_1].go, false)
	end
end

function var_0_0.createRewardItem(arg_11_0, arg_11_1)
	local var_11_0 = IconMgr.instance:getCommonPropItemIcon(arg_11_0.goRewardContent)

	arg_11_0.rewardItemList[arg_11_1] = var_11_0

	return var_11_0
end

function var_0_0.onClose(arg_12_0)
	VersionActivity1_4DungeonModel.instance:setSelectEpisodeId()
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagecosticon:UnLoadImage()
end

return var_0_0
