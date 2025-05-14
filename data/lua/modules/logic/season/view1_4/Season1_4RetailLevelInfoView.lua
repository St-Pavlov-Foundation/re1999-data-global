module("modules.logic.season.view1_4.Season1_4RetailLevelInfoView", package.seeall)

local var_0_0 = class("Season1_4RetailLevelInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageuppermask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_uppermask")
	arg_1_0._simagedecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_decorate")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "bottom")
	arg_1_0._gonormalcondition = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_conditions/#go_normalcondition")
	arg_1_0._txtnormalrule = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_conditions/#go_normalcondition/#txt_normalrule")
	arg_1_0._gospecialcondition = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_conditions/#go_specialcondition")
	arg_1_0._txtspecialrule = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_conditions/#go_specialcondition/#txt_specialrule")
	arg_1_0._txtlevelname = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_levelname")
	arg_1_0._txtenemylevelnum = gohelper.findChildText(arg_1_0.viewGO, "bottom/txt_enemylevel/#txt_enemylevelnum")
	arg_1_0._scrollcelebritycard = gohelper.findChildScrollRect(arg_1_0.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard/scrollcontent_seasoncelebritycarditem")
	arg_1_0._txtdecr = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_decr")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_close")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_start")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_tag")
	arg_1_0._txttagdesc = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_tag/descbg/#txt_tagdesc")
	arg_1_0._gostageitem = gohelper.findChild(arg_1_0.viewGO, "bottom/stages/#go_stageitem")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btnclose2OnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, arg_2_0._onBattleReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0:removeEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, arg_3_0._onBattleReply, arg_3_0)
end

function var_0_0._onBattleReply(arg_4_0, arg_4_1)
	Activity104Model.instance:onStartAct104BattleReply(arg_4_1)
end

function var_0_0._btnclose1OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnclose2OnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnstartOnClick(arg_8_0)
	local var_8_0 = Activity104Model.instance:getCurSeasonId()

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(var_8_0, 0, arg_8_0.viewParam.episodeId)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._simageuppermask:LoadImage(ResUrl.getSeasonIcon("full/seasonsecretlandentrance_mask.png"))
	arg_9_0._simagedecorate:LoadImage(ResUrl.getSeasonIcon("particle.png"))
	arg_9_0._simageleftbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_xia.png"))
	arg_9_0._simagerightbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_shang.png"))
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._cardItems = {}

	arg_11_0:_setInfo()
end

local var_0_1 = {
	targetFlagUIPosX = -32.7,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 28.3
}

function var_0_0._setInfo(arg_12_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail, arg_12_0.viewParam.retail.position)

	local var_12_0 = math.min(Activity104Model.instance:getAct104CurStage(), 6)
	local var_12_1 = Activity104Model.instance:getCurSeasonId()

	arg_12_0._txtlevelname.text = SeasonConfig.instance:getSeasonTagDesc(var_12_1, arg_12_0.viewParam.retail.tag).name .. " " .. GameUtil.getRomanNums(var_12_0)

	local var_12_2 = Activity104Model.instance:getRetailStage()

	arg_12_0._txtenemylevelnum.text = HeroConfig.instance:getCommonLevelDisplay(SeasonConfig.instance:getSeasonRetailCo(var_12_1, var_12_2).level)

	local var_12_3 = Activity104Model.instance:getRetailEpisodeTag(arg_12_0.viewParam.retail.id)

	gohelper.setActive(arg_12_0._gotag, not string.nilorempty(var_12_3))

	arg_12_0._txttagdesc.text = tostring(var_12_3)

	for iter_12_0, iter_12_1 in pairs(arg_12_0._cardItems) do
		gohelper.setActive(iter_12_1.go, false)
	end

	for iter_12_2 = 1, #arg_12_0.viewParam.retail.showActivity104EquipIds do
		local var_12_4 = arg_12_0.viewParam.retail.showActivity104EquipIds[iter_12_2]

		if not arg_12_0._cardItems[iter_12_2] then
			arg_12_0._cardItems[iter_12_2] = Season1_4CelebrityCardItem.New()

			arg_12_0._cardItems[iter_12_2]:init(arg_12_0._gocarditem, var_12_4, var_0_1)
		else
			gohelper.setActive(arg_12_0._cardItems[iter_12_2].go, true)
			arg_12_0._cardItems[iter_12_2]:reset(var_12_4)
		end

		arg_12_0._cardItems[iter_12_2]:showTag(true)
		arg_12_0._cardItems[iter_12_2]:showProbability(true)
	end

	gohelper.setActive(arg_12_0._gonormalcondition, arg_12_0.viewParam.retail.advancedId ~= 0 and arg_12_0.viewParam.retail.advancedRare == 1)
	gohelper.setActive(arg_12_0._gospecialcondition, arg_12_0.viewParam.retail.advancedId ~= 0 and arg_12_0.viewParam.retail.advancedRare == 2)

	if arg_12_0.viewParam.retail.advancedId ~= 0 then
		local var_12_5 = "      " .. lua_condition.configDict[arg_12_0.viewParam.retail.advancedId].desc

		if arg_12_0.viewParam.retail.advancedRare == 1 then
			arg_12_0._txtnormalrule.text = var_12_5
		elseif arg_12_0.viewParam.retail.advancedRare == 2 then
			arg_12_0._txtspecialrule.text = var_12_5
		end
	end

	arg_12_0:_refreshStateUI()
end

var_0_0.MaxStageCount = 7

function var_0_0._refreshStateUI(arg_13_0)
	arg_13_0._stageItemsTab = arg_13_0._stageItemsTab or arg_13_0:getUserDataTb_()

	local var_13_0 = Activity104Model.instance:getAct104CurStage()

	for iter_13_0 = 1, var_0_0.MaxStageCount do
		local var_13_1 = arg_13_0._stageItemsTab[iter_13_0]

		if not var_13_1 then
			var_13_1 = gohelper.cloneInPlace(arg_13_0._gostageitem, "stageitem_" .. iter_13_0)

			table.insert(arg_13_0._stageItemsTab, iter_13_0, var_13_1)
		end

		gohelper.setActive(var_13_1, iter_13_0 <= 6 or iter_13_0 <= var_13_0)

		local var_13_2 = gohelper.findChildImage(var_13_1, "dark")
		local var_13_3 = gohelper.findChildImage(var_13_1, "light")

		gohelper.setActive(var_13_3.gameObject, iter_13_0 <= var_13_0)
		gohelper.setActive(var_13_2.gameObject, var_13_0 < iter_13_0)

		local var_13_4 = iter_13_0 == 7 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(var_13_3, var_13_4)
	end
end

function var_0_0.onClose(arg_14_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail)
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._cardItems then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._cardItems) do
			iter_15_1:destroy()
		end

		arg_15_0._cardItems = nil
	end

	arg_15_0._simageuppermask:UnLoadImage()
	arg_15_0._simagedecorate:UnLoadImage()
	arg_15_0._simageleftbg:UnLoadImage()
	arg_15_0._simagerightbg:UnLoadImage()
end

return var_0_0
